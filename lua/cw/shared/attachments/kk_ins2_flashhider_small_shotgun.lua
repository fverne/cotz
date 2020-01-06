local att = {}
att.name = "kk_ins2_flashhider_small_shotgun"
att.displayName = "Small Flash Hider"
att.displayNameShort = "SFH"

att.statModifiers = {
	// OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Decreases Muzzle Flash and Recoil", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	self.Recoil = 2.75
end

function att:detachFunc()
	self.Recoil = 3
end

CustomizableWeaponry:registerAttachment(att)
