local att = {}
att.name = "md_saker"
att.displayName = "SAKER"
att.displayNameShort = "SAKER"
att.isSuppressor = true

att.statModifiers = {DamageMult = -0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/saker")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:resetSuppressorStatus()
end

CustomizableWeaponry:registerAttachment(att)