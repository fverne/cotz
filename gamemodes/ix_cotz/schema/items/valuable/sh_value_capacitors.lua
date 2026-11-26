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