ITEM.name = "Izlom Hand"
ITEM.model ="models/kek1ch/item_fracture_hand.mdl"
ITEM.description = "The hand from an izlom."
ITEM.longdesc = "A severed hand of an izlom - an extremely deformed humanoid mutant. It is certain that these creatures used to be humans and that they are the direct result of the second Chernobyl incident. From the remains of their clothing we can deduce that izloms originate from prisoner population that was stationed in the Exclusion Zone and sentenced to forced labor. Since all izloms suffer almost the same the deformation of the body, it is supposed that when the exposure took place all subjects were in the same body position - either because they were being transported at the time or because someone forced them. All specimens encountered so far were male and sterile. Hence it can be safely assumed that the izlom population is unable to reproduce, and their number in the Zone will be steadily getting lower. For this reason, at present they remain one of the most rarely encountered type of mutant."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 250
ITEM.flag = "A"
ITEM.attribBoosts = { ["luck"] = 2 }
ITEM.value = ITEM.price*1*1

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["OwnerName"] = "self",
				["Name"] = "",
				["UniqueID"] = "izlom1",
				["Bone"] = "pelvis",
				["ClassName"] = "model",
				["Position"] = Vector(-5.473, -1.317, 1.768),
				["Size"] = 1,
				["Angles"] = Angle(-11.734, -102.435, 26.834),
				["Model"] = "models/kek1ch/item_fracture_hand.mdl",
			},
		},
	},
	["self"] = {
		["UniqueID"] = "izlom2",
		["Name"] = "",
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["EditorExpand"] = true,
	},
},
}

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		item:RemovePart(item.player)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					item.player:Notify("You're already equipping this kind of outfit")

					return false
				end
			end
		end

		item:SetData("equip", true)
		item.player:AddPart(item.uniqueID, item)

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:AddBoost(item.uniqueID, k, v)
			end
		end

		item:OnEquipped()
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.Sell = {
	icon = "icon16/stalker/sell.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Sold for "..(item.value).." rubles." )
		client:GetCharacter():GiveMoney(item.value)
		
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

ITEM.functions.Value = {
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Item is sellable for "..(item.value).." rubles." )
		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}