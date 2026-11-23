-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_545x39_ap"

att.displayName = "Ammunition 5,45x39 mm BP"

att.displayNameShort = "Ammunition 5,45x39 mm BP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.45x39MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_545x39_ap")

	att.description = {{t = "7N22 5.45x39 mm caliber armor-piercing bullet (APB) is used in automatic rifles of many Warsaw Pact countries. Inside the bullet is an armor-piercing core made of U12A tool steel. Effective against body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_545x39_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
