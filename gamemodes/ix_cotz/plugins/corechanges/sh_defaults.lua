local DEFAULTS = {
	allowVoice = true,
	artifactSpawnerThreshold = 5,
	blowoutRemoveItems = true,
	blowoutRemoveNPCs = true,
	boxSpawnerThreshold = 40,
	charloadremove = true,
	color = Color(145, 145, 145, 255),
	communityText = "Discord",
	containerOpenTime = 0,
	containerSpawnChanceScaling = 0,
	containerSpawnRate = 1800,
	cotzintro = false,
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
	pdaMapSwampsURL = "https://media.discordapp.net/attachments/940346461705601054/1571027053338431620/cotz_swamp.png?ex=6af93c75&is=6af7eaf5&hm=73462b536c962c3a2381a369bcb07366a01ae4b5799003de3aa7a36656bbd7ba&format=webp&quality=lossless&width=1024&height=1024",
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
