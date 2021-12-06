ITEM.name = "Scientist Curriculum Vitae"
ITEM.description = "A folder containing the employment and achievements of a local professor."
ITEM.longdesc = "This Curriculum Vitae contains the various employment dates of a scientist at different companies, most institutes in Ukraine. You can tell most of these are very old, the last being near the collapse of the Soviet Union."
ITEM.model = "models/lostsignalproject/items/quest/notes_photo.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2500

ITEM.flatweight = 0.150

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 30,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end