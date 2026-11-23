-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_mosin"

att.displayName = "PU scope"

att.displayNameShort = "PU scope"

att.anomalyEffect = {
	["RunSightsPos"] = function(wep, stat) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function(wep, stat) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_mosinscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_mosinscope"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 6 end
	},
	["INS2_SightVElement"] = "scope_anomaly_mosinscope",
	["INS2_SightSuffix"] = "MOSINSCOPE"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_mosin")

	att.description = {{t = "PU (Universal Sight) is a standard Red Army telescopic sight. During the Great Patriotic War it was designed for installation on Mosin rifle and SVT-40 rifle. The design turned out to be so successful and reliable that this sight still enjoys well-deserved popularity. It has a fixed magnification of 3.5x, which makes it a good choice for combat at medium and long ranges.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mosin", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_mosin", false)

end

CustomizableWeaponry:registerAttachment(att)
