AddCSLuaFile()

SWEP.Base = "cotz_detector_base"
SWEP.PrintName = "Echo Detector"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Slot = 4
SWEP.SlotPos = 1

-- cotz_general ships a copy of the Echo viewmodel with its legend plate lifted off the front
-- panel, which otherwise z-fights. Fall back to the Workshop original when that content is missing.
local FIXED_VIEWMODEL = "models/cotz/chands/dar_anomaly/dev_diolator_detector_1_hud.mdl"
local ORIGINAL_VIEWMODEL = "models/flaymi/stalker/dar_anomaly/weapons/v_models/dev_diolator_detector_1_hud.mdl"

SWEP.ViewModel = file.Exists(FIXED_VIEWMODEL, "GAME") and FIXED_VIEWMODEL or ORIGINAL_VIEWMODEL
SWEP.WorldModel = "models/flaymi/stalker/dar_anomaly/weapons/w_models/dev_diolator_detector_echo.mdl"

-- Release at the peak of the hand flick in anm_throw_e.
SWEP.BoltReleaseCycle = 4 / 40

-- Like Anomaly's CSimpleDetector, the Echo only reports distance: it beeps and flashes its indicator light.
SWEP.DetectRadius = 150
SWEP.DisplayMode = "flash"

-- The Echo viewmodel's first emission bodygroup is blank; the second holds its lights.
SWEP.EmissionBodygroup = 1

-- Bone-local lifts along each light glow's outward normal; the glows sit 0.001-0.005 units above the body.
SWEP.OverlayLifts = {
	["light_bone_1"] = Vector(0, 0, 0.05),
	["light_bone_2"] = Vector(0, 0, -0.05),
	["light_bone_3"] = Vector(0, 0.017, 0.047),
}
