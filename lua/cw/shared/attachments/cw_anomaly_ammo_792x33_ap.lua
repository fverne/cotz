-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_792x33_ap"

att.displayName = "Ammunition 7,92x57 mm PS"

att.displayNameShort = "Ammunition 7,92x57 mm PS"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ""
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_792x33_ap")

	att.description = {{t = "7.92x57 PS is a cartridge used by the British Armed Forces against armored targets. It has a hardened steel core, which gives it high penetrating power. Used primarily for long-range shooting, this cartridge is of higher quality than the standard round. It is used in some sniper rifles.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_792x33_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_792x33_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
