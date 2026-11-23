-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x19_pbp"

att.displayName = "Ammunition 9x19 mm Dum-Dum/Hollow-point"

att.displayNameShort = "Ammunition 9x19 mm Dum-Dum/Hollow-point"

att.anomalyEffect = {
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 1.3 end,
		["KickUp"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["KickDown"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["Ammo"] = "9x19MM -HP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x19_pbp")

	att.description = {{t = "A semi-rimmed bullet with an expansive notch has high stopping power and is not prone to ricochets. It's used primarily as a “police” ammunition and in civilian personal defense weapons. It's ineffective against body armor due to its low penetration potential.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_pbp", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_pbp", false)

end

CustomizableWeaponry:registerAttachment(att)
