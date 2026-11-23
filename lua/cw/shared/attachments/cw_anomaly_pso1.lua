-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_pso1"

att.displayName = "PSO-1M scope"

att.displayNameShort = "PSO-1M scope"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_pso1"] = {
			["active"] = true,
		},
		["anomaly_addon_rail"] = {
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
	["WElements"] = {
		["scope_anomaly_pso1"] = {
			["active"] = true
		},
		["anomaly_addon_rail"] = {
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
	["INS2_SightVElement"] = "scope_anomaly_pso1",
	["INS2_SightSuffix"] = "PSO1"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_pso")

	att.description = {{t = "The PSO-1M (Sniper Optical Sight) is a series of Soviet telescopic sights produced by the Novosibirsk Instrument-Making Plant. It was developed in 1964 as a standard sight for the SVD rifle. Later it was widely used on: 9A-91, AEK-971, AEK-973, AK-74, AKS-74, AKS-74U, AKM, AKMS, AK “hundredth series”, AN-94, AC ‘Val’ modifications, RPK-74, IED and SR-3M. It is recognized for its durability, versatility and very well thought out type of reticle with a convenient rangefinder. This model is a fixed 4.0x magnification, which makes it suitable mainly for long-range use. Common in the Warsaw Pact countries, uses a dovetail mount. Magnification: 4.0x Reticle type: PSO-1", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pso1", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pso1", false)

end

CustomizableWeaponry:registerAttachment(att)
