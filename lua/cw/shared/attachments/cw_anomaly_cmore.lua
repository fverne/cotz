-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_cmore"

att.displayName = "Sight C-MORE Tactical Sight"

att.displayNameShort = "Sight C-MORE Tactical Sight"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_cmore"] = {
			["active"] = true,
		},
		["sight_anomaly_cmore_lense"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_off"] = {
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
		["sight_anomaly_cmore"] = {
			["active"] = true
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Cmore or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Cmore or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Cmore or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_cmore_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_cmore_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_c-more_crosshair_dot",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_cmore")

	att.description = {{t = "C-More Railway open-type collimator sight, which does not block the shooter's view, allowing him to use his peripheral vision. The sighting mark is a dot, red color. It can be instantly mounted on the Viver or Picatinny rail. Magnification: none (collimator)", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_cmore", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_cmore", false)

end

CustomizableWeaponry:registerAttachment(att)
