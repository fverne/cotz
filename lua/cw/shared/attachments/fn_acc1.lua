local att = {}
att.name = "fn_acc1"
att.displayName = "Accuracy 1"
att.displayNameShort = "ACC1"

att.statModifiers = {
    HipSpreadMult = -0.1,
    AimSpreadMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)