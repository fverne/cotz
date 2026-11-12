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
	net.WriteUInt(action, 4)
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
		local propTier, propLimit = net.ReadUInt(3), net.ReadUInt(7)
		local nextPropLimit, propPrice = net.ReadUInt(7), net.ReadUInt(32)
		local guests = {}
		for _ = 1, net.ReadUInt(16) do
			guests[#guests + 1] = {id = net.ReadUInt(32), name = net.ReadString()}
		end
		ix.cotzUI.Label(scroll, name, true)
		ix.cotzUI.Label(scroll, "Prop capacity: " .. propLimit)
		if scope == "exit" then
			button(scroll, "Leave hideout", function()
				sendManagement(panel, id, 9)
				panel:Remove()
			end)
		end
		if manage then
			if nextPropLimit > 0 then
				button(scroll, "Upgrade prop capacity to " .. nextPropLimit .. " (" .. ix.currency.Get(propPrice) .. ")", function()
					ix.cotzUI.Confirm("Increase this hideout's prop capacity to " .. nextPropLimit .. " for " .. ix.currency.Get(propPrice) .. "?",
						"Upgrade prop capacity", "Purchase", function()
							sendManagement(panel, id, 0, "", propTier)
						end, "Cancel")
				end)
			end
			if canReset then
				button(scroll, "Reset hideout layout", function()
					ix.cotzUI.Confirm("Restore containers you manage to their template positions and remove props placed by this character? Stored items and purchased upgrades are kept.",
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
	local width, height, hasUpgrade = net.ReadUInt(6), net.ReadUInt(6), net.ReadBool()
	local required, nextWidth, nextHeight
	if hasUpgrade then required, nextWidth, nextHeight = net.ReadString(), net.ReadUInt(6), net.ReadUInt(6) end
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
	if hasUpgrade then
		local label = tier == 0 and "Install" or "Upgrade"
		button(scroll, label .. " with " .. required .. " (" .. nextWidth .. " × " .. nextHeight .. ")", function()
			ix.cotzUI.Query("Hand in " .. required .. " for " .. nextWidth .. " × " .. nextHeight .. " storage?",
				label .. " container", "Hand in", function() sendManagement(panel, id, 4, slot, tier) end, "Cancel")
		end)
	else
		ix.cotzUI.Label(scroll, squad and "Fully upgraded" or "Upgrades are available at the local hideout trader's barter menu.")
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
		recover = "Stock recovery", props = "Prop capacity upgrade"}
	for _ = 1, net.ReadUInt(6) do
		local timestamp, name, kind, delta = net.ReadUInt(32), net.ReadString(), net.ReadString(), net.ReadInt(32)
		ix.cotzUI.Label(scroll, os.date("%Y-%m-%d %H:%M", timestamp) .. " — " .. name .. " — "
			.. (labels[kind] or kind) .. " — treasury " .. (delta >= 0 and "+" or "") .. delta)
	end
end)
