local att = {}
att.name = "fn_stab1"
att.displayName = "Stability 1"
att.displayNameShort = "STAB1"

att.statModifiers = {
    SpreadPerShotMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)