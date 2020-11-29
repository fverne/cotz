ITEM.name = "Battery"
ITEM.model ="models/nasca/etherealsrp_artifacts/battery.mdl"
ITEM.description = "An electric artifact."
ITEM.longdesc = "It comprises electrostatic elements, but scientists have yet to determine the exact physical conditions required for its formation. The artifact is quite popular in the Zone and is valued by its residents and visitors alike for its energizing properties, although it has an adverse effect on the body when used for prolonged periods of time. One should take note, however, that this artifact hinders blood clotting and increases bleeding rate of open wounds. On the other hand, being a powerful resistor, it is well known for its ability to shield its user from lethal doses of electricity. This artifact is also extremely light and very portable. Common artifact."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 9000
ITEM.flag = "A"
ITEM.value = ITEM.price*0.5
/*
-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
    name = "Unequip",
    tip = "equipTip",
    icon = "icon16/stalker/unequip.png",
    onRun = function(item)
        item.player:RemoveBuff("buff_slowheal")
        item:setData("equip", nil)
        return false
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item:getData("equip") == true)
    end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
    name = "Equip",
    tip = "equipTip",
    icon = "icon16/stalker/equip.png",
    onRun = function(item)
        local char = item.player:getChar()
        local items = char:getInv():getItems()

        item:setData("equip", true)
		item.player:AddBuff("buff_slowheal", -1, { amount = 5 })

        if (item.attribBoosts) then
            for k, v in pairs(item.attribBoosts) do
                char:addBoost(item.uniqueID, k, v)
            end
        end
        
        return false
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item:getData("equip") != true)
    end
}

function ITEM:removePart(client)
	local char = client:getChar()
	
	self:setData("equip", false)
	client:removePart(self.uniqueID)
	client:RemoveBuff("buff_slowheal")

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:removeBoost(self.uniqueID, k)
		end
	end
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:hook("drop", function(item)
	if (item:getData("equip")) then
		item:removePart(item.player)
	end
end)

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:onRemoved()
	local inv = nut.item.inventories[self.invID]
	local receiver = inv.getReceiver and inv:getReceiver()

	if (IsValid(receiver) and receiver:IsPlayer()) then
		if (self:getData("equip")) then
			self:removePart(receiver)
		end
	end
end