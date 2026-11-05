local PLUGIN = PLUGIN

net.Receive("cotz/equipment/admin-list", function()
	local characterID = net.ReadUInt(32)
	local name = net.ReadString()
	local count = net.ReadUInt(16)
	local frame = PLUGIN.adminInventory
	if not IsValid(frame) then
		local list
		frame, list = ix.cotzUI.Frame("Take inventory", 0.65, 0.65, 850)
		frame.list = list
		PLUGIN.adminInventory = frame
	end
	frame:SetTitle("Take inventory: " .. name)
	frame.list:Clear()
	for _ = 1, count do
		local itemID = net.ReadUInt(32)
		local itemName = net.ReadString()
		local equipped = net.ReadBool()
		ix.cotzUI.Button(frame.list, itemName .. " [" .. itemID .. "] - "
			.. (equipped and "Unequip, then take" or "Take"), function()
			if (frame.nextTake or 0) > RealTime() then return end
			frame.nextTake = RealTime() + 0.5
			net.Start("cotz/equipment/admin-take")
				net.WriteUInt(characterID, 32)
				net.WriteUInt(itemID, 32)
			net.SendToServer()
		end)
	end
end)
