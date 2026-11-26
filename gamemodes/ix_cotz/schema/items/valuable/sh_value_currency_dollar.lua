ITEM.name = "Dollar Notes"
ITEM.description = "A bundle of American currency."
ITEM.longdesc = "Although hardly useful in hostile areas as the zone, cash such as the dollar notes are still of use to those who have connections to the outside of the zone, especially since the dollar is a strong currency worldwide."
ITEM.model = "models/kek1ch/money_usa.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 38 -- lower than real conversion rate, intended

ITEM.quantity = 5000

ITEM.flatweight = 0
ITEM.weight = 0.001

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.5,
}

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		return item:GetStackCombineTarget(data) ~= nil
	end,
	OnRun = function(item, data)
		return item:CombineStack(item:GetStackCombineTarget(data))
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", 1)
	end
end