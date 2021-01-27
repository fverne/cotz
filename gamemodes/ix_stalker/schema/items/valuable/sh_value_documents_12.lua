ITEM.name = "Soviet Manual of Arms"
ITEM.description = "The classic firearm shooting manual. Quite worn."
ITEM.longdesc = "This manual of arms contain a guide for soviet conscripts on how to shoot their weapon in a correct manner. Required to be read before getting any actual firearm training."
ITEM.model = "FILLME"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.400

ITEM.img = ix.util.GetMaterial("FILLME.png")

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end