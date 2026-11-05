ITEM.name = "Anomalous Material Report"
ITEM.description = "A scientific report on the creation of artifacts."
ITEM.longdesc = "Dense observations and references to collection sites fill the pages. The writer appears more"
	.. " concerned with establishing a pattern than making the subject accessible to outsiders."
ITEM.model = "models/lostsignalproject/items/quest/document_02.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2840

ITEM.flatweight = 0.740

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