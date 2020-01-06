local att = {}
att.name = "kk_ins2_ww2_knife_fat"
att.displayNameShort = "Pig Stick"
att.displayName = "Bayonet Stick"

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
