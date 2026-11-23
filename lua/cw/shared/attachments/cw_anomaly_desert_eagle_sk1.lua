-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_desert_eagle_sk1"

att.displayName = "Custom Desert Eagle"

att.displayNameShort = "Custom Desert Eagle"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/desert_eagle/wpn_desert_eagle_sk1",
	},
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/desert_eagle/wpn_desert_eagle_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_desert_eagle_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_desert_eagle_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_desert_eagle_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
