-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_mosin_sk1"

att.displayName = "Camouflaged AN-94"

att.displayNameShort = "Camouflaged AN-94"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk1",
	},
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk1",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_abakan_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mosin_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mosin_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
