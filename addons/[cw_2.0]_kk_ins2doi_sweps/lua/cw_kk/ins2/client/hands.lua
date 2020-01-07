
CustomizableWeaponry_KK.ins2.hands = {}
CustomizableWeaponry_KK.ins2.hands._cache = {}

function CustomizableWeaponry_KK.ins2.hands:_get(i)
	return self._cache[math.Round(math.Clamp(i or 1, 1, self.cacheSize), 0)]
end

function CustomizableWeaponry_KK.ins2.hands:addModel(tab)
	table.insert(self._cache, tab)
	self.cacheSize = #self._cache
end

CustomizableWeaponry_KK.ins2.hands:addModel({"models/gmod4phun/c_ins_to_gmod_hands.mdl", "[GM] PM hands (by G4P)", mergeGMHands = true})
CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_cw_kk_ins2_hands_css.mdl", "[CSS] shared"})

if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/cw_kk_ins2_base"}) then
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_vip.mdl", "[INS] Very Individual Player"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ins_h.mdl", "[INS] T Heavy"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ins_m.mdl", "[INS] T Medium"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ins_l.mdl", "[INS] T Light"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_sec_h.mdl", "[INS] CT Heavy"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_sec_m.mdl", "[INS] CT Medium"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_sec_l.mdl", "[INS] CT Light"})
end

if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/doiGameContentOK"}) then
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_brit.mdl", "[DOI] GB Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_brit.mdl", "[DOI] GB Sleeve"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_brit_gloves.mdl", "[DOI] GB Gloved"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_brit_indian.mdl", "[DOI] GB India Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_brit_indian.mdl", "[DOI] GB India Sleeve"})

	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_us.mdl", "[DOI] US Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_us.mdl", "[DOI] US Sleeve"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_us_glove.mdl", "[DOI] US Gloved"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_us_glove_airborne.mdl", "[DOI] US Para"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_us_buffalo.mdl", "[DOI] US Buff Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_us_buffalo.mdl", "[DOI] US Buff Sleeve"})

	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_ger.mdl", "[DOI] DE Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ger.mdl", "[DOI] DE Sleeve"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ger_gloves.mdl", "[DOI] DE Gloved"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ger_wehrmacht.mdl", "[DOI] DE Wehr Sleeve"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ger_gloves_wehrmacht.mdl", "[DOI] DE Wehr Gloved"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ger_gloves_paratrooper.mdl", "[DOI] DE Para"})
end

if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/namModContentOK"}) then
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_us_nam.mdl", "[B2K] US Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_nam_hands_us.mdl", "[B2K] US Sleeve"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_short_us_black.mdl", "[B2K] US2 Short"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_nva.mdl", "[B2K] NVA Short"})
end

if CustomizableWeaponry_KK.ins2.isContentMounted4({Folder = "weapons/doiWW1ModContentOK"}) then
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ww1_ger.mdl", "[WW1] DE"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ww1_ger_gloves.mdl", "[WW1] DE Gloved"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ww1_brit.mdl", "[WW1] GB"})
	CustomizableWeaponry_KK.ins2.hands:addModel({"models/weapons/v_hands_ww1_brit_gloves.mdl", "[WW1] GB Gloved"})
end
