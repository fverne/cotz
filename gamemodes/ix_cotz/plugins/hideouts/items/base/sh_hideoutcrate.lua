ITEM.name = "Hideout upgrade crate"
ITEM.description = "Packed fittings for a hideout storage installation."
ITEM.longdesc = "The packed fittings supply one storage installation at the marked grade."
ITEM.model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 0
ITEM.weight = 1
ITEM.category = "Hideout crates"

function ITEM:GetName()
	local data = self:GetData("cotzHideoutCrate", {})

	return string.format("%s — %s level %d", self.name, data.squad and "squad" or "personal", data.level or 0)
end

function ITEM:GetDescription()
	return self.description .. "\n\n" .. self.longdesc .. "\n\nInstall this crate through the matching hideout container's upgrade menu."
end
