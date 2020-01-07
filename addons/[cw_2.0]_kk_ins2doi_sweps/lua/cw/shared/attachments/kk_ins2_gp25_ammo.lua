local att = {}
att.name = "kk_ins2_gp25_ammo"
att.displayName = "Ammo"
att.displayNameShort = "40MM Ammo Selector"
att.isGrenadeLauncher = true
att.isFakeGrenadeLauncher = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/kk_ins2_gl_gp25")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)
