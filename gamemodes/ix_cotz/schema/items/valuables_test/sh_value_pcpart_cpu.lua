ITEM.name = "Desktop Processor"
ITEM.description = "A desktop processor with a square metal lid."
ITEM.longdesc = "The processor's metal lid covers a much smaller electronic die. Contacts beneath it link the chip to a matching motherboard socket. Several generations can look nearly identical from above, making the printed model reference more useful than the square outline."
ITEM.valuableCategory = "computer parts"

ITEM.model = "models/cotz/eft/barter/electr_cpu.mdl"

ITEM.price = 750
ITEM.width = 1
ITEM.height = 1
ITEM.flatweight = 0
ITEM.weight = 0.06

ITEM.quantity = 6
ITEM.quantdesc = "A stack containing %d desktop processors."

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 100.05897),
	ang = Angle(90, 180, 0),
	fov = 1.33045,
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
