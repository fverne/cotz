ITEM.name = "Swamps Research Documents"
ITEM.description = "A file containing research documents about anomalous parts of the swamps."
ITEM.longdesc = "This file contains some rather extensive research documents regarding parts of the swamps. There are surely someone willing to pay quite a bit for these."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.650

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end