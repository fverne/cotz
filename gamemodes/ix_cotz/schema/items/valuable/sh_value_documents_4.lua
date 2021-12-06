ITEM.name = "Scribbled Scientific Notes"
ITEM.description = "A small document containing some scientfic scribblings."
ITEM.longdesc = "The document has, in poor handwriting, described some kind of zone-related anomalous event, but you cannot yourself understand it, partly due to the handwriting."
ITEM.model = "models/lostsignalproject/items/quest/notes_paper_2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2100

ITEM.flatweight = 0.120

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