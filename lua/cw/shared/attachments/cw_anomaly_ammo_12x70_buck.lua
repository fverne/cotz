-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_12x70_buck"

att.displayName = "Ammunition 12x70 mm buckshot"

att.displayNameShort = "Ammunition 12x70 mm buckshot"

att.anomalyEffect = {
	["Primary"] = {
		["Range"] = function(wep, stat) return stat - stat * 0.75 end,
		["NumShots"] = 9,
		["Ammo"] = "12 Gauge"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_12x70_buck")

	att.description = {{t = "A common 12-gauge cartridge loaded with 6 mm shot. At close ranges, it has a tremendous killing and stopping power. It's intended for smoothbores and shotguns.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x70_buck", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x70_buck", false)

end

CustomizableWeaponry:registerAttachment(att)
