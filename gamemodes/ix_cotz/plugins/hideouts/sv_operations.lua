local PLUGIN = PLUGIN
local MAX_MONEY = 2147483647
local locks = {}
local walletLocks = {}
local previousPostLoad = PLUGIN.PostLoadData

local function read(query, callback)
	if ix.crossserver and ix.crossserver.Query then
		ix.crossserver.Query(query, callback)
	else
		query:Callback(function(rows) callback(rows or {}) end)
		query:Execute()
	end
end

-- Only this adapter bypasses ordinary Execute: native transactions must own the whole batch.
function PLUGIN:RunAtomicQueries(queries, callback)
	local statements = {}
	for index, query in ipairs(queries) do statements[index] = query:Build() end
	if mysql.module == "sqlite" then
		if sql.Query("BEGIN IMMEDIATE") == false then callback(false, sql.LastError()) return end
		local result
		for _, statement in ipairs(statements) do
			result = sql.Query(statement)
			if result == false then
				local failure = sql.LastError()
				sql.Query("ROLLBACK")
				ErrorNoHalt("[Hideouts] Transaction failed: " .. failure .. "\n")
				callback(false, failure)
				return
			end
		end
		if sql.Query("COMMIT") == false then
			local failure = sql.LastError()
			sql.Query("ROLLBACK")
			callback(false, failure)
			return
		end
		callback(true, result or {})
		return
	end
	if mysql.module ~= "mysqloo" or not mysql.connection.createTransaction then
		callback(false, "The database adapter does not support transactions.")
		return
	end
	local transaction = mysql.connection:createTransaction()
	local last
	for _, statement in ipairs(statements) do
		last = mysql.connection:query(statement)
		last:setOption(mysqloo.OPTION_NAMED_FIELDS)
		transaction:addQuery(last)
	end
	transaction.onSuccess = function() callback(true, last:getData() or {}) end
	transaction.onError = function(_, failure)
		ErrorNoHalt("[Hideouts] Transaction error; verifying its receipt: " .. failure .. "\n")
		-- A connection loss can hide a successful COMMIT. Absence must be verified before refunding.
		callback(nil, failure)
	end
	transaction:start()
end

function PLUGIN:InitializeOperations()
	self.operationsReady = false
	if not mysql.All then
		ErrorNoHalt("[Hideouts] Enable simplecrossserverdata for the installed structured database API.\n")
		return
	end
	local operations = mysql:Create("ix_hideout_operations")
	operations:Create("token", "VARCHAR(64) NOT NULL")
	operations:Create("scope", "VARCHAR(64) NOT NULL")
	operations:Create("map", "VARCHAR(128) NOT NULL")
	operations:Create("hideout", "VARCHAR(20) NOT NULL")
	operations:Create("actor", "INTEGER NOT NULL")
	operations:Create("kind", "VARCHAR(16) NOT NULL")
	operations:Create("squad", "VARCHAR(20) NOT NULL")
	operations:Create("created", "BIGINT NOT NULL")
	operations:Create("payload", "TEXT NOT NULL")
	operations:PrimaryKey("token")
	operations:Index("hideout_operation_recovery", {"scope", "map", "kind"})
	operations:Index("hideout_operation_history", {"scope", "squad", "created"})
	local treasury = mysql:Create("ix_hideout_treasuries")
	treasury:Create("scope", "VARCHAR(64) NOT NULL")
	treasury:Create("squad", "VARCHAR(20) NOT NULL")
	treasury:Create("balance", "BIGINT NOT NULL DEFAULT 0")
	treasury:PrimaryKey({"scope", "squad"})
	read(operations, function(_, failure)
		if failure then return end
		read(treasury, function(_, treasuryFailure)
			if treasuryFailure then return end
			self:CheckTransactionalTables(function(supported)
				if supported then
					self:InitializeSquadHomes(function(owned)
						if owned then
							self:RecoverUpgradeEntitlements(function(ok) self.operationsReady = ok end)
						end
					end)
				end
			end)
		end)
	end)
end

function PLUGIN:CheckTransactionalTables(callback)
	if mysql.module == "sqlite" then callback(true) return end
	if mysql.module ~= "mysqloo" or not mysql.connection.createTransaction then callback(false) return end
	local query = mysql.connection:query("SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES "
		.. "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN "
		.. "('ix_items', 'ix_characters', 'ix_hideout_operations', 'ix_hideout_treasuries')")
	query:setOption(mysqloo.OPTION_NAMED_FIELDS)
	query.onSuccess = function(_, rows)
		local supported = #rows == 4
		for _, row in ipairs(rows) do supported = supported and row.ENGINE == "InnoDB" end
		if not supported then ErrorNoHalt("[Hideouts] Economic tables require InnoDB; no engine changes were made.\n") end
		callback(supported)
	end
	query.onError = function(_, failure) ErrorNoHalt("[Hideouts] " .. failure .. "\n") callback(false) end
	query:start()
end

function PLUGIN:PostLoadData()
	previousPostLoad(self)
	self:InitializeOperations()
	self:InstallWalletSaveGuard()
end

function PLUGIN:InstallWalletSaveGuard()
	ix.meta.character.cotzHideoutSaveOriginal = ix.meta.character.cotzHideoutSaveOriginal or ix.meta.character.Save
	self.originalCharacterSave = ix.meta.character.cotzHideoutSaveOriginal
	ix.meta.character.Save = function(character, callback)
		if character.cotzHideoutStale then return end
		local pending = walletLocks[character:GetID()]
		if pending then
			if callback then
				assert(#pending.callbacks < 128, "Too many character saves waiting for a hideout transaction")
				pending.callbacks[#pending.callbacks + 1] = callback
			end
			return
		end
		return self.originalCharacterSave(character, callback)
	end
end

function PLUGIN:IsCharacterOperationPending(character)
	return walletLocks[character:GetID()] ~= nil
end

function PLUGIN:IsOperationLocked(item, current, target)
	if self.applyingOperation then return false end

	return item and locks["item:" .. item:GetID()]
		or current and current.GetID and locks["inventory:" .. current:GetID()]
		or target and target.GetID and locks["inventory:" .. target:GetID()]
end

function PLUGIN:GetTreasury(record, callback)
	if not self.operationsReady then callback(nil, "Economic persistence is not ready.") return end
	local insert = mysql:InsertIgnore("ix_hideout_treasuries")
	insert:Insert("scope", Schema.folder)
	insert:Insert("squad", record.squadID)
	insert:Insert("balance", 0)
	read(insert, function(_, failure)
		if failure then callback(nil, failure) return end
		local query = mysql:Select("ix_hideout_treasuries")
		query:Where("scope", Schema.folder)
		query:Where("squad", record.squadID)
		read(query, function(rows, errorText)
			callback(not errorText and rows[1] and tonumber(rows[1].balance), errorText)
		end)
	end)
end

local function receiptCondition(token)
	local receipt = mysql:Select("ix_hideout_operations")
	receipt:SelectValue(1)
	receipt:Where("token", token)

	return mysql.Exists(receipt)
end

function PLUGIN:BuildOperationQueries(character, record, spec, token, row)
	local source = mysql:Select()
	for _, value in ipairs({token, Schema.folder, game.GetMap(), record.id, character:GetID(),
		spec.payload.kind, record.squadID or "", os.time(), util.TableToJSON(spec.payload)}) do
		source:SelectValue(value)
	end
	if spec.item then
		local itemRow = mysql:Select("ix_items")
		itemRow:SelectValue(1)
		itemRow:Where("item_id", spec.item:GetID())
		itemRow:Where("inventory_id", spec.from:GetID())
		itemRow:Where("data", row.data)
		source:WhereExpr(mysql.Exists(itemRow))
	end
	if spec.session then
		local session = mysql:Select("ix_squads_presence")
		session:SelectValue(1)
		session:Where("scope", Schema.folder)
		session:Where("character_id", character:GetID())
		session:Where("session", spec.session.token)
		session:Where("state", "online")
		session:WhereExpr(mysql.Compare("expires", ">", mysql.Now()))
		source:WhereExpr(mysql.Exists(session))
	end
	if spec.treasuryDelta and spec.treasuryDelta ~= 0 then
		local balance = mysql:Select("ix_hideout_treasuries")
		balance:SelectValue(1)
		balance:Where("scope", Schema.folder)
		balance:Where("squad", record.squadID)
		balance:WhereGTE("balance", math.max(0, -spec.treasuryDelta))
		balance:WhereLTE("balance", MAX_MONEY - math.max(0, spec.treasuryDelta))
		source:WhereExpr(mysql.Exists(balance))
	end
	if record.ownerType == "squad" and ix.squad.cross and ix.squad.cross.Enabled() then
		local active = mysql:Select("ix_squads_state")
		active:SelectValue(1)
		active:Where("scope", Schema.folder)
		active:Where("squad_id", record.squadID)
		active:Where("active", 1)
		source:WhereExpr(mysql.Exists(active))
	end
	-- Privileged operations recheck shared membership inside the commit, not only before it.
	local requiredRank = spec.rank
	if record.ownerType == "squad" and requiredRank == nil and record.access ~= "public"
		and not (record.guests or {})[tostring(character:GetID())] then requiredRank = 0 end
	if requiredRank ~= nil and ix.squad.cross and ix.squad.cross.Enabled() then
		local member = mysql:Select("ix_squads_members"):Alias("m")
		member:SelectValue(1)
		member:Join("ix_squads_state", "s", mysql.All(
			mysql.Compare("s.scope", "=", mysql.Column("m.scope")),
			mysql.Compare("s.squad_id", "=", mysql.Column("m.squad_id"))))
		member:WhereExpr(mysql.Compare("m.scope", "=", Schema.folder))
		member:WhereExpr(mysql.Compare("m.squad_id", "=", record.squadID))
		member:WhereExpr(mysql.Compare("m.character_id", "=", character:GetID()))
		member:WhereExpr(mysql.Compare("m.member_rank", ">=", requiredRank))
		member:WhereExpr(mysql.Compare("s.active", "=", 1))
		source:WhereExpr(mysql.Exists(member))
	end
	local receipt = mysql:Insert("ix_hideout_operations")
	receipt:InsertFrom(source, {"token", "scope", "map", "hideout", "actor", "kind", "squad", "created", "payload"})
	local queries = {receipt}
	local condition = receiptCondition(token)
	if spec.item then
		local change = spec.consume and mysql:Delete("ix_items") or mysql:Update("ix_items")
		if not spec.consume then
			change:Update("inventory_id", spec.to:GetID())
			change:Update("x", spec.x)
			change:Update("y", spec.y)
			change:Update("data", util.TableToJSON(spec.data or spec.item.data))
		end
		change:Where("item_id", spec.item:GetID())
		change:WhereExpr(condition)
		queries[#queries + 1] = change
	end
	if spec.moneyDelta and spec.moneyDelta ~= 0 then
		local money = mysql:Update("ix_characters")
		money:Update("money", spec.balance + spec.moneyDelta)
		money:Where("id", character:GetID())
		money:WhereExpr(condition)
		queries[#queries + 1] = money
	end
	if spec.treasuryDelta and spec.treasuryDelta ~= 0 then
		local treasury = mysql:Update("ix_hideout_treasuries")
		treasury:UpdateValue("balance", mysql.Add(mysql.Column("balance"), spec.treasuryDelta))
		treasury:Where("scope", Schema.folder)
		treasury:Where("squad", record.squadID)
		treasury:WhereExpr(condition)
		queries[#queries + 1] = treasury
	end
	local result = mysql:Select("ix_hideout_operations")
	result:Where("token", token)
	queries[#queries + 1] = result

	return queries
end

function PLUGIN:CommitOperation(client, record, spec, callback)
	local character = client:GetCharacter()
	if not self.operationsReady or not character or client.cotzHideoutOperation then
		callback(false, "Persistence is unavailable or an operation is already pending.")
		return
	end
	if ix.crossserver and ix.crossserver.Enabled and ix.crossserver.Enabled() then
		spec.session = ix.crossserver.sessions[character:GetID()]
		if not spec.session or not spec.session.claimed or spec.session.travelling then
			callback(false, "Wait for your character session to become ready.")
			return
		end
	end
	local keys = {}
	if spec.item then keys[#keys + 1] = "item:" .. spec.item:GetID() end
	if spec.from then keys[#keys + 1] = "inventory:" .. spec.from:GetID() end
	if spec.to then keys[#keys + 1] = "inventory:" .. spec.to:GetID() end
	for _, key in ipairs(keys) do
		if locks[key] then callback(false, "That inventory is busy.") return end
	end
	spec.balance = character:GetMoney()
	local resulting = spec.balance + (spec.moneyDelta or 0)
	if resulting < 0 or resulting > MAX_MONEY then
		callback(false, "Insufficient funds or wallet limit reached.")
		return
	end
	local token = util.SHA256(Schema.folder .. game.GetMap() .. SysTime() .. math.random())
	spec.payload = spec.payload or {kind = "transfer"}
	spec.payload.actorName = character:GetName()
	client.cotzHideoutOperation = token
	local instance = self.instances[record.id]
	if instance then instance.operations = (instance.operations or 0) + 1 end
	for _, key in ipairs(keys) do locks[key] = token end
	local pending = {callbacks = {}}
	walletLocks[character:GetID()] = pending
	-- Reserve outgoing funds immediately. Other ordinary wallet changes remain visible as deltas.
	if (spec.moneyDelta or 0) < 0 then character:TakeMoney(-spec.moneyDelta) end
	local finished = false
	local function finish(ok, reason)
		if finished then return end
		finished = true
		if ok then
			if (spec.moneyDelta or 0) > 0 then character:GiveMoney(spec.moneyDelta) end
			self.applyingOperation = token
			if spec.item then self:ApplyCommittedItem(spec, client) end
			self.applyingOperation = nil
		elseif (spec.moneyDelta or 0) < 0 then
			character:GiveMoney(-spec.moneyDelta)
		end
		walletLocks[character:GetID()] = nil
		client.cotzHideoutOperation = nil
		for _, key in ipairs(keys) do locks[key] = nil end
		if instance then instance.operations = instance.operations - 1 end
		local sameSession = not spec.session or ix.crossserver.sessions[character:GetID()] == spec.session
		if IsValid(client) and client:GetCharacter() == character and sameSession then
			character:Save(function()
				for _, complete in ipairs(pending.callbacks) do complete() end
			end)
		else
			-- The transaction already persisted custody/money. An old session must not overwrite a new one.
			character.cotzHideoutStale = true
			local cached = ix.char.loaded[character:GetID()]
			if cached then cached.cotzHideoutStale = true end
			ErrorNoHalt("[Hideouts] Deferred save requires fresh character restore after session loss.\n")
		end
		callback(ok, reason, token)
	end
	local function commit(row)
		local current = spec.resolve and spec.resolve() or self:GetHideout(record.id)
		local accessible = spec.resolve ~= nil or self:CanAccess(client, record)
		if not IsValid(client) or client:GetCharacter() ~= character or not accessible
			or current ~= record or record.deleting or spec.authorize and not spec.authorize() then
			finish(false, "Your character or vendor access changed.")
			return
		end
		local queries = self:BuildOperationQueries(character, record, spec, token, row)
		self:RunAtomicQueries(queries, function(ok, result)
			if ok == nil then
				local receipt = mysql:Select("ix_hideout_operations")
				receipt:Where("token", token)
				read(receipt, function(rows, failure)
					if failure then
						ErrorNoHalt("[Hideouts] Uncertain outcome remains locked: " .. token .. "\n")
						return
					end
					finish(rows[1] ~= nil, result)
				end)
				return
			end
			finish(ok and istable(result) and result[1] ~= nil,
				ok and "The item or squad state changed; try again." or result)
		end)
	end
	if not spec.item then commit() return end
	local query = mysql:Select("ix_items")
	query:Where("item_id", spec.item:GetID())
	query:Where("inventory_id", spec.from:GetID())
	read(query, function(rows, failure)
		if failure or not rows[1] then finish(false, failure or "The item is no longer available.") return end
		commit(rows[1])
	end)
	-- No timeout refund: a lost callback is an uncertain outcome, not proof of rollback.
	timer.Simple(20, function()
		if client.cotzHideoutOperation == token then
			ErrorNoHalt("[Hideouts] Operation pending database outcome: " .. token .. "\n")
		end
	end)
end

function PLUGIN:ApplyCommittedItem(spec, client)
	local item = spec.item
	if spec.consume then
		spec.from:Remove(item:GetID(), false, true)
		ix.item.instances[item:GetID()] = nil
		return
	end
	-- The row is already committed. Use inventory APIs without issuing another custody write.
	local oldNoSave = spec.to.noSave
	spec.to.noSave = true
	item.data = spec.data or item.data
	local x = spec.to:Add(item:GetID(), 1, nil, spec.x, spec.y)
	spec.to.noSave = oldNoSave
	if not x then error("Committed hideout transfer could not be applied; restart to restore authoritative rows") end
	spec.from:Remove(item:GetID(), false, true, true)
	if item.OnTransferred then item:OnTransferred(spec.from, spec.to) end
	hook.Run("OnItemTransferred", item, spec.from, spec.to)
end

function PLUGIN:RecoverUpgradeEntitlements(callback)
	local query = mysql:Select("ix_hideout_operations")
	query:Where("scope", Schema.folder)
	query:Where("map", game.GetMap())
	query:WhereIn("kind", {"upgrade", "personal"})
	read(query, function(rows, failure)
		if failure then callback(false) return end
		for _, row in ipairs(rows) do
			local payload = util.JSONToTable(row.payload or "{}")
			local record = self:GetHideout(row.hideout)
			if record and payload and payload.kind == "personal" then
				self:ApplyPersonalEntitlement(record, payload)
			elseif record and payload and payload.kind == "upgrade"
				and (record.ownerType == "squad" or not record.personalVersion) then
				record.containers = record.containers or {}
				local slot = record.containers[payload.slot] or {public = false}
				if (slot.tier or 0) < payload.tier then
					slot.tier, slot.width, slot.height = payload.tier, payload.width, payload.height
					record.containers[payload.slot] = slot
				end
			end
		end
		callback(self:Persist())
	end)
end
