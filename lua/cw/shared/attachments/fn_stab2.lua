local att = {}
att.name = "fn_stab2"
att.displayName = "Stability 2"
att.displayNameShort = "STAB2"

att.statModifiers = {
    SpreadPerShotMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)