-- Worn suit appearance: the model, finish (skin) and named bodygroups a suit puts on its wearer.
ix.suitAppearance = ix.suitAppearance or {}

local SECTOR_FOUR_PATH = "models/cotz/sectorfour/"
ix.suitAppearance.SWEATER_MODEL = SECTOR_FOUR_PATH .. "male_outfit_novice.mdl"
ix.suitAppearance.LONER_ANORAK_SKIN_COUNT = 35

-- Families sharing a model are kept apart by the vest painted into each skin's texture.
-- Sector Four Sunrise: Pathfinder finishes have skin 41's plain-flap pouch vest; Sunrise has the rest.
ix.suitAppearance.PATHFINDER_SKINS = {30, 31, 32, 33, 37, 39, 41, 42, 46, 47, 48}
ix.suitAppearance.SUNRISE_SKINS = {
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
	34, 35, 36, 38, 40, 43, 44, 45,
}
-- Stingray-9: Skat-9 has skin 17's three-pouch vest, Skat-10 skin 18's two-pouch vest.
ix.suitAppearance.SKAT9_SKINS = {1, 2, 3, 4, 5, 6, 10, 12, 14, 15, 16, 17, 22, 28, 29, 30}
ix.suitAppearance.SKAT10_SKINS = {0, 7, 8, 9, 11, 13, 18, 19, 20, 21, 23, 24, 25, 26, 27}

-- Builds a suit's `skincustom` finish list. Pass an inclusive range (`SkinOptions(0, 60)`) when every
-- skin of the model is allowed, or a list of skin indices when only some finishes belong to the suit.
function ix.suitAppearance.SkinOptions(first, last)
	local skins = first
	if type(first) ~= "table" then
		skins = {}
		for skin = first, last do skins[#skins + 1] = skin end
	end

	local options = {}
	for _, skin in ipairs(skins) do
		options[#options + 1] = {name = "Skin " .. skin, skingroup = skin}
	end

	return options
end

function ix.suitAppearance.IsAllowedSkin(item, skin)
	for _, option in pairs(item.skincustom or {}) do
		if option.skingroup == skin then return true end
	end

	return false
end

-- A saved finish only applies to the model it was chosen on. Finishes saved before the playermodel
-- replacement indexed the legacy models' skin tables, so they fall back to the suit's factory finish.
function ix.suitAppearance.GetSkin(item)
	local skin = item:GetData("setSkin")
	local savedForModel = item:GetData("setSkinModel") == item.newModel
	if skin ~= nil and savedForModel and ix.suitAppearance.IsAllowedSkin(item, skin) then return skin end

	-- Coats merged from the former colour items keep their colour until repainted.
	local coat = item:GetData("legacyCoatSkin")
	if coat ~= nil and ix.suitAppearance.IsAllowedSkin(item, coat) then return coat end

	return item.newSkin or 0
end

-- Applies the suit's named bodygroups and returns them by index for the entity's current model.
function ix.suitAppearance.IsSectorFourModel(model)
	return model and string.sub(model, 1, #SECTOR_FOUR_PATH) == SECTOR_FOUR_PATH
end

function ix.suitAppearance.ApplyBodygroups(entity, item)
	local groups = {}
	for name, value in pairs(item.bodyGroups or {}) do
		local index = entity:FindBodygroupByName(name)
		if index > -1 then
			entity:SetBodygroup(index, value)
			groups[index] = value
		end
	end
	if ix.suitAppearance.IsSectorFourModel(item.newModel) then
		local index = entity:FindBodygroupByName("gloves")
		if index >= 0 then
			local bareHands = item.baseSuit == "suit_anorak" or item.newModel == ix.suitAppearance.SWEATER_MODEL
			local value = bareHands and 0 or 1
			entity:SetBodygroup(index, value)
			groups[index] = value
		end
	end

	return groups
end
