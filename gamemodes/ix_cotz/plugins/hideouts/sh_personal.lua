local PLUGIN = PLUGIN

PLUGIN.personalContacts = {
	rp_marsh_cs = {name = "'Ballast'", id = "ballast", prefix = "BA", claimStep = "access"},
	rp_garbage_cotz = {name = "'Cleaner'", id = "cleaner", prefix = "CL", claimStep = "access"},
	rp_waystation = {name = "'Ledger'", id = "ledger", prefix = "LE", claimStep = "access"},
}

PLUGIN.personalUnlockSteps = {
	general = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	ammo = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	medical = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	weapon = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	gear = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	floor = {2, 4}, furnishing = {3},
}
PLUGIN.personalPriceMultiplier = 2.2
PLUGIN.personalUpgradePrices = {floor = 500, furnishing = 5000}

PLUGIN.personalContainerRecipes = {
	general = {
		name = "General crate", filter = "general", price = 600, item = "value_container_smallitems",
		sizes = {{2, 3}, {3, 3}, {3, 4}, {4, 4}, {4, 5}, {5, 5}, {5, 6}, {6, 6}, {6, 7}, {7, 7}, {7, 8}, {8, 8}},
		models = {
			"models/lostsignalproject/items/misc/backpack.mdl",
			"models/lostsignalproject/items/misc/backpack.mdl",
		},
	},
	ammo = {
		name = "Ammunition container", filter = "ammo", price = 900, item = "value_container_ammo",
		sizes = {{4, 4}, {5, 4}, {5, 5}, {6, 5}, {6, 6}, {7, 6}, {7, 7}, {8, 7}, {8, 8}, {9, 8}, {9, 9}, {10, 9}},
		models = {"models/cotz/eft/lootcont/ammo_crate_wood.mdl", "models/cotz/eft/lootcont/scontainer_ammo_grenade.mdl"},
	},
	medical = {
		name = "Medical cabinet", filter = "medical", price = 1000, item = "value_container_injectorcase",
		sizes = {{4, 4}, {5, 4}, {5, 5}, {6, 5}, {6, 6}, {7, 6}, {7, 7}, {8, 7}, {8, 8}, {9, 8}, {9, 9}, {10, 9}},
		models = {"models/illusion/eftcontainers/ifak.mdl", "models/illusion/eftcontainers/ifak.mdl"},
	},
	gear = {
		name = "Suit and gear locker", filter = "gear", price = 1400, item = "value_container_parls",
		sizes = {
			{6, 6}, {7, 6}, {7, 7}, {8, 7}, {8, 8}, {9, 8},
			{9, 10}, {10, 10}, {10, 12}, {11, 12}, {11, 14}, {12, 14},
		},
		models = {"models/props_c17/Lockers001a.mdl", "models/props_wasteland/controlroom_storagecloset001b.mdl"},
	},
	weapon = {
		name = "Weapon rack", filter = "weapon", price = 1400, item = "value_container_parls",
		sizes = {
			{6, 4}, {7, 4}, {7, 6}, {8, 6}, {8, 8}, {9, 8},
			{9, 10}, {10, 10}, {10, 12}, {11, 12}, {11, 14}, {12, 14},
		},
		models = {"models/props_c17/Lockers001a.mdl", "models/props_wasteland/controlroom_storagecloset001b.mdl"},
	},
}

-- Each extra level costs 2.2 times as much; capacity grows only by a row or column.
for _, recipe in pairs(PLUGIN.personalContainerRecipes) do
	recipe.tiers = {}
	for level, size in ipairs(recipe.sizes) do
		recipe.tiers[level] = {
			width = size[1], height = size[2],
			price = math.ceil(recipe.price * PLUGIN.personalPriceMultiplier ^ (level - 1)),
			item = level == 1 and recipe.item or nil,
			model = recipe.models[level < 3 and 1 or 2],
		}
	end
end

function PLUGIN:GetContainerRecipe(record, definition)
	local recipes = record.ownerType == "squad" and self.containerRecipes or self.personalContainerRecipes

	return definition and recipes[definition.recipe]
end

function PLUGIN:GetPersonalUnlock(character, feature, level)
	local contact = self.personalContacts[game.GetMap()]
	if not contact then return false, "No local hideout contact is configured." end
	if feature == "claim" and not contact.claimStep then return true end
	local steps = self.personalUnlockSteps[feature]
	local step = feature == "claim" and contact.claimStep or steps and steps[level]
	if not step then return false, "Further progression is not enabled yet." end
	local suffix = type(step) == "number" and string.format("%02d", step) or step
	local id = "cotz/town/" .. contact.id .. "/v3/hideout/" .. suffix

	local reason = feature == "claim" and "Arrange initial hideout access with " .. contact.name .. "."
		or "Requires hideout improvement " .. step .. "."

	return ix.progression.IsCompleted(character, id), reason
end

function PLUGIN:GetPersonalFloorLimit(record)
	return 4 + 2 * (record.floorLevel or 0)
end

ix.command.Add("HideoutLocationAdd", {
	adminOnly = true,
	arguments = {ix.type.string, ix.type.string, ix.type.string, ix.type.text},
	OnRun = function(self, client, id, template, entrance, name)
		if SERVER then return PLUGIN:AddPersonalLocation(id, template, entrance, name) end
	end,
})
