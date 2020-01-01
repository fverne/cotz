local att = {}
att.name = "md_sight_railmount"
att.displayName = "Sight Rail Mount"
att.displayNameShort = "Rail"
att.isSight = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_sight_rail_mount")
	att.description = {[1] = {t = "A rail mount. Allows additional attachments.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

CustomizableWeaponry:registerAttachment(att)