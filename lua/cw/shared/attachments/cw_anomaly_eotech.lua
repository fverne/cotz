-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_eotech"

att.displayName = "Sight EOTech"

att.displayNameShort = "Sight EOTech"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_eotech"] = {
			["active"] = true,
		},
		["sight_anomaly_eotech_lense"] = {
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
		["anomaly_ironsight_remington870"] = {
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
		["sight_anomaly_eotech"] = {
			["active"] = true
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
		["anomaly_ironsight_remington870"] = {
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
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Eotech or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Eotech or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Eotech or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_eotech_lense",


	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_eotech_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_eot_sight",

    ["StencilSight_ReticleSize"] = 75,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_eotech")

	att.description = {{t = "EO Tech - is the world's leading and exclusive manufacturer of holographic sighting systems for small arms. EOTech sights are based on holographic construction of the sighting mark, thanks to which they have no parallax, the reticle is made of thousands of small pixels and does not overlap the target. Magnification: none (collimator)", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_eotech", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_eotech", false)

end

CustomizableWeaponry:registerAttachment(att)
