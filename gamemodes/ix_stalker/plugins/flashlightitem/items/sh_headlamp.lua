ITEM.name = "Headlamp"
ITEM.description = "A headlamp with adjustable straps."
ITEM.model = "models/lostsignalproject/items/devices/tactical_torch.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1950
ITEM.weight = 0.310

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/misc_headlamp.png")

/* exrender for "models/lostsignalproject/items/devices/tactical_torch.mdl"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.5, 11, 0),
	ang = Angle(0, 270, 0),
	fov = 45,
}
*/

ITEM:Hook("drop", function(item)
	item.player:Flashlight(false)
end)
