ITEM.name = "Compass"
ITEM.description = "A small device that keeps track of its heading."
ITEM.model = "models/lostsignalproject/items/quest/gps.mdl"
ITEM.price = 700
ITEM.flag = "A"
ITEM.weight = 0.075

ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 6.8000001907349),
	ang = Angle(90, -90, 0),
	fov = 59,
}

function ITEM:GetDescription()
	if(self.entity) then return self.description end
	if(!self.GetOwner()) then return self.description end

	local desc = self.description.."\n\n"
	desc = desc.."\nCurrent Heading: "..ix.util.GetHeadingFromAngle(self:GetOwner():GetAngles()).."\n"

	return Format(desc)
end