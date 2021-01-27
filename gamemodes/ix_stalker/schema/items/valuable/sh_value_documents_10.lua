ITEM.name = "Anomalous Material Report"
ITEM.description = "A scientific report on the creation of artifacts."
ITEM.longdesc = "This report is rather extensive, and covers the creation of certain artifacts in the zone at various locations."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.740

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end