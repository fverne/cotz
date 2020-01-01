local att = {}
att.name = "md_sight_rail_larue"
att.displayName = "LaRue Sight Rail"
att.displayNameShort = "LaRue"
att.isSight = false

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_sight_rail_larue")
	att.description = {[1] = {t = "A LaRue rail. Allows additional attachments.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

CustomizableWeaponry:registerAttachment(att)