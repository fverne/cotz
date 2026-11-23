-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ammo_1143x23_fmj"

att.displayName = "Ammunition .45 ACP"

att.displayNameShort = "Ammunition .45 ACP"

att.anomalyEffect = {
	["Primary"] = {
		["Ammo"] = ".45 ACP"
	}
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly_ammo_1143x23_fmj")

	att.description = {{t = "The .45 caliber, full metal jacketed bullet, has remained popular for over a hundred years. The heavy bullet, with a relatively weak powder charge, has a low velocity, but it has considerable stopping power.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_1143x23_fmj", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ammo_1143x23_fmj", false)

end

CustomizableWeaponry:registerAttachment(att)
