ITEM.name = "Artifact Research Ledger"
ITEM.description = "A research ledger containing a catalogue of some common artifacts."
ITEM.longdesc = "The research ledger contains little information of use to stalkers, but for researchers this is quite valuable."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.920

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end