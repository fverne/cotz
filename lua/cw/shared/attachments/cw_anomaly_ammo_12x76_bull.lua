-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_12x76_bull"

att.displayName = "Ammunition 12x76 mm «Bull»/slug"

att.displayNameShort = "Ammunition 12x76 mm «Bull»/slug"

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

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_12x76_bull")

	att.description = {{t = "An artisanal cartridge, or should I say 12-gauge bullet. for hunting dinosaurs, but it's also good against mutants. The interior of the bullet is made of copper-coated lead, which in turn has a steel, dart-like insert. The bullet is so impressive in its size and powder volume. There's a good chance you could just lose your hands.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_bull", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_12x76_bull", false)

end

CustomizableWeaponry:registerAttachment(att)
