ITEM.name = "Soviet Manual of Arms"
ITEM.description = "The classic firearm shooting manual. Quite worn."
ITEM.longdesc = "This manual of arms contain a guide for soviet conscripts on how to shoot their weapon in a correct manner. Required to be read before getting any actual firearm training."
ITEM.model = "models/lostsignalproject/items/misc/book1.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.flatweight = 0.400

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -1, 13.071895599365),
	ang = Angle(90, 180, 0),
	fov = 65.294117647059,
}

if (CLIENT) then
	function ITEM:PopulateTooltipIndividual(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Documents", Color(200, 200, 200))
		end
	end
end