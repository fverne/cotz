ITEM.name = "Tool Cleaning Paste"
ITEM.desc = "Used by technicians to restore the durability of tools."
ITEM.model = "models/lostsignalproject/items/repair/gun_oil_ru_d.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = "8000"
ITEM.flag = "A"
ITEM.toolValue = 3


ITEM.functions.repair = {
	name = "Repair Tools",
	icon = "icon16/stalker/repair.png",
	isMulti = true,
	multiOptions = function(item, client)
		local targets = {}
		local char = client:GetCharacter()
		
		
		if (char) then
			local inv = char:GetInventory()

			if (inv) then
				local items = inv:GetItems()

				for k, v in pairs(items) do
					if v.isTool and v:GetData("quantity", 0) < 100 then
						table.insert(targets, {
							name = L("Repair "..v.name.." with "..math.Clamp(v:GetData("quantity",0), 0 , 100).." percent durability to "..math.Clamp(v:GetData("quantity",0)+(item.toolValue*v.toolMult), 0, 100).." percent durability"),
							data = {v:GetID()},
						})
					else
						continue
					end
				end
			end
		end

		return targets
		end,
	OnCanRun = function(item)				
		return (!IsValid(item.entity))
	end,
	OnRun = function(item, data)
		local client = item.player
		local char = client:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()
		local target = data[1]
		
		for k, invItem in pairs(items) do
			if (data[1]) then
				if (invItem:GetID() == data[1]) then
					target = invItem

					break
				end
			else
				client:Notify("No tool selected.")
				return false
			end
		end
		
		target:SetData("quantity", math.Clamp(target:GetData("quantity",100) + (item.toolValue*target.toolMult), 0, 100))
		client:Notify(target.name.." successfully repaired.")
		item.player:EmitSound("stalkersound/inv_attach_addon.mp3")
		
		return true
	end,
}