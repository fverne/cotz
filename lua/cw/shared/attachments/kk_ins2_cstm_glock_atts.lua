local att = {}

	att.name = "kk_ins2_g19_skin"
	att.displayName = "Matte Gray Finish"
	att.displayNameShort = "Gray"
	att.isBG = true

	att.statModifiers = {
		RecoilMult = -0.1
	}

	if CLIENT then
		-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
		att.displayIcon = surface.GetTextureID("atts/kk_dogg")
		att.description = {}
	end

CustomizableWeaponry:registerAttachment(att)

local att = {}
	att.name = "kk_ins2_g19_skin2"
	att.displayName = "Black-Tan Finish"
	att.displayNameShort = "Two Tone"
	att.isBG = true

	att.statModifiers = {
		RecoilMult = -0.1
	}

	if CLIENT then
		-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
		att.displayIcon = surface.GetTextureID("atts/kk_dogg")
		att.description = {}
		att.SelectIconOverride = surface.GetTextureID("vgui/inventory/cw_kk_ins2_cstm_g19_tt")
	end

CustomizableWeaponry:registerAttachment(att)

local att = {}
	att.name = "kk_ins2_g19_skin3"
	att.displayName = "Stainless Steel Slide"
	att.displayNameShort = "Stainless"
	att.isBG = true

	att.statModifiers = {
		RecoilMult = -0.1
	}

	if CLIENT then
		-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
		att.displayIcon = surface.GetTextureID("atts/kk_dogg")
		att.description = {}
		att.SelectIconOverride = surface.GetTextureID("vgui/inventory/cw_kk_ins2_cstm_g19_ss")
	end

CustomizableWeaponry:registerAttachment(att)

local att = {}
	att.name = "kk_ins2_mag_g19_22"
	att.displayName = "22 round magazine"
	att.displayNameShort = "22 RND"

	att.statModifiers = {
		// OverallMouseSensMult = -0.05
	}

	if CLIENT then
		-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
		att.displayIcon = surface.GetTextureID("atts/kk_dogg")
		att.description = {
			[1] = {t = "Increases mag size to 22 rounds.", c = CustomizableWeaponry.textColors.POSITIVE}
		}
	end

	function att:attachFunc()
		self._KK_INS2_customReloadSuffix = "_mm"
		self:unloadWeapon()
		self.Primary.ClipSize = 22
		self.Primary.ClipSize_Orig = 22
	end

	function att:detachFunc()
		self._KK_INS2_customReloadSuffix = ""
		self:unloadWeapon()
		self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
		self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	end

CustomizableWeaponry:registerAttachment(att)
