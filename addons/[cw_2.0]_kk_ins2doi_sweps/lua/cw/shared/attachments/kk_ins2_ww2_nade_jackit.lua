local att = {}
att.name = "kk_ins2_ww2_nade_jackit"
att.displayNameShort = "Jacket"
att.displayName = "Frag Jacket"

att.statModifiers = {
	-- VelocitySensitivityMult = -0.3,
	-- // OverallMouseSensMult = -0.15,
	-- RecoilMult = -0.2,
}

att.activeVM = "models/weapons/v_splintering_stielhandgranate.mdl"
att.activeWM = "models/weapons/w_splintering_stielhandgranate.mdl"
att.origVM = "models/weapons/v_stielhandgranate.mdl"
att.origWM = "models/weapons/w_stielhandgranate.mdl"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Causes grenade to create more shrapnels upon detonation.", c = CustomizableWeaponry.textColors.VPOSITIVE},
		[2] = {t = "LOL, no, it does not. Not yet. Enjoy model changes for now.", c = CustomizableWeaponry.textColors.VNEGATIVE}
	}

	att.SelectIconOverride = surface.GetTextureID("vgui/inventory/weapon_splintering")
end

function att:attachFunc()
	self.WorldModel = att.activeWM
end

function att:detachFunc()
	self.WorldModel = att.origWM
end

CustomizableWeaponry:registerAttachment(att)
