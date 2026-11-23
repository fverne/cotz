-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_12x76_dart"

att.displayName = "Ammunition 12x76 mm dart/flechette"

att.displayNameShort = "Ammunition 12x76 mm dart/flechette"

att.anomalyEffect = {
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 6 end,
		["ClumpSpread"] = function(wep, stat) return stat and stat * 0.6 end,
		["NumShots"] = 1,
		["Ammo"] = "12 Gauge -DT-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_12x76_dart")

	att.description = {{t = "A 12-gauge cartridge with a heavy, breech-loading bullet. Typically used for hunting large animals, but is also suitable for other purposes. The bullet's massive steel body is capable of penetrating light body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_dart", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_dart", false)

end

CustomizableWeaponry:registerAttachment(att)
