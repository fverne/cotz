-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_556x45_ss190"

att.displayName = "Ammunition 5,56x45 mm EP"

att.displayNameShort = "Ammunition 5,56x45 mm EP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = "5.56x45MM"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_556x45_ss190")

	att.description = {{t = "Known as the M855A1, this 5.56x45mm cartridge Enhanced Performance Round is the latest round used by the U.S. Army. The bullet consists of a copper jacket with a steel tip, has a higher velocity and better armor penetration than the SS109/M855 round. It has increased effectiveness against both enemy armor and soft tissue.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_ss190", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_ss190", false)

end

CustomizableWeaponry:registerAttachment(att)
