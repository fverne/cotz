local att = {}
att.name = "md_csgo_silencer_pistol"
att.displayName = "Pistol Suppressor"
att.displayNameShort = "Pistol"
att.isSuppressor = true

att.statModifiers = {RecoilMult = -0.35,
DamageMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_csgo_silencer_pistol")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)