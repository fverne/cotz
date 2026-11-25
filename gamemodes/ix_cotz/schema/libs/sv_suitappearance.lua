local LEGACY_ANORAK = "models/stalkerisaac/playermodel/male_01_anorak.mdl"
local BARE_HANDS = "models/flaymi/hands/wpn_hand_no_outfit.mdl"
local GLOVED_HANDS = "models/arms/c_arms_stalker.mdl"
local LEGACY_ANORAK_CREATOR_SKINS = {
	0, 1, 2, 3, 4, 5, 6, 7, 8, 13, 14, 15, 16, 21, 22, 23, 25, 26, 27, 28, 29, 30, 31, 32,
}

-- The former character creator's Anorak skins keep their menu order on the new Loner finishes.
local legacyAnorakSkins = {}
for index, skin in ipairs(LEGACY_ANORAK_CREATOR_SKINS) do
	legacyAnorakSkins[skin] = index - 1
end

-- Unworn character appearances replaced by the Sector Four playermodels.
ix.suitAppearance.LEGACY_BASE_MODELS = {
	[LEGACY_ANORAK] = {
		model = "models/cotz/sectorfour/male_anorak.mdl",
		skins = legacyAnorakSkins,
		defaultSkin = 0,
	},
}

function ix.suitAppearance.SaveSkin(item, skin)
	item:SetData("setSkin", skin)
	item:SetData("setSkinModel", item.newModel)
	item:SetData("setSkinOverrideModel", nil)
end

function ix.suitAppearance.GetHandsModel(client)
	if not ix.suitAppearance.IsSectorFourModel(client:GetModel()) then return end

	local gloves = client:FindBodygroupByName("gloves")
	local gloved = gloves >= 0 and client:GetBodygroup(gloves) == 1
	local anomalyHands, skin = ix.suitAppearance.GetAnomalyHands(client, gloved)
	if anomalyHands then return anomalyHands, skin end

	if gloved and util.IsValidModel(GLOVED_HANDS) then
		return GLOVED_HANDS
	end

	return BARE_HANDS
end

function ix.suitAppearance.RefreshHands(client)
	local model, skin = ix.suitAppearance.GetHandsModel(client)
	if not model then return end

	local hands = client:GetHands()
	if not IsValid(hands) or hands:GetModel() ~= model then
		client:SetupHands()
	elseif hands:GetSkin() ~= (skin or 0) then
		hands:SetSkin(skin or 0)
	end
end

-- Puts the suit's model, finish and bodygroups on its wearer and records the bodygroups that Helix
-- restores during character setup. Bodygroup indices differ between models, so a model change
-- starts from the new model's defaults.
function ix.suitAppearance.ApplyWorn(client, item)
	local character = client:GetCharacter()
	local groups = character:GetData("groups", {})
	if character:GetModel() ~= item.newModel then
		character:SetModel(item.newModel)
		client:ResetBodygroups()
		groups = {}
	end

	client:SetSkin(ix.suitAppearance.GetSkin(item))
	for index, value in pairs(ix.suitAppearance.ApplyBodygroups(client, item)) do
		groups[index] = value
	end
	character:SetData("groups", groups)
	ix.suitAppearance.RefreshHands(client)
	ix.plugin.Get("legs"):RefreshLegs(client)
end

local function getWornSuit(character)
	local inventory = character:GetInventory()
	if not inventory then return end

	local worn, starter
	for _, item in pairs(inventory:GetItems()) do
		if not worn and item.isBodyArmor and item.newModel and item:GetData("equip") then worn = item end
		if item:GetData("starterAnorak") then starter = item end
	end

	return worn, starter
end

local function getReplacement(model, skin)
	local legacy = ix.suitAppearance.LEGACY_BASE_MODELS[model or ""]
	if not legacy then return end

	return legacy.model, legacy.skins[skin] or legacy.defaultSkin
end

function ix.suitAppearance.GrantStarterAnorak(character)
	local inventory = character:GetInventory()
	local anorak = ix.item.Get("suit_anorak")
	if not inventory or not anorak then return end

	local skin = math.random(0, ix.suitAppearance.LONER_ANORAK_SKIN_COUNT - 1)
	local added, reason = inventory:Add(anorak.uniqueID, 1, {
		starterAnorak = true,
		setSkin = skin,
		setSkinModel = anorak.newModel,
	})
	if not added then
		ErrorNoHalt("[COTZ] Could not grant the starter Anorak: " .. tostring(reason) .. "\n")
	end
end

function ix.suitAppearance.FinishStarterAnorak(inventory, suit)
	if not suit:GetData("starterAnorak") then return end

	local character = ix.char.loaded[suit:GetCharacterID()]
	if not character or character:GetInventory() ~= inventory then return end
	local worn = getWornSuit(character)
	if worn and worn ~= suit then
		suit:SetData("starterAnorak", nil)

		return
	end

	local modelKey = "oldModel" .. suit.outfitCategory
	if not character:GetData(modelKey) then
		character:SetData(modelKey, ix.suitAppearance.SWEATER_MODEL)
		character:SetData("oldSkin" .. suit.outfitCategory, 0)
	end
	suit:SetData("equip", true)

	-- Helix can finish the inventory insert after the player has selected the new character.
	local client = inventory:GetOwner()
	if IsValid(client) and client:GetCharacter() == character then
		ix.suitAppearance.ApplyWorn(client, suit)
		client:RecalculateResistances()
		client:ReevaluateOverlay()
		ix.weight.Update(character)
	end
	character:Save(function()
		suit:SetData("starterAnorak", nil)
	end)
end

local function migrateWornSuit(character, suit)
	local modelKey, skinKey = "oldModel" .. suit.outfitCategory, "oldSkin" .. suit.outfitCategory
	local baseSkin = character:GetData(skinKey, character:GetData("skin", 0))
	local model, skin = getReplacement(character:GetData(modelKey), baseSkin)
	if model then
		character:SetData(modelKey, model)
		character:SetData(skinKey, skin)
		character:SetData("skin", skin)
		-- These were captured on the legacy model and would select unrelated bodygroups now.
		suit:SetData("origgroups", nil)
	end

	if character:GetModel() ~= suit.newModel then
		character:SetModel(suit.newModel)
		character:SetData("groups", nil)
	end
end

-- Moves a loading character off the legacy playermodels before Helix applies its saved appearance.
-- Already migrated characters are left unchanged, so this is safe on every load and map transfer.
function ix.suitAppearance.MigrateCharacter(character)
	local suit, starter = getWornSuit(character)
	if starter then
		ix.suitAppearance.FinishStarterAnorak(character:GetInventory(), starter)
		if starter:GetData("equip") then suit = starter end
	end
	if suit then
		migrateWornSuit(character, suit)

		return
	end

	local model, skin = getReplacement(character:GetModel(), character:GetData("skin", 0))
	if not model then return end
	character:SetModel(model)
	character:SetData("skin", skin)
	character:SetData("groups", nil)
end
