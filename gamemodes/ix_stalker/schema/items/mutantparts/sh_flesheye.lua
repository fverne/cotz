ITEM.name = "Flesh eye"
ITEM.model ="models/lostsignalproject/items/parts/flesh_eye.mdl"
ITEM.description = "A giant mutated eye of a flesh. It feels slimy and soft."
ITEM.longdesc = "Mutated, swollen eye of a flesh has a number of strange characteristics, the most interesting and potentially useful of which is the ability to repair even severe damage sustained to the organ. The specifics of this process are hitherto unknown, although the discovery of the mechanism behind it would most certainly revolutionize modern medicine by providing cures for many diseases. You can play a part in speeding up the progress of science and save the lives of innocent people by selling eyes of fleshes to the scientists."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 400
ITEM.flag = "A"
ITEM.attribBoosts = { ["luck"] = 1 }
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
				["UniqueID"] = "flesh1",
				["Bone"] = "pelvis",
				["ClassName"] = "model",
				["Position"] = Vector(-3.841, -0.859, 0.656),
				["Size"] = 0.75,
				["Angles"] = Angle(8.632, 69.193, -28.685),
				["Model"] = "models/kek1ch/item_flesh_eye.mdl",
			},
		},
	},
	["self"] = {
		["UniqueID"] = "flesh2",
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