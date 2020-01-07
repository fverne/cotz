local att = {}
att.name = "kk_ins2_flashhider_big_shotgun"
att.displayName = "Large Flash Hider"
att.displayNameShort = "LFH"

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
	self.Recoil = 2.5
end

function att:detachFunc()
	self.Recoil = 3
end

CustomizableWeaponry:registerAttachment(att)
