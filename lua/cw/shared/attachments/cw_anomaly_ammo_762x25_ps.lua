-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x25_ps"

att.displayName = "Ammunition 7,62x25 mm Pst"

att.displayNameShort = "Ammunition 7,62x25 mm Pst"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x25MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x25_ps")

	att.description = {{t = "7,62-mm pistol cartridge with a steel-core bullet (7.62 PS), weighing 5.6 grams. It was adopted for service in 1953. The cartridge has a bimetallic or brass case. The stopping power of the bullet was brought as close as possible to that of the 9x19 mm Parabellum bullet.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x25_ps", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x25_ps", false)

end

CustomizableWeaponry:registerAttachment(att)
