local att = {}
att.name = "fn_rec1"
att.displayName = "Recoil 1"
att.displayNameShort = "REC1"

att.statModifiers = {
    RecoilMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)