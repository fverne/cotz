-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_gemtech"

att.displayName = "Silencer GemTech"

att.displayNameShort = "Silencer GemTech"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_gemtech"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_gemtech"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_gemtech")

	att.description = {{t = "Silent firing device for Glock and FN FNP pistols. Muffling: high", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_gemtech", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_gemtech", false)

end

CustomizableWeaponry:registerAttachment(att)
