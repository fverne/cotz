local att = {}
att.name = "md_tokasup"
att.displayName = "7.62x25 Suppressor"
att.displayNameShort = "x25 Supp"
att.isSuppressor = true

att.statModifiers = {DamageMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "A modified suppressor to be used with 7.62x25.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)