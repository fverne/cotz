-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x39_pab9"

att.displayName = "Ammunition 9x39 mm SP-5"

att.displayNameShort = "Ammunition 9x39 mm SP-5"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "9x39MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x39_pab9")

	att.description = {{t = "The SP-5 subsonic “sniper” cartridge is equipped with a bullet with a bimetallic jacket. The cavity behind the steel core is filled with lead. Requires the use of a silencer to ensure silent firing. Common in some Warsaw Pact countries. Effective against body armor.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x39_pab9", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x39_pab9", false)

end

CustomizableWeaponry:registerAttachment(att)
