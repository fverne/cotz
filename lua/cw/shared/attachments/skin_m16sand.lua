local att = {}
att.name = "skin_m16sand"
att.displayName = "C7 Finish"
att.displayNameShort = "C7"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/skin_m16sand")
	att.description = {[1] = {t = "C7 finish for your weapon.", c = CustomizableWeaponry.textColors.POSITIVE}}
end


function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(1)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(1)
	end
end

function att:detachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(0)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(0)
	end
end

CustomizableWeaponry:registerAttachment(att)