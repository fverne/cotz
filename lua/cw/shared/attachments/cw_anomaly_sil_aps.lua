-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_aps"

att.displayName = "APS silencer"

att.displayNameShort = "APS silencer"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_aps"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_aps"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_pbs4")

	att.description = {{t = "Silent firing device for pistol OTs-33 “Pernach”. Muffling: medium", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_aps", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_aps", false)

end

CustomizableWeaponry:registerAttachment(att)
