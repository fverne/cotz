-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_vz61_sk2"

att.displayName = "Camouflaged Skorpion vz.61"

att.displayNameShort = "Camouflaged Skorpion vz.61"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vz61/wpn_vz61_sk2",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vz61/wpn_vz61_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_vz61_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_vz61_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_vz61_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
