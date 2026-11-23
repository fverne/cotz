-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_762x51_ap"

att.displayName = "Ammunition 7,62x51 mm NATO AP"

att.displayNameShort = "Ammunition 7,62x51 mm NATO AP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "7.62x51MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_762x51_ap")

	att.description = {{t = "M61 armor-piercing bullet with hardened steel core. Maintains damage performance while providing improved armor penetration rates.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x51_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_762x51_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
