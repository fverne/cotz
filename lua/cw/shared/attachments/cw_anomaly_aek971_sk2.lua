-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_aek971_sk2"

att.displayName = "Worn out AEK-971"

att.displayNameShort = "Worn out AEK-971"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/aek971/wpn_aek971_sk2",
	},
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/aek971/wpn_aek971_sk2",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_aek971_sk2")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_aek971_sk2", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_aek971_sk2", false)

end

CustomizableWeaponry:registerAttachment(att)
