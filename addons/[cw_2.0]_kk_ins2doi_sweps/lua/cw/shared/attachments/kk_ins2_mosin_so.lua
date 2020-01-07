local att = {}
att.name = "kk_ins2_mosin_so"
att.displayNameShort = "Hacksaw"
att.displayName = "CQC Variant"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -20

att.statModifiers = {
	AimSpreadMult = 0.1,
	DrawSpeedMult = 0.05,
	VelocitySensitivityMult = 0.2,
	// OverallMouseSensMult = 0.1,
	DamageMult = 0.1,
	RecoilMult = 0.2,
}

att.activeVM = "models/weapons/v_cw_kk_ins2_mosin_so.mdl"
att.activeWM = "models/weapons/w_cw_kk_ins2_mosin_so.mdl"
att.origVM = "models/weapons/v_mosin.mdl"
att.origWM = "models/weapons/w_mosin.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}

	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/cw_kk_ins2_mosin_so")
end

function att:attachFunc()
	self.ViewModel = att.activeVM
	self.WorldModel = att.activeWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
		self.AttachmentModelsVM.cw_menu_muzzle._bone = 52
	end
end

function att:detachFunc()
	self.ViewModel = att.origVM
	self.WorldModel = att.origWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
		self.AttachmentModelsVM.cw_menu_muzzle._bone = 57
	end
end

CustomizableWeaponry:registerAttachment(att)
