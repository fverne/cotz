local PLUGIN = PLUGIN

local function frame(title)
	return ix.cotzUI.Frame(title, 0.8, 0.75, 900)
end

local function button(parent, text, callback)
	return ix.cotzUI.Button(parent, text, callback)
end

local function sendManagement(panel, id, action, value, expectedTier)
	if (panel.nextRequest or 0) > CurTime() then return end
	panel.nextRequest = CurTime() + 0.5
	net.Start("cotz/hideouts/manage-action")
	net.WriteString(id)
	net.WriteUInt(action, 4)
	net.WriteString(value or "")
	net.WriteUInt(expectedTier or 0, 8)
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
		ix.cotzUI.Label(scroll, name, true)
		if scope == "exit" then
			button(scroll, "Leave hideout", function()
				sendManagement(panel, id, 9)
				panel:Remove()
			end)
		end
		if manage then
			for _, option in ipairs({{label = "Invite character", action = 6}, {label = "Revoke invitation", action = 7}}) do
				button(scroll, option.label, function()
					local menu = ix.cotzUI.Menu()
					for _, target in ipairs(player.GetHumans()) do
						local character = target:GetCharacter()
						if character and target ~= LocalPlayer() then
							menu:AddOption(character:GetName(), function()
								sendManagement(panel, id, option.action, tostring(character:GetID()))
							end)
						end
					end
					menu:Open()
				end)
			end
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
		ix.cotzUI.Label(scroll, "Fully upgraded")
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
			or "Private: owner only — share with invited guests", function() sendManagement(panel, id, 5, slot) end)
	end
end)

net.Receive("cotz/hideouts/shop-close", function()
	if IsValid(ix.gui.vendor) and ix.gui.vendor.entity:GetClass() == "ix_hideout_vendor" then
		ix.gui.vendor:Remove()
	end
end)

net.Receive("cotz/hideouts/history", function()
	local panel, scroll = frame("Recent squad transactions")
	local labels = {sale = "Sale", withdraw = "Treasury withdrawal", donate = "Stock donation", recover = "Stock recovery"}
	for _ = 1, net.ReadUInt(6) do
		local timestamp, name, kind, delta = net.ReadUInt(32), net.ReadString(), net.ReadString(), net.ReadInt(32)
		ix.cotzUI.Label(scroll, os.date("%Y-%m-%d %H:%M", timestamp) .. " — " .. name .. " — "
			.. (labels[kind] or kind) .. " — treasury " .. (delta >= 0 and "+" or "") .. delta)
	end
end)
