ITEM.name = "Pump Station Checklist"
ITEM.description = "A technicians checklist for the pump station in the swamps."
ITEM.longdesc = "This small document contains a detailed checklist of how to turn on parts of the pump station in the swamps."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.175

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end