ITEM.name = "Empty Noteblock"
ITEM.description = "A Noteblock. All the pages are empty."
ITEM.longdesc = "This Noteblock has none of it's pages written on. It's worth very little, as paper rarely has any value in the zone, as many messages are done digitally. Some old fashioned people might find use for it however, but you most likely won't net a large sum of money."
ITEM.model = "models/lostsignalproject/items/quest/notes_writing_book_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 360

ITEM.flatweight = 0.500

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 19.607843399048),
	ang = Angle(90, 180, 0),
	fov = 50,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end