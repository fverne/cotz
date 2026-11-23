-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_lr300_sk2"

att.displayName = "Custom LR-300ML"

att.displayNameShort = "Custom LR-300ML"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2",
	},
	["VElements"] = {
		["lr300_sight"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2"
		},
	},
	 MaterialTable_W = {
	[2] =	"models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2",
	},
	["WElements"] = {
		["lr300_sight"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2"
		},
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_lr300_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_lr300_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_lr300_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
