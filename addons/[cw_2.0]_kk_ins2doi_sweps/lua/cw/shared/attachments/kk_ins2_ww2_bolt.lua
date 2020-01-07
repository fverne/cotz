local att = {}
att.name = "kk_ins2_ww2_bolt"
att.displayNameShort = "Grease"
att.displayName = "Greasy Bolt"

att.statModifiers = {
	BoltActionSpeedMult = 0.2
}

if CLIENT then
	-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.displayIcon = surface.GetTextureID("atts/kk_dogg")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)

-- if CLIENT then
	-- CustomizableWeaponry:createStatText(att)
-- end
