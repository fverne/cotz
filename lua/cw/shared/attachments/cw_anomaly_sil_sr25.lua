-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_sr25"

att.displayName = "SR-25 silencer"

att.displayNameShort = "SR-25 silencer"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_sr25"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_sr25"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_sr25")

	att.description = {{t = "A silent and flameless firing device for the SR-25 semi-automatic sniper rifle. Muffling: high", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_sr25", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_sr25", false)

end

CustomizableWeaponry:registerAttachment(att)
