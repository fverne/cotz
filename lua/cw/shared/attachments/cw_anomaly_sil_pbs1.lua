-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_pbs1"

att.displayName = "Silencer PBS-1"

att.displayNameShort = "Silencer PBS-1"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_pbs1"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_pbs1"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_pbs1")

	att.description = {{t = "A device for silent and flameless firing from a Kalashnikov assault rifle of caliber 7.62 mm. When the silencer is installed, firing is carried out with US cartridges with subsonic bullet velocity. Muffling: medium", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_pbs1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_pbs1", false)

end

CustomizableWeaponry:registerAttachment(att)
