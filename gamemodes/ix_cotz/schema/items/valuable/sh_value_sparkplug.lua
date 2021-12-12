ITEM.name = "Spark Plug"
ITEM.description = "A spark plug from an engine."
ITEM.longdesc = "A sparking plug for an engine. Useful for zone inhabitants that use generators to power their dwellings."
ITEM.model = "models/illusion/eftcontainers/sparkplug.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 350

ITEM.quantity = 5

ITEM.flatweight = 0
ITEM.weight = 0.085

ITEM.img = ix.util.GetMaterial("vgui/hud/valuable/sparkplug.png")

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
		self:SetData("quantity", math.random(1,2))
	end
end