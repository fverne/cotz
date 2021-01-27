ITEM.name = "Empty Noteblock"
ITEM.description = "A Noteblock. All the pages are empty."
ITEM.longdesc = "This Noteblock has none of it's pages written on. It's worth very little, as paper rarely has any value in the zone, as many messages are done digitally. Some old fashioned people might find use for it however, but you most likely won't net a large sum of money."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.500

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end