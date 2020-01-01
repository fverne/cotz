local att = {}
att.name = "up_firerate1"
att.displayName = "Firerate increase"
att.displayNameShort = "firerate1"


att.statModifiers = {RecoilMult = -0.1,
AimSpreadMult = 0.6,
FireDelayMult = -0.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ws_m16auto")
	att.description = {[1] = {t = "Allows for fully automatic fire.", c = CustomizableWeaponry.textColors.POSITIVE},
					   [2] = {t = "Disallows 3-round burst fire.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	
end

function att:detachFunc()
	
end

CustomizableWeaponry:registerAttachment(att)