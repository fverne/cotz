local PLUGIN = PLUGIN

PLUGIN.crateVersion = 1
PLUGIN.cratePriceMultiplier = 1.5
PLUGIN.crateStructuralBatches = {2, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8}
PLUGIN.crateBatchSizes = {value_nuts = 3, value_bolts = 4, value_nails = 1, value_screws = 1}
PLUGIN.crateMaterials = {
	general = {
		common = {"value_tape_duct", "value_rope", "value_paracord"},
		rare = "value_plastic", regional = "value_retardant3",
	},
	ammo = {
		common = {"value_gunoil", "value_tape_electric", "value_paracord"},
		rare = "value_lubricant", regional = "value_retardant4",
	},
	medical = {
		common = {"value_med_peroxide", "value_med_petroleumjelly", "value_soap"},
		rare = "value_med_aquatabs", regional = "value_other_hosemilitary",
	},
	gear = {
		common = {"value_rope", "value_paracord", "value_tape_duct"},
		rare = "value_sewingkit", regional = "value_retardant9",
	},
	weapon = {
		common = {"value_gunoil", "value_tape_duct", "value_metalparts"},
		rare = "value_wd40_100ml", regional = "value_retardant6",
	},
	fridge = {
		common = {"value_tape_electric", "value_wire_light", "value_bleach"},
		rare = "value_building_poxeram", regional = "value_airfilter",
	},
}

function PLUGIN:GetCrateRecipe(family, level, squad)
	local recipe = self.personalContainerRecipes[family]
	local materials = self.crateMaterials[family]
	if not recipe or not materials or not isnumber(level) or level % 1 ~= 0
		or not self.crateStructuralBatches[level] then return end
	local multiplier = squad and 3 or 1
	local groups = {
		{name = "Fasteners", quantity = self.crateStructuralBatches[level] * multiplier,
			items = {"value_nuts", "value_bolts", "value_nails", "value_screws"}},
		{name = "Packing materials", quantity = (level == 12 and 2 or 1) * multiplier,
			items = materials.common},
	}
	local function add(item, quantity, region)
		groups[#groups + 1] = {name = region, quantity = quantity * multiplier, items = {item}}
	end
	if level >= 4 then add(materials.rare, 1, "Swamps / Garbage") end
	if level >= 6 then add(materials.regional, level == 12 and 3 or level >= 8 and 2 or 1, "Waystation") end
	if level >= 10 then add("value_circuitboard", 1, "Pripyat") end
	if level >= 11 then add("value_textolite", 1, "Pripyat") end
	if level >= 12 then add("value_controller", 1, "Pripyat") end

	return {
		family = family, level = level, squad = squad == true, groups = groups,
		item = recipe.item,
		price = math.ceil(recipe.price * self.cratePriceMultiplier ^ (level - 1)) * multiplier,
		data = {cotzHideoutCrate = {level = level, squad = squad == true, version = self.crateVersion}},
	}
end

function PLUGIN:GetCrateUnlock(character, level)
	if level == 1 then
		if self:GetPersonalUnlock(character, "general", 1) then return true end
		return self:GetPersonalUnlock(character, "claim", 1)
	end

	return self:GetPersonalUnlock(character, "general", level - 1)
end

function PLUGIN:IsUpgradeCrate(client, item, family, level, squad)
	local inventory = client:GetCharacter():GetInventory()
	local data = item and item:GetData("cotzHideoutCrate")

	return item and item.uniqueID == "hideout_crate_" .. family and item.invID == inventory:GetID()
		and istable(data) and data.level == level and data.squad == (squad == true)
		and data.version == self.crateVersion and self:CanStockItem(client, item)
end

function PLUGIN:FindUpgradeCrate(client, family, level, squad)
	for _, item in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if self:IsUpgradeCrate(client, item, family, level, squad) then return item end
	end
end

-- Keep the old three-tier recipes available for receipt replay and legacy personal conversion.
PLUGIN.legacyContainerRecipes = table.Copy(PLUGIN.containerRecipes)
for family, recipe in pairs(PLUGIN.personalContainerRecipes) do
	local squadRecipe = PLUGIN.containerRecipes[family]
	squadRecipe.tiers = {}
	for level, tier in ipairs(recipe.tiers) do
		squadRecipe.tiers[level] = {
			width = tier.width + 2, height = tier.height + 1, item = tier.item, model = tier.model, price = 0,
		}
	end
end

local function migrateSquadSlot(self, slot, definition)
	if slot.crateVersion == self.crateVersion then return end
	local recipe = self.containerRecipes[slot.recipe or definition and definition.recipe]
	if not recipe then return end
	if (slot.tier or 0) > 0 then
		slot.tier = #recipe.tiers
		for level, tier in ipairs(recipe.tiers) do
			if tier.width >= (slot.width or 1) and tier.height >= (slot.height or 1) then
				slot.tier = level
				break
			end
		end
	end
	slot.crateVersion = self.crateVersion
end

function PLUGIN:MigrateSquadContainers(record)
	if record.ownerType ~= "squad" then return end
	local template = self:GetTemplate(record)
	for id, slot in pairs(record.containers or {}) do
		migrateSquadSlot(self, slot, template and (template.containers or {})[id])
	end
	record.crateVersion = self.crateVersion
end
