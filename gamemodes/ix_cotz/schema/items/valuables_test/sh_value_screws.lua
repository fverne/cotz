ITEM.name = "Pack of Screws"
ITEM.description = "A worn packet of screws."
ITEM.longdesc = "Threads turn each screw's rotation into a controlled pull through its matching material. The packet keeps several small fasteners together instead of losing them among larger fittings. Size and head shape matter far more than their shared metallic appearance."
ITEM.valuableCategory = "repair parts"

ITEM.model = "models/illusion/eftcontainers/packofscrews.mdl"

ITEM.price = 163
ITEM.width = 1
ITEM.height = 1
ITEM.flatweight = 0
ITEM.weight = 0.35

ITEM.quantity = 4
ITEM.quantdesc = "A stack containing %d packs of screws."

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0.10929, -0.19331, 122.12821),
	ang = Angle(90, 0, -42),
	fov = 4.4832,
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
