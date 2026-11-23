-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_l85_sk1"

att.displayName = "Custom L85A1"

att.displayNameShort = "Custom L85A1"

att.anomalyEffect = {
	 MaterialTable_V = {
	[5] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
	[6] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_l85_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_l85_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_l85_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
