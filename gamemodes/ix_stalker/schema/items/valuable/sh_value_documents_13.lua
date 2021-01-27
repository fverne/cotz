ITEM.name = "Manufacture of Gear Wheels"
ITEM.description = "Factory manual on creation of gears."
ITEM.longdesc = "A quite new manual for factory workers on how to create a various assortion of gears, from start of production to the end product"
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.410

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end