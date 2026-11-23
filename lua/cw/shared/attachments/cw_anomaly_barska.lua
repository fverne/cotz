-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_barska"

att.displayName = "Sight Barska ELECTRO SIGHT AC10632"

att.displayNameShort = "Sight Barska ELECTRO SIGHT AC10632"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_barska"] = {
			["active"] = true,
		},
		["sight_anomaly_barska_lense"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
	},
	["WElements"] = {
		["sight_anomaly_barska"] = {
			["active"] = true
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Barska or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Barska or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Barska or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_barska_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_barska_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_barska_crosshair_dot",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ac10632")

	att.description = {{t = "ELECTRO SIGHT 1x22x33 collimator sight for quick aiming. Shockproof, fits all types of weapons with Picatinny bar. Selectable level of brightness of illumination of the sighting mark (7 stages) allows to use the sight at different light levels. Magnification: none (collimator)", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_barska", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_barska", false)

end

CustomizableWeaponry:registerAttachment(att)
