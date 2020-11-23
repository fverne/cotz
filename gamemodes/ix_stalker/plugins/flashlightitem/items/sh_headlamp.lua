ITEM.name = "Headlamp"
ITEM.model = "models/lostsignalproject/items/devices/tactical_torch.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A standard flashlight that can be toggled."
ITEM.category = "Tools"
ITEM.busflag = {"hardware"}
ITEM.price = 2500
ITEM.repairCost = ITEM.price/100*1

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.5, 11, 0),
	ang = Angle(0, 270, 0),
	fov = 45,
}

ITEM:Hook("drop", function(item)
	item.player:Flashlight(false)
end)
