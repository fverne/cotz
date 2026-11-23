-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ak101_sk1"

att.displayName = "Camouflaged AK-101"

att.displayNameShort = "Camouflaged AK-101"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_mag_a_camog",
	[2] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak100_grips_camog",
	[3] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_mag_camog",
	[4] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_body_camog",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_body_camog",
	[2] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak100_grips_camog",
	[3] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_mag_a_camog",
	[4] =	"models/flaymi/stalker/anomaly/skins/ak101/wpn_ak101_mag_camog",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ak101_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak101_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak101_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
