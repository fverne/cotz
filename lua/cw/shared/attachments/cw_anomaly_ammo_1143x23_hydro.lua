-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_1143x23_hydro"

att.displayName = "Ammunition .45 ACP Hydra-shock"

att.displayNameShort = "Ammunition .45 ACP Hydra-shock"

att.anomalyEffect = {
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 1.3 end,
		["KickUp"] = function(wep, stat) return stat + stat * 1/2 end,
		["KickDown"] = function(wep, stat) return stat + stat * 1/2 end,
		["Ammo"] = ".45 ACP -HP-"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_1143x23_hydro")

	att.description = {{t = "A non-standard type of round for the .45 ACP caliber is a semi-rimmed bullet with an expansive notch and a steel core. This combination of a semi-hollow point expansive bullet and an armor-piercing bullet. The advantages and disadvantages of both types of ammunition are inherent in this combination.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_1143x23_hydro", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_1143x23_hydro", false)

end

CustomizableWeaponry:registerAttachment(att)
