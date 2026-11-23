-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_1p29"

att.displayName = "Sight USP-1 “Tulip”"

att.displayNameShort = "Sight USP-1 “Tulip”"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_1p29"] = {
			["active"] = true,
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
	},
	["WElements"] = {
		["scope_anomaly_1p29"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_1p29",
	["INS2_SightSuffix"] = "1P29"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_1p29")

	att.description = {{t = "The unified rifle sight USP-1 is designed for aiming shooting from: 9A-91, AEK-971, AEK-973,AK “hundredth series”, AK-74, AKM,AKMS, AKS-74U, AN-94, AC “Val”, VSK-94, VSS “Vintorez”, RPK-74, SVD, IED and SR-3M, during daylight hours and at night against illuminated and illuminated targets. 1P29 - sight index USP-1 of the USSR Defense Ministry Main Artillery Directorate. It was created as part of the Tulip design project, from which it got its name. Magnification: 4.0x Reticle type: USP-1", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_1p29", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_1p29", false)

end

CustomizableWeaponry:registerAttachment(att)
