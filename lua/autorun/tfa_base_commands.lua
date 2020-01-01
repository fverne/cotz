--Config GUI
if CLIENT then

	local function tfaOptionServer(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionSV = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Server"}
	
	tfaOptionSV.Options["#Default"] = { sv_tfa_weapon_strip =	"0",
								sv_tfa_allow_dryfire =	"1",
								sv_tfa_damage_multiplier =	"1",
								sv_tfa_default_clip =	"-1",
								sv_tfa_arrow_lifetime = "30",
								sv_tfa_force_multiplier = "1",
								sv_tfa_dynamicaccuracy = "1",
								sv_tfa_near_wall = "1",
								sv_tfa_range_modifier = "0.5",
								sv_tfa_fx_impact_override = "-1",
								sv_tfa_fx_muzzlesmoke_override = "-1",
								sv_tfa_fx_gas_override = "-1",
								sv_tfa_fx_ricochet_override = "-1",
								sv_tfa_bullet_penetration = "1",
								sv_tfa_bullet_ricochet = "1",
								sv_tfa_reloads_legacy = "0"								
							   }				
	panel:AddControl("ComboBox", tfaOptionSV)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
	
		panel:AddControl("CheckBox", {
		Label = "Require reload keypress",
		Command = "sv_tfa_allow_dryfire",
	})
	
	panel:AddControl("CheckBox", {
		Label = "Dynamic Accuracy",
		Command = "sv_tfa_dynamicaccuracy",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Pull up weapon when near wall",
		Command = "sv_tfa_near_wall",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Strip Empty Weapons",
		Command = "sv_tfa_weapon_strip",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Bullet Penetration",
		Command = "sv_tfa_bullet_penetration",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Bullet Ricochet",
		Command = "sv_tfa_bullet_ricochet",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Legacy-Style Reloading",
		Command = "sv_tfa_reloads_legacy",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Damage Multiplier",
		Command 	= "sv_tfa_damage_multiplier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Impact Force Multiplier",
		Command 	= "sv_tfa_force_multiplier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Default Clip Count (-1 = default)",
		Command 	= "sv_tfa_default_clip",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "10",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Bullet Range Damage Degredation",
		Command 	= "sv_tfa_range_modifier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})
	
	panel:AddControl("Label", {Text = "Performance Overrides (Good for RP Servers)"})
	
	panel:AddControl("Slider", {
		Label 	= "Gas Blur Effect Override (-1 to leave clientside)",
		Command 	= "sv_tfa_fx_gas_override",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "1",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Impact Effect Override (-1 to leave clientside)",
		Command 	= "sv_tfa_fx_impact_override",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "1",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Muzzle Smoke Effect Override (-1 to leave clientside)",
		Command 	= "sv_tfa_fx_muzzlesmoke_override",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "1",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Ricochet Effect Override (-1 to leave clientside)",
		Command 	= "sv_tfa_fx_ricochet_override",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "1",
	})	
	
	panel:AddControl("Slider", {
		Label 	= "World Model Cull Distance (-1 to disable)",
		Command 	= "sv_tfa_worldmodel_culldistance",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "4096",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end
	
	local function tfaOptionClient(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionCL = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Client"}
	
	tfaOptionCL.Options["#Default"] = { cl_tfa_3dscope = "1",
								cl_tfa_3dscope_overlay = "0",
								cl_tfa_scope_sensitivity_autoscale = "1",
								cl_tfa_scope_sensitivity =	"100",
								cl_tfa_inspection_ckey = "0",
								cl_tfa_inspection_old = "0",
								cl_tfa_ironsights_toggle = "1",
								cl_tfa_ironsights_resight = "1",
								cl_tfa_viewbob_reloading = "1",
								cl_tfa_viewbob_drawing = "0",
								sv_tfa_gunbob_intensity = "1",
								sv_tfa_viewbob_intensity = "1",
								cl_tfa_viewmodel_offset_x = "0",
								cl_tfa_viewmodel_offset_y = "0",
								cl_tfa_viewmodel_offset_z = "0",
								cl_tfa_viewmodel_offset_fov = "0",
								cl_tfa_viewmodel_flip = "0"
							   }				
	panel:AddControl("ComboBox", tfaOptionCL)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
		panel:AddControl("CheckBox", {
		Label = "Enable 3D Scopes (Re-Draw Gun After Changing)",
		Command = "cl_tfa_3dscope",
	})
		panel:AddControl("CheckBox", {
		Label = "Enable 3D Scope Shadows (Re-Draw Gun After Changing)",
		Command = "cl_tfa_3dscope_overlay",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Viebob While Drawing",
		Command = "cl_tfa_viewbob_drawing",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Viebob While Reloading",
		Command = "cl_tfa_viewbob_reloading",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Context Key Inspection",
		Command = "cl_tfa_inspection_ckey",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Legacy Text Inspection",
		Command = "cl_tfa_inspection_old",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Toggle Ironsights",
		Command = "cl_tfa_ironsights_toggle",
	})
		panel:AddControl("CheckBox", {
		Label = "Preserve Sights On Reload, Sprint, etc.",
		Command = "cl_tfa_ironsights_resight",
	})
		panel:AddControl("CheckBox", {
		Label = "Compensate sensitivity for FOV",
		Command = "cl_tfa_scope_sensitivity_autoscale",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Scope sensitivity",
		Command 	= "cl_tfa_scope_sensitivity",
		Type 		= "Integer",
		Min 		= "1",
		Max 		= "100",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Gun Bob Intensity",
		Command 	= "cl_tfa_gunbob_intensity",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})
	
	panel:AddControl("Slider", {
		Label 	= "View Bob Intensity",
		Command 	= "cl_tfa_viewbob_intensity",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Viemodel Offset - X",
		Command 	= "cl_tfa_viewmodel_offset_x",
		Type 		= "Float",
		Min 		= "-2",
		Max 		= "2",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Viemodel Offset - Y",
		Command 	= "cl_tfa_viewmodel_offset_y",
		Type 		= "Float",
		Min 		= "-2",
		Max 		= "2",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Viemodel Offset - Z",
		Command 	= "cl_tfa_viewmodel_offset_z",
		Type 		= "Float",
		Min 		= "-2",
		Max 		= "2",
	})
	
	panel:AddControl("Slider", {
		Label 	= "Viemodel Offset - FOV",
		Command 	= "cl_tfa_viewmodel_offset_fov",
		Type 		= "Float",
		Min 		= "-5",
		Max 		= "5",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Left Handed Viewmodel (Buggy)",
		Command = "cl_tfa_viewmodel_flip",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end

	local function tfaOptionPerformance(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionPerf = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Performance"}
	
	tfaOptionPerf.Options["#Default"] = {    cl_tfa_fx_impact_enabled = "1",
								cl_tfa_fx_impact_ricochet_enabled = "1",
								cl_tfa_fx_impact_ricochet_sparks = "20",
								cl_tfa_fx_impact_ricochet_sparklife = "2",
								cl_tfa_fx_gasblur = "1",
								cl_tfa_fx_muzzlesmoke = "1",
								cl_tfa_inspection_bokeh = "0"
							   }				
	panel:AddControl("ComboBox", tfaOptionPerf)
	
		panel:AddControl("CheckBox", {
		Label = "Use Gas Blur",
		Command = "cl_tfa_fx_gasblur",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Muzzle Smoke Trails",
		Command = "cl_tfa_fx_muzzlesmoke",
	})	
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom Impact FX",
		Command = "cl_tfa_fx_impact_enabled",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Ricochet FX",
		Command = "cl_tfa_fx_impact_ricochet_enabled",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Inspection BokehDOF",
		Command = "cl_tfa_inspection_bokeh",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Ricochet Spark Amount",
		Command 	= "cl_tfa_fx_impact_ricochet_sparks",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "50",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Ricochet Spark Life",
		Command 	= "cl_tfa_fx_impact_ricochet_sparklife",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end

	local function tfaOptionHUD(panel)
	
	--Here are whatever default categories you want.
	
	local tfaOptionHUD = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings HUD"}
	
	tfaOptionHUD.Options["#Default"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "225",
								cl_tfa_hud_crosshair_color_g = "225",
								cl_tfa_hud_crosshair_color_b = "225",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "225",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "1",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0",
								cl_tfa_hud_hitmarker_enabled = "1",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "225",
							   }		
	
	tfaOptionHUD.Options["Cross"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "200",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "154",
								cl_tfa_hud_crosshair_outline_color_g = "152",
								cl_tfa_hud_crosshair_outline_color_b = "175",
								cl_tfa_hud_crosshair_outline_color_a = "255",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "0.75",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "0",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0",
								cl_tfa_hud_hitmarker_enabled = "1",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "225",
							   }		
	
	tfaOptionHUD.Options["Dot/Minimalist"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "72",
								cl_tfa_hud_crosshair_color_g = "72",
								cl_tfa_hud_crosshair_color_b = "72",
								cl_tfa_hud_crosshair_color_a = "85",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "225",
								cl_tfa_hud_crosshair_outline_color_g = "225",
								cl_tfa_hud_crosshair_outline_color_b = "225",
								cl_tfa_hud_crosshair_outline_color_a = "85",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.1",
								cl_tfa_hud_hangtime = "0.5",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "0",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "0",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0",
								cl_tfa_hud_hitmarker_enabled = "0",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "225",
							   }	
	
	tfaOptionHUD.Options["Rockstar/GTAV/MP3"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "225",
								cl_tfa_hud_crosshair_color_g = "225",
								cl_tfa_hud_crosshair_color_b = "225",
								cl_tfa_hud_crosshair_color_a = "85",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "30",
								cl_tfa_hud_crosshair_outline_color_g = "30",
								cl_tfa_hud_crosshair_outline_color_b = "30",
								cl_tfa_hud_crosshair_outline_color_a = "85",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.1",
								cl_tfa_hud_hangtime = "0.5",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "0",
								cl_tfa_hud_crosshair_width = "2",
								cl_tfa_hud_crosshair_gap_scale = "0",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0",
								cl_tfa_hud_hitmarker_enabled = "1",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "8",
							   }
	
	tfaOptionHUD.Options["Half Life 2"] = {	cl_tfa_hud_crosshair_enable_custom = "0",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "0",
								cl_tfa_hud_enabled = "0",
								cl_tfa_hud_ammodata_fadein = "0.01",
								cl_tfa_hud_hangtime = "0",
								cl_tfa_hud_crosshair_length_use_pixels = "1",
								cl_tfa_hud_crosshair_length = "0.5",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "0",
								cl_tfa_hud_crosshair_outline_width = "0",
								cl_tfa_hud_crosshair_dot = "1",
								cl_tfa_hud_hitmarker_enabled = "0",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "225",
							   }	
	
	tfaOptionHUD.Options["Half Life 2 Enhanced"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_color_team = "1",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "0",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "1",
								cl_tfa_hud_crosshair_length = "0.5",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "0",
								cl_tfa_hud_crosshair_outline_width = "0",
								cl_tfa_hud_crosshair_dot = "1",
								cl_tfa_hud_hitmarker_enabled = "1",
								cl_tfa_hud_hitmarker_solidtime = "0.1",
								cl_tfa_hud_hitmarker_fadetime = "0.3",
								cl_tfa_hud_hitmarker_scale = "1",
								cl_tfa_hud_hitmarker_color_r = "225",
								cl_tfa_hud_hitmarker_color_g = "225",
								cl_tfa_hud_hitmarker_color_b = "225",
								cl_tfa_hud_hitmarker_color_a = "225",
							   }				
	panel:AddControl("ComboBox", tfaOptionHUD)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom HUD",
		Command = "cl_tfa_hud_enabled",
	})

		panel:AddControl("Slider", {
		Label 	= "Ammo HUD Fadein Time",
		Command 	= "cl_tfa_hud_ammodata_fadein",
		Type 		= "Float",
		Min 		= "0.01",
		Max 		= "1",
	})
	
		panel:AddControl("Slider", {
		Label 	= "HUD Hang Time (after a reload, etc.)",
		Command 	= "cl_tfa_hud_hangtime",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})	
	
	panel:AddControl("Label", {Text = "-Crosshair Options-"})
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom Crosshair",
		Command = "cl_tfa_hud_crosshair_enable_custom",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Crosshair Dot",
		Command = "cl_tfa_hud_crosshair_dot",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Crosshair Length In Pixels?",
		Command = "cl_tfa_hud_crosshair_length_use_pixels",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Length",
		Command 	= "cl_tfa_hud_crosshair_length",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "10",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Gap Scale",
		Command 	= "cl_tfa_hud_crosshair_gap_scale",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Width",
		Command 	= "cl_tfa_hud_crosshair_width",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "3",
	})
	
		panel:AddControl("Color", {
		Label = "Crosshair Color",
		Red = "cl_tfa_hud_crosshair_color_r",
		Green = "cl_tfa_hud_crosshair_color_g",
		Blue = "cl_tfa_hud_crosshair_color_b",
		Alpha = "cl_tfa_hud_crosshair_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Crosshair Teamcolor",
		Command = "cl_tfa_hud_crosshair_color_team",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Crosshair Outline",
		Command = "cl_tfa_hud_crosshair_outline_enabled",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Outline Width",
		Command 	= "cl_tfa_hud_crosshair_outline_width",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "3",
	})
	
		panel:AddControl("Color", {
		Label = "Crosshair Outline Color",
		Red = "cl_tfa_hud_crosshair_outline_color_r",
		Green = "cl_tfa_hud_crosshair_outline_color_g",
		Blue = "cl_tfa_hud_crosshair_outline_color_b",
		Alpha = "cl_tfa_hud_crosshair_outline_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Hitmarker",
		Command = "cl_tfa_hud_hitmarker_enabled",
	})

		panel:AddControl("Slider", {
		Label 	= "Hitmaker Solid Time",
		Command 	= "cl_tfa_hud_hitmarker_solidtime",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})

		panel:AddControl("Slider", {
		Label 	= "Hitmaker Fade Time",
		Command 	= "cl_tfa_hud_hitmarker_fadetime",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})

		panel:AddControl("Slider", {
		Label 	= "Hitmaker Scale",
		Command 	= "cl_tfa_hud_hitmarker_scale",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
		panel:AddControl("Color", {
		Label = "Hitmarker Color",
		Red = "cl_tfa_hud_hitmarker_color_r",
		Green = "cl_tfa_hud_hitmarker_color_g",
		Blue = "cl_tfa_hud_hitmarker_color_b",
		Alpha = "cl_tfa_hud_hitmarker_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end
	
	local function tfaOptionRestriction(panel)
	
	--Here are whatever default categories you want.
	
	local tfaOptionRestriction = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Restriction"}
	
	tfaOptionRestriction.Options["#Default"] = {}				
	panel:AddControl("ComboBox", tfaOptionRestriction)
	local blankar = {}
	local lv = vgui.Create("DListView")
	
	
	lv:AddColumn("Weapon")
	lv:AddColumn("Restricted?")
	
	local myoptionstable = tfaOptionRestriction.Options["#Default"]
	
	for k,v in pairs(TFAWeaponTable) do
		if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0) == 0 then
			lv:AddLine(v,"false")
		else
			lv:AddLine(v,"true")
		end
		myoptionstable["tfa_blacklist_"..string.Replace(v,"tfa_","")]=0
	end
	
	lv:SizeToContents()
	lv.DoDoubleClick = function(parent, index, listv)
		local v = TFAWeaponTable[index]
		local v_og = TFAWeaponTable[index]
		v = string.Replace(v,"tfa_","")
		if IsValid(LocalPlayer()) then
			local pl = LocalPlayer()
			local ccm = "tfa_blacklist_"..v
			pl:ConCommand(ccm.." "..(1-GetConVarNumber(ccm,0)))
			local lines = lv:GetLines()
			local line = lines[1]
			lv:Update()
			timer.Simple(0.01, function()
				if IsValid(lv) then
					lv:Update()
				end
			end)
		end
	end
	
	lv.Update = function()
		timer.Simple(0, function()
			if IsValid(lv) then
				lv:Clear()
				for k,v in pairs(TFAWeaponTable) do
					local line
					if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0) == 0 then
						lv:AddLine(v,"false")
					else
						lv:AddLine(v,"true")
					end
				end
			end
		end)
	end
	
	local s_x,s_y = panel:GetSize()
	lv:SetHeight(math.max(480,s_y-10))
	
	panel:AddItem(lv)
	
	local b = vgui.Create("DButton")
	b.listv = lv
	b:SizeToContents()
	b.DoClick = function()
		if IsValid(self) then
			if IsValid(self.listv) then
				self.listv:Update()
			end
		end
		if IsValid(lv) then
			lv:Update()
		end
	end
	b:SetText("Refresh")
	
	panel:AddItem(b)
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	
	end
	
	function tfaAddOption()
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionWeapons", "Weapon Behavior, Clientside", "", "", tfaOptionClient)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionPerformance", "Performance", "", "", tfaOptionPerformance)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseCrosshair", "HUD / Crosshair", "", "", tfaOptionHUD)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseServer", "Admin / Server", "", "", tfaOptionServer)
		--spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseRestriction", "Restriction", "", "", tfaOptionRestriction)
	end
	
	--hook.Add("PopulateToolMenu", "tfaAddOption", tfaAddOption)


else
	AddCSLuaFile()
end

--Serverside Convars

if GetConVar("sv_tfa_weapon_strip") == nil then
	CreateConVar("sv_tfa_weapon_strip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow the removal of empty weapons? 1 for true, 0 for false")
	--print("Weapon strip/removal con var created")
end
	
if GetConVar("sv_tfa_range_modifier") == nil then
	CreateConVar("sv_tfa_range_modifier", "0.5", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This controls how much the range affects damage.  0.5 means the maximum loss of damage is 0.5.")
	--print("Dry fire con var created")
end
	
if GetConVar("sv_tfa_allow_dryfire") == nil then
	CreateConVar("sv_tfa_allow_dryfire", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow dryfire?")
	--print("Dry fire con var created")
end


if GetConVar("sv_tfa_near_wall") == nil then
	CreateConVar("sv_tfa_near_wall", "1", {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Pull up your weapon and disable shooting when you're too close to a wall?" )
	--print("Near wall con var created")
end

if GetConVar("sv_tfa_damage_multiplier") == nil then
	CreateConVar("sv_tfa_damage_multiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for TFA base projectile damage.")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_damage_mult_min") == nil then
	CreateConVar("sv_tfa_damage_mult_min", "0.95", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This is the lower range of a random damage factor.")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_damage_mult_max") == nil then
	CreateConVar("sv_tfa_damage_mult_max", "1.05", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This is the lower range of a random damage factor.")
	--print("Damage Multiplier con var created")
end

function TFAUpdateDefaultClip()
	local dfc = math.Round(GetConVarNumber("sv_tfa_default_clip"))
	local weplist = weapons.GetList()
	if !weplist or #weplist<=0 then return end
	for k,v in pairs(weplist) do
		local cl = v.ClassName and v.ClassName or v
		local wep = weapons.GetStored(cl)
		if wep and ( wep.IsTFAWeapon or string.find( string.lower( wep.Base and wep.Base or "" ),"tfa") ) then
			
			if !wep.Primary then
				wep.Primary = {}
			end
			
			if !wep.Primary.TrueDefaultClip then
				wep.Primary.TrueDefaultClip = wep.Primary.DefaultClip
			end
			
			if !wep.Primary.TrueDefaultClip then
				wep.Primary.TrueDefaultClip = 0
			end
			
			if dfc<0 then
				wep.Primary.DefaultClip = wep.Primary.TrueDefaultClip
			else
				if wep.Primary.ClipSize and wep.Primary.ClipSize>0 then
					wep.Primary.DefaultClip = wep.Primary.ClipSize * dfc
				else
					wep.Primary.DefaultClip = wep.Primary.TrueDefaultClip * dfc				
				end
			end
		end
	end
end
	
hook.Add("InitPostEntity","TFADefaultClipPE", TFAUpdateDefaultClip)

if TFAUpdateDefaultClip then
	TFAUpdateDefaultClip()
end

--if GetConVar("sv_tfa_default_clip") == nil then
	local cv = CreateConVar("sv_tfa_default_clip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	
	cvars.AddChangeCallback( "sv_tfa_default_clip", function( convar_name, value_old, value_new )
		print("Update Default Clip")
		TFAUpdateDefaultClip()
	end, "TFAUpdateDefaultClip" )
	--print("Default clip size con var created")
--end
	
if GetConVar("sv_tfa_unique_slots") == nil then
	CreateConVar("sv_tfa_unique_slots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give TFA-based Weapons unique slots? 1 for true, 0 for false. RESTART AFTER CHANGING.")
	--print("Unique slot con var created")
end
	
if GetConVar("sv_tfa_force_multiplier") == nil then
	CreateConVar("sv_tfa_force_multiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Arrow force multiplier (not arrow velocity, but how much force they give on impact).")
	--print("Arrow force con var created")
end
	
if GetConVar("sv_tfa_dynamicaccuracy") == nil then
	CreateConVar("sv_tfa_dynamicaccuracy", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Dynamic acuracy?  (e.g.more accurate on crouch, less accurate on jumping.")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation") == nil then
	CreateConVar("sv_tfa_ammo_detonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation?  (e.g. shoot ammo until it explodes) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation_mode") == nil then
	CreateConVar("sv_tfa_ammo_detonation_mode", "2", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation Mode?  (0=Bullets,1=Blast,2=Mix) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation_chain") == nil then
	CreateConVar("sv_tfa_ammo_detonation_chain", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation Chain?  (0=Ammo boxes don't detonate other ammo boxes, 1 you can chain them together) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_scope_gun_speed_scale") == nil then
	CreateConVar("sv_tfa_scope_gun_speed_scale", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Scale player sensitivity based on player move speed?")
end
	
if GetConVar("sv_tfa_bullet_penetration") == nil then
	CreateConVar("sv_tfa_bullet_penetration", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow bullet penetration?")
end
	
if GetConVar("sv_tfa_bullet_ricochet") == nil then
	CreateConVar("sv_tfa_bullet_ricochet", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow bullet ricochet?")
end
	
if GetConVar("sv_tfa_holdtype_dynamic") == nil then
	CreateConVar("sv_tfa_holdtype_dynamic", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow dynamic holdtype?")
end
	
if GetConVar("sv_tfa_compatibility_movement") == nil then
	CreateConVar("sv_tfa_compatibility_movement", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable custom movement speed for increased compatibility?")
end
	
if GetConVar("sv_tfa_compatibility_clientframe") == nil then
	CreateConVar("sv_tfa_compatibility_clientframe", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This should be used if you have an addon that breaks TFA Base's aiming or other features, but you don't want to remove it.")
end

if GetConVar("sv_tfa_compatibility_footstep") == nil then
	CreateConVar("sv_tfa_compatibility_footstep", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This should be used if you have an addon that breaks TFA Base's running, sprinting, etc. animations.")
end

if GetConVar("sv_tfa_arrow_lifetime") == nil then
	CreateConVar("sv_tfa_arrow_lifetime", "30", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Arrow lifetime.")
end

if GetConVar("sv_tfa_arrow_lifetime") == nil then
	CreateConVar("sv_tfa_arrow_lifetime", "30", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Arrow lifetime.")
end

if GetConVar("sv_tfa_fx_muzzlesmoke_override") == nil then
	CreateConVar("sv_tfa_fx_muzzlesmoke_override", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to let clients pick.  0 to force off.  1 to force on.")
end

if GetConVar("sv_tfa_fx_gas_override") == nil then
	CreateConVar("sv_tfa_fx_gas_override", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to let clients pick.  0 to force off.  1 to force on.")
end

if GetConVar("sv_tfa_fx_impact_override") == nil then
	CreateConVar("sv_tfa_fx_impact_override", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to let clients pick.  0 to force off.  1 to force on.")
end

if GetConVar("sv_tfa_fx_ricochet_override") == nil then
	CreateConVar("sv_tfa_fx_ricochet_override", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to let clients pick.  0 to force off.  1 to force on.")
end

if GetConVar("sv_tfa_worldmodel_culldistance") == nil then
	CreateConVar("sv_tfa_worldmodel_culldistance", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to leave unculled.  Anything else is feet*16.")
end

if GetConVar("sv_tfa_reloads_legacy") == nil then
	CreateConVar("sv_tfa_reloads_legacy", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "-1 to leave unculled.  Anything else is feet*16.")
end

--Clientside Convars

if CLIENT then

	if GetConVar("cl_tfa_inspection_old") == nil then
		CreateClientConVar("cl_tfa_inspection_old", 0, true, true)
	end

	if GetConVar("cl_tfa_inspection_ckey") == nil then
		CreateClientConVar("cl_tfa_inspection_ckey", 0, true, true)
	end

	if GetConVar("cl_tfa_viewbob_intensity") == nil then
		CreateClientConVar("cl_tfa_viewbob_intensity", 1, true, false)
	end

	if GetConVar("cl_tfa_gunbob_intensity") == nil then
		CreateClientConVar("cl_tfa_gunbob_intensity", 1, true, false)
		--print("Viewbob intensity con var created")
	end

	if GetConVar("cl_tfa_3dscope") == nil then
		CreateClientConVar("cl_tfa_3dscope",1,true,true)
	end

	if GetConVar("cl_tfa_3dscope_overlay") == nil then
		CreateClientConVar("cl_tfa_3dscope_overlay",0,true,true)
	end

	if GetConVar("cl_tfa_scope_sensitivity_autoscale") == nil then
		CreateClientConVar("cl_tfa_scope_sensitivity_autoscale", 100, true, true)
		--print("Scope sensitivity autoscale con var created")
	end
		
	if GetConVar("cl_tfa_scope_sensitivity") == nil then
		CreateClientConVar("cl_tfa_scope_sensitivity", 100, true, true)
		--print("Scope sensitivity con var created")
	end
		
	if GetConVar("cl_tfa_ironsights_toggle") == nil then
		CreateClientConVar("cl_tfa_ironsights_toggle", 1, true, true)
		--print("Ironsights toggle con var created")
	end
		
	if GetConVar("cl_tfa_ironsights_resight") == nil then
		CreateClientConVar("cl_tfa_ironsights_resight", 1, true, true)
		--print("Ironsights resight con var created")
	end
		
	--Crosshair Params
	
	if GetConVar("cl_tfa_hud_crosshair_length") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_length", 1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_length_use_pixels") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_length_use_pixels", 0, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_width") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_width", 1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_enable_custom") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_enable_custom", 1, true, false)
		--print("Custom crosshair con var created")
	end
		
	if GetConVar("cl_tfa_hud_crosshair_gap_scale") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_gap_scale", 1, true, false)
	end
	
	if GetConVar("cl_tfa_hud_crosshair_dot") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_dot", 0, true, false)
	end
	
	--Crosshair Color
	if GetConVar("cl_tfa_hud_crosshair_color_r") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_r", 225, true, false)
		--print("Crosshair tweaking con vars created")
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_g") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_g", 225, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_b") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_b", 225, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_a") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_a", 200, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_team") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_team", 1, true, false)
	end
	
	--Crosshair Outline
	if GetConVar("cl_tfa_hud_crosshair_outline_color_r") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_r", 5, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_g") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_g", 5, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_b") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_b", 5, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_a") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_a", 200, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_width") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_width", 1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_enabled") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_enabled", 1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_enabled") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_enabled", 1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_fadetime") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_fadetime", 0.3, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_solidtime") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_solidtime", 0.1, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_scale") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_scale", 1, true, false)
	end
	
	if GetConVar("cl_tfa_hud_hitmarker_color_r") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_color_r", 225, true, false)
		--print("hitmarker tweaking con vars created")
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_color_g") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_color_g", 225, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_color_b") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_color_b", 225, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hitmarker_color_a") == nil then
		CreateClientConVar("cl_tfa_hud_hitmarker_color_a", 200, true, false)
	end
	
	--Other stuff
	
	if GetConVar("cl_tfa_hud_ammodata_fadein") == nil then
		CreateClientConVar("cl_tfa_hud_ammodata_fadein", 0.2, true, false)
	end
		
	if GetConVar("cl_tfa_hud_hangtime") == nil then
		CreateClientConVar("cl_tfa_hud_hangtime", 1, true, true)
	end
		
	if GetConVar("cl_tfa_hud_enabled") == nil then
		CreateClientConVar("cl_tfa_hud_enabled", 1, true, false)
	end
		
	if GetConVar("cl_tfa_fx_gasblur") == nil then
		CreateClientConVar("cl_tfa_fx_gasblur", 0, true, true)
	end
		
	if GetConVar("cl_tfa_fx_muzzlesmoke") == nil then
		CreateClientConVar("cl_tfa_fx_muzzlesmoke", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_impact_enabled") == nil then
		CreateClientConVar("cl_tfa_fx_impact_enabled", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_impact_ricochet_enabled") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_enabled", 1, true, true)
	end

	if GetConVar("cl_tfa_fx_impact_ricochet_sparks") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_sparks", 6, true, true)
	end

	if GetConVar("cl_tfa_fx_impact_ricochet_sparklife") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_sparklife", 2, true, true)
	end
	
	--viewbob 
	
		
	if GetConVar("cl_tfa_viewbob_drawing") == nil then
		CreateClientConVar("cl_tfa_viewbob_drawing", 0, true, false)
	end
	
	if GetConVar("cl_tfa_viewbob_reloading") == nil then
		CreateClientConVar("cl_tfa_viewbob_reloading", 1, true, false)
	end
	
	--Viewmodel Mods
	
	if GetConVar("cl_tfa_viewmodel_offset_x") == nil then
		CreateClientConVar("cl_tfa_viewmodel_offset_x", 0, true, false)
	end
	
	if GetConVar("cl_tfa_viewmodel_offset_y") == nil then
		CreateClientConVar("cl_tfa_viewmodel_offset_y", 0, true, false)
	end
	
	if GetConVar("cl_tfa_viewmodel_offset_z") == nil then
		CreateClientConVar("cl_tfa_viewmodel_offset_z", 0, true, false)
	end
	
	if GetConVar("cl_tfa_viewmodel_offset_fov") == nil then
		CreateClientConVar("cl_tfa_viewmodel_offset_fov", 0, true, false)
	end
	
	if GetConVar("cl_tfa_viewmodel_multiplier_fov") == nil then
		CreateClientConVar("cl_tfa_viewmodel_multiplier_fov", 1, true, false)
	end
	
	if GetConVar("cl_tfa_viewmodel_flip") == nil then
		CreateClientConVar("cl_tfa_viewmodel_flip", 0, true, false)
	end
	
	
end

--Helpers

local gas_cl_enabled = GetConVar("cl_tfa_fx_gasblur")
local gas_sv_enabled = GetConVar("sv_tfa_fx_gas_override")

function GetTFAGasEnabled()
	
	local enabled
	if gas_cl_enabled then
		enabled = gas_cl_enabled:GetBool()
	else
		enabled = false
	end
	
	if gas_sv_enabled and gas_sv_enabled:GetInt()>=0 then enabled=gas_sv_enabled:GetBool() end
	
	return enabled
	
end

local muzzlesmoke_cl_enabled = GetConVar("cl_tfa_fx_muzzlesmoke")
local muzzlesmoke_sv_enabled = GetConVar("sv_tfa_fx_muzzlesmoke_override")

function GetTFAMZSmokeEnabled()
	
	local enabled
	if muzzlesmoke_cl_enabled then
		enabled = muzzlesmoke_cl_enabled:GetBool()
	else
		enabled = false
	end
	
	if muzzlesmoke_sv_enabled and muzzlesmoke_sv_enabled:GetInt()>=0 then enabled=muzzlesmoke_sv_enabled:GetBool() end
	
	return enabled
	
end

local ricofx_cl_enabled = GetConVar("cl_tfa_fx_impact_ricochet_enabled")
local ricofx_sv_enabled = GetConVar("sv_tfa_fx_ricochet_override")

function GetTFARicochetEnabled()
	
	local enabled
	if ricofx_cl_enabled then
		enabled = ricofx_cl_enabled:GetBool()
	else
		enabled = false
	end
	
	if ricofx_sv_enabled and ricofx_sv_enabled:GetInt()>=0 then enabled=ricofx_sv_enabled:GetBool() end
	
	return enabled
	
end




--Local function for detecting TFA Base weapons.

function PlayerCarryingTFAWeapon( ply )
	if !ply then
		if CLIENT then
			if IsValid(LocalPlayer()) then
				ply = LocalPlayer()
			else
				return false, nil, nil
			end
		elseif game.SinglePlayer() then
			ply = Entity(1)
		else
			return false, nil, nil
		end
	end
	
	if not ( IsValid(ply) and ply:IsPlayer() and ply:Alive() ) then return end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		if (wep.IsTFAWeapon)then
			return true, ply, wep
		end
		return false, ply, wep
	end
	return false, ply, nil
end

--Blacklist convar creation

function TFABlacklistPE()
	--[[
	local weplist = weapons.GetList()
	if !weplist or #weplist<=0 then return end
	for k,v in pairs(weplist) do
		local cl = v.ClassName and v.ClassName or v
		local wep = weapons.GetStored(cl)
		if wep and ( wep.IsTFAWeapon or string.find( string.lower( wep.Base and wep.Base or "" ),"tfa") or string.find(string.lower(v.Folder and v.Folder or ""),"tfa") ) then	
			if GetConVar("tfa_bl_"..cl) == nil then
				CreateConVar("tfa_bl_"..cl, "0", { FCVAR_PROTECTED, FCVAR_ARCHIVE }, "Blacklist the "..(wep.PrintName and wep.PrintName or cl).."?")
			end
		end
	end
	]]--
end
	
hook.Add("InitPostEntity","TFABlacklistPE", TFABlacklistPE)

if TFABlacklistPE then
	TFABlacklistPE()
end

--Disable spawning of blacklisted guns, now depracated

local redcol = Color(255,0,0,255)

--[[

hook.Add( "WeaponEquip" , "TFAEquipBlacklist", function( wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_bl_"..v,0)==1 then
		print("SWEP Blocked:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerCanPickupWeapon" , "TFAPickUpBlacklist", function( ply, wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_bl_"..v,0)==1 then
		print("This player tried to pick up a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerSwitchWeapon" , "TFAWepSwitchBlacklist", function( ply, oldwep, wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_bl_"..v,0)==1 then
		print("This player tried to switch to a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerGiveSWEP" , "TFAGiveSWEPBlacklist", function( ply, v, swep )
	if GetConVarNumber("tfa_bl_"..v,0)==1 then
		print("This player tried to give themselves a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		return false
	end
end)

hook.Add( "PlayerSpawnSWEP" , "TFASpawnSWEPBlacklist", function( ply, v, swep )
	if GetConVarNumber("tfa_bl_"..v,0)==1 then
		print("This player tried to spawn themselves a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		return false
	end
end)
]]--

--Main weapon think

hook.Add( "PlayerTick" , "PlayerTickTFA", function( ply )
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		if wep.PlayerThink and wep.IsTFAWeapon then
			wep:PlayerThink( ply )
		end
	end
end)
	
--You can't pick up props while holding TFA guns.  Well, you can now.

hook.Add("AllowPlayerPickup","TFAPickupDisable", function(ply, ent)
	ply:SetNWEntity("LastHeldEntity",ent)
	ply:SetNWInt("LastHeldEntityIndex",ent.EntIndex and ent:EntIndex() or -1)
	--[[
	local iscarryingtfa, pl, wep = PlayerCarryingTFAWeapon(ply)
	if iscarryingtfa then
		return false
	else
		return
	end
	]]--
end)

--Client think per-frame

if CLIENT then
	if GetConVarNumber("sv_tfa_compatibility_clientframe",0)!=1 then
		hook.Add("PreRender", "prerender_tfabase", function()
			
			local ply = LocalPlayer()
			if !IsValid(ply) then return end
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.IsTFAWeapon and wep.PlayerThinkClientFrame then
				wep:PlayerThinkClientFrame(ply)
			end
			
		end)
	else
		hook.Add("Think", "prerender_tfabase", function()
		
			local ply = LocalPlayer()
			if !IsValid(ply) then return end
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.IsTFAWeapon and wep.PlayerThinkClientFrame then
				wep:PlayerThinkClientFrame(pl)
			end
			
		end)
	end
end

--Post draw opaque renderables.  Not needed really, not used.

hook.Add("PostDrawTranslucentRenderables", "postdrawtranslucentrenderables_tfabase", function()

	local ply = LocalPlayer()
	if !IsValid(ply) then return end
	
	local wep = ply:GetActiveWeapon()
	
	if wep.PostDrawTranslucentRenderables_TFA then
		wep:PostDrawTranslucentRenderables_TFA(pl)
	end
	
end)

--SWEP footstep hook

if GetConVarNumber("sv_tfa_compatibility_footstep",0)!=1 then
	hook.Add("PlayerFootstep","tfa_playerfootstep", function( ply )
		local isc, pl, wep = PlayerCarryingTFAWeapon(ply)
		
		if isc then
			if wep.Footstep and CLIENT then
				wep:Footstep()
			end
		end
		
		return
	end)
end

--Hide default hud for TFA weapons

if CLIENT then

	local TFAHudHide = {
		CHudAmmo = true, 
		CHudSecondaryAmmo = true
	}
	
	hook.Add("HUDShouldDraw", "tfa_hidehud", function( name )
		if ( TFAHudHide[ name ] ) and ( GetConVarNumber("cl_tfa_hud_enabled",1) == 1 ) then
			local ictfa = PlayerCarryingTFAWeapon()
			if ictfa then
				return false
			end
		end
	end)

end

--Movement speed

if !(Clockwork) and GetConVarNumber("sv_tfa_compatibility_movement",0)!=1 then
	hook.Add("SetupMove","tfa_setupmove",function( ply, movedata, commanddata ) 

		local iscarryingtfaweapon, pl, wep = PlayerCarryingTFAWeapon( ply )
		
		if iscarryingtfaweapon then
			if wep.GetIronSightsRatio then
				local speedmult = Lerp(wep:GetIronSightsRatio(), wep.MoveSpeed or 1, wep.IronSightsMoveSpeed or 1)
				movedata:SetMaxClientSpeed(movedata:GetMaxClientSpeed()*speedmult)
				commanddata:SetForwardMove(commanddata:GetForwardMove()*speedmult)
				commanddata:SetSideMove(commanddata:GetSideMove()*speedmult)
			end
		end

	end)
end

--Particle PCF files

if game.AddParticles then
	game.AddParticles("particles/tfa_smoke.pcf")
end

--Fonts

if !TFASleekFontCreated and CLIENT then
	local fontdata = {}
	fontdata.font = "Roboto-Regular"
	fontdata.size = 36
	fontdata.antialias = true
	fontdata.shadow = false 
	surface.CreateFont("TFASleek",fontdata)
	fontdata.size = 30
	surface.CreateFont("TFASleekMedium",fontdata)
	fontdata.size = 24
	surface.CreateFont("TFASleekSmall",fontdata)
	fontdata.size = 18
	surface.CreateFont("TFASleekTiny",fontdata)
	TFASleekFontCreated = true
	TFASleekFontHeight = draw.GetFontHeight("TFASleek")
	TFASleekFontHeightMedium = draw.GetFontHeight("TFASleekMedium")
	TFASleekFontHeightSmall = draw.GetFontHeight("TFASleekSmall")
	TFASleekFontHeightTiny = draw.GetFontHeight("TFASleekTiny")
end

--Scope materials

if CLIENT then
	TFA_SCOPE_ACOG				= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
	dottex = surface.GetTextureID("scope/gdcw_acogcross")
	}
	TFA_SCOPE_MILDOT			= {
	scopetex = surface.GetTextureID("scope/gdcw_scopesight")
	}
	TFA_SCOPE_SVD				= {
	scopetex = surface.GetTextureID("scope/gdcw_svdsight")
	}
	TFA_SCOPE_PARABOLIC			= {
	scopetex = surface.GetTextureID("scope/gdcw_parabolicsight")
	}
	TFA_SCOPE_ELCAN				= {
	scopetex = surface.GetTextureID("scope/gdcw_elcansight"),
	reticletex = surface.GetTextureID("scope/gdcw_elcanreticle")
	}
	TFA_SCOPE_GREENDUPLEX		= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/gdcw_nvgilluminatedduplex")
	}
	TFA_SCOPE_AIMPOINT		= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/aimpoint")
	}
	TFA_SCOPE_MATADOR		= {
	scopetex = surface.GetTextureID("scope/rocketscope")
	}
	TFA_SCOPE_SCOPESCALE = 4
	TFA_SCOPE_RETICLESCALE = 1
	TFA_SCOPE_DOTSCALE = 1
end

--DarkRP pocketing code.

tfanpw = {}
table.insert(tfanpw, "tfa_davy_crockett_explo")
table.insert(tfanpw, "tfa_gdcwa_matador_90mm")
table.insert(tfanpw, "tfa_gdcwa_rpg_heat")
table.insert(tfanpw, "tfa_improvised_explosive")
table.insert(tfanpw, "tfa_launched_davycrockett")
table.insert(tfanpw, "tfa_launched_ex41")
table.insert(tfanpw, "tfa_launched_m79")
table.insert(tfanpw, "tfa_m202_rocket")
table.insert(tfanpw, "tfa_mad_c4")
table.insert(tfanpw, "tfa_milkor_nade")
table.insert(tfanpw, "tfa_nervegasnade")
table.insert(tfanpw, "tfa_nitro_vapor")
table.insert(tfanpw, "tfa_oribital_cannon")
table.insert(tfanpw, "tfa_poison_parent")
table.insert(tfanpw, "tfa_proxy")
table.insert(tfanpw, "tfa_released_poison")
table.insert(tfanpw, "tfa_sent_nuke_radiation")
table.insert(tfanpw, "tfa_thrown_harpoon")
table.insert(tfanpw, "tfa_thrown_knife")
table.insert(tfanpw, "tfa_thrown_m61")
table.insert(tfanpw, "tfa_thrown_nitrox")
table.insert(tfanpw, "tfa_thrown_spec_knife")
table.insert(tfanpw, "tfa_thrown_sticky_grenade")
table.insert(tfanpw, "bb_dod_bazooka_rocket")
table.insert(tfanpw, "bb_dod_panzershreck_rocket")
table.insert(tfanpw, "bb_garand_riflenade")
table.insert(tfanpw, "bb_k98_riflenade")
table.insert(tfanpw, "bb_planted_dod_tnt")
table.insert(tfanpw, "bb_thrownalliedfrag")
table.insert(tfanpw, "bb_thrownaxisfrag")
table.insert(tfanpw, "bb_thrownsmoke_axis")
table.insert(tfanpw, "bb_thrownaxisfrag")
table.insert(tfanpw, "bb_planted_alt_c4")
table.insert(tfanpw, "bb_planted_css_c4")
table.insert(tfanpw, "bb_throwncssfrag")
table.insert(tfanpw, "bb_throwncsssmoke")
table.insert(tfanpw, "tfa_ammo_40mm")
table.insert(tfanpw, "tfa_ammo_40mm_single")
table.insert(tfanpw, "tfa_ammo_357")
table.insert(tfanpw, "tfa_ammo_ar2")
table.insert(tfanpw, "tfa_ammo_buckshot")
table.insert(tfanpw, "tfa_ammo_c4")
table.insert(tfanpw, "tfa_ammo_frags")
table.insert(tfanpw, "tfa_ammo_ieds")
table.insert(tfanpw, "tfa_ammo_nervegas")
table.insert(tfanpw, "tfa_ammo_nuke")
table.insert(tfanpw, "tfa_ammo_pistol")
table.insert(tfanpw, "tfa_ammo_proxmines")
table.insert(tfanpw, "tfa_ammo_rockets")
table.insert(tfanpw, "tfa_ammo_smg")
table.insert(tfanpw, "tfa_ammo_sniper_rounds")
table.insert(tfanpw, "tfa_ammo_stickynades")
table.insert(tfanpw, "tfa_ammo_winchester")

function TFAPocketFix(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	
	if tfanpw[class] then
		return false
	end
	
end

hook.Add("canPocket", "TFAPocketFix", TFAPocketFix )



--[[ 
Function Name:  VecOrFix
Syntax: self:VecOrFix( ). 
Returns:  Nothing.
Notes:    Guarantees vector_origin = 0.
Purpose:  Utility
]]--

function VecOrFix()
	vector_origin.x=0
	vector_origin.y=0
	vector_origin.z=0
end

hook.Add("Think", "TFAVecOrFix", VecOrFix )
--[[ 
Inspection Stuff
]]--

if SERVER then
	util.AddNetworkString( "tfaInspect" )

	net.Receive("tfaInspect", function( length, client )
		local mybool = net.ReadBool()
		mybool = mybool and 1 or 0
		if IsValid(client) and client:IsPlayer() and client:Alive() then
			local ply = client
			wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.ToggleInspect then
				wep:ToggleInspect()
			end
		
		end
	end)
	
	util.AddNetworkString( "tfaShotgunInterrupt" )

	net.Receive("tfaShotgunInterrupt", function( length, client )
	
		if IsValid(client) and client:IsPlayer() and client:Alive() then
			local ply = client
			wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.ShotgunInterrupt then
				wep:ShotgunInterrupt()
			end
		
		end
	end)
	
	util.AddNetworkString( "tfaAltAttack" )

	net.Receive("tfaAltAttack", function( length, client )
	
		if IsValid(client) and client:IsPlayer() and client:Alive() then
			local ply = client
			wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.AltAttack then
				wep:AltAttack()
			end
		
		end
	
	end)
	
	util.AddNetworkString( "tfaSoundEvent" )
end

function TFAPlayerBindPress(ply, b, p)
	if p and IsValid(ply) then
		local wep = ply:GetActiveWeapon()

		if IsValid(wep) then	
			if wep.AltAttack then
				if b == "+zoom" then
					wep:AltAttack()
					if CLIENT then
						net.Start("tfaAltAttack")
						net.SendToServer()
					end
					return true
				end
			end	
			if wep.ToggleInspect then
				if b == "+menu_context"  then
					wep:ToggleInspect()
					return true
				end
			end
			if wep.ShotgunInterrupt then
				if b == "+attack" and (wep:GetReloading() and wep.Shotgun and !wep:GetShotgunPumping() and !wep:GetShotgunNeedsPump()) then
					wep:ShotgunInterrupt()
					return true
				end
			end		
		end
	end
end

hook.Add("PlayerBindPress", "TFAInspectionMenu", TFAPlayerBindPress)

hook.Add("PlayerSpawn","TFAExtinguishQOL", function(ply)
	if IsValid(ply) then
		if ply:IsOnFire() then
			ply:Extinguish()
		end
	end
end)

hook.Add("PreDrawOpaqueRenderables","tfaweaponspredrawopaque",function()
	for k,v in pairs(player.GetAll()) do
		local wep = v:GetActiveWeapon()
		if IsValid(wep) and wep.PreDrawOpaqueRenderables then
			wep:PreDrawOpaqueRenderables()
		end
	end
end)

--receive sounds in mp

if CLIENT then
	net.Receive( "tfaSoundEvent", function( length,ply )
	
		local wep = net.ReadEntity()
		local snd = net.ReadString()
		if IsValid(wep) and snd and snd!="" then
			wep:EmitSound(snd)
		end
		
	end )
end

--For networking muzzles

if SERVER then
	util.AddNetworkString("tfa_base_muzzle_mp")
end

if SERVER then
	net.Receive( "tfa_base_muzzle_mp", function( length,ply )
	
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.ShootEffectsCustom then
			wep:ShootEffectsCustom()
		end
		
	end )
end

if CLIENT then
	net.Receive( "tfa_base_muzzle_mp", function( length,ply )
	
		local wep = net.ReadEntity()
		if IsValid(wep) and wep.ShootEffectsCustom then
			wep:ShootEffectsCustom( true )
		end
		
	end )
end

--More Muzzle Stuff

TFAFlareParts = {}
TFAVMAttachments = {}

if CLIENT or game.SinglePlayer() then
	hook.Add("PreDrawEffects", "TFAMuzzleUpdate", function()
		if IsValid(LocalPlayer()) and IsValid(LocalPlayer():GetActiveWeapon()) and IsValid(LocalPlayer():GetViewModel()) then
			local wep = LocalPlayer():GetActiveWeapon()
			local vm = LocalPlayer():GetViewModel()
			local tbl = vm:GetAttachments()
			if tbl then
				local i = 1
				while i<=#tbl do
					TFAVMAttachments[i] = vm:GetAttachment(i)
					i=i+1
				end
			end
		end
		for k,v in pairs(TFAFlareParts) do
			if v and v.ThinkFunc then
				v:ThinkFunc()
			end
		end
	end)
end

function TFARegPartThink( particle, partfunc )
	if !particle or !partfunc then return end
	particle.ThinkFunc = partfunc
	if IsValid(particle.FollowEnt) and particle.Att then
		local angpos = particle.FollowEnt:GetAttachment(particle.Att)
		if angpos and angpos.Pos then
			particle.OffPos = WorldToLocal(particle:GetPos(),particle:GetAngles(),angpos.Pos,angpos.Ang)
		end
	end
	--[[
	if particle and particle.ThinkFunc then
		particle:ThinkFunc(true)
	end
	]]--
	table.insert(TFAFlareParts,#TFAFlareParts+1,particle)
	timer.Simple( particle:GetDieTime(), function()
		if particle then
			table.RemoveByValue(TFAFlareParts,particle)
		end
	end)

end

function TFAMuzzlePartFunc(self,first)
	if self.isfirst==nil then
		self.isfirst = false
		first = true
	end
	local vm = LocalPlayer():GetViewModel()
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) and wep.IsCurrentlyScoped and wep:IsCurrentlyScoped() then return end
	if IsValid(self.FollowEnt) then
		local owent = self.FollowEnt.Owner or self.FollowEnt
		
		if !IsValid(owent) then return end
		
		local firvel
		
		if first then
			firvel = owent:GetVelocity() * FrameTime() * 1.1
		else
			firvel = vector_origin
		end
		
		if self.Att and self.OffPos then
			if self.FollowEnt == vm then
				local angpos = TFAVMAttachments[self.Att]
				if angpos and angpos.Pos then
					local tmppos = LocalToWorld(self.OffPos,self:GetAngles(),angpos.Pos,angpos.Ang)
					local npos = tmppos+self:GetVelocity()*FrameTime()
					self.OffPos = WorldToLocal(npos + firvel * 0.5,self:GetAngles(),angpos.Pos,angpos.Ang)
					self:SetPos( npos + firvel)
					--[[
					self.PrevAngPos = self.PrevAngPos and self.PrevAngPos or angpos.Pos
					dif = angpos.Pos-self.PrevAngPos
					self:SetPos(self:GetPos()+dif*1)
					self.PrevAngPos = angpos.Pos
					]]--
				end
			else
				local angpos =self.FollowEnt:GetAttachment(self.Att)
				if angpos and angpos.Pos then
					local tmppos = LocalToWorld(self.OffPos,self:GetAngles(),angpos.Pos,angpos.Ang)
					local npos = tmppos+self:GetVelocity()*FrameTime()
					self.OffPos = WorldToLocal(npos + firvel * 0.5,self:GetAngles(),angpos.Pos,angpos.Ang)
					self:SetPos( npos + firvel)
					--[[
					self.PrevAngPos = self.PrevAngPos and self.PrevAngPos or angpos.Pos
					dif = angpos.Pos-self.PrevAngPos
					self:SetPos(self:GetPos()+dif*1)
					self.PrevAngPos = angpos.Pos
					]]--
				end
			end			
		end
	end
end

--[[Efficient Lerp Angle]]--

local normalize = math.NormalizeAngle

function JuckeyLerpAngle(delta, from, to)	
	return LerpAngle(delta,from,to)  --Juckey please, your code was making that weird U thing happen
end

--[[Parti-COOLs]]--

game.AddParticles("particles/tfa_muzzleflashes.pcf")

PrecacheParticleSystem("tfa_muzzle_rifle")

PrecacheParticleSystem("tfa_muzzle_sniper")

PrecacheParticleSystem("tfa_muzzle_m82")

PrecacheParticleSystem("tfa_muzzle_energy")

PrecacheParticleSystem("tfa_muzzle_gauss")

--[[Bow Ammo]]--

game.AddAmmoType({
	name = "tfbow_arrow",
	dmgtype = DMG_CLUB,
	tracer = 0,
	minsplash = 5,
	maxsplash = 5
})

if CLIENT then
	language.Add("tfbow_arrow_ammo","Arrows")
end

--[[Sounds]]--

sound.Add({
	name = 			"TFA.Bash",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			{ "weapons/tfa/bash1.wav", "weapons/tfa/bash2.wav"},
	pitch = { 97, 103 }
})

sound.Add({
	name = 			"TFA.BashWall",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			"weapons/melee/rifle_swing_hit_world.wav",
	pitch = { 97, 103 }
})

sound.Add({
	name = 			"TFA.BashFlesh",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			{ "weapons/melee/rifle_swing_hit_infected7.wav", "weapons/melee/rifle_swing_hit_infected8.wav", "weapons/melee/rifle_swing_hit_infected9.wav", "weapons/melee/rifle_swing_hit_infected10.wav", "weapons/melee/rifle_swing_hit_infected11.wav", "weapons/melee/rifle_swing_hit_infected12.wav" },
	pitch = { 97, 103 }
})

sound.Add({
	name = 			"TFA.IronIn",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			{ "weapons/tfa/ironin.wav" },
	pitch = { 97, 103 }
})

sound.Add({
	name = 			"TFA.IronOut",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			{ "weapons/tfa/ironout.wav" },
	pitch = { 97, 103 }
})

--ATTACHMENTS

TFA_ATT = {}

function TFARegisterAttachment(att)

	local base

	if att.Base then
		base = TFA_ATT[att.Base]
	else
		base = TFA_ATT["base"]
	end
	
	if base then
		for k,v in pairs(base) do
			if !att[k] then att[k] = v end
		end
	end
	
	TFA_ATT[ att.ID or att.Name ] = att

end

TFA_ATTACHMENT_PATH = "tfa/att/"
TFA_ATTACHMENT_ISUPDATING = false

function TFAUpdateAttachments()
	TFA_ATT = {}

	TFA_ATTACHMENT_ISUPDATING = true

	local tbl = file.Find(TFA_ATTACHMENT_PATH.."*base*","LUA","namedesc")
	local addtbl = file.Find(TFA_ATTACHMENT_PATH.."*","LUA","namedesc")
	
	for k,v in ipairs(addtbl) do
		if !string.find(v,"base") then
			table.insert(tbl,#tbl+1,v)
		end
	end
	
	addtbl = nil
	
	for k,v in ipairs(tbl) do
		
		local id = v
		
		v = TFA_ATTACHMENT_PATH .. v
	
		ATTACHMENT = {}
		
		ATTACHMENT.ID = string.Replace(id,".lua","")
		
		if SERVER then
			AddCSLuaFile(v)
			include(v)
		else
			include(v)
		end
		
		if ATTACHMENT.Model and type(ATTACHMENT.Model)=="string" and ATTACHMENT.Model != "" then
			util.PrecacheModel(ATTACHMENT.Model)
		end
		
		TFARegisterAttachment(ATTACHMENT)
		
		ATTACHMENT = nil
	end
	
	TFA_ATTACHMENT_ISUPDATING = false
end
	
hook.Add("InitPostEntity","TFAUpdateAttachmentsIPE", TFAUpdateAttachments)

if TFAUpdateAttachments then
	TFAUpdateAttachments()
end

if SERVER then
	util.AddNetworkString("tfa_att")
	
	net.Receive("tfa_att",function(length,client)
		if IsValid(client) then
			local wep = client:GetActiveWeapon()
			if IsValid(wep) and wep.Attach and wep.Detach then
				local attach = net.ReadBool()
				local attachment = net.ReadString()
				if attach then wep:Attach(attachment,true) else wep:Detach(attachment,true) end
			end
		end
	end)
end

hook.Add("PlayerBindPress","TFA_Attachment_Binds",function(ply,bind,pressed)
	if IsValid(ply) and pressed then
		local first4 = string.sub(bind,1,4)
		if first4=="slot" then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.CLInspectingProgress and wep.CLInspectingProgress>0.1 then
				--print(string.sub(bind,5,6))
				local slotstr = string.sub(bind,5,6)
				if slotstr and wep.Attachments then
					local slotnum = tonumber(slotstr)
					if slotnum then
						local attbl = wep.Attachments[slotnum]
						if attbl and attbl.atts then
						
							local curatt = 0
							local newatt
							
							for k,v in pairs(attbl.atts) do
								if wep.AttachmentCache[v] and wep.AttachmentCache[v].active then
									curatt = k
								end
							end
							
							newatt = curatt+1
							
							if newatt>#attbl.atts+1 then
								newatt = 1
							end
							
							if attbl.atts[curatt] then
								wep:Detach(attbl.atts[curatt])
								net.Start("tfa_att")
								net.WriteBool(false)
								net.WriteString(attbl.atts[curatt])
								net.SendToServer()
							end
							
							if attbl.atts[newatt] then
								wep:Attach(attbl.atts[newatt])
								net.Start("tfa_att")
								net.WriteBool(true)
								net.WriteString(attbl.atts[newatt])
								net.SendToServer()
							end
							
						end
					end
				end
				return true
			end
		end
	end	
end)

--Inspection Blur

local INSPECTION_BACKGROUND = Color(15,15,15,64)
local INSPECTION_PRIMARYCOLOR = Color(245,245,245,255)
local INSPECTION_SECONDARYCOLOR = Color(153,253,220,255)

if CLIENT then
	
	local doblur = CreateClientConVar("cl_tfa_inspection_bokeh", 0, true, false)
	
	local tfablurintensity = 0

	local blur_mat = Material( "pp/bokehblur" )

	local tab = {}
	
	tab[ "$pp_colour_addr" ] 		= 0
	tab[ "$pp_colour_addg" ] 		= 0
	tab[ "$pp_colour_addb" ] 		= 0
	tab[ "$pp_colour_brightness" ] 	= 0
	tab[ "$pp_colour_contrast" ] 	= 1
	tab[ "$pp_colour_colour" ] 		= 1
	tab[ "$pp_colour_mulr" ] 		= 0
	tab[ "$pp_colour_mulg" ] 		= 0
	tab[ "$pp_colour_mulb" ] 		= 0
	
	local function MyDrawBokehDOF()
		if !doblur or !doblur:GetBool() then return end
		
		render.UpdateScreenEffectTexture()

		blur_mat:SetTexture( "$BASETEXTURE", render.GetScreenEffectTexture() )
		blur_mat:SetTexture( "$DEPTHTEXTURE", render.GetResolvedFullFrameDepth() )

		blur_mat:SetFloat( "$size", tfablurintensity*6 )
		blur_mat:SetFloat( "$focus", 0 )
		blur_mat:SetFloat( "$focusradius", 0.1 )

		render.SetMaterial( blur_mat )
		render.DrawScreenQuad()
	
	end

	hook.Add("PreDrawViewModel","PreDrawViewModel_TFA_INSPECT",function()
		tfablurintensity = 0
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		tfablurintensity = (wep.CLInspectingProgress or 0)
		local its = tfablurintensity*10
		if its>0.01 then
			if doblur and doblur:GetBool() then
				MyDrawBokehDOF()
			end
			tab[ "$pp_colour_brightness" ] = -tfablurintensity*0.02
			tab[ "$pp_colour_contrast" ] = 1-tfablurintensity*0.1
			DrawColorModify( tab )
			cam.IgnoreZ(true)
		end
	end)

	hook.Add( "NeedsDepthPass", "NeedsDepthPass_TFA_Inspect", function()
		if !doblur or !doblur:GetBool() then return end
		if tfablurintensity >0.01 then
			DOFModeHack( true )
			return true
		end
		
	end )

	
end

--Hitmarker
	
if SERVER then
	util.AddNetworkString( "tfaHitmarker" )
end

if CLIENT then
	local lasthitmarkertime = -1
	
	local enabledcvar,solidtimecvar,fadetimecvar,scalecvar
	local rcvar,gcvar,gcvar,acvar
	
	local c = Color(255,255,255,255)
	
	local spr
	
	net.Receive("tfaHitmarker",function()
		lasthitmarkertime = CurTime()
	end)
	
	hook.Add("HUDPaint","tfaDrawHitmarker",function()
	
		if !enabledcvar then
			enabledcvar = GetConVar("cl_tfa_hud_hitmarker_enabled")
		end
		
		if enabledcvar and enabledcvar:GetBool() then
			
			if !spr then
				spr = Material("scope/hitmarker")
			end
			
			if !solidtimecvar then
				solidtimecvar = GetConVar("cl_tfa_hud_hitmarker_solidtime")
			end
		
			if !fadetimecvar then
				fadetimecvar = GetConVar("cl_tfa_hud_hitmarker_fadetime")
			end
		
			if !scalecvar then
				scalecvar = GetConVar("cl_tfa_hud_hitmarker_scale")
			end
		
			if !rcvar then
				rcvar = GetConVar("cl_tfa_hud_hitmarker_color_r")
			end
		
			if !gcvar then
				gcvar = GetConVar("cl_tfa_hud_hitmarker_color_g")
			end
		
			if !bcvar then
				bcvar = GetConVar("cl_tfa_hud_hitmarker_color_b")
			end
		
			if !acvar then
				acvar = GetConVar("cl_tfa_hud_hitmarker_color_a")
			end
		
			local solidtime = solidtimecvar:GetFloat()
			local fadetime = math.max(fadetimecvar:GetFloat(),0.001)
			local s = 0.025*scalecvar:GetFloat()
			
			c.r = rcvar:GetFloat()
			c.g = gcvar:GetFloat()
			c.b = bcvar:GetFloat()
			
			local alpha = math.Clamp(lasthitmarkertime-CurTime()+solidtime+fadetime,0,fadetime)/fadetime
			
			c.a = acvar:GetFloat()*alpha
			
			local w,h = ScrW(),ScrH()
			local sprw,sprh = h*s,h*s
			
			surface.SetDrawColor(c)
			surface.SetMaterial(spr)
			surface.DrawTexturedRect(w/2-sprw/2,h/2-sprh/2,sprw,sprh)
			
		end
	end)

end