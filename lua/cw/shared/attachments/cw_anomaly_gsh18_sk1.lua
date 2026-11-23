-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_gsh18_sk1"

att.displayName = "Custom GSh-18"

att.displayNameShort = "Custom GSh-18"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/gsh18/wpn_gsh18_sk1",
	},
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/gsh18/wpn_gsh18_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_gsh18_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_gsh18_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_gsh18_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
