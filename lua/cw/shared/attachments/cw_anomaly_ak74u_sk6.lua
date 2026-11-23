-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ak74u_sk6"

att.displayName = "Old AKS-74U"

att.displayNameShort = "Old AKS-74U"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk6",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk7",
	},
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk6",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk7",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ak74u_sk6")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak74u_sk6", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ak74u_sk6", false)

end

CustomizableWeaponry:registerAttachment(att)
