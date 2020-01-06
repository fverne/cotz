local att = {}
att.name = "kk_ins2_pbs5"
att.displayNameShort = "PBS-5"
att.displayName = "PBS-5 Suppressor"
att.isSuppressor = true
att.WeaponLength = 12

att.statModifiers = {
	// OverallMouseSensMult = -0.1,
	RecoilMult = -0.15,
	-- WeaponLength = 12,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE},
		-- [2] = {t = "Increases weapon length.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end

CustomizableWeaponry:registerAttachment(att)
