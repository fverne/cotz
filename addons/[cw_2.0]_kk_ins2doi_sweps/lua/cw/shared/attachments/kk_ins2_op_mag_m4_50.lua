local att = {}
att.name = "kk_ins2_op_mag_m4_50"
att.displayName = "50 round magazine"
att.displayNameShort = "50 RND"

att.statModifiers = {
	// OverallMouseSensMult = -0.03
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Increases mag size to 50 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.std_mag then
			self.AttachmentModelsVM.std_mag.active = false
		end
	end

	-- self._KK_INS2_customReloadSuffix = "_mm"
	self:unloadWeapon()
	self.Primary.ClipSize = 50
	self.Primary.ClipSize_Orig = 50
end

function att:detachFunc()
	if CLIENT then
		if self.AttachmentModelsVM.std_mag then
			self.AttachmentModelsVM.std_mag.active = true
		end
	end

	self._KK_INS2_customReloadSuffix = ""
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)
