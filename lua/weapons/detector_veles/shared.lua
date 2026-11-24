AddCSLuaFile()

SWEP.Base = "cotz_detector_base"
SWEP.PrintName = "Veles Detector"
SWEP.Author = "COTZ, Subleader, AirBlack and Hobo_Gus"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Slot = 4
SWEP.SlotPos = 5

SWEP.ViewModel = "models/flaymi/stalker/dar_anomaly/weapons/v_models/dev_diolator_detector_3_hud.mdl"
SWEP.WorldModel = "models/flaymi/stalker/dar_anomaly/weapons/w_models/dev_diolator_detector_elite.mdl"

-- Release as the detector starts to recoil in anm_throw_e.
SWEP.BoltReleaseCycle = 4 / 59

-- Like Anomaly's CEliteDetector, the Veles plots every artifact in range on its radar screen.
SWEP.DetectRadius = 400
SWEP.DisplayMode = "screen"

-- Bone-local lifts along the outward normal for the power light and radar screen glows.
SWEP.OverlayLifts = {
	["light_bone_1"] = Vector(0, 0, 0.05),
	["cover_power"] = Vector(0, 0, 0.03),
}
SWEP.ExtraArtifactModels = {
	["models/nasca/etherealsrp_artifacts/compass.mdl"] = true,
	["models/nasca/etherealsrp_artifacts/altered_wheel.mdl"] = true,
	["models/kek1ch/psi_field.mdl"] = true,
}
