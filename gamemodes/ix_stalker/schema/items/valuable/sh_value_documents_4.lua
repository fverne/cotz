ITEM.name = "Scribbled Scientific Notes"
ITEM.description = "A small document containing some scientfic scribblings."
ITEM.longdesc = "The document has, in poor handwriting, described some kind of zone-related anomalous event, but you cannot yourself understand it, partly due to the handwriting."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.120

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end