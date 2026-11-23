-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_545x39_fmj"

att.displayName = "Ammunition 5,45x39 mm PS"

att.displayNameShort = "Ammunition 5,45x39 mm PS"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.45x39MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_545x39_fmj")

	att.description = {{t = "7H6 5.45x39 mm caliber military cartridge with a common bullet (PS). with a steel core, designed to engage live targets located in the open or behind obstacles penetrated by the bullet, firearms and unarmored vehicles. It provides better accuracy than the 7.62 mm caliber due to reduced recoil, as well as increased the effectiveness of fire at 100 meters.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
