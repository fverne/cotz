-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sig550_sk4"

att.displayName = "Camouflaged SIG SG550"

att.displayNameShort = "Camouflaged SIG SG550"

att.anomalyEffect = {
	 MaterialTable_V = {
	[3] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk2",
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk2",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk2",
	[2] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sig550_sk4")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sig550_sk4", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sig550_sk4", false)

end

CustomizableWeaponry:registerAttachment(att)
