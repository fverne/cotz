local att = {}
att.name = "ws_m16auto"
att.displayName = "Fully Automatic Conversion"
att.displayNameShort = "Auto"

att.statModifiers = {
	//ReloadSpeedMult = -0.20,
	//OverallMouseSensMult = -0.20 //-0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/ws_m16auto")
	att.description = {[1] = {t = "Allows for fully automatic fire.", c = CustomizableWeaponry.textColors.POSITIVE},
					   [2] = {t = "Disallows 3-round burst fire.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.FireModes = {"auto", "semi", "safe"}
	self:SelectFiremode("auto")
end

function att:detachFunc()
	self.FireModes = {"3burst", "semi", "safe"}
	self:SelectFiremode("3burst")
end

CustomizableWeaponry:registerAttachment(att)