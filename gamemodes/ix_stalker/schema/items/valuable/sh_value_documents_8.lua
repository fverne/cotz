ITEM.name = "Unreadable Torn Note"
ITEM.description = "A piece of paper with unintelligible handwriting."
ITEM.longdesc = "The note seems to be an order or something, as it has two signatures on it. You cannot make out anything it says though."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.090

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end