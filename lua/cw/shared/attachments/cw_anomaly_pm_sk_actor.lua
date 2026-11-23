-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_pm_sk_actor"

att.displayName = "Ceremonial PM"

att.displayNameShort = "Ceremonial PM"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/pm/wpn_pm_actor",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/pm/wpn_pm_actor",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_pm_sk_actor")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pm_sk_actor", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pm_sk_actor", false)

end

CustomizableWeaponry:registerAttachment(att)
