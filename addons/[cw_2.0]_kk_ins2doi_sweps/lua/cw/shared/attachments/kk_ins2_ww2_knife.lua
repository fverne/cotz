local att = {}
att.name = "kk_ins2_ww2_knife"
att.displayName = "Bayonet Knife"
att.displayNameShort = "A Knife"

att.statModifiers = {
	// OverallMouseSensMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "bind mouse5 cw_kk_melee", c = CustomizableWeaponry.textColors.NEUTRAL},
		[2] = {t = "Increases range and damage of melee attack.", c = CustomizableWeaponry.textColors.POSITIVE},
	}
end

CustomizableWeaponry:registerAttachment(att)
