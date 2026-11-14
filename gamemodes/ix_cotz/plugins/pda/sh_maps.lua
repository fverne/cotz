PLUGIN.maps = {
	swamps = {
		name = "Swamps",
		urlConfig = "pdaMapSwampsURL",
	},
	farmlands = {
		name = "Farmlands",
		urlConfig = "pdaMapFarmlandsURL",
	},
	waystation = {
		name = "Waystation",
		urlConfig = "pdaMapWaystationURL",
	},
	pripyat = {
		name = "Pripyat",
		urlConfig = "pdaMapPripyatURL",
	},
	garbage = {
		name = "Garbage",
		urlConfig = "pdaMapGarbageURL",
	},
}

ix.config.Add("pdaMapSwampsURL", "https://media.discordapp.net/attachments/673842219144183809/1446868781191397496/cotz_swamp.png?ex=6af86e0e&is=6af71c8e&hm=cf68be3e3e65cad4c78929772be87fa7a80ab23d4e1112dc42708447197745cb&format=webp&quality=lossless&width=1024&height=1024", "Image URL displayed by the Swamps map USB. Use a direct HTTP or HTTPS image URL.", nil, {
	category = "PDA Maps",
})

ix.config.Add("pdaMapFarmlandsURL", "", "Image URL displayed by the Farmlands map USB. Use a direct HTTP or HTTPS image URL.", nil, {
	category = "PDA Maps",
})

ix.config.Add("pdaMapWaystationURL", "", "Image URL displayed by the Waystation map USB. Use a direct HTTP or HTTPS image URL.", nil, {
	category = "PDA Maps",
})

ix.config.Add("pdaMapPripyatURL", "", "Image URL displayed by the Pripyat map USB. Use a direct HTTP or HTTPS image URL.", nil, {
	category = "PDA Maps",
})

ix.config.Add("pdaMapGarbageURL", "", "Image URL displayed by the Garbage map USB. Use a direct HTTP or HTTPS image URL.", nil, {
	category = "PDA Maps",
})

function PLUGIN:GetMapInstallTarget(item)
	if IsValid(item.entity) or not self.maps[item.mapID] then return end
	local client = item.player
	if not IsValid(client) then return end
	local character = client:GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory or inventory:GetItemByID(item.id) ~= item then return end
	if character:GetData("cotzMaps", {})[item.mapID] == true then return end

	return character
end

function PLUGIN:GetInstalledMaps(client)
	local character = IsValid(client) and client:GetCharacter()
	local installed = character and character:GetData("cotzMaps", {}) or {}
	local maps = {}
	for id, definition in pairs(self.maps) do
		if installed[id] == true then maps[#maps + 1] = {id = id, name = definition.name} end
	end
	table.sort(maps, function(a, b) return a.name < b.name end)

	return maps
end
