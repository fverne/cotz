ITEM.name = "Spark Plug"
ITEM.description = "A spark plug from an engine."
ITEM.longdesc = "Dark residue marks the working end, and the flats show where a spanner has gripped it. A"
	.. " generator owner is more likely to recognise its value than a casual visitor."
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
		return item:GetStackCombineTarget(data) ~= nil
	end,
	OnRun = function(item, data)
		return item:CombineStack(item:GetStackCombineTarget(data))
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", math.random(1,2))
	end
end