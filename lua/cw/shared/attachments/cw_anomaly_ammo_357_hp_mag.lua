-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_357_hp_mag"

att.displayName = "Ammunition .357 HP"

att.displayNameShort = "Ammunition .357 HP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ".357 Magnum"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_357_hp_mag")

	att.description = {{t = ".357 NR - Expansive bullet cartridge. The purpose of these rounds is is to slow down the bullet on impact, reducing penetration, but causing greater internal tissue damage.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_357_hp_mag", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_357_hp_mag", false)

end

CustomizableWeaponry:registerAttachment(att)
