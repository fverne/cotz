local PLUGIN = PLUGIN

ITEM.name = "Map USB"
ITEM.description = "A USB drive holding a map."
ITEM.model = "models/lostsignalproject/items/quest/usb2.mdl"
ITEM.category = "Communication"
ITEM.price = 1000
ITEM.width = 1
ITEM.height = 1
ITEM.flatweight = 0.01

function ITEM:GetDescription()
	if self.entity or not self.longdesc then return self.description end

	return self.description .. "\n\n" .. self.longdesc
end

ITEM.functions.Install = {
	name = "Add to Maps",
	icon = "icon16/map_add.png",
	OnRun = function(item)
		return PLUGIN:InstallMapUSB(item)
	end,
	OnCanRun = function(item)
		return PLUGIN:GetMapInstallTarget(item) ~= nil
	end,
}
