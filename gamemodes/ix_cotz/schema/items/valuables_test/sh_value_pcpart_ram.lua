ITEM.name = "RAM Stick"
ITEM.description = "A narrow memory module lined with dark chips."
ITEM.longdesc = "Rows of dark memory chips line the narrow RAM board above a strip of contacts. A notch in that edge helps distinguish its fitting. The module was made to sit upright in a motherboard socket, largely hidden once the computer case was closed."
ITEM.valuableCategory = "computer parts"

ITEM.model = "models/cotz/eft/barter/electr_ram.mdl"

ITEM.price = 360
ITEM.width = 1
ITEM.height = 1
ITEM.flatweight = 0
ITEM.weight = 0.025

ITEM.quantity = 5
ITEM.quantdesc = "A stack containing %d RAM sticks."

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-2e-05, 0, 100.04265),
	ang = Angle(90, 0, -45),
	fov = 3.70814,
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
	if self:GetData("quantity") == nil then
		self:SetData("quantity", math.random(1, 2))
	end
end
