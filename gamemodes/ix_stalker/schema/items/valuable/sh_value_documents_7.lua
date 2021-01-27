ITEM.name = "Firearm Assembly Illustration"
ITEM.description = "A single page torn from a weapons manual."
ITEM.longdesc = "This single page shows the various elements of the assembly and disassembly of a weapon of soviet origin."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.100

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end