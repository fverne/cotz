local PLUGIN = PLUGIN

local function frame(title)
	return ix.cotzUI.Frame(title, 0.8, 0.75, 900)
end

local function button(parent, text, callback)
	return ix.cotzUI.Button(parent, text, callback)
end

local function sendManagement(panel, id, action, value, expectedTier, guestID)
	if (panel.nextRequest or 0) > CurTime() then return end
	panel.nextRequest = CurTime() + 0.5
	net.Start("cotz/hideouts/manage-action")
	net.WriteString(id)
	net.WriteUInt(action, 5)
	net.WriteString(value or "")
	net.WriteUInt(expectedTier or 0, 8)
	net.WriteUInt(guestID or 0, 32)
	net.SendToServer()
end

function PLUGIN:RequestManagement(id, scope)
	local scopes = {entrance = 1, exit = 2, vendor = 3, squad = 4}
	if not scopes[scope] or (self.nextMenuRequest or 0) > CurTime() then return end
	self.nextMenuRequest = CurTime() + 0.5
	net.Start("cotz/hideouts/manage-open")
	net.WriteUInt(scopes[scope], 3)
	net.WriteString(id or "")
	net.SendToServer()
end

net.Receive("cotz/hideouts/manage", function()
	if IsValid(ix.gui.hideoutManagement) then ix.gui.hideoutManagement:Remove() end
	local scope, count = net.ReadString(), net.ReadUInt(4)
	local panel, scroll = frame(scope == "exit" and "Hideout exit" or "Hideout management")
	ix.gui.hideoutManagement = panel
	if count == 0 then
		local message = scope == "squad" and "No squad hideout is available on this map."
			or "No hideout management is available at this location."
		ix.cotzUI.Label(scroll, message)
	end
	for _ = 1, count do
		local id, name = net.ReadString(), net.ReadString()
		local squad, access = net.ReadBool(), net.ReadString()
		local manage, canReset = net.ReadBool(), net.ReadBool()
		local propLimit = net.ReadUInt(7)
		local leader, fundUpgrades = net.ReadBool(), net.ReadBool()
		local guests = {}
		for _ = 1, net.ReadUInt(16) do
			guests[#guests + 1] = {id = net.ReadUInt(32), name = net.ReadString()}
		end
		local migrationTarget = net.ReadString()
		ix.cotzUI.Label(scroll, name, true)
		ix.cotzUI.Label(scroll, "Prop capacity: " .. propLimit)
		if scope == "exit" then
			button(scroll, "Leave hideout", function()
				sendManagement(panel, id, 9)
				panel:Remove()
			end)
		end
		if manage then
			if not squad and scope == "entrance" and migrationTarget ~= "" then
				button(scroll, "Migrate hideout to " .. migrationTarget, function()
					ix.cotzUI.Query("Move this hideout to the new interior? Containers, their upgrades and contents, room upgrades and ground items are kept. Player-placed props are discarded without a refund. Everyone must leave the hideout and let it finish saving first. Ground items keep their local positions; the move is blocked if they do not fit the new bounds.",
						"Migrate personal hideout", "Migrate hideout", function()
							sendManagement(panel, id, 18)
							panel:Remove()
						end, "Cancel")
				end)
			end
			if not squad and (scope == "entrance" or scope == "exit") then
				button(scroll, "Delete personal hideout", function()
					ix.cotzUI.Query("Permanently delete this hideout? Everyone inside will be moved outside. Furnishings, loose items and upgrades are lost, with no refund. Empty your containers first; their contents will only be recoverable by an administrator. You can arrange a new hideout at a configured entrance afterward.",
						"Delete personal hideout", "Delete hideout", function()
							sendManagement(panel, id, 17)
							panel:Remove()
						end, "Cancel")
				end)
			end
			if canReset then
				button(scroll, "Reset hideout layout", function()
					ix.cotzUI.Query("Restore containers you manage to their template positions and remove props placed by this character? Stored items and purchased upgrades are kept.",
						"Reset hideout layout", "Reset layout", function() sendManagement(panel, id, 15) end, "Cancel")
				end)
			end
			button(scroll, "Invite character", function()
				local menu = ix.cotzUI.Menu()
				for _, target in ipairs(player.GetHumans()) do
					local character = target:GetCharacter()
					if character and target ~= LocalPlayer() then
						menu:AddOption(character:GetName(), function()
							sendManagement(panel, id, 6, tostring(character:GetID()))
						end)
					end
				end
				menu:Open()
			end)
			button(scroll, "Revoke invitation", function()
				local menu = ix.cotzUI.Menu()
				for _, guest in ipairs(guests) do
					menu:AddOption(guest.name, function()
						sendManagement(panel, id, 7, tostring(guest.id))
					end)
				end
				menu:Open()
			end)
			if squad then
				ix.cotzUI.Label(scroll, "Vendor funding for upgrades: " .. (fundUpgrades and "enabled" or "disabled"))
				if leader then
					button(scroll, "Use squad vendor funds for hideout upgrades: " .. (fundUpgrades and "on" or "off"), function()
						sendManagement(panel, id, 16, fundUpgrades and "0" or "1")
					end)
				end
				if scope == "squad" or scope == "entrance" then
					button(scroll, "Place entrance where you are looking", function() sendManagement(panel, id, 1) end)
				end
				if canReset then
					button(scroll, "Reset vendor position", function() sendManagement(panel, id, 2) end)
				end
				button(scroll, "Access: " .. access, function()
					local menu = ix.cotzUI.Menu()
					for _, mode in ipairs({"public", "invite", "squad"}) do
						menu:AddOption(mode, function() sendManagement(panel, id, 3, mode) end)
					end
					menu:Open()
				end)
			end
		end
	end
end)

net.Receive("cotz/hideouts/container", function()
	if IsValid(ix.gui.hideoutContainer) then ix.gui.hideoutContainer:Remove() end
	local id, slot, name = net.ReadString(), net.ReadString(), net.ReadString()
	local tier, public = net.ReadUInt(8), net.ReadBool()
	local squad, minimumRank, rank = net.ReadBool(), net.ReadUInt(2), net.ReadUInt(2)
	local width, height, contact = net.ReadUInt(6), net.ReadUInt(6), net.ReadString()
	local guests = {}
	for _ = 1, net.ReadUInt(7) do
		guests[#guests + 1] = {id = net.ReadUInt(32), name = net.ReadString(), allowed = net.ReadBool()}
	end
	local panel, scroll = frame(name)
	ix.gui.hideoutContainer = panel
	if tier > 0 then
		button(scroll, "Open storage (" .. width .. " × " .. height .. ")", function()
			sendManagement(panel, id, 8, slot)
			panel:Remove()
		end)
	else
		ix.cotzUI.Label(scroll, "Container not installed")
	end
	if contact ~= "" then
		ix.cotzUI.Label(scroll, "Installation and upgrades are arranged with " .. contact .. ".")
	end
	if squad then
		local labels = {[0] = "Entire squad", [1] = "Officers and leader", [2] = "Leader only"}
		button(scroll, "Storage access: " .. labels[minimumRank], function()
			local menu = ix.cotzUI.Menu()
			for minimum = 0, rank do
				menu:AddOption(labels[minimum], function() sendManagement(panel, id, 10 + minimum, slot) end)
			end
			menu:Open()
		end)
	else
		button(scroll, public and "Public: invited guests can access — make private"
			or "Private: selected guests only — share with all invited guests", function()
				sendManagement(panel, id, 5, slot)
			end)
		if not public then
			for _, guest in ipairs(guests) do
				local action = guest.allowed and 14 or 13
				local guestID = guest.id
				button(scroll, (guest.allowed and "Revoke: " or "Allow: ") .. guest.name, function()
					sendManagement(panel, id, action, slot, tier, guestID)
				end)
			end
		end
	end
end)

net.Receive("cotz/hideouts/shop-close", function()
	if IsValid(ix.gui.vendor) and ix.gui.vendor.entity:GetClass() == "ix_hideout_vendor" then
		ix.gui.vendor:Remove()
	end
end)

net.Receive("cotz/hideouts/history", function()
	local panel, scroll = frame("Recent squad transactions")
	local labels = {sale = "Sale", withdraw = "Treasury withdrawal", donate = "Stock donation",
		recover = "Stock recovery", props = "Prop capacity upgrade", craft = "Storage crate assembly",
		upgrade = "Storage upgrade"}
	for _ = 1, net.ReadUInt(6) do
		local timestamp, name, kind, delta = net.ReadUInt(32), net.ReadString(), net.ReadString(), net.ReadInt(32)
		ix.cotzUI.Label(scroll, os.date("%Y-%m-%d %H:%M", timestamp) .. " — " .. name .. " — "
			.. (labels[kind] or kind) .. " — treasury " .. (delta >= 0 and "+" or "") .. delta)
	end
end)
