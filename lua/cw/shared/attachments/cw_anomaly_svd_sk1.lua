-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_svd_sk1"

att.displayName = "Modified SVD"

att.displayNameShort = "Modified SVD"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_mag_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_body_sk1",
	[3]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_grips_sk1",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svd/wpn_svd_grips_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_body_sk1",
	[3]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_mag_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_svd_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svd_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svd_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
