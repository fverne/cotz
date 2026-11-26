ITEM.name = "Euro Notes"
ITEM.description = "A bundle of European currency."
ITEM.longdesc = "While this currency is not the primary way of trading in the zone, it does still retain value to people residing in european countries, and other financially interested people. Aside from a trading perspective, foreign currency is practically useless in an alienated environment such as the zone."
ITEM.model = "models/kek1ch/money_euro.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 52 -- lower than real conversion rate, intended

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