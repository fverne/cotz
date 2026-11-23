-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_sil_9p"

att.displayName = "Silencer 9mm"

att.displayNameShort = "Silencer 9mm"

att.anomalyEffect = {
	["VElements"] = {
		["anomaly_sil_9p"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_9p"] = {
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

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_sil_9p")

	att.description = {{t = "Silencer for 9 mm caliber weapons. It's archaic in design, but at the same time, quite effective. Contains a tightly packed roll of brass mesh inside.At the front of the device is a set of rubber diaphragms with holes for the for the bullet to pass through. The silencer is used in close combat against lightly armored and for silent assassinations. Muffling: very high", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_9p", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_sil_9p", false)

end

CustomizableWeaponry:registerAttachment(att)
