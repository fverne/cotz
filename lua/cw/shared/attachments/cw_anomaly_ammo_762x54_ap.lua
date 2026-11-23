-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x54_ap"

att.displayName = "Ammunition 7,62x54 mm PP"

att.displayNameShort = "Ammunition 7,62x54 mm PP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x54MMR -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x54_ap")

	att.description = {{t = "Inexpensive 7H13 armor-piercing machine gun cartridge in 7.62x54 mm caliber. Due to design features it is unsuitable for firing from sniper rifles, so it is used as ammunition for the PKM machine gun. This cartridge has increased power and, due to steel core, has very good penetration. A powerful cartridge for powerful weapons.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x54_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
