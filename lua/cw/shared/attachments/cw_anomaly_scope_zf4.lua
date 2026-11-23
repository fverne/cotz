-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_scope_zf4"

att.displayName = "ZF-4 scope"

att.displayNameShort = "ZF-4 scope"

att.anomalyEffect = {
	["VElements"] = {
		["scope_anomaly_zf4"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_zf4"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 4 end
	},
	["INS2_SightVElement"] = "scope_anomaly_zf4",
	["INS2_SightSuffix"] = "ZF4"
}

att.anomalyLauncher = {}

att.isSight = true

att.aimPos = {"AnomalySightPos", "AnomalySightAng"}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_zf4")

	att.description = {{t = "The ZF-4 (ZF-43) sight was created in Germany in 1943 on the basis of the Soviet PU telescopic sight. It was intended to arm the regular troops to allow them to fight at long ranges. However, due to insufficientnumber of sights produced, they were primarily provided to German snipers andelite units. Today, the ZF-4 remains quite popular in the Zone,because the World War II weapon it was designed for is still in use here. Magnification: 2.0x", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_scope_zf4", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_scope_zf4", false)

end

CustomizableWeaponry:registerAttachment(att)
