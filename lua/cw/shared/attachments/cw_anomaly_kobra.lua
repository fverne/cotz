-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_kobra"

att.displayName = "Sight “Cobra” EKP-1S-03"

att.displayNameShort = "Sight “Cobra” EKP-1S-03"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["anomaly_addon_rail"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
		["sight_anomaly_kobra"] = {
			["active"] = true,
		},
		["sight_anomaly_kobra_lense"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_addon_rail"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
		["sight_anomaly_kobra"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Kobra or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Kobra or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Kobra or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_kobra_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_kobra_lense",

    ["StencilSight_ReticleType"] = "sequence",

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_ko",

    ["StencilSight_ReticleSize"] = 150,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_kobra")

	att.description = {{t = "The Cobra riflescope provides confident aiming in conditions of natural light conditions (bright sunny day, deep twilight and moonlit night) thanks to 16 levels of manual adjustment of the reticle brightness. Positioning of the reticle mark and target in the same plane allows aiming with one or two eyes, which creates an unobstructed field of view for the shooter, and allows for effective high-speed shooting at fast moving speeds, small-sized and suddenly appearing targets for a short period of time. Magnification: none (collimator)", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_kobra", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_kobra", false)

end

CustomizableWeaponry:registerAttachment(att)
