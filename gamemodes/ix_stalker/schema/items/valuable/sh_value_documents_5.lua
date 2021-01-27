ITEM.name = "Handdrawn Anomaly Map"
ITEM.description = "A hastily drawn, and soaked, anomaly map."
ITEM.longdesc = "This map describes the anomalies quite detailed of an anomaly field. It's quite useless, as anomalies move between emissions."
ITEM.model = "models/lostsignalproject/items/quest/notes_paper_1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.180

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