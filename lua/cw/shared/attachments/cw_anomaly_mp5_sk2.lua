-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_mp5_sk2"

att.displayName = "MP5A3 (Alternate)"

att.displayNameShort = "MP5A3 (Alternate)"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/mp5/wpn_mp5_sk2",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/mp5/wpn_mp5_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_mp5_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mp5_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mp5_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
