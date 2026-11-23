-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x19_fmj"

att.displayName = "Ammunition 9x19 mm FMJ"

att.displayNameShort = "Ammunition 9x19 mm FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "9x19MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x19_fmj")

	att.description = {{t = "Standard 9x19 mm caliber cartridge with jacketed bullet. It has good ballistic characteristics and is inexpensive to produce. It's particularly popular due to international convention prohibiting the use of expansive bullets in combat. Ineffective against body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x19_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
