AddCSLuaFile()

SWEP.Base = "cotz_detector_base"
SWEP.PrintName = "Bear Detector"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.ViewModel = "models/flaymi/stalker/dar_anomaly/weapons/v_models/dev_diolator_detector_2_hud.mdl"
SWEP.WorldModel = "models/flaymi/stalker/dar_anomaly/weapons/w_models/dev_diolator_detector_bear.mdl"

-- Like Anomaly's CAdvancedDetector, the Bear's LED segment turns towards the nearest artifact.
SWEP.DetectRadius = 300
SWEP.DisplayMode = "arrow"

-- Bone-local lifts along each light glow's outward normal; the glows sit 0.004-0.027 units above the body.
SWEP.OverlayLifts = {
	["light_bone_1"] = Vector(0, 0, 0.05),
	["light_bone_2"] = Vector(0, 0, 0.05),
	["screen_bone"] = Vector(0, 0.03, 0),
	["screen_bone_1"] = Vector(0, 0.04, 0),
}
