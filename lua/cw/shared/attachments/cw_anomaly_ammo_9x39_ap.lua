-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x39_ap"

att.displayName = "Ammunition 9x39 mm SP-6"

att.displayNameShort = "Ammunition 9x39 mm SP-6"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "9x39MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x39_ap")

	att.description = {{t = "The SP-6 subsonic armor-piercing “machine gun” cartridge is equipped with semi-hollow point bullet with partially open hardened steel core. Requires the use of a silencer to ensure silent firing. Common in some Warsaw Pact countries. Extremely effective against light body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x39_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x39_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
