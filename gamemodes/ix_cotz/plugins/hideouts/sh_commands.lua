local PLUGIN = PLUGIN
ix.inventory.Register("hideout", 8, 6)

ix.command.Add("HideoutAreaStart", {
	adminOnly = true,
	OnRun = function(self, client)
		client.ixHideoutAreaStart = client:GetPos()

		return "First area corner marked at your feet. Move to the opposite upper corner "
			.. "and use /HideoutAreaFinish <name>."
	end,
})

ix.command.Add("HideoutAreaFinish", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, name)
		local first = client.ixHideoutAreaStart
		if not first then
			return "Use /HideoutAreaStart first."
		end
		local last = client:GetPos()
		local mins = Vector(math.min(first.x, last.x), math.min(first.y, last.y), math.min(first.z, last.z))
		local maxs = Vector(math.max(first.x, last.x), math.max(first.y, last.y), math.max(first.z, last.z))
		if maxs.x - mins.x < 128 or maxs.y - mins.y < 128 or maxs.z - mins.z < 128 then
			return "The usable volume must be at least 128 units on each axis."
		end
		if not table.IsEmpty(PLUGIN.instances) then
			return "Unload all hideouts before changing areas."
		end
		PLUGIN.state.areas[name] = { mins = mins, maxs = maxs }
		if not PLUGIN:Persist() then
			return "Could not save area configuration."
		end
		client.ixHideoutAreaStart = nil

		return "Saved hideout area " .. name .. "."
	end,
})

ix.command.Add("HideoutRecovery", {
	adminOnly = true,
	OnRun = function(self, client)
		PLUGIN.state.recovery = client:GetPos()
		if not PLUGIN:Persist() then
			return "Could not save the recovery point."
		end

		return "Saved the outside recovery point."
	end,
})

ix.command.Add("HideoutTemplateAdd", {
	adminOnly = true,
	arguments = { ix.type.string, ix.type.string, ix.type.number, ix.type.number, ix.type.number },
	OnRun = function(self, client, id, dupe, width, depth, height)
		if width < 128 or depth < 128 or height < 128 or width > 16000 or depth > 16000 or height > 16000 then
			return "Template dimensions must be between 128 and 16000 units."
		end
		if not table.IsEmpty(PLUGIN.instances) then
			return "Unload all hideouts before editing templates."
		end
		local integration = ix.plugin.Get("advdupeint")
		if not integration then
			return "AdvDupe integration is unavailable."
		end
		local decoded, err = integration:ReadDupe(dupe)
		if not decoded then
			return err
		end
		local template = {
			dupe = dupe,
			mins = Vector(-width / 2, -depth / 2, -16),
			maxs = Vector(width / 2, depth / 2, height),
			spawns = { Vector(0, 0, 8), Vector(48, 0, 8), Vector(-48, 0, 8) },
			exit = Vector(0, 64, 24),
			storage = Vector(80, 64, 24),
			facing = angle_zero,
		}
		local ok, reason = PLUGIN:ValidateDupe(decoded, template)
		if not ok then
			return reason
		end
		PLUGIN.state.templates[id] = template
		if not PLUGIN:Persist() then
			return "Could not save the template."
		end

		return "Saved template "
			.. id
			.. ". Its paste anchor is the floor center; use /HideoutTemplatePoint "
			.. "to adjust local utility and spawn positions."
	end,
})

ix.command.Add("HideoutTemplatePoint", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional),
		bit.bor(ix.type.number, ix.type.optional),
		bit.bor(ix.type.number, ix.type.optional),
	},
	OnRun = function(self, client, id, point, x, y, z)
		local ok, message = PLUGIN:SetTemplatePoint(client, id, point, x, y, z)

		return message
	end,
})

ix.command.Add("HideoutEntranceAdd", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		if not table.IsEmpty(PLUGIN.instances) then
			return "Unload all hideouts before editing entrances."
		end
		local trace = client:GetEyeTraceNoCursor()
		if not trace.Hit or trace.HitSky or trace.HitPos:DistToSqr(client:GetPos()) > 256 * 256 then
			return "Look at a nearby wall or floor."
		end
		PLUGIN.state.entrances[id] = {
			pos = trace.HitPos + trace.HitNormal * 3,
			angles = trace.HitNormal:Angle(),
			outside = client:GetPos(),
		}
		if not PLUGIN:Persist() then
			return "Could not save the entrance."
		end
		PLUGIN:SpawnEntrances()

		return "Saved entrance " .. id .. "."
	end,
})

ix.command.Add("HideoutGrant", {
	adminOnly = true,
	arguments = { ix.type.player, ix.type.string, ix.type.string, ix.type.text },
	OnRun = function(self, client, target, template, entrance, name)
		local ok, result = PLUGIN:GrantHideout(target, template, entrance, name)
		if not ok then
			return result
		end
		target:Notify("Your character received hideout #" .. result .. ": " .. name)

		return "Created hideout #" .. result .. "."
	end,
})

ix.command.Add("HideoutList", {
	adminOnly = true,
	OnRun = function(self, client)
		local records = {}
		for _, record in pairs(PLUGIN.state.hideouts) do
			if PLUGIN:CanAccess(client, record) then
				records[#records + 1] = "#"
					.. record.id
					.. " "
					.. record.name
					.. " ("
					.. record.entrance
					.. ")"
			end
		end

		return #records > 0 and table.concat(records, "; ") or "This character has no hideouts."
	end,
})

ix.command.Add("HideoutEnter", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		local ok, err = PLUGIN:RequestEntry(client, id)
		if not ok then
			return err
		end
	end,
})

ix.command.Add("HideoutLeave", {
	adminOnly = true,
	OnRun = function(self, client)
		local ok, err = PLUGIN:LeaveHideout(client, true)
		if not ok then
			return err
		end
	end,
})

ix.command.Add("HideoutInvite", {
	adminOnly = true,
	arguments = { ix.type.string, ix.type.player },
	OnRun = function(self, client, id, target)
		local record = PLUGIN:GetHideout(id)
		if not PLUGIN:CanManageHideout(client, record) then
			return "You do not own that hideout."
		end
		local character = target:GetCharacter()
		if not character then
			return "The player has no active character."
		end
		local previous = record.guests[tostring(character:GetID())]
		record.guests[tostring(character:GetID())] = true
		if not PLUGIN:Persist() then
			record.guests[tostring(character:GetID())] = previous
			return "Could not save the invitation."
		end
		target:Notify("Your character can now enter " .. record.name .. ".")

		return "Character invited."
	end,
})

ix.command.Add("HideoutRevoke", {
	adminOnly = true,
	arguments = { ix.type.string, ix.type.player },
	OnRun = function(self, client, id, target)
		local record = PLUGIN:GetHideout(id)
		if not PLUGIN:CanManageHideout(client, record) then
			return "You do not own that hideout."
		end
		if not target:GetCharacter() then
			return "The player has no active character."
		end
		local key = tostring(target:GetCharacter():GetID())
		local previous = record.guests[key]
		record.guests[key] = nil
		if not PLUGIN:Persist() then
			record.guests[key] = previous
			return "Could not save access changes."
		end
		if PLUGIN.members[target] == record.id and not PLUGIN:CanAccess(target, record) then
			PLUGIN:LeaveHideout(target, true)
		end

		return "Character access revoked."
	end,
})

ix.command.Add("HideoutStatus", {
	adminOnly = true,
	OnRun = function(self, client)
		local status = {}
		for id, instance in pairs(PLUGIN.instances) do
			status[#status + 1] = "#"
				.. id
				.. ": "
				.. instance.state
				.. ", occupants "
				.. table.Count(instance.occupants)
		end

		return #status > 0 and table.concat(status, "; ") or "No hideouts are loaded."
	end,
})

ix.command.Add("HideoutRetrySave", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		local instance = PLUGIN.instances[id]
		if not instance or instance.state ~= "failed" or instance.saving then
			return "No retryable save failure for this hideout; restart after resolving a stalled database connection."
		end
		PLUGIN:UnloadInstance(instance)

		return "Save retried."
	end,
})

ix.command.Add("HideoutDelete", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		PLUGIN:DeleteHideout(id, function(ok, reason)
			if IsValid(client) then
				client:Notify(reason or (ok and "Hideout deleted." or "Hideout deletion failed."))
			end
		end)
	end,
})

ix.command.Add("HideoutLegacyStorage", {
	adminOnly = true,
	arguments = ix.type.string,
	OnRun = function(self, client, id)
		local ok, err = PLUGIN:OpenLegacyStorage(client, id)
		if not ok then
			return err
		end
	end,
})
