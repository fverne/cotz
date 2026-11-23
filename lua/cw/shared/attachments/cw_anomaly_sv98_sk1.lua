-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sv98_sk1"

att.displayName = "Custom SV-98"

att.displayNameShort = "Custom SV-98"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sv98/wpn_sv98_sk1",
	},
	 MaterialTable_W = {
	[3] =	"models/flaymi/stalker/anomaly/skins/sv98/wpn_sv98_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sv98_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sv98_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sv98_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
