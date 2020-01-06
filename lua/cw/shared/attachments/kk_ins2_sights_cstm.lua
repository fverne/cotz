local att = {}
att.name = "kk_ins2_sights_cstm"
att.displayName = "INS2 Comm."
att.displayNameShort = "Workshop"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		-- [1] = {t = "Makes you love this pack even more.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		-- [2] = {t = "Does not force you to donate muney.", c = CustomizableWeaponry.textColors.VNEGATIVE},
	}
end

CustomizableWeaponry:registerAttachment(att)
