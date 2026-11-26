ITEM.name = "1.5 Volt Battery"
ITEM.description = "AA battery."
ITEM.longdesc = "Small AA batteries, often used for powering flashlights and other small electronic devices. Fetches a small price."
ITEM.model = "models/illusion/eftcontainers/aabattery.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 46

ITEM.quantity = 20

ITEM.flatweight = 0
ITEM.weight = 0.023

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
		self:SetData("quantity", math.random(1,6))
	end
end