ITEM.name = "Capacitors"
ITEM.description = "Some capacitors."
ITEM.longdesc = "A bunch of 3300µF capacitors, used in electronics work. Fetches a decent price, especially if one manages to find a couple."
ITEM.model = "models/illusion/eftcontainers/capacitors.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 460

ITEM.quantity = 10

ITEM.flatweight = 0
ITEM.weight = 0.090

ITEM.img = ix.util.GetMaterial("vgui/hud/valuable/capacitor.png")

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", math.random(2,3))
	end
end