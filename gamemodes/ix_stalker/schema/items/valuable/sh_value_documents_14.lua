ITEM.name = "Kevlar Sewing Manual"
ITEM.description = "A manual for experienced body armor makers on how correctly repair and sew with kevlar."
ITEM.longdesc = "This manual covers the basics on repairing body armor, sewing on attachments to it, and in general just manufacture body armor from the bottom up."
ITEM.model = "models/lostsignalproject/items/misc/book3.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.395

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -1, 13.071895599365),
	ang = Angle(90, 180, 0),
	fov = 65.294117647059,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end