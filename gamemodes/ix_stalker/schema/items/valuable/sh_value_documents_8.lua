ITEM.name = "Unreadable Torn Note"
ITEM.description = "A piece of paper with unintelligible handwriting."
ITEM.longdesc = "The note seems to be an order or something, as it has two signatures on it. You cannot make out anything it says though."
ITEM.model = "models/lostsignalproject/items/quest/notes_letter_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 80

ITEM.flatweight = 0.090

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