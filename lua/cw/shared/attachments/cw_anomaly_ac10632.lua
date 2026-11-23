-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ac10632"

att.displayName = "Sight Barska ELECTRO SIGHT AC10632"

att.displayNameShort = "Sight Barska ELECTRO SIGHT AC10632"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_ac10632"] = {
			["active"] = true,
		},
		["sight_anomaly_ac10632_lense"] = {
			["active"] = true,
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["g3sg_anomaly_rail"] = {
			["active"] = true,
		},
		["anomaly_hk416_sights"] = {
			["active"] = false,
		},
		["lr300_sight"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_off"] = {
			["active"] = true,
		},
		["ironsight_anomaly_m4a1"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m16"] = {
			["active"] = false,
		},
		["anomaly_mp5_mount"] = {
			["active"] = true,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_off"] = {
			["active"] = true,
		},
		["sight_anomaly_p90_sight"] = {
			["active"] = false,
		},
		[ "anomaly_scar_sight" ] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["g3sg_anomaly_rail"] = {
			["active"] = true,
		},
		["anomaly_hk416_sights"] = {
			["active"] = false,
		},
		["lr300_sight"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_off"] = {
			["active"] = true,
		},
		["ironsight_anomaly_m4a1"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m16"] = {
			["active"] = false,
		},
		["anomaly_mp5_mount"] = {
			["active"] = true,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["sight_anomaly_p90_sight"] = {
			["active"] = false,
		},
		[ "anomaly_scar_sight" ] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_AC10632 or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_AC10632 or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_AC10632 or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_ac10632",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_ac10632_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/ac10_sight",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ac10632")

	att.description = {{t = "ELECTRO SIGHT 1x22x33 collimator scope for fast aiming. Shockproof, suitable for all types of weapons with Picatinny rail. Selectable brightness level of illumination of the sighting mark (7 steps) allows you to use the sight at different light levels.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac10632", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac10632", false)

end

CustomizableWeaponry:registerAttachment(att)
