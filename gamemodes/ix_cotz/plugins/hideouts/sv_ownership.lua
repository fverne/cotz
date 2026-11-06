local PLUGIN = PLUGIN

local function query(statement, callback)
	ix.crossserver.Query(statement, callback)
end

function PLUGIN:ClaimSquadHome(record, callback)
	local claim = mysql:InsertIgnore("ix_hideout_homes")
	claim:Insert("scope", Schema.folder)
	claim:Insert("squad", record.squadID)
	claim:Insert("map", game.GetMap())
	claim:Insert("hideout", record.id)
	query(claim, function(_, failure)
		if failure then callback(false, "Could not reserve squad ownership.") return end
		local read = mysql:Select("ix_hideout_homes")
		read:Where("scope", Schema.folder)
		read:Where("squad", record.squadID)
		query(read, function(rows, readFailure)
			local home = not readFailure and rows and rows[1]
			local allowed = home and home.map == game.GetMap() and tostring(home.hideout) == record.id
			callback(allowed == true, home and "This squad already owns a hideout on " .. home.map .. "."
				or "Squad ownership could not be verified.")
		end)
	end)
end

function PLUGIN:InitializeSquadHomes(callback)
	local homes = mysql:Create("ix_hideout_homes")
	homes:Create("scope", "VARCHAR(64) NOT NULL")
	homes:Create("squad", "VARCHAR(20) NOT NULL")
	homes:Create("map", "VARCHAR(128) NOT NULL")
	homes:Create("hideout", "VARCHAR(20) NOT NULL")
	homes:PrimaryKey({"scope", "squad"})
	query(homes, function(_, failure)
		if failure then callback(false) return end
		local pending = {}
		for _, record in pairs(self.state.hideouts) do
			if record.ownerType == "squad" then pending[#pending + 1] = record end
		end
		table.sort(pending, function(a, b) return a.id < b.id end)
		local function nextClaim(index)
			local record = pending[index]
			if not record then callback(true) return end
			self:ClaimSquadHome(record, function(ok, reason)
				record.homeConflict = not ok
				if ok then record.homePending = nil end
				if not ok then
					ErrorNoHalt("[Hideouts] Preserved conflicting squad hideout #" .. record.id .. ": " .. reason .. "\n")
				end
				nextClaim(index + 1)
			end)
		end
		nextClaim(1)
	end)
end

function PLUGIN:ReleaseSquadHome(record, callback)
	if record.ownerType ~= "squad" then callback(true) return end
	local remove = mysql:Delete("ix_hideout_homes")
	remove:Where("scope", Schema.folder)
	remove:Where("squad", record.squadID)
	remove:Where("map", game.GetMap())
	remove:Where("hideout", record.id)
	query(remove, function(_, failure) callback(not failure) end)
end
