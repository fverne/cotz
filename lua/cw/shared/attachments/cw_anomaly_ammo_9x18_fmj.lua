-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x18_fmj"

att.displayName = "Ammunition 9x18 mm FMJ"

att.displayNameShort = "Ammunition 9x18 mm FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "9x18MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x18_fmj")

	att.description = {{t = "A jacketed bullet cartridge is a cartridge with a steel core and a lead bullet with a metal jacket. It has good stopping power, but is ineffective against body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
