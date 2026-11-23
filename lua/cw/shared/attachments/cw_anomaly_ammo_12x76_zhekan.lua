-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_12x76_zhekan"

att.displayName = "Ammunition 12x76 mm zhekan/unjacketed slug"

att.displayNameShort = "Ammunition 12x76 mm zhekan/unjacketed slug"

att.anomalyEffect = {
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 6 end,
		["ClumpSpread"] = function(wep, stat) return stat and stat * 0.6 end,
		["NumShots"] = 1,
		["Ammo"] = "12 Gauge -SG-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_12x76_zhekan")

	att.description = {{t = "A 12-gauge cartridge with a boreless bullet. Typically used for hunting large animals, but it's also suitable for other purposes: its heavy bullet doesn't penetrate, but actually pierces body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_zhekan", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_zhekan", false)

end

CustomizableWeaponry:registerAttachment(att)
