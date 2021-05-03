ITEM.name = "Pump Station Checklist"
ITEM.description = "A technicians checklist for the pump station in the swamps."
ITEM.longdesc = "This small document contains a detailed checklist of how to turn on parts of the pump station in the swamps."
ITEM.model = "models/lostsignalproject/items/quest/notes_letter_3.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 570

ITEM.flatweight = 0.175

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 57.058823529412,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end