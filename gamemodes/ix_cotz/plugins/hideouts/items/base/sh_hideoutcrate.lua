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

	return string.format("Tier %d %s%s", data.level or 1, self.name:lower(), data.squad and " — squad" or "")
end

function ITEM:GetDescription()
	return self.description .. "\n\n" .. self.longdesc .. "\n\nNo new crates are assembled. Choose the matching upgrade at your local hideout contact to have this one fitted instead of paying its cash and materials."
end

function ITEM:GetIndividualProperties()
	local data = self:GetData("cotzHideoutCrate", {})
	local level = data.level or 1
	local name = self.name:lower()
	local text
	if level == 1 then
		text = string.format("Installs tier 1 %s", name)
	else
		text = string.format("Upgrades tier %d to tier %d %s", level - 1, level, name)
	end

	return {{id = "hideoutCrateUpgrade", text = text}}
end
