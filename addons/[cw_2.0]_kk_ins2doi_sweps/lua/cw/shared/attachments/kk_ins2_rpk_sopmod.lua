local att = {}
att.name = "kk_ins2_rpk_sopmod"
att.displayName = "Tacticool RPK Mod"
att.displayNameShort = "SOPMOD"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -6

att.statModifiers = {
	AimSpreadMult = 1,
	DrawSpeedMult = 0.05,
	VelocitySensitivityMult = -0.3,
	// OverallMouseSensMult = -0.1,
	DamageMult = 0.1,
	RecoilMult = -0.2,
	FireDelayMult = -0.071,
}

att.activeVM = "models/weapons/v_cw_kk_ins2_rpk_tac.mdl"
att.activeWM = "models/weapons/w_cw_kk_ins2_rpk_tac.mdl"
att.origVM = "models/weapons/v_rpk.mdl"
att.origWM = "models/weapons/w_rpk.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}

	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/cw_kk_ins2_rpk_sopmod")
end

function att:attachFunc()
	self.ViewModel = att.activeVM
	self.WorldModel = att.activeWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
	end
end

function att:detachFunc()
	self.ViewModel = att.origVM
	self.WorldModel = att.origWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
	end
end

CustomizableWeaponry:registerAttachment(att)
