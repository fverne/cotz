local att = {}
att.name = "kk_ins2_galil_sar"
att.displayName = "Short Assault Rifle"
att.displayNameShort = "SAR"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -4

att.statModifiers = {
	AimSpreadMult = 0.3,
	DrawSpeedMult = 0.05,
	DamageMult = 0.1,
	RecoilMult = 0.1,
	-- WeaponLength = -4
}

att.activeVM = "models/weapons/v_galil_sar.mdl"
att.activeWM = "models/weapons/w_galil_sar.mdl"
att.origVM = "models/weapons/v_galil.mdl"
att.origWM = "models/weapons/w_galil.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}

	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/weapon_galil_sar")
end

function att:attachFunc()
	self.ViewModel = att.activeVM
	self.WorldModel = att.activeWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_sec2.mdl")
	end
end

function att:detachFunc()
	self.ViewModel = att.origVM
	self.WorldModel = att.origWM

	if CLIENT then
		self.CW_VM:SetModel(self.ViewModel)
		self.AttachmentModelsVM.kk_ins2_vertgrip.ent:SetModel("models/weapons/upgrades/a_foregrip_ins.mdl")
	end
end

CustomizableWeaponry:registerAttachment(att)
