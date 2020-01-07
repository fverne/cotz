ITEM.name = "Crow Beak"
ITEM.model ="models/gibs/antlion_gib_small_3.mdl"
ITEM.description = "A beak from a crow."
ITEM.longdesc = "While many stalkers consider crows no more than pests, more insightful ones acknowledge their usefulness in tackling the many challenges the Zone presents. While murders of crows can prove invaluable navigating and evading danger on the empty streets of Chernobyl and Pripyat, it's only after their death when their true value is manifested. The population of crows grows constantly in spite of the increased knowledge of usefulness of their beaks. It seems accelerated adaptation, typical among Zone's fauna, has provided them with a sped-up reproduction cycle resulting in up to 4 egg lays a year. Their prolonged life-span, of up to 20 years, has given them extraordinary intelligence manifested especially when many crows are in close proximity."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 50
ITEM.flag = "A"
ITEM.attribBoosts = { ["luck"] = 1 }
ITEM.value = ITEM.price*1*1
ITEM.weight = 0.25

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["OwnerName"] = "self",
				["Name"] = "",
				["UniqueID"] = "crow1",
				["Bone"] = "pelvis",
				["ClassName"] = "model",
				["Position"] = Vector(-5.435, -1.648, 4.132),
				["Size"] = 0.25,
				["Angles"] = Angle(15.625, 84.242, -29.734),
				["Model"] = "models/gibs/antlion_gib_small_3.mdl",
			},
		},
	},
	["self"] = {
		["UniqueID"] = "crow2",
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