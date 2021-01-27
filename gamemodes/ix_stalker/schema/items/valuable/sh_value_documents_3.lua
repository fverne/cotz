ITEM.name = "Scientist Curriculum Vitae"
ITEM.description = "A folder containing the employment and achievements of a local professor."
ITEM.longdesc = "This Curriculum Vitae contains the various employment dates of a scientist at different companies, most institutes in Ukraine. You can tell most of these are very old, the last being near the collapse of the Soviet Union."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.150

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end