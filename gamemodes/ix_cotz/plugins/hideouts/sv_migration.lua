local PLUGIN = PLUGIN
local PREVIEW_LIFETIME = 600
local BACKUP_ROOT = "cotz_hideout_migrations"

local function sameValue(left, right)
	if type(left) ~= type(right) then return false end
	if type(left) ~= "table" then return left == right end
	for key, value in pairs(left) do
		if not sameValue(value, right[key]) then return false end
	end
	for key in pairs(right) do
		if left[key] == nil then return false end
	end

	return true
end

local function authorized(client)
	return IsValid(client) and client:IsAdmin() and client:GetCharacter() ~= nil
end

local function backupPath(token)
	local scope = util.SHA256(Schema.folder .. ":" .. game.GetMap()):sub(1, 16)

	return BACKUP_ROOT .. "/" .. scope .. "/" .. token .. ".json"
end

local function readBackup(plugin, token)
	local contents = file.Read(backupPath(token), "DATA")
	local plan = contents and util.JSONToTable(contents)
	if not plan or plan.token ~= token or plan.schema ~= Schema.folder or plan.map ~= game.GetMap() then return end
	-- Match LoadData: Helix's JSON decoder converts numeric-looking IDs into number keys.
	plan.records = plugin:NormalizeIDKeys(plan.records)
	plan.locations = plugin:NormalizeIDKeys(plan.locations)
	plan.definitions = plugin:NormalizeIDKeys(plan.definitions)
	if plan.sourceTemplate.containers then
		plan.sourceTemplate.containers = plugin:NormalizeIDKeys(plan.sourceTemplate.containers)
	end
	for _, record in pairs(plan.records) do
		record.containers = plugin:NormalizeIDKeys(record.containers)
		if record.personalLayout then record.personalLayout = plugin:NormalizeIDKeys(record.personalLayout) end
		record.shell = plugin:NormalizeIDKeys(record.shell)
	end

	return plan
end

local function writeBackup(token, data)
	local path = backupPath(token)
	if file.Exists(path, "DATA") then return false end
	file.CreateDir(string.GetPathFromFilename(path))
	local encoded = util.TableToJSON(data)
	if not encoded then return false end
	file.Write(path, encoded)

	return file.Read(path, "DATA") == encoded
end

function PLUGIN:GetMigrationDupeHash(template)
	if not AdvDupe2 or not isstring(template.dupe) then return end
	local contents = file.Read(AdvDupe2.DataFolder .. "/STALKERDupes/" .. template.dupe .. ".txt", "DATA")

	return contents and util.SHA256(contents)
end

local function roomBusy(plugin, record)
	return record.deleting or record.frozen or record.homePending or record.homeConflict
		or plugin.instances[record.id] or (plugin.personalPurchases or {})[record.id]
end

local function migrationReady(plugin)
	return plugin.ready and plugin.operationsReady
end

local function validateContainers(record, definitions, sourceDefinitions)
	for id, slot in pairs(record.containers or {}) do
		local definition = definitions[id]
		if (slot.tier or 0) <= 0 and not slot.inventoryID then continue end
		local recipe = slot.recipe or (sourceDefinitions[id] or {}).recipe
		if not definition or not recipe or recipe ~= definition.recipe then
			return false, "Room " .. record.id .. " needs matching slot/recipe: " .. id
		end
	end
	if record.starterSlot and (not definitions[record.starterSlot]
		or definitions[record.starterSlot].recipe ~= "general") then
		return false, "Room " .. record.id .. " needs its general starter slot: " .. record.starterSlot
	end

	return true
end

local function reconcileUninstalledContainers(record, definitions)
	for id, slot in pairs(record.containers or {}) do
		if (slot.tier or 0) > 0 or slot.inventoryID then continue end
		local definition = definitions[id]
		if definition then
			slot.recipe = definition.recipe
		else
			record.containers[id] = nil
		end
	end
end

local function pendingSeedsFit(plugin, record, template)
	for _, seed in pairs(record.seeds or {}) do
		if not seed.initialized and (not isvector(seed.pos)
			or not plugin:Contains(seed.pos, template.mins, template.maxs)) then return false end
	end

	return true
end

local function currentPlan(plugin, plan)
	if not migrationReady(plugin) then return false, "Hideout persistence is not ready." end
	if not sameValue(plugin.state.templates[plan.source], plan.sourceTemplate)
		or not sameValue(plugin.state.templates[plan.target], plan.targetTemplate)
		or plugin:GetMigrationDupeHash(plan.targetTemplate) ~= plan.dupeHash
		or plugin:GetMigrationDupeHash(plan.sourceTemplate) ~= plan.sourceDupeHash then
		return false, "Templates changed. Make a new preview."
	end
	local count = 0
	for id, record in pairs(plugin.state.hideouts) do
		if record.ownerType == "squad" or record.template ~= plan.source then continue end
		count = count + 1
		if roomBusy(plugin, record) then return false, "Room " .. id .. " is loaded or busy." end
		if not sameValue(record, plan.records[id]) then return false, "Room " .. id .. " changed. Preview again." end
	end
	if count ~= table.Count(plan.records) then return false, "The room list changed. Preview again." end
	if not sameValue(plugin.state.locations or {}, plan.locations) then
		return false, "Location bindings changed. Preview again."
	end

	return true
end

function PLUGIN:PreviewTemplateMigration(client, source, pilotID)
	if not authorized(client) then return false, "Administrator character required." end
	client.cotzHideoutMigration = nil
	if not migrationReady(self) then return false, "Hideout persistence is not ready." end
	local pilot = self:GetHideout(pilotID)
	local instance = pilot and self.instances[pilot.id]
	if not pilot or pilot.ownerType == "squad" or not instance or instance.state ~= "active"
		or instance.saving or (instance.operations or 0) > 0 or not pilot.personalLayout then
		return false, "Load a personal test room using the new template first; supply its hideout ID."
	end
	if source == pilot.template or not self.state.templates[source] then
		return false, "Choose an existing source template different from the test room's template."
	end
	local targetTemplate = self.state.templates[pilot.template]
	local dupeHash = self:GetMigrationDupeHash(targetTemplate)
	if not dupeHash or instance.migrationDupeHash ~= dupeHash then
		return false, "The test room must be loaded with the current dupe file and migration code. Reload it."
	end
	local sourceDupeHash = self:GetMigrationDupeHash(self.state.templates[source])
	if not sourceDupeHash then return false, "Keep the original source dupe available for layout rollback." end
	local plan = {
		schema = Schema.folder,
		map = game.GetMap(),
		source = source,
		target = pilot.template,
		sourceTemplate = table.Copy(self.state.templates[source]),
		targetTemplate = table.Copy(targetTemplate),
		dupeHash = dupeHash,
		sourceDupeHash = sourceDupeHash,
		definitions = table.Copy(instance.template.containers or {}),
		locations = table.Copy(self.state.locations or {}),
		records = {},
		expires = CurTime() + PREVIEW_LIFETIME,
	}
	local furnishings = 0
	for id, record in pairs(self.state.hideouts) do
		if record.ownerType == "squad" or record.template ~= source then continue end
		local sourceDefinitions = record.personalLayout or plan.sourceTemplate.containers or {}
		local ok, reason = validateContainers(record, plan.definitions, sourceDefinitions)
		if not ok then return false, reason end
		for _, prop in ipairs(record.furnishings or {}) do
			if not isvector(prop.pos) or not self:Contains(prop.pos, targetTemplate.mins, targetTemplate.maxs) then
				return false, "Room " .. id .. " has furnishings outside the new bounds. Reposition them first."
			end
			furnishings = furnishings + 1
		end
		if not pendingSeedsFit(self, record, targetTemplate) then
			return false, "Room " .. id .. " has uninitialized loot outside the new bounds. Initialize the old room first."
		end
		plan.records[id] = table.Copy(record)
	end
	if next(plan.records) == nil then return false, "No personal rooms use that source template." end
	local ok, reason = currentPlan(self, plan)
	if not ok then return false, reason end
	local token = util.SHA256(client:SteamID64() .. ":" .. SysTime() .. ":" .. source):sub(1, 16)
	plan.token = token
	client.cotzHideoutMigration = {plan = plan, character = client:GetCharacter()}
	local ids = table.GetKeys(plan.records)
	table.sort(ids)
	client:PrintMessage(HUD_PRINTCONSOLE, "[Hideouts] Migration rooms: " .. table.concat(ids, ", "))

	return true, string.format(
		"Preview %s: %d personal rooms, %s -> %s; %d furnishings retained. Containers move to new markers; floor items retain local coordinates. Inspect wall/floor clearance. Source locations also switch; squads stay unchanged. Unload ALL rooms, then /HideoutMigrateApply %s within 10 minutes.",
		token, #ids, source, pilot.template, furnishings, token
	)
end

local function applyMigration(self, client, token)
	if not authorized(client) then return false, "Administrator character required." end
	local pending = client.cotzHideoutMigration
	local plan = pending and pending.plan
	if not plan or plan.token ~= token or pending.character ~= client:GetCharacter()
		or plan.expires < CurTime() then return false, "Preview expired or belongs to another character. Preview again." end
	if next(self.instances) then return false, "Unload all hideouts, including the test room, first." end
	local ok, reason = currentPlan(self, plan)
	if not ok then return false, reason end
	-- Never start a second migration while an economic outcome may still be uncertain.
	for _, record in pairs(self.state.hideouts) do
		if roomBusy(self, record) then return false, "A hideout is busy; resolve pending saves/purchases first." end
	end
	if not writeBackup(token, plan) then return false, "Could not write and verify a new migration backup." end
	local previous = self.state
	self.state = table.Copy(previous)
	for id in pairs(plan.records) do
		local record = self.state.hideouts[id]
		record.template = plan.target
		record.personalLayout = table.Copy(plan.definitions)
		record.shell = {}
		record.cassetteTransform = nil
		record.ignoreTemplateSeeds = true
		record.templateMigration = token
		reconcileUninstalledContainers(record, plan.definitions)
		for _, slot in pairs(record.containers or {}) do slot.transform = nil end
	end
	for _, location in pairs(self.state.locations or {}) do
		if location.template == plan.source then location.template = plan.target end
	end
	if not self:Persist() then
		self.state = previous
		self.ready, self.operationsReady = false, false
		return false, "Migration save could not be verified. Keep the server closed and inspect saved plugin data and backup."
	end
	client.cotzHideoutMigration = nil

	return true, "Migrated " .. table.Count(plan.records) .. " rooms. Backup: data/" .. backupPath(token)
		.. ". Layout rollback: /HideoutMigrateRollback " .. token
end

local function rollbackMigration(self, client, token)
	if not authorized(client) then return false, "Administrator character required." end
	if not migrationReady(self) or next(self.instances) then return false, "Unload all hideouts first." end
	if not isstring(token) or not token:match("^[a-f0-9]+$") or #token ~= 16 then
		return false, "Use the migration token from the apply result."
	end
	local plan = readBackup(self, token)
	if not plan then return false, "No matching migration backup on this map." end
	if not sameValue(self.state.templates[plan.source], plan.sourceTemplate)
		or self:GetMigrationDupeHash(plan.sourceTemplate) ~= plan.sourceDupeHash then
		return false, "Restore the original source template and dupe before rolling back."
	end
	for _, record in pairs(self.state.hideouts) do
		if roomBusy(self, record) then return false, "A hideout is busy; resolve pending saves/purchases first." end
	end
	for id, before in pairs(plan.records) do
		local record = self:GetHideout(id)
		if not record or record.templateMigration ~= token or record.template ~= plan.target
			or roomBusy(self, record) then return false, "Room " .. id .. " changed migration or is busy." end
		for _, prop in ipairs(record.furnishings or {}) do
			if not isvector(prop.pos) or not self:Contains(prop.pos, plan.sourceTemplate.mins, plan.sourceTemplate.maxs) then
				return false, "Room " .. id .. " has furnishings outside the original bounds. Reposition them first."
			end
		end
		if not pendingSeedsFit(self, record, plan.sourceTemplate) then
			return false, "Room " .. id .. " has uninitialized loot outside the original bounds."
		end
		local definitions = before.personalLayout or plan.sourceTemplate.containers or {}
		local ok, reason = validateContainers(record, definitions, plan.definitions)
		if not ok then return false, reason .. "; rollback would strand new storage." end
	end
	for id, before in pairs(plan.locations) do
		local current = (self.state.locations or {})[id]
		local expected = table.Copy(before)
		if expected.template == plan.source then expected.template = plan.target end
		if not sameValue(current, expected) then return false, "Locations changed; reconcile them before rollback." end
	end
	for id, location in pairs(self.state.locations or {}) do
		if not plan.locations[id] and location.template == plan.target then
			return false, "A new target location exists; reconcile it before rollback."
		end
	end
	local previous = self.state
	self.state = table.Copy(previous)
	for id, before in pairs(plan.records) do
		local record = self.state.hideouts[id]
		for _, key in ipairs({"template", "personalLayout", "shell", "cassetteTransform", "ignoreTemplateSeeds"}) do
			record[key] = istable(before[key]) and table.Copy(before[key]) or before[key]
		end
		record.templateMigration = before.templateMigration
		reconcileUninstalledContainers(record, before.personalLayout or plan.sourceTemplate.containers or {})
		for slotID, slot in pairs(record.containers or {}) do
			slot.transform = before.containers and before.containers[slotID] and before.containers[slotID].transform
		end
	end
	for id, before in pairs(plan.locations) do
		if before.template == plan.source then self.state.locations[id] = table.Copy(before) end
	end
	if not self:Persist() then
		self.state = previous
		self.ready, self.operationsReady = false, false
		return false, "Rollback save could not be verified. Inspect saved plugin data before reopening the server."
	end

	return true, "Original template layouts restored. Current inventories, upgrades, furnishings and progression retained."
end

local function checkFloorItems(plugin, plan, template, callback)
	local query = mysql:Select("ix_items")
	query:Where("inventory_id", 0)
	-- The transaction adapter reports read failures instead of mistaking them for an empty room.
	plugin:RunAtomicQueries({query}, function(ok, rows)
		if not ok then callback(false, "Could not verify floor items. Check the database and try again.") return end
		for _, row in ipairs(rows or {}) do
			local data = util.JSONToTable(row.data or "{}")
			local location = data and data.cotzHideout
			if not istable(location) or location.schema ~= plan.schema or location.map ~= plan.map
				or not plan.records[tostring(location.id)] then continue end
			if not isvector(location.pos) or not plugin:Contains(location.pos, template.mins, template.maxs) then
				callback(false, "Floor item " .. row.item_id .. " is outside the destination bounds. Reposition it first.")

				return
			end
		end
		callback(true)
	end)
end

function PLUGIN:ApplyTemplateMigration(client, token)
	if not authorized(client) then return false, "Administrator character required." end
	local pending = client.cotzHideoutMigration
	local plan = pending and pending.plan
	if not plan or plan.token ~= token or pending.character ~= client:GetCharacter()
		or plan.expires < CurTime() then return false, "Preview expired or belongs to another character. Preview again." end
	if not migrationReady(self) or next(self.instances) then return false, "Unload all hideouts first." end
	if pending.checking then return false, "Floor-item verification is already pending." end
	pending.checking = true
	checkFloorItems(self, plan, plan.targetTemplate, function(ok, reason)
		pending.checking = nil
		if not authorized(client) or pending.character ~= client:GetCharacter() then return end
		if ok then ok, reason = applyMigration(self, client, token) end
		client:Notify(reason)
	end)

	return true, "Checking floor items; the migration result will follow."
end

function PLUGIN:RollbackTemplateMigration(client, token)
	if not authorized(client) then return false, "Administrator character required." end
	if not migrationReady(self) or next(self.instances) then return false, "Unload all hideouts first." end
	if not isstring(token) or not token:match("^[a-f0-9]+$") or #token ~= 16 then
		return false, "Use the migration token from the apply result."
	end
	if client.cotzMigrationRollback then return false, "A rollback verification is already pending." end
	local plan = readBackup(self, token)
	if not plan then return false, "No matching migration backup on this map." end
	local character = client:GetCharacter()
	client.cotzMigrationRollback = true
	checkFloorItems(self, plan, plan.sourceTemplate, function(ok, reason)
		client.cotzMigrationRollback = nil
		if not authorized(client) or character ~= client:GetCharacter() then return end
		if ok then ok, reason = rollbackMigration(self, client, token) end
		client:Notify(reason)
	end)

	return true, "Checking floor items; the rollback result will follow."
end

function PLUGIN:ConfigurePersonalMigration(client, source, pilotID)
	if not authorized(client) then return false, "Administrator character required." end
	if not migrationReady(self) then return false, "Hideout persistence is not ready." end
	local pilot = self:GetHideout(pilotID)
	local instance = pilot and self.instances[pilot.id]
	if not pilot or pilot.ownerType == "squad" or not instance or instance.state ~= "active"
		or instance.saving or (instance.operations or 0) > 0 or not pilot.personalLayout then
		return false, "Load and inspect a personal test room using the destination template first."
	end
	if source == pilot.template or not self.state.templates[source] then
		return false, "Choose an existing old template different from the test room's template."
	end
	local target = self.state.templates[pilot.template]
	local hash = target and self:GetMigrationDupeHash(target)
	if not hash or instance.migrationDupeHash ~= hash then
		return false, "Reload the test room with the current destination dupe first."
	end
	self.state.migrationOffers = self.state.migrationOffers or {}
	local previous = self.state.migrationOffers[source]
	self.state.migrationOffers[source] = {
		target = pilot.template, targetTemplate = table.Copy(target), dupeHash = hash,
		definitions = table.Copy(instance.template.containers or {}),
	}
	if not self:Persist() then
		self.state.migrationOffers[source] = previous
		return false, "Could not save the migration offer."
	end

	return true, "Owners on " .. source .. " can now migrate to " .. pilot.template .. " from entrance management."
end

function PLUGIN:GetPersonalMigrationOffer(record)
	if not record or record.ownerType == "squad" then return end
	local offer = (self.state.migrationOffers or {})[record.template]
	if offer and offer.target ~= record.template
		and sameValue(self.state.templates[offer.target], offer.targetTemplate) then return offer end
end

function PLUGIN:MigratePersonalHideout(client, record)
	local session = client.cotzHideoutMenu
	local offer = self:GetPersonalMigrationOffer(record)
	if not migrationReady(self) or not self:CanManageHideout(client, record)
		or not self:CanUseManagementMenu(client, record.id) or session.scope ~= "entrance"
		or not offer or not sameValue((session.migrations or {})[record.id], offer) then
		return false, "Reopen entrance management for the current migration offer."
	end
	if roomBusy(self, record) then return false, "Everyone must leave and let this hideout finish saving first." end
	if self:GetMigrationDupeHash(offer.targetTemplate) ~= offer.dupeHash then
		return false, "The destination changed. Ask an administrator to update the migration offer."
	end
	local sourceTemplate = self.state.templates[record.template]
	if not sourceTemplate then return false, "The old template is unavailable. Contact an administrator." end
	local ok, reason = validateContainers(record, offer.definitions,
		record.personalLayout or sourceTemplate.containers or {})
	if not ok then return false, reason end
	if not pendingSeedsFit(self, record, offer.targetTemplate) then
		return false, "Initialize the old room's loose items before migrating."
	end
	local character = client:GetCharacter()
	local snapshot, quotedOffer = table.Copy(record), table.Copy(offer)
	local token = util.SHA256(client:SteamID64() .. ":" .. SysTime() .. ":" .. record.id):sub(1, 16)
	local plan = {
		token = token, schema = Schema.folder, map = game.GetMap(),
		source = record.template, target = offer.target,
		sourceTemplate = table.Copy(sourceTemplate), targetTemplate = table.Copy(offer.targetTemplate),
		records = {[record.id] = snapshot}, definitions = table.Copy(offer.definitions), locations = {},
	}
	self.personalPurchases[record.id] = true
	checkFloorItems(self, plan, offer.targetTemplate, function(verified, failure)
		local currentOffer = self:GetPersonalMigrationOffer(record)
		local allowed = IsValid(client) and client:GetCharacter() == character
			and migrationReady(self) and self:GetHideout(record.id) == record
			and self:CanManageHideout(client, record) and self:CanUseManagementMenu(client, record.id)
			and client.cotzHideoutMenu == session and not self.instances[record.id]
			and sameValue(record, snapshot) and sameValue(currentOffer, quotedOffer)
			and sameValue(self.state.templates[record.template], plan.sourceTemplate)
			and self:GetMigrationDupeHash(quotedOffer.targetTemplate) == quotedOffer.dupeHash
		if not allowed then verified, failure = false, "Hideout state or access changed. Reopen management." end
		if verified and not writeBackup(token, plan) then
			verified, failure = false, "Could not verify the migration backup. Nothing was moved."
		end
		if verified then
			local moved = table.Copy(record)
			moved.template = quotedOffer.target
			moved.personalLayout = table.Copy(quotedOffer.definitions)
			moved.furnishings, moved.shell = {}, {}
			moved.cassetteTransform = nil
			moved.ignoreTemplateSeeds = true
			moved.personalMigration = token
			reconcileUninstalledContainers(moved, quotedOffer.definitions)
			for _, slot in pairs(moved.containers or {}) do slot.transform = nil end
			self.state.hideouts[record.id] = moved
			if not self:Persist() then
				self.state.hideouts[record.id] = record
				self.ready, self.operationsReady = false, false
				verified, failure = false, "Migration save could not be verified. Contact an administrator."
				ErrorNoHalt("[Hideouts] Uncertain personal migration; backup: data/" .. backupPath(token) .. "\n")
			end
		end
		self.personalPurchases[record.id] = nil
		if IsValid(client) and client:GetCharacter() == character then
			if verified and client.cotzHideoutMenu == session then client.cotzHideoutMenu = nil end
			client:Notify(verified and "Hideout migrated. Storage, upgrades and items were kept; placed props were discarded."
				or failure)
		end
	end)

	return true
end
