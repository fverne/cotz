ITEM.name = "Battery"
ITEM.model ="models/nasca/etherealsrp_artifacts/battery.mdl"
ITEM.description = "An electric artifact."
ITEM.longdesc = "It comprises electrostatic elements, but scientists have yet to determine the exact physical conditions required for its formation. The artifact is quite popular in the Zone and is valued by its residents and visitors alike for its energizing properties, although it has an adverse effect on the body when used for prolonged periods of time. One should take note, however, that this artifact hinders blood clotting and increases bleeding rate of open wounds. On the other hand, being a powerful resistor, it is well known for its ability to shield its user from lethal doses of electricity. This artifact is also extremely light and very portable. Common artifact."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 9000
ITEM.flag = "A"
ITEM.value = ITEM.price*0.5
ITEM.isArtefact = true
ITEM.res = {
	["Fall"] = 0.00,
	["Blast"] = 0.00,
	["Bullet"] = 0.00,
	["Shock"] = 0.30,
	["Burn"] = 0.00,
	["Radiation"] = 0.00,
	["Chemical"] = 0.00,
	["Psi"] = 0.00,
}



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