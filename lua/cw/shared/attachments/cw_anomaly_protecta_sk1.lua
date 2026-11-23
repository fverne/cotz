-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_protecta_sk1"

att.displayName = "Camouflaged Armsel Protecta"

att.displayNameShort = "Camouflaged Armsel Protecta"

att.anomalyEffect = {
	 MaterialTable_V = {
	[2] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk1",
	},
	 MaterialTable_W = {
	[3] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_protecta_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_protecta_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_protecta_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
