-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x19_ap"

att.displayName = "Ammunition 9x19 mm AP"

att.displayNameShort = "Ammunition 9x19 mm AP"

att.anomalyEffect = {
	["Primary"] = {
		["KickUp"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["KickDown"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["Ammo"] = "9x19MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x19_ap")

	att.description = {{t = "Armor-piercing 9x19 mm caliber cartridge with steel-core bullet. Designed to improve the penetration capability of pistols and submachine guns. It's used primarily by anti-terrorist and special police units when they're confronting opponents protected by body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
