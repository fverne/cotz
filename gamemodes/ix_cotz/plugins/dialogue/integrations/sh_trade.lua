ix.dialogue = ix.dialogue or {}

function ix.dialogue.OpenVendor(_, client, target)
	if not SERVER then return end
	if ix.sherpa and ix.sherpa.IsVendor(target) then return ix.sherpa.Open(client, target) end
	local character = client:GetCharacter()
	local items = {}
	target.receivers[#target.receivers + 1] = client
	for id, entry in pairs(ix.vendorStock.GetItems(character, target)) do
		local allowed = CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or entry[VENDOR_MODE]
		local canBuy = ix.progression.CanBuyItem(character, target:GetDisplayName(), id)
		local canSell = ix.townNPCs and ix.townNPCs:CanSellItem(id, target:GetDisplayName()) == true
		if not table.IsEmpty(entry) and allowed and (canBuy or canSell) then
			if not canBuy then entry[VENDOR_MODE] = VENDOR_BUYONLY end
			items[id] = entry
		end
	end
	client.ixVendorAdv = target
	client.ixVendorAdvEditing = nil
	character:GetInventory():Sync(client, true)
	net.Start("ixVendorAdvOpen")
	net.WriteEntity(target)
	net.WriteUInt(target.money or 0, 16)
	net.WriteTable(items)
	net.WriteFloat(target.scale or 0.5)
	net.Send(client)
	ix.log.Add(client, "vendorUse", target:GetDisplayName())
end

function ix.dialogue.AddTradeTopic(dialogue, statement, response)
	dialogue.addTopic("TradeTopic", {
		statement = statement,
		response = response,
		postCallback = ix.dialogue.OpenVendor,
		options = {"BackTopic"},
	})
end
