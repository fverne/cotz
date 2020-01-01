local att = {}
att.name = "skin_ws_mosinclean"
att.displayName = "Clean Wood"
att.displayNameShort = "Clean"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/skin_ws_mosinclean")
	att.description = {[1] = {t = "Clean wood finish for your weapon.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetSkin(2)
	end
	if self.WMEnt then
		self.WMEnt:SetSkin(2)
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