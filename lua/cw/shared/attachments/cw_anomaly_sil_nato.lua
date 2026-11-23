-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_nato"

att.displayName = "NATO silencer"

att.displayNameShort = "NATO silencer"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_nato"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_nato"] = {
			["active"] = true
		},
	},
	["Primary"] = {
		["Damage"] = function(wep, stat) return stat * 0.98 end,
		["Spread"] = function(wep, stat) return stat * 1.05 end,
		["IronAccuracy"] = function(wep, stat) return stat * 1.1 end,
		["Sound"] = function(wep, stat) return wep.Primary.SilencedSound or stat end
	},
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced",
	["MuzzleAttachmentMod"] = function(wep, stat) return wep.MuzzleAttachmentSilenced or stat end,
	["Silenced"] = true,
}

att.anomalyLauncher = {}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_nato")

	att.description = {{t = "Silent and flameless firing device for NATO standard 5.56x45 caliber assault rifles, as well as for pistols and submachine guns 11.43x23 caliber. Muffling: high", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_nato", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_nato", false)

end

CustomizableWeaponry:registerAttachment(att)
