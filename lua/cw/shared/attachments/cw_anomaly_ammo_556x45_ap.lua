-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_556x45_ap"

att.displayName = "Ammunition 5,56x45 mm EPR"

att.displayNameShort = "Ammunition 5,56x45 mm EPR"

att.anomalyEffect = {
	["Primary"] = {
		["KickUp"] = function(wep, stat) return stat + stat * 1/2 end,
		["KickDown"] = function(wep, stat) return stat + stat * 1/2 end,
		["Ammo"] = "5.56x45MM -AP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_556x45_ap")

	att.description = {{t = "Known as the M855A1, this 5.56x45mm Enhanced Performance Round is the latest round used by the U.S. Army. The bullet consists of a copper half-shell with a steel tip, has a higher velocity and better armor penetration compared to the SS109/M855 round. It has an increased effectiveness in hitting against both enemy armor and soft tissue.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_ap", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_556x45_ap", false)

end

CustomizableWeaponry:registerAttachment(att)
