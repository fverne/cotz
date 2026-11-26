ITEM.name = "Nuts"
ITEM.description = "A bunch of metal nuts."
ITEM.longdesc = "The pieces are mixed by size and finish, with old grease caught in some threads. A workshop"
	.. " drawer never seems to contain enough of the one a repair actually needs."
ITEM.model = "models/illusion/eftcontainers/nuts.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 20

ITEM.quantity = 20

ITEM.flatweight = 0
ITEM.weight = 0.008

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
		self:SetData("quantity", math.random(3,8))
	end
end