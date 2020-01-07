local att = {}
att.name = "fn_rof2"
att.displayName = "ROF 2"
att.displayNameShort = "ROF2"

att.statModifiers = {
    FireDelayMult = -0.025,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)