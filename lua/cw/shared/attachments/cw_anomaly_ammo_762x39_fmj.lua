-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x39_fmj"

att.displayName = "Ammunition 7,62x39 mm FMJ"

att.displayNameShort = "Ammunition 7,62x39 mm FMJ"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x39MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x39_fmj")

	att.description = {{t = "The 7.62x39 mm all-metal jacketed cartridge is one of the most popular ammunition used, especially in Africa and the Middle East. Many refer to it as the “Bullet of the Revolution” due to its frequent use by both terrorists and criminal organizations. Because of its tremendous penetrating power, militaries of all nations have had to increase the armor protection of their units, because the likelihood of encountering this ammunition in combat situations is very high.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x39_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x39_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
