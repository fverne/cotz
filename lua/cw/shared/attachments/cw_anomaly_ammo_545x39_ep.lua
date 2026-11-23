-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_545x39_ep"

att.displayName = "Ammunition 5,45x39 mm PP"

att.displayNameShort = "Ammunition 5,45x39 mm PP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.45x39MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_545x39_ep")

	att.description = {{t = "The 7H10 5.45x39 mm caliber military cartridge with high penetration bullet (PP) is used in automatic rifles of many Warsaw Pact countries. The bullet has a steel heat-strengthened core provides better penetration of the target.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_ep", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_ep", false)

end

CustomizableWeaponry:registerAttachment(att)
