ITEM.name = "9 Volt Battery"
ITEM.description = "Worn and dirty, but seems to be in working condition."
ITEM.longdesc = "A 9 volt battery, used for powering smaller electronic devices."
ITEM.model = "models/lostsignalproject/items/misc/battery.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 90

ITEM.quantity = 10

ITEM.flatweight = 0
ITEM.weight = 0.053

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
		self:SetData("quantity", math.random(2,3))
	end
end