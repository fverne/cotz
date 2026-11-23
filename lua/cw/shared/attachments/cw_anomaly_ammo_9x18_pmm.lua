-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x18_pmm"

att.displayName = "Ammunition 9x18 mm +P+"

att.displayNameShort = "Ammunition 9x18 mm +P+"

att.anomalyEffect = {
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 1.3 end,
		["KickUp"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["KickDown"] = function(wep, stat) return stat + stat * 1.1/2 end,
		["Ammo"] = "9x18MM -HP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x18_pmm")

	att.description = {{t = "A cartridge with a bullet with increased stopping power 7H16. The European marking +P+ stands for “very high barrel pressure”. The bullet's velocity is increased by 30%. Ineffective against body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_pmm", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_pmm", false)

end

CustomizableWeaponry:registerAttachment(att)
