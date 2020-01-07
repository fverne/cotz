local att = {}
att.name = "md_csgo_taclight"
att.displayName = "Tactical Light"
att.displayNameShort = "Taclight"

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_csgo_taclight")
	att.description = {[1] = {t = "Attaches a tactical light.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

CustomizableWeaponry:registerAttachment(att)