-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_spas12_sk1"

att.displayName = "Custom SPAS-12"

att.displayNameShort = "Custom SPAS-12"

att.anomalyEffect = {
	 MaterialTable_V = {
	[2] =	"models/flaymi/stalker/anomaly/skins/spas12/wpn_spas12_sk1",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/spas12/wpn_spas12_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_spas12_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_spas12_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_spas12_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
