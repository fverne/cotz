local att = {}
att.name = "fn_rec2"
att.displayName = "Recoil 2"
att.displayNameShort = "REC2"

att.statModifiers = {
    RecoilMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)