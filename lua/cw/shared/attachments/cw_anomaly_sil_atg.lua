-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_atg"

att.displayName = "ATG silencer"

att.displayNameShort = "ATG silencer"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_atg"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_atg"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_atg")

	att.description = {{t = "The tactical automatic rifle silencer (ATG) is designed to reduce the sound and flame of the shot when firing 5.56-mm Kalashnikov AK101 and AK102 rifles, as well as 7.62-mm Kalashnikov AK103 and AK104 rifles. Muffling: medium", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_atg", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_atg", false)

end

CustomizableWeaponry:registerAttachment(att)
