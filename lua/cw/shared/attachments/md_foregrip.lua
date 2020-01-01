local att = {}
att.name = "md_foregrip"
att.displayName = "Foregrip"
att.displayNameShort = "Grip"

att.statModifiers = {VelocitySensitivityMult = -0.3,
OverallMouseSensMult = -0.15,
RecoilMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foregrip")
end

CustomizableWeaponry:registerAttachment(att)