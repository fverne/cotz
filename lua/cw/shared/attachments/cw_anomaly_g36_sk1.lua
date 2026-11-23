-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_g36_sk1"

att.displayName = "Camouflaged G36"

att.displayNameShort = "Camouflaged G36"

att.anomalyEffect = {
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_sk1",
	[4]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_scope_sk1",
	},
	 MaterialTable_W = {
	[2]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_sk1",
	[1]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_scope_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_g36_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_g36_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_g36_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
