PLUGIN.name = "Temp changes"
PLUGIN.author = "verne"
PLUGIN.desc = "Will be removed later"


function PLUGIN:PostPlayerLoadout(client)
	if !client:GetCharacter() then
		return
	end

	-- untested :)
	if client:GetCharacter():GetData("bRemoveAttachments", true) then
		for k, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
			if v.isBodyArmor and v:GetData("attachments", {}) then
				for i = 1, #v:GetData("attachments", {}) do
					if not client:GetCharacter():GetInventory():Add(ix.armortables.attachments[v:GetData("attachments", {})[i]].uID) then
						local position = client:GetItemDropPos()
						ix.item.Spawn(ix.armortables.attachments[v[i]].uID, position, nil, AngleRand())
						position = position + Vector(0, 0, 5)
						client:Notify("No space in your inventory! Items have been dropped.")
					end	
				end
				v:SetData("attachments", v.miscSlots)
			end
		end

		client:GetCharacter():SetData("bRemoveAttachments", false)
	end
end
