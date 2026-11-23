-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_colt1911_sk3"

att.displayName = "Camouflaged Colt M1911"

att.displayNameShort = "Camouflaged Colt M1911"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/colt1911/wpn_colt1911_sk3",
	},
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/colt1911/wpn_colt1911_sk3",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_colt1911_sk3")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_colt1911_sk3", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_colt1911_sk3", false)

end

CustomizableWeaponry:registerAttachment(att)
