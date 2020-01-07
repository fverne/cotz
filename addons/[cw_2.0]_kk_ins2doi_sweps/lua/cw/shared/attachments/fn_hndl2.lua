local att = {}
att.name = "fn_hndl2"
att.displayName = "Handling 2"
att.displayNameShort = "HNDL2"

att.statModifiers = {
    MaxSpreadIncMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)