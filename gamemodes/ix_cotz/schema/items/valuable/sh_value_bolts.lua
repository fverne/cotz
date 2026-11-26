ITEM.name = "Bolts"
ITEM.description = "A bunch of metal bolts."
ITEM.longdesc = "Threads are darkened with old oil, and a few heads bear hard spanner marks. Their value becomes"
	.. " obvious when an otherwise repairable machine is missing one small fastening."
ITEM.model = "models/illusion/eftcontainers/screwnutbolt.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 26

ITEM.quantity = 20

ITEM.flatweight = 0
ITEM.weight = 0.017

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
		self:SetData("quantity", math.random(4,8))
	end
end