-- Run from the repository root: luatex --luaonly tests/suit_appearance_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

-- Converts the GMod operators used by legacy item code into standard Lua.
local function standardLua(source)
	return (source:gsub("!=", "~="):gsub("!", "not "))
end

local function loadChunk(path, first, finish)
	local source = read(path)
	local start = assert(source:find(first, 1, true), first)
	local stop = assert(source:find(finish, start, true), finish) + #finish - 1
	assert(load(standardLua(source:sub(start, stop)), "@" .. path))()
end

SERVER = true
istable = function(value) return type(value) == "table" end
IsValid = function(value) return type(value) == "table" and value.valid == true end
Color = function(r, g, b) return {r = r, g = g, b = b} end
local anomalyMounted = true
local thapMounted = false
local bakedMounted = false
util = {IsValidModel = function(path)
	if path:find("/cotz/sleeves/", 1, true) then return bakedMounted end
	if path:find("/mods/thap/", 1, true) then return thapMounted end

	return not path:find("wpn_hand_", 1, true) or anomalyMounted
end}
ix = {util = {GetMaterial = function() end}}
dofile("gamemodes/ix_cotz/schema/libs/sh_suitappearance.lua")
dofile("gamemodes/ix_cotz/schema/libs/sv_suitappearance.lua")
dofile("gamemodes/ix_cotz/schema/libs/sv_suithands.lua")
dofile("gamemodes/ix_cotz/schema/libs/sv_bakedhands.lua")

local function newItem(definition, data)
	local item = setmetatable({data = data or {}, writes = {}}, {__index = definition})
	function item:GetData(key, default)
		if self.data[key] == nil then return default end

		return self.data[key]
	end
	function item:SetData(key, value)
		self.data[key] = value
		self.writes[#self.writes + 1] = key
	end

	return item
end

-- Bodygroups of the compiled Sector Four models (`reports/model_mapping.csv`). The exoskeleton's
-- frame toggle is added by the pack rebuild described in docs/suit-playermodels.md.
local MODELS = {
	["models/cotz/sectorfour/male_anorak.mdl"] = {skins = 61, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_trenchcoat.mdl"] = {skins = 9, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_berill5m.mdl"] = {skins = 13, groups = {Head = 2, gloves = 2}},
	["models/cotz/sectorfour/male_cs1.mdl"] = {skins = 12, groups = {Head = 2, gloves = 2}},
	["models/cotz/sectorfour/male_cs1a.mdl"] = {skins = 6, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_cs1b.mdl"] = {skins = 5, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_cs2.mdl"] = {skins = 7, groups = {Head = 2, gloves = 2}},
	["models/cotz/sectorfour/male_cs4.mdl"] = {skins = 5, groups = {Head = 2, gloves = 2}},
	["models/cotz/sectorfour/male_exoskeleton.mdl"] = {
		skins = 37, groups = {Head = 2, gloves = 2, Exoskeleton = 2},
	},
	["models/cotz/sectorfour/male_hawk.mdl"] = {skins = 40, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_psz9.mdl"] = {skins = 65, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_stingray9.mdl"] = {skins = 31, groups = {Head = 2, gloves = 2}},
	["models/cotz/sectorfour/male_sunrise.mdl"] = {skins = 49, groups = {Head = 2, Neck = 3, gloves = 2}},
	["models/cotz/sectorfour/male_nbc_lone.mdl"] = {
		skins = 51, groups = {Head = 2, Hood = 2, Gasmask = 2, Kneepads = 3, gloves = 2},
	},
	["models/cotz/sectorfour/male_seva.mdl"] = {skins = 65, groups = {Head = 3, gloves = 2}},
	["models/cotz/sectorfour/male_ssp99.mdl"] = {skins = 15, groups = {Head = 2, Neck = 3, gloves = 2}},
}

-- Finish lists and saved finishes.
local range = ix.suitAppearance.SkinOptions(0, 2)
check(#range == 3 and range[1].skingroup == 0 and range[3].name == "Skin 2", "ranges list every skin in order")
local listed = ix.suitAppearance.SkinOptions({4, 9})
check(#listed == 2 and listed[2].skingroup == 9, "explicit lists keep only the given skins")
local suit = {newModel = "new.mdl", newSkin = 4, skincustom = listed, bodyGroups = {Head = 1, Missing = 1}}
local legacy = newItem(suit, {setSkin = 9})
check(ix.suitAppearance.GetSkin(legacy) == 4, "finishes saved before the model replacement use the factory finish")
check(legacy.data.setSkin == 9, "reading a legacy finish never rewrites the saved value")
ix.suitAppearance.SaveSkin(legacy, 9)
check(ix.suitAppearance.GetSkin(legacy) == 9 and legacy.data.setSkinModel == "new.mdl",
	"saved finishes record the model they belong to")
legacy.data.setSkin = 5
check(ix.suitAppearance.GetSkin(legacy) == 4, "finishes outside the suit's list fall back to the factory finish")
local entity = {groups = {}}
function entity:FindBodygroupByName(name) return name == "Head" and 1 or -1 end
function entity:SetBodygroup(index, value) self.groups[index] = value end
local applied = ix.suitAppearance.ApplyBodygroups(entity, suit)
check(entity.groups[1] == 1 and applied[1] == 1 and next(applied, 1) == nil,
	"bodygroups apply by name and skip names the model lacks")

-- Shared models keep vest families apart.
local function set(values)
	local result = {}
	for _, value in ipairs(values) do result[value] = true end

	return result
end
local pathfinder, sunrise = set(ix.suitAppearance.PATHFINDER_SKINS), set(ix.suitAppearance.SUNRISE_SKINS)
local skat9, skat10 = set(ix.suitAppearance.SKAT9_SKINS), set(ix.suitAppearance.SKAT10_SKINS)
for skin = 0, 48 do
	check(not (pathfinder[skin] and sunrise[skin]), "Sunrise and Pathfinder never share skin " .. skin)
	check(pathfinder[skin] or sunrise[skin], "every Sector Four Sunrise skin belongs to a family: " .. skin)
end
for skin = 0, 30 do
	check(skat9[skin] ~= skat10[skin], "Stingray-9 skin " .. skin .. " belongs to exactly one Skat family")
end
check(pathfinder[41] and skat9[17] and skat10[18], "the reference vests define their families")

-- Concrete definitions.
local paths = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/suit"))
local definitions = {}
for path in paths:lines() do
	local source = read(path)
	ITEM = {skincustom = {}, bgcustom = {}, functions = {}}
	assert(load(standardLua(source), "@" .. path))()
	local id = path:match("sh_(suit_[%w_]+)%.lua$")
	definitions[id] = ITEM
	local model = MODELS[ITEM.newModel]
	check(model, id .. " uses a Sector Four playermodel")
	check(source:find("\nITEM.newSkin = %d+\n"), id .. " declares its factory finish")
	check(#ITEM.skincustom > 0, id .. " offers finishes")
	for _, option in ipairs(ITEM.skincustom) do
		check(option.skingroup >= 0 and option.skingroup < model.skins, id .. " lists real skins only")
	end
	check(ix.suitAppearance.IsAllowedSkin(ITEM, ITEM.newSkin), id .. " can be repainted to its factory finish")
	for name, value in pairs(ITEM.bodyGroups or {}) do
		check(model.groups[name] and value < model.groups[name], id .. " sets an existing bodygroup: " .. name)
	end
	local appliedGloves
	ix.suitAppearance.ApplyBodygroups({
		FindBodygroupByName = function(_, name) return name == "gloves" and 2 or -1 end,
		SetBodygroup = function(_, _, value) appliedGloves = value end,
	}, ITEM)
	check(appliedGloves == (id:match("^suit_anorak") and 0 or 1), id .. " applies the expected gloves")
	if ITEM.hoodBodygroup then
		check(model.groups[ITEM.hoodBodygroup.name], id .. " toggles an existing hood bodygroup")
	end
	check(not ITEM.functions.Lift, id .. " uses the shared hood action")
	check(ITEM.pacData == nil, id .. " needs no PAC overlay")
end
paths:close()

local function countDefinitions()
	local count = 0
	for _ in pairs(definitions) do count = count + 1 end

	return count
end
check(countDefinitions() == 95, "every concrete suit definition was checked")
for id, definition in pairs(definitions) do
	local allowed = set((function()
		local values = {}
		for _, option in ipairs(definition.skincustom) do values[#values + 1] = option.skingroup end

		return values
	end)())
	if id:match("^suit_sunrise") then check(not allowed[41] and allowed[0], id .. " uses Sunrise finishes") end
	if id:match("^suit_wind") then check(allowed[41] and not allowed[0], id .. " uses Pathfinder finishes") end
	if id:match("^suit_skat9") then check(allowed[17] and not allowed[18], id .. " uses Skat-9 finishes") end
	if id:match("^suit_skat10") then check(allowed[18] and not allowed[17], id .. " uses Skat-10 finishes") end
	if id:match("^suit_nbc") then
		local groups = definition.bodyGroups
		check(groups.Head == 1 and groups.Hood == 0 and groups.Gasmask == 1, id .. " stays sealed")
	end
	if id:match("^suit_seva") then check(definition.bodyGroups.Head == 0, id .. " keeps its helmet on") end
	if id:match("^suit_ssp99") then
		check(definition.bodyGroups.Head == 1 and definition.bodyGroups.Neck == 1, id .. " keeps its visor on")
	end
	if id:match("^suit_radsuit") then
		check(definition.bodyGroups.Exoskeleton == 1, id .. " hides the exoskeleton frame")
	end
	if id:match("^suit_exoskeleton") then
		check(definition.bodyGroups.Exoskeleton == 0, id .. " shows the exoskeleton frame")
	end
	if id:match("^suit_anorak") or id:match("^suit_mailjacket") or id:match("^suit_trenchcoat") then
		check(definition.hoodBodygroup and definition.hoodBodygroup.up == 1, id .. " can lift its hood")
	end
end

-- Character creation.
FACTION = {}
dofile("gamemodes/ix_cotz/schema/factions/sh_loners.lua")
local sweater = "models/cotz/sectorfour/male_outfit_novice.mdl"
check(#FACTION.models == 1 and FACTION.models[1][1] == sweater and FACTION.models[1][2] == 0
	and FACTION.models[1][3] == "000", "new Loners have the sweater and bare hands as their base outfit")
local legacyAnorak = ix.suitAppearance.LEGACY_BASE_MODELS["models/stalkerisaac/playermodel/male_01_anorak.mdl"]
local mapped = {}
for _, skin in pairs(legacyAnorak.skins) do
	check(skin < ix.suitAppearance.LONER_ANORAK_SKIN_COUNT and not mapped[skin],
		"legacy creator skins map to distinct Loner finishes")
	mapped[skin] = true
end

-- Suit base: worn appearance, painting and hood.
ITEM = {functions = {}}
loadChunk("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "function ITEM:OnLoadout(", "\nend")
loadChunk("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "function ITEM:RemoveOutfit(", "\nend")
loadChunk("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "ITEM.functions.zCustomizeSkin = {", "\n}")
loadChunk("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "ITEM.functions.Lift = {", "\n}")
local base = ITEM

local function newCharacter(model, data, items)
	local inventory = {items = items or {}}
	function inventory:GetItems() return self.items end
	function inventory:GetOwner() return self.owner end
	local character = {model = model, data = data or {}, inventory = inventory}
	function character:GetModel() return self.model end
	function character:SetModel(value) self.model = value end
	function character:GetInventory() return self.inventory end
	function character:GetData(key, default)
		if self.data[key] == nil then return default end

		return self.data[key]
	end
	function character:SetData(key, value) self.data[key] = value end
	function character:Save(callback) if callback then callback() end end

	return character
end

local function newPlayer(character, groupNames)
	local player = {valid = true, character = character, groups = {[0] = 3, 3, 3}, skin = 7}
	function player:GetCharacter() return self.character end
	function player:GetModel() return self.character:GetModel() end
	function player:GetSkin() return self.skin end
	function player:GetHands() return self.hands end
	function player:SetupHands()
		local model, skin = ix.suitAppearance.GetHandsModel(self)
		self.hands = {valid = true, GetModel = function() return model end, skin = skin or 0}
		function self.hands:GetSkin() return self.skin end
		function self.hands:SetSkin(value) self.skin = value end
	end
	function player:RecalculateResistances() self.resistancesUpdated = true end
	function player:ReevaluateOverlay() self.overlayUpdated = true end
	function player:RemovePart() end
	function player:SetSkin(skin) self.skin = skin end
	function player:ResetBodygroups() self.groups = {[0] = 0, 0, 0} end
	function player:FindBodygroupByName(name) return groupNames[name] or -1 end
	function player:GetBodygroup(index) return self.groups[index] end
	function player:SetBodygroup(index, value) self.groups[index] = value end

	return player
end

local nbc = definitions.suit_nbc
local worn = newItem(setmetatable({}, {__index = function(_, key) return base[key] or nbc[key] end}),
	{equip = true})
local character = newCharacter("models/cotz/sectorfour/male_anorak.mdl", {groups = {[2] = 1}})
local player = newPlayer(character, {Head = 0, Hood = 1, Gasmask = 2, gloves = 3})
worn.GetOwner = function() return player end
worn:OnLoadout()
check(character.model == nbc.newModel and player.skin == nbc.newSkin, "a worn suit applies its model and finish")
check(player.groups[0] == 1 and player.groups[1] == 0 and player.groups[2] == 1,
	"a sealed suit starts from the model's defaults and closes its helmet")
check(character.data.groups[0] == 1 and character.data.groups[2] == 1, "the worn bodygroups are saved for setup")
check(player.groups[3] == 1 and player:GetHands():GetModel() == "models/flaymi/hands/wpn_hand_loner_sunrise.mdl",
	"equipping a gloved NBC suit applies the gloved Sunrise arms after the bodygroups")
player.groups[1] = 1
worn:OnLoadout()
check(player.groups[1] == 0 and player.groups[0] == 1, "respawns restore the fixed bodygroups")
worn.player = player
check(not base.functions.zCustomizeSkin.OnRun(worn, {51}) and worn.data.setSkin == nil,
	"the paint action rejects skins the suit does not list")
base.functions.zCustomizeSkin.OnRun(worn, {29})
check(worn.data.setSkin == 29 and worn.data.setSkinModel == nbc.newModel and player.skin == 29
	and player.groups[0] == 1, "the paint action saves and applies the finish with the helmet on")
check(player:GetHands():GetModel() == "models/flaymi/hands/wpn_hand_freedom_wind.mdl",
	"changing a suit finish refreshes the sleeves to the matching Sunrise finish's arms")
thapMounted = true
ix.suitAppearance.RefreshHands(player)
check(player:GetHands():GetModel() == "models/flaymi/stalker/mods/thap/arms/wpn_hand_freedom_wind.mdl",
	"an installed THAP model takes priority over the stock gloved donor")
thapMounted = false
anomalyMounted = false
ix.suitAppearance.RefreshHands(player)
check(player:GetHands():GetModel() == "models/arms/c_arms_stalker.mdl", "unmounted donors use the CotZ fallback")
anomalyMounted = true
local hooded = newItem(setmetatable({}, {__index = function(_, key)
	return base[key] or definitions.suit_anorak[key]
end}), {equip = true})
hooded.player = newPlayer(character, {Neck = 2})
hooded.player.groups[2] = 0
check(base.functions.Lift.OnCanRun(hooded), "suits with a hood offer the hood action")
check(not base.functions.Lift.OnCanRun(worn), "suits without a hood do not offer it")
base.functions.Lift.OnRun(hooded)
check(hooded.player.groups[2] == 1, "the hood lifts by bodygroup name")
base.functions.Lift.OnRun(hooded)
check(hooded.player.groups[2] == 0, "the hood lowers again")

-- Saved character migration.
local LEGACY = "models/stalkerisaac/playermodel/male_01_anorak.mdl"
local unworn = newCharacter(LEGACY, {skin = 13, groups = {[1] = 1}})
ix.suitAppearance.MigrateCharacter(unworn)
check(unworn.model == "models/cotz/sectorfour/male_anorak.mdl" and unworn.data.skin == 9
	and unworn.data.groups == nil, "unworn legacy characters move to the new Anorak in creator order")
ix.suitAppearance.MigrateCharacter(unworn)
check(unworn.data.skin == 9, "migration is idempotent")
local custom = newCharacter("models/custom/admin.mdl", {skin = 3, groups = {[1] = 1}})
ix.suitAppearance.MigrateCharacter(custom)
check(custom.model == "models/custom/admin.mdl" and custom.data.skin == 3 and custom.data.groups[1] == 1,
	"models outside the legacy creator set are untouched")

local wornSuit = newItem(setmetatable({}, {__index = function(_, key)
	return base[key] or definitions.suit_sunrise[key]
end}), {equip = true, origgroups = {[1] = 1}, setSkin = 3})
wornSuit.outfitCategory = "model"
wornSuit.isBodyArmor = true
local wearer = newCharacter("models/stalkerisaac/playermodel/male_01_sunrise.mdl",
	{oldModelmodel = LEGACY, oldSkinmodel = 25, skin = 25, groups = {[1] = 3}}, {wornSuit})
ix.suitAppearance.MigrateCharacter(wearer)
check(wearer.model == definitions.suit_sunrise.newModel and wearer.data.groups == nil,
	"worn suits load on their new model without legacy bodygroups")
check(wearer.data.oldModelmodel == "models/cotz/sectorfour/male_anorak.mdl" and wearer.data.oldSkinmodel == 16
	and wearer.data.skin == 16, "the appearance restored after taking a suit off is migrated too")
check(wornSuit.data.origgroups == nil and wornSuit.data.setSkin == 3,
	"legacy pre-suit bodygroups are cleared; the saved finish is kept but ignored")
local writes = #wornSuit.writes
ix.suitAppearance.MigrateCharacter(wearer)
check(#wornSuit.writes == writes and wearer.model == definitions.suit_sunrise.newModel,
	"migrated wearers are not rewritten on later loads")

-- The grant rolls once and goes through the inventory's normal equipped-state setter after insertion.
local starterCharacter = newCharacter(sweater)
local starterInventory = starterCharacter:GetInventory()
local starterDefinition = definitions.suit_anorak
starterDefinition.uniqueID = "suit_anorak"
starterDefinition.outfitCategory = "model"
starterDefinition.isBodyArmor = true
ix.item = {Get = function() return starterDefinition end}
ix.char = {loaded = {[1] = starterCharacter}}
ix.weight = {Update = function(owner) owner.weightUpdated = true end}
local starter
function starterInventory:Add(id, quantity, data)
	check(id == "suit_anorak" and quantity == 1 and data.equip == nil,
		"the starter is inserted before it is moved to the equipment slot")
	starter = newItem(starterDefinition, data)
	starter.GetCharacterID = function() return 1 end
	self.items[1] = starter
	return 1
end
ix.suitAppearance.GrantStarterAnorak(starterCharacter)
local finish = starter.data.setSkin
check(finish >= 0 and finish < 35 and starter.data.setSkinModel == starterDefinition.newModel,
	"the grant saves a Loner color on the new item")
local starterPlayer = newPlayer(starterCharacter, {gloves = 3})
starterInventory.owner = starterPlayer
ix.suitAppearance.FinishStarterAnorak(starterInventory, starter)
check(starter.data.equip and not starter.data.starterAnorak and starterPlayer.skin == finish
	and starterCharacter.model == starterDefinition.newModel and starterCharacter.data.oldModelmodel == sweater
	and starterCharacter.data.oldSkinmodel == 0, "the equipped Anorak retains the sweater underneath")
check(starterPlayer.resistancesUpdated and starterPlayer.overlayUpdated and starterCharacter.weightUpdated,
	"a late starter grant refreshes the current player's equipment effects")
check(starterPlayer.groups[3] == 0
	and starterPlayer:GetHands():GetModel() == "models/flaymi/hands/wpn_hand_loner_novice.mdl",
	"the Anorak uses Loner jacket sleeves instead of sweater sleeves")
thapMounted = true
starterPlayer:SetSkin(0)
ix.suitAppearance.RefreshHands(starterPlayer)
check(starterPlayer:GetHands():GetModel() == "models/flaymi/stalker/mods/thap/arms/wpn_hand_loner_novice.mdl",
	"the tan Anorak prefers the THAP bare-handed jacket model")
ix.suitAppearance.MigrateCharacter(starterCharacter)
check(starter.data.setSkin == finish, "loading the starter suit leaves its rolled color intact")
starter.GetOwner = function() return starterPlayer end
base.RemoveOutfit(starter, starterPlayer)
check(starterCharacter.model == sweater and starterPlayer.skin == 0 and starterPlayer.groups[3] == nil
	and not starter.data.equip, "removing the starter suit restores the plain sweater")
check(starterPlayer:GetHands():GetModel() == "models/flaymi/hands/wpn_hand_no_outfit.mdl",
	"the sweater uses the CotZ sweater arms")

-- Baked coats change their model skin without replacing the hands entity.
bakedMounted = true
starterCharacter.model = starterDefinition.newModel
starterPlayer:SetSkin(0)
ix.suitAppearance.RefreshHands(starterPlayer)
local bakedHands = starterPlayer:GetHands()
local tan = bakedHands:GetSkin()
check(bakedHands:GetModel():find("models/cotz/sleeves/", 1, true) and tan > 0,
	"the tan jacket uses a baked hands model and skin")
starterPlayer:SetSkin(11)
ix.suitAppearance.RefreshHands(starterPlayer)
check(starterPlayer:GetHands() == bakedHands and bakedHands:GetSkin() ~= tan,
	"repainting to blue updates the baked skin on the same hands entity")
starterCharacter.model = sweater
ix.suitAppearance.RefreshHands(starterPlayer)
check(starterPlayer:GetHands():GetModel() == "models/flaymi/hands/wpn_hand_no_outfit.mdl",
	"changing to the sweater restores the stock rig")

print("Suit appearance: " .. checks .. " checks passed")
