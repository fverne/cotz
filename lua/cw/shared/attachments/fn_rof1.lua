local att = {}
att.name = "fn_rof1"
att.displayName = "ROF 1"
att.displayNameShort = "ROF1"

att.statModifiers = {
    FireDelayMult = -0.025,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)