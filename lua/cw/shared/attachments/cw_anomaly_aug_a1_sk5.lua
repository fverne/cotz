-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_aug_a1_sk5"

att.displayName = "Worn out Steyr AUG A1"

att.displayNameShort = "Worn out Steyr AUG A1"

att.anomalyEffect = {
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/aug_a1/wpn_aug_sk5",
	},
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/aug_a1/wpn_aug_sk5",
	},
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_aug_a1_sk5")

	att.description = {{t = "", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_aug_a1_sk5", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_aug_a1_sk5", false)

end

CustomizableWeaponry:registerAttachment(att)
