-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_ac10632_m249"

att.displayName = "Sight Barska AC11090 Red Dot Sight"

att.displayNameShort = "Sight Barska AC11090 Red Dot Sight"

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
	},
	["Animations"] = {
		["reload"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
				val["value"] = "anm_reload_eotech"
			return val, true, true
		end,
		["reload_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
				val["value"] = "anm_reload_eotech"
			return val, true, true
		end,
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

	att.description = {{t = "Cheap 2.0x fixed magnification rifle scope with red reticle designed for use on NATO assault rifles, submachine guns and AK-12s.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac10632_m249", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_ac10632_m249", false)

end

CustomizableWeaponry:registerAttachment(att)
