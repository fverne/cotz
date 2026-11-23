-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_fn2000_sk2"

att.displayName = "Custom FN F2000"

att.displayNameShort = "Custom FN F2000"

att.anomalyEffect = {
	 MaterialTable_V = {
	[3]	= "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk2",
	},
	 MaterialTable_W = {
	[2] = "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_fn2000_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_fn2000_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_fn2000_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
