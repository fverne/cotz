-- Original attachment configuration: Flaymi / Anomaly pack authors. CW adapter: COTZ.

local att = {}

att.name = "cw_anomaly_gl_m202"

att.displayName = "M203 underbarrel grenade launcher"

att.displayNameShort = "M203 underbarrel grenade launcher"

att.anomalyEffect = {
	["VElements"] = {
		["gl"] = {
			["active"] = true
		},
		["aug_a3_grip"] = {
			["active"] = false
		},
	},
	["WElements"] = {
		["gl"] = {
			["active"] = true
		},
		["aug_a3_grip"] = {
			["active"] = false
		},
	},
	["Animations"] = {
		["holster"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence"
			if wep:GLDeployed() then
				val["value"] = "anm_hide_w_gl_setup"
			else
				val["value"] = "anm_hide_w_gl"
			end
			return val, true, true
		end,
		["draw"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence"
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl_setup"
			else
				val["value"] = "anm_show_w_gl"
			end
			return val, true, true
		end,
		["draw_first"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence"
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl_setup_first"
			else
				val["value"] = "anm_show_w_gl_first"
			end
			return val, true, true
		end,
		["draw_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_show_w_gl_setup"
			else
				val["value"] = "anm_show_w_gl"
			end
			return val, true, true
		end,
		["shoot1"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["shoot1_last"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["shoot1_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_shots_g"
			else
				val["value"] = "anm_shots_w_gl"
			end
			return val, true, true
		end,
		["reload"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_reload_g"
			else
				val["value"] = "anm_reload_w_gl"
			end
			return val, true, true
		end,
		["reload_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_reload_g"
			else
				val["value"] = "anm_reload_empty_w_gl"

				if wep:CheckVMSequence("anm_reload_empty_w_gl") then
					val["value"] = "anm_reload_empty_w_gl"
				end
			end
			val["enabled"] = true
			return val, true, true
		end,
		["idle"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_w_gl_setup"
			else
				val["value"] = "anm_idle_w_gl"
			end
			return val, true, true
		end,
		["idle_empty"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_w_gl_setup"
			else
				val["value"] = "anm_idle_w_gl"
			end
			return val, true, true
		end,
		["rof"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "gl_fireselect_setup"
				val["enabled"] = false
			else
				val["value"] = "gl_fireselect"
			end
			return val, true, true
		end,
		["rof_is"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "gl_iron_fireselect_setup"
				val["enabled"] = false
			else
				val["value"] = "gl_iron_fireselect"
			end
			return val, true, true
		end
	},
	["Primary"] = {
		["GLSound"] = function(wep, stat)
			return stat or wep:GetStat("Secondary.Sound") or wep:GetStat("Primary.Sound")
		end,
		["KickUp"] = function(wep, stat) return stat * 0.8 end,
		["KickDown"] = function(wep, stat) return stat * 0.8 end,
		["Spread"] = function(wep, stat) return stat * 1.1 end,
		["IronAccuracy"] = function(wep, stat) return stat * 1.05 end
	},
	["Secondary"] = {
		["ClipSize"] = 1,
		["Ammo"] = "40MM"
	},
	["SprintAnimation"] = {
		["loop"] = function(wep, val)
			val = table.Copy(val) or {}
			val["type"] = "sequence" --Sequence or act
			if wep:GLDeployed() then
				val["value"] = "anm_idle_sprint_w_gl_setup"
			else
				val["value"] = "anm_idle_sprint_w_gl"
			end
			if val.value_empty then
				if wep:GLDeployed() then
					val["value_empty"] = "anm_idle_sprint_w_gl_setup"
				else
					val["value_empty"] = "anm_idle_sprint_w_gl"
				end
			end
			return val, true, true
		end
	},
	["IronAnimation"] = {
		["shoot"] = function(wep, val)
			val = table.Copy(val) or {}
			if wep:GLDeployed() then
				val["type"] = "sequence" --Sequence or act
				val["value"] = "anm_shots_g"
				val["value_empty"] = "anm_shots_g"
			else
				if not wep.IronAnimation.shoot then return nil, false, true end
				val["type"] = "sequence" --Sequence or act
				if val.value then
					val["value"] = "anm_shots_w_gl"
				end
				if val.value_last then
					val["value_last"] =  "anm_shots_w_gl"
				end
				if val.value_empty then
					val["value_empty"] =  "anm_shots_w_gl"
				end
			end
			return val, true, true
		end
	},
	["IronSightsPos"] = function(wep, val)
		if wep:GLDeployed() then
			return wep.IronSightsPos_GL, true, true
		else
			return val, false, true
		end
	end,
	["IronSightsAng"] = function(wep, val)
		if wep:GLDeployed() then
			return wep.IronSightsAng_GL, true, true
		else
			return val, false, true
		end
	end,
}

att.anomalyLauncher = {
	["Ammo"] = "40MM",
	["Damage"] = 250,
	["Velocity"] = 4015.74,
	["DefaultModel"] = "models/flaymi/anomaly/weapons/ammo/ammo_m209.mdl",
	["Delay"] = 0.3,
	["ClipSize"] = 1,
	["Sound"] = "weapons/ar2/ar2_altfire.wav",
}

if CLIENT then

	att.displayIcon = surface.GetTextureID("entities/anomaly/addons/addon_m203")

	att.description = {{t = "M203 single shot grenade launcher with three-inch shorter barrel and Picatinny mount. Thanks to the change in mount, this model is very widely used all over the world. Despite the more modern design, it has essentially the same characteristics as its Soviet counterpart, the GP-25.", c = CustomizableWeaponry.textColors.REGULAR}}

end

function att:attachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_gl_m202", true)

end

function att:detachFunc()

	self:ApplyAnomalyAttachments("cw_anomaly_gl_m202", false)

end

CustomizableWeaponry:registerAttachment(att)
