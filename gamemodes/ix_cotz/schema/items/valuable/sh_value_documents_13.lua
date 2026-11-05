ITEM.name = "Manufacture of Gear Wheels"
ITEM.description = "Factory manual on creation of gears."
ITEM.longdesc = "Diagrams follow the process from rough stock to a finished component, with workshop notes"
	.. " crowded around the margins. The language assumes a reader who already knows the machines"
	.. " involved."
ITEM.model = "models/lostsignalproject/items/misc/book2.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 3500

ITEM.flatweight = 0.410

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -0.5, 200),
	ang = Angle(90, 180, 0),
	fov = 5,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end