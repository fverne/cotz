ITEM.name = "Swamps Research Documents"
ITEM.description = "A file containing research documents about anomalous parts of the swamps."
ITEM.longdesc = "This file contains some rather extensive research documents regarding parts of the swamps. There are surely someone willing to pay quite a bit for these."
ITEM.model = "models/lostsignalproject/items/quest/document_03.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 3560

ITEM.flatweight = 0.650

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