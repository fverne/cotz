local PLUGIN = PLUGIN

ix.inventory.Register("cotzHideoutContainer", 1, 1)
ix.inventory.Register("cotzHideoutStock", 10, 8)

ix.config.Add("hideoutSaleCommission", 5, "Percentage deducted from paid squad sales.", nil, {
	category = "Hideouts", data = {min = 0, max = 100},
})
ix.config.Add("hideoutStockWidth", 10, "Squad vendor stock width (applies to new stock inventories).", nil, {
	category = "Hideouts", data = {min = 4, max = 20},
})
ix.config.Add("hideoutStockHeight", 8, "Squad vendor stock height (applies to new stock inventories).", nil, {
	category = "Hideouts", data = {min = 4, max = 20},
})

ix.config.Add("hideoutPersonalLimit", 0, "Maximum personal storage rooms per character on this map (0 is unlimited).", nil, {
	category = "Hideouts", data = {min = 0, max = 32},
})

-- Administrators choose a recipe for each template spot; these do not install themselves.
PLUGIN.containerRecipes = {
	general = {
		name = "General storage", filter = "general",
		tiers = {
			{
				item = "value_container_smallitems", width = 3, height = 3,
				model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl",
			},
			{
				item = "value_container_junkbox", width = 6, height = 6,
				model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl",
			},
			{
				item = "value_container_parls", width = 10, height = 8,
				model = "models/z-o-m-b-i-e/st/equipment_cache/st_equipment_box_01.mdl",
			},
		},
	},
	ammo = {
		name = "Ammunition storage", filter = "ammo",
		tiers = {
			{item = "value_container_ammo", width = 4, height = 4},
			{item = "value_container_ammo", width = 6, height = 6},
			{item = "value_container_ammo", width = 10, height = 8},
		},
	},
	medical = {
		name = "Medical storage", filter = "medical",
		tiers = {
			{item = "value_container_injectorcase", width = 3, height = 3},
			{item = "value_container_injectorcase", width = 5, height = 5},
			{item = "value_container_injectorcase", width = 8, height = 6},
		},
	},
	gear = {
		name = "Suit and gear storage", filter = "gear",
		tiers = {
			{item = "value_container_parls", width = 3, height = 6, model = "models/props_c17/Lockers001a.mdl"},
			{item = "value_container_parls", width = 4, height = 8, model = "models/props_c17/Lockers001a.mdl"},
			{item = "value_container_parls", width = 5, height = 10, model = "models/props_c17/Lockers001a.mdl"},
		},
	},
	weapon = {
		name = "Weapon storage", filter = "weapon",
		tiers = {
			{item = "value_container_parls", width = 6, height = 4},
			{item = "value_container_parls", width = 8, height = 6},
			{item = "value_container_parls", width = 10, height = 8},
		},
	},
}

PLUGIN.furnishingTools = {colour = true, material = true, remover = true}
PLUGIN.furnishingProperties = {skin = true, bodygroups = true, bonemanipulate = false}
PLUGIN.propCapacityTiers = {
	{limit = 30},
	{limit = 40, price = 5000},
	{limit = 50, price = 10000},
	{limit = 60, price = 20000},
}

function PLUGIN:GetHideoutPropTier(record)
	return math.Clamp(math.floor(tonumber(record.propTier) or 1), 1, #self.propCapacityTiers)
end

function PLUGIN:GetHideoutPropLimit(record)
	return self.propCapacityTiers[self:GetHideoutPropTier(record)].limit
end

function PLUGIN:GetHideoutPropCount(instance)
	local count = 0
	for entity in pairs(instance.props) do
		if IsValid(entity) then count = count + 1 end
	end

	return count
end

function PLUGIN:GetSaleCommission()
	return math.Clamp(math.floor(tonumber(ix.config.Get("hideoutSaleCommission", 5)) or 5), 0, 100)
end

function PLUGIN:IsHideoutDestination(destination)
	return istable(destination) and destination.kind == "cotzHideout" and destination.version == 1
end
