-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_svu_sk1"

att.displayName = "OTs-03 SVU (Alternative)"

att.displayNameShort = "OTs-03 SVU (Alternative)"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1",
	},
	["VElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1"
		},
	},
	["WElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_sk1"
		},
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_svu_sk1")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svu_sk1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svu_sk1", false)

end

CustomizableWeaponry:registerAttachment(att)
