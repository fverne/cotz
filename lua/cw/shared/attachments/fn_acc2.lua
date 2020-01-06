local att = {}
att.name = "fn_acc2"
att.displayName = "Accuracy 2"
att.displayNameShort = "ACC2"

att.statModifiers = {    
    HipSpreadMult = -0.1,
    AimSpreadMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)