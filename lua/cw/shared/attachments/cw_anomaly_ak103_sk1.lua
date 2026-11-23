-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ak103_sk1"

att.displayName = "Camouflaged AK-103"

att.displayNameShort = "Camouflaged AK-103"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_camog",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_a_camog",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_grips_camog",
	[4]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_body_camog",
	},
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_body_camog",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_grips_camog",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_camog",
	[4]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_a_camog",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ak103_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak103_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak103_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
