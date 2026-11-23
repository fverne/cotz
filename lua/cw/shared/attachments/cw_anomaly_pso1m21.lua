-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_pso1m21"

att.displayName = "PSO-1M2-1 Scope"

att.displayNameShort = "PSO-1M2-1 Scope"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_pso1m21"] = {
			["active"] = true,
		},
		["anomaly_addon_rail"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["scope_anomaly_pso1m21"] = {
			["active"] = true
		},
		["anomaly_addon_rail"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_pso1m21",
	["INS2_SightSuffix"] = "PSO1M21"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_pso1m21")

	att.description = {{t = "Special version of the PSO-1M rifle scope with reticle, designed specifically to simplify shooting with low-velocity, weighted subsonic cartridges of 9x39 type. The reticle markings and a special rangefinder scale makes it easy to calculate compensating environmental factors. The reticle is illuminated in low light conditions. This set of features allowed to use such sights in special-purpose troops. It is also a standard sight on VSS “Vintorez” silent sniper rifle... Magnification: 4.0x Reticle type: PSO-1-1", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pso1m21", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_pso1m21", false)

end

CustomizableWeaponry:registerAttachment(att)
