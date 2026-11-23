-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_toz34_sk1"

att.displayName = "Decorated TOZ-34"

att.displayNameShort = "Decorated TOZ-34"

att.anomalyEffect = {
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/toz34/wpn_toz-34_sk1",
	},
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/toz34/wpn_toz-34_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_toz34_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_toz34_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_toz34_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
