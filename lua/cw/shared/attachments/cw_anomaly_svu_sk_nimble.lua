-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_svu_sk_nimble"

att.displayName = "OTs-03 SVU-A"

att.displayNameShort = "OTs-03 SVU-A"

att.anomalyEffect = {
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble",
	},
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble",
	},
	["VElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
	},
	["WElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_svu_sk_nimble")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svu_sk_nimble", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_svu_sk_nimble", false)

end

CustomizableWeaponry:registerAttachment(att)
