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
	button(scroll, public and "Public: invited guests can access — make private"
		or "Private: owner only — share with invited guests", function() sendManagement(panel, id, 5, slot) end)
end)

net.Receive("cotz/hideouts/shop-close", function()
	if IsValid(ix.gui.hideoutShop) then ix.gui.hideoutShop:Remove() end
end)

net.Receive("cotz/hideouts/shop", function()
	if IsValid(ix.gui.hideoutShop) then ix.gui.hideoutShop:Remove() end
	local id, name, rank, balance = net.ReadString(), net.ReadString(), net.ReadInt(3), net.ReadUInt(32)
	local commission = net.ReadUInt(7)
	local page, pages, count = net.ReadUInt(5), net.ReadUInt(5), net.ReadUInt(5)
	local panel, scroll = frame(name .. " — Squad vendor")
	ix.gui.hideoutShop = panel
	local function send(action, itemID, amount, revision)
		if (panel.nextRequest or 0) > CurTime() then return end
		panel.nextRequest = CurTime() + 0.5
		net.Start("cotz/hideouts/shop-action")
		net.WriteString(id)
		net.WriteUInt(action, 3)
		net.WriteUInt(itemID or 0, 32)
		net.WriteUInt(amount or 0, 32)
		net.WriteUInt(revision or 0, 32)
		net.SendToServer()
	end
	if pages > 1 then
		button(scroll, "Page " .. page .. " / " .. pages .. " — previous", function()
			send(7, 0, math.max(1, page - 1))
		end)
		button(scroll, "Next page", function() send(7, 0, math.min(pages, page + 1)) end)
	end
	if rank >= 1 then
		button(scroll, "Manage squad hideout", function() PLUGIN:RequestManagement(id, "vendor") end)
	end
	if rank >= 0 then
		ix.cotzUI.Label(scroll, "Treasury: " .. balance .. " roubles — sale commission " .. commission .. "%", true)
		button(scroll, "Recent squad transactions", function() send(6) end)
		button(scroll, "Donate item (becomes squad property; no payment)", function()
			local menu = ix.cotzUI.Menu()
			for _, item in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems(true)) do
				menu:AddOption(item:GetName(), function()
					ix.cotzUI.Query("This donation becomes squad property and pays you nothing.", "Donate item",
						"Donate", function() send(2, item:GetID()) end, "Cancel")
				end)
			end
			menu:Open()
		end)
		if rank == 2 then
			button(scroll, "Withdraw treasury funds", function()
				ix.cotzUI.StringRequest("Treasury", "Amount in roubles", "", function(value)
					send(5, 0, math.Clamp(math.floor(tonumber(value) or 0), 0, 2147483647))
				end)
			end)
		end
	end
	for _ = 1, count do
		local itemID, itemName, description = net.ReadUInt(32), net.ReadString(), net.ReadString()
		local price, revision = net.ReadUInt(32), net.ReadUInt(32)
		local control = button(scroll, itemName .. " — " .. (price > 0 and (price .. " roubles") or "Unlisted"),
			function()
				local menu = ix.cotzUI.Menu()
				if price > 0 then
					menu:AddOption("Buy whole item for " .. price, function()
						ix.cotzUI.Query(description .. "\n\nTotal: " .. price .. " roubles", "Confirm purchase",
							"Buy", function() send(1, itemID, price, revision) end, "Cancel")
					end)
				end
				if rank >= 1 then
					menu:AddOption("Publish/reprice", function()
						ix.cotzUI.StringRequest(
							"Listing", "Whole item price (0 cancels listing)", tostring(price),
							function(value)
								local amount = math.Clamp(math.floor(tonumber(value) or 0), 0, 2147483647)
								send(3, itemID, amount, revision)
							end
						)
					end)
					menu:AddOption("Recover stock (no payout)", function() send(4, itemID) end)
				end
				menu:Open()
			end)
		control:SetTooltip(description)
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
