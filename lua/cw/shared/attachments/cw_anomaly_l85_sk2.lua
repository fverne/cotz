-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_l85_sk2"

att.displayName = "Modern L85A1"

att.displayNameShort = "Modern L85A1"

att.anomalyEffect = {
	 MaterialTable_V = {
	[5] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk2",
	[6] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk2",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk2",
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_l85_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_l85_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_l85_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
