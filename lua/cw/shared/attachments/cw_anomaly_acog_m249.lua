-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_acog_m249"

att.displayName = "Sight ACOG"

att.displayNameShort = "Sight ACOG"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_acog"] = {
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
				val["value"] = "anm_reload_acog"
			return val, true, true
		end,
		["reload_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
				val["value"] = "anm_reload_acog"
			return val, true, true
		end,
	},
	["WElements"] = {
		["scope_anomaly_acog"] = {
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
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_ACOG or val end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_ACOG or val end,
	["Secondary"] = {
		["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_ACOG or val * 0.95 end
	},
	["IronSightTime"] = function(wep, val) return val * 1.05 end,
	["INS2_SightVElement"] = "scope_anomaly_acog",
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_acog")

	att.description = {{t = "A detachable telescopic sight designed for NATO rifles. ACOG stands for Advanced Combat Optical Gunsight and belongs to the Trijicon family of rifle scopes. This type of sights is mounted on the Picatinny rail and have tritium illumination. This model has a special “Trijicon” reticle and a fixed magnification of 2.0x. Magnification: 2.0x Reticle type: trijicon", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_acog_m249", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_acog_m249", false)

end

CustomizableWeaponry:registerAttachment(att)
