ITEM.name = "Artifact Research Ledger"
ITEM.description = "A research ledger containing a catalogue of some common artifacts."
ITEM.longdesc = "The research ledger contains little information of use to stalkers, but for researchers this is quite valuable."
ITEM.model = "models/lostsignalproject/items/quest/document_01.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 5420

ITEM.flatweight = 0.920

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