-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_m4a1_sk2"

att.displayName = "Camouflaged M4A1"

att.displayNameShort = "Camouflaged M4A1"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk2",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_m4a1_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_m4a1_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_m4a1_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
