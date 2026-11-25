-- Donors from [Anomaly] Hands (2943525727) and [DLTX] T.H.A.P. Rework 2.1 (3130162394).
-- Skin indices refer to Sector Four suits.
local HANDS_PATH = "models/flaymi/hands/wpn_hand_"
local THAP_HANDS_PATH = "models/flaymi/stalker/mods/thap/arms/wpn_hand_"
local THAP_DONOR_NAMES = {
	duty_skat9 = "duty_psz9d",
	trench_brown = "brown_trench",
}
-- Prefer rigs with their own sleeve slot when the original THAP donor shares its glove atlas.
local THAP_SLEEVE_DONORS = {
	bandit_seva = "bandit_nbc_suit",
	bandit_sun = "bandit_ps5",
	cs3b = "cs3a",
	cs_seva = "cs_nbc_suit",
	duty_seva = "duty_nbc_suit",
	freedom_seva = "freedom_nbc_suit",
	isg_suit = "isg_camo_mk2",
	loner_seva = "loner_nbc_suit",
	loner_sunrise = "loner_sunrise_predator",
	merc_seva = "merc_nbc_suit",
	merc_suit = "merc_fighter",
	monolith_seva = "monolith_nbc_suit",
}
local ANORAK_HANDS = {
	"loner_novice",
	{35, 46, "bandit_novice"},
	{47, 47, "cs_novice"},
	{48, 50, "duty_novice"},
	{51, 53, "freedom_novice"},
	{54, 54, "cs_novice"},
	{55, 57, "bandit_novice"},
	{58, 59, "military_novice"},
}

local SUIT_HANDS = {
	male_anorak = {
		"loner_sunrise",
		{35, 46, "bandit_sun"},
		{47, 47, "cs1"},
		{48, 50, "duty_ps5m"},
		{51, 53, "freedom_wind"},
		{54, 57, "merc_sun"},
		{58, 59, "military_berill"},
	},
	male_berill1 = {"military_berill"},
	male_berill5m = {
		"military_berill", {3, 4, "duty_ps5m"}, {6, 7, "freedom_wind"}, {8, 9, "merc_suit"},
	},
	male_cs1 = {"cs1", {9, 10, "duty_ps5m"}, {11, 11, "freedom_wind"}},
	male_cs1a = {"cs1", {4, 4, "duty_ps5m"}, {5, 5, "freedom_wind"}},
	male_cs1b = {"cs1"},
	male_cs2 = {"cs2", {5, 5, "freedom_wind"}, {6, 6, "merc_suit"}},
	male_cs4 = {"cs3b", {4, 4, "freedom_skat9"}},
	male_exoskeleton = {
		"exo",
		{7, 10, "bandit_exo"},
		{11, 12, "cs_exo"},
		{13, 16, "dolg_exo"},
		{17, 18, "ecolog_exo"},
		{19, 22, "freedom_exo"},
		{24, 27, "merc_exo"},
		{28, 28, "military_exo"},
		{29, 34, "monolith_exo"},
	},
	male_hawk = {
		"military_berill", {8, 28, "merc_suit"}, {29, 31, "military_skat9"}, {32, 32, "monolith_suit"},
	},
	male_outfit_expedition = {"loner_sunrise"},
	male_psz9 = {
		"military_berill",
		{5, 6, "bandit_ps5"}, {7, 7, "cs1"}, {8, 11, "duty_psz9d"}, {16, 22, "freedom_wind"},
		{23, 23, "isg_suit"}, {26, 26, "monolith_suit"},
		{35, 36, "bandit_ps5"}, {37, 39, "cs1"}, {40, 43, "duty_psz9d"},
		{45, 47, "freedom_wind"}, {48, 50, "isg_suit"}, {51, 56, "merc_suit"}, {59, 63, "monolith_suit"},
	},
	male_seva = {
		"loner_seva",
		{5, 6, "bandit_seva"}, {7, 7, "cs_seva"}, {8, 11, "duty_seva"}, {16, 22, "freedom_seva"},
		{26, 26, "monolith_seva"}, {35, 36, "bandit_seva"}, {37, 39, "cs_seva"}, {40, 43, "duty_seva"},
		{45, 47, "freedom_seva"}, {51, 56, "merc_seva"}, {59, 63, "monolith_seva"},
	},
	male_ssp99 = {
		"ecologist_ssp99m",
		{0, 0, "ecologist_white"}, {1, 1, "ecologist_ssp99"}, {2, 2, "ecologist_yello"},
		{3, 3, "ecologist_red"}, {4, 4, "ecologist_blue"}, {7, 7, "ecologist_ssp99"},
		{9, 9, "ecologist_ssp99"}, {10, 10, "ecologist_red"}, {12, 12, "ecologist_yello"},
		{13, 13, "ecologist_red"},
	},
	male_stingray9 = {
		"military_skat9", {4, 5, "bandit_skat9"}, {6, 7, "cs_skat9"}, {8, 11, "duty_skat9"},
		{13, 16, "freedom_skat9"}, {19, 23, "merc_skat9"}, {27, 30, "monolith_skat9"},
	},
	male_sunrise = {
		"loner_sunrise", {22, 22, "merc_sun"}, {23, 23, "military_berill"}, {24, 24, "monolith_suit"},
		{25, 25, "bandit_sun"}, {26, 26, "duty_ps5m"}, {27, 27, "freedom_wind"}, {30, 30, "monolith_suit"},
		{31, 32, "bandit_ps5"}, {34, 35, "cs1"}, {36, 37, "duty_ps5m"}, {39, 42, "freedom_wind"},
		{43, 43, "isg_suit"}, {44, 45, "merc_sun"}, {46, 48, "monolith_suit"},
	},
	male_trenchcoat = {"trench_brown", {1, 1, "bandit_trench"}},
}

-- NBC skins 2-50 are the Sunrise finishes in Sunrise order, so NBC suits wear the matching gloved
-- Sunrise arms; its two original Loner skins use the Loner Sunrise arms.
local NBC_SUNRISE_SKIN_OFFSET = 2
SUIT_HANDS.male_nbc_lone = {SUIT_HANDS.male_sunrise[1]}
for index = 2, #SUIT_HANDS.male_sunrise do
	local range = SUIT_HANDS.male_sunrise[index]
	SUIT_HANDS.male_nbc_lone[index] = {
		range[1] + NBC_SUNRISE_SKIN_OFFSET, range[2] + NBC_SUNRISE_SKIN_OFFSET, range[3],
	}
end

local function getDonor(choices, skin)
	for index = 2, #choices do
		local range = choices[index]
		if skin >= range[1] and skin <= range[2] then return range[3] end
	end

	return choices[1]
end

function ix.suitAppearance.GetAnomalyHands(client, gloved)
	local model = client:GetModel():match("/([^/]+)%.mdl$")
	local choices = model == "male_anorak" and not gloved and ANORAK_HANDS or SUIT_HANDS[model]
	if not choices then return end

	local skin = client:GetSkin()
	local donor = getDonor(choices, skin)
	if model == "male_exoskeleton" then
		local frame = client:FindBodygroupByName("Exoskeleton")
		if frame >= 0 and client:GetBodygroup(frame) == 1 then
			if donor == "exo" or donor == "ecolog_exo" then
				donor = "exolight"
			else
				donor = donor:gsub("_exo$", "_exolight")
			end
		end
	end

	-- All bare Anoraks can share the Novice rig because the client supplies the selected jacket fabric.
	local thapDonor = gloved and (THAP_SLEEVE_DONORS[donor] or THAP_DONOR_NAMES[donor] or donor) or "loner_novice"
	if model == "male_trenchcoat" and (skin == 4 or skin == 5) then thapDonor = "green_trench" end
	local bakedModel, bakedSkin = ix.suitAppearance.GetBakedHands(model, thapDonor, skin)
	if bakedModel then return bakedModel, bakedSkin end

	local reworkPath = THAP_HANDS_PATH .. thapDonor .. ".mdl"
	if util.IsValidModel(reworkPath) then return reworkPath end

	local path = HANDS_PATH .. donor .. ".mdl"
	if util.IsValidModel(path) then return path end
end
