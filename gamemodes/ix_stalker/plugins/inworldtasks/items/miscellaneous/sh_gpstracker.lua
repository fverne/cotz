ITEM.name = "GPS Tracker"
ITEM.description = "A small sensor that keeps track of its own position."
ITEM.model = "models/lostsignalproject/items/devices/sensor_b.mdl"
ITEM.price = 14000
ITEM.flag = "A"
ITEM.weight = 0.100

ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 6.8000001907349),
	ang = Angle(90, 1, 0),
	fov = 59,
}

function ITEM:GetDescription()
	if(self.entity) then return self.description end

	local desc = self.description.."\n\n"
	local ppos = ix.util.GetLongLatFromVector(self:GetOwner():GetPos())
	desc = desc.."\nCurrent Position:\n  "..math.Round(ppos[1],4).." Latitude, "..math.Round(ppos[2],4).." Longtitude\n"

	return Format(desc)
end