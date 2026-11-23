-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x39_ap"

att.displayName = "Ammunition 7,62x39 mm M43"

att.displayNameShort = "Ammunition 7,62x39 mm M43"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x39MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x39_ap")

	att.description = {{t = "A 7.62x39 M43 cartridge made in China, with a bullet of increased penetration, often referred to as the 7.62x39 CN. It has a soft steel core that increases penetration. This Chinese ammunition (basically like all other M43 ammunition) is currently banned for importation into the United States because federal law classifies it as armor-piercing. This classification is based on materials and design of the bullet, not its ability to penetrate armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x39_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x39_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
