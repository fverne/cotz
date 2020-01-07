local att = {}
att.name = "kk_ins2_fnfal_skin"
att.displayName = "Black FAL Finish"
att.displayNameShort = "Black"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)

local att = {}
att.name = "kk_ins2_fnfal_skin2"
att.displayName = "Gr€€n FAL Finish"
att.displayNameShort = "Green"
att.isBG = true

att.statModifiers = {
	RecoilMult = -0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)
