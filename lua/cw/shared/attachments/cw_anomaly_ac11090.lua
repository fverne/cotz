-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ac11090"

att.displayName = "Sight Barska AC11090 Red Dot Sight"

att.displayNameShort = "Sight Barska AC11090 Red Dot Sight"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_ac11090"] = {
			["active"] = true,
		},
		["sight_anomaly_ac11090_lense"] = {
			["active"] = true,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["sight_anomaly_ac11090"] = {
			["active"] = true
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_AC11090 or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_AC11090 or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_AC11090 or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_ac11090_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_ac11090_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_ac11090_crosshair_dot",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_ac11090")

	att.description = {{t = "Cheap 2.0x fixed magnification rifle scope with red reticle designed for use on NATO assault rifles, submachine guns and AK-12s.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac11090", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac11090", false)

end

CustomizableWeaponry:registerAttachment(att)
