local att = {}
att.name = "fn_hndl1"
att.displayName = "Handling 1"
att.displayNameShort = "HNDL1"

att.statModifiers = {    
    MaxSpreadIncMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)