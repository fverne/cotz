local att = {}
att.name = "md_sight_rail"
att.displayName = "Sight Rail"
att.displayNameShort = "Rail"
att.isSight = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_sight_rail")
	att.description = {[1] = {t = "A rail. Allows additional attachments.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

CustomizableWeaponry:registerAttachment(att)