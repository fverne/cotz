local att = {}
att.name = "md_rearsight"
att.displayName = "Rear Aiming Sight"
att.displayNameShort = "Rear"
att.isSight = true
att.aimPos = {"FrontRearPos", "FrontRearAng"}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_rearsight")
	att.description = {[1] = {t = "Rear ironsight.", c = CustomizableWeaponry.textColors.COSMETIC}}
end

CustomizableWeaponry:registerAttachment(att)