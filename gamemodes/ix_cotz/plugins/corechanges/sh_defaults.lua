local DEFAULTS = {
	allowVoice = true,
	artifactSpawnerThreshold = 5,
	blowoutRemoveItems = true,
	blowoutRemoveNPCs = true,
	boxSpawnerThreshold = 40,
	charloadremove = false,
	color = Color(145, 145, 145, 255),
	communityText = "Discord",
	containerOpenTime = 0,
	containerSpawnChanceScaling = 0,
	containerSpawnRate = 1800,
	cotzIntro = false,
	day = 2,
	deathWeaponDuraDmg = 1,
	deathWeaponWearDmg = 15,
	eventControllerAdvThreshold = 1,
	eventControllerThreshold = 70,
	font = "Alsina",
	genericFont = "Candara",
	intro = false,
	inventoryHeight = 11,
	inventoryWidth = 7,
	maxCharacters = 1,
	maxHoldWeight = 250,
	month = 4,
	music = "stalkersound/music/coronaradiata.ogg",
	mutantLimit = 128,
	mutantRegionLimit = 32,
	saveInterval = 60,
	spawnTime = 300,
	thirdperson = true,
	walkSpeed = 100,
	weaponRaiseTime = 0.5,
	worldSpawnerThreshold = 50,
	year = 2022,
}

function PLUGIN:ApplyConfiguredDefaults()
	for key, value in pairs(DEFAULTS) do
		ix.config.SetDefault(key, value)
		-- InitializedPlugins precedes config.Load. Seed initial values, then let saved overrides load normally.
		if not IX_RELOADED then ix.config.stored[key].value = value end
	end
end
