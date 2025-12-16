PLUGIN.name = "Temp changes"
PLUGIN.author = "verne"
PLUGIN.desc = "Will be removed later"


function PLUGIN:PlayerLoadout(client)
	if !client:GetCharacter() then
		return
	end

	-- untested :)
	-- if client:GetCharacter():GetData("bRemoveAttachments", true) then
		for k, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
			if v.isBodyArmor then
				if v:GetData("attachments", {}) then
					PrintTable(v:GetData("attachments", {}))
					for k2, v2 in pairs(v:GetData("attachments", {})) do
						if !isstring(v2) then
							break 	
						end

						if not client:GetCharacter():GetInventory():Add(ix.armortables.attachments[v2].uID) then
							print(v2)
							local position = client:GetItemDropPos()
							ix.item.Spawn(ix.armortables.attachments[v2].uID, position, nil, AngleRand())
							position = position + Vector(0, 0, 5)
							client:Notify("No space in your inventory! Items have been dropped.")
						end	
					end
					v:SetData("attachments", v.miscSlots)
				end
			end
		end

		client:GetCharacter():SetData("bRemoveAttachments", false)
	-- end
end
