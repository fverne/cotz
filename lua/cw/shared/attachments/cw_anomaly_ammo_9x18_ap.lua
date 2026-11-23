-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_9x18_ap"

att.displayName = "Ammunition 9x18 mm RG028"

att.displayNameShort = "Ammunition 9x18 mm RG028"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "9x18MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_9x18_ap")

	att.description = {{t = "RG028 is a cartridge used to penetrate light armor. RG028 was designed to withstand enemies wearing personal protective equipment; for this reason, the cartridge is equipped with a hardened steel core. Unfortunately, the cartridge itself is not much superior to the standard 9x18, but only has an increased penetrating power.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_9x18_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
