local att = {}
att.name = "kk_ins2_mag_ppsh_71"
att.displayName = "71 round magazine"
att.displayNameShort = "71 RND"

att.statModifiers = {
	// OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Increases mag size to 71 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	self._KK_INS2_customReloadSuffix = "_mm"
	self:unloadWeapon()
	self.Primary.ClipSize = 71
	self.Primary.ClipSize_Orig = 71
end

function att:detachFunc()
	self._KK_INS2_customReloadSuffix = ""
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)
