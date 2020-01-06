local att = {}
att.name = "kk_ins2_sights_base"
att.displayName = "INS2 Devs"
att.displayNameShort = "NWI"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)
