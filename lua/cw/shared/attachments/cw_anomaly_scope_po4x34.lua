-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_scope_po4x34"

att.displayName = "PO4x34 scope"

att.displayNameShort = "PO4x34 scope"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_po4x34"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_po4x34"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_po4x34",
	["INS2_SightSuffix"] = "PO4X34"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_po4x34")

	att.description = {{t = "Optical sights of constant and variable magnification are mounted on rifled weapons and are intended for aiming them during shooting. On the weapon the sight is mounted on the weapon by means of special brackets. Magnification: 4.0x", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_scope_po4x34", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_scope_po4x34", false)

end

CustomizableWeaponry:registerAttachment(att)
