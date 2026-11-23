-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_glock_sk2"

att.displayName = "Glock 19 (Alternate)"

att.displayNameShort = "Glock 19 (Alternate)"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/glock/wpn_glock19_sk2",
	},
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/glock/wpn_glock19_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_glock_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_glock_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_glock_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
