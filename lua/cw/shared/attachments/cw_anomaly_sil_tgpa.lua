-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_tgpa"

att.displayName = "Silencer TGP-A"

att.displayNameShort = "Silencer TGP-A"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_tgpa"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_tgpa"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_tgpa")

	att.description = {{t = "Tactical silencer-flame arrester “TGP-A-5.45” for 5.45-mm AK series assault rifles and RPK-74 machine guns. The design of the silencer does not include a rubber baffle and there is no need to use cartridges with subsonic ammunition. However, the accuracy of fire is somewhat impaired when it is installed. Muffling: medium", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_tgpa", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_tgpa", false)

end

CustomizableWeaponry:registerAttachment(att)
