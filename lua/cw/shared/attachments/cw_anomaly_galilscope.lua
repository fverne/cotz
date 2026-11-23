-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_galilscope"

att.displayName = "Sight Galil 4.0x"

att.displayNameShort = "Sight Galil 4.0x"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_galilscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_galilscope"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_galilscope",
	["INS2_SightSuffix"] = "GALILSCOPE"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_galilscope")

	att.description = {{t = "Optical sight designed specifically for the Galil AR. Characteristic feature is the pylon-shaped reticle, which makes the sight suitable mainly for short and medium ranges, as at long ranges it overlaps the target.This model has fixed magnification of 4.0x and can be used for aiming fire at medium and long ranges. Magnification: 4.0x", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_galilscope", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_galilscope", false)

end

CustomizableWeaponry:registerAttachment(att)
