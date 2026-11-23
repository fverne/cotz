-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_colt1911_sk5"

att.displayName = "Modern Colt M1911"

att.displayNameShort = "Modern Colt M1911"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/colt1911/wpn_colt1911_sk5",
	},
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/colt1911/wpn_colt1911_sk5",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_colt1911_sk5")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_colt1911_sk5", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_colt1911_sk5", false)

end

CustomizableWeaponry:registerAttachment(att)
