local function pose(bone, angles, position)
	local matrix = Matrix()
	matrix:SetAngles(angles)
	if position then matrix:SetTranslation(position) end

	return {bone = bone, matrix = matrix}
end

return {
	["models/cotz/chands/51c713667a.mdl"] = {
		right = Vector(-0.035, 0.11, 0),
		-- The Beretta's finger bones have generic names and its sleeves use a separate elbow chain.
		pose = {
			left = {
				Clavicle = pose("Right_Bone48", Angle(0, 0, -81.23712)),
				UpperArm = pose("Right_Bone48", Angle(0, 0, 173.73585)),
				Forearm = pose("Right_Bone49", Angle(4.77385, -3.90521, -169.98172)),
				Hand = pose("Right_Bone27", Angle(62.05, 147.4501, 119.59105)),
				Finger4 = pose("Right_Bone28", Angle(0, 0, -123.70888)),
				Finger41 = pose("Right_Bone29", Angle(0, 0, -136.60664)),
				Finger42 = pose("Right_Bone30", Angle(0, 0, -148.50675)),
				Finger3 = pose("Right_Bone32", Angle(0, 0, -126.5309)),
				Finger31 = pose("Right_Bone33", Angle(0, 0, -81.2957)),
				Finger32 = pose("Right_Bone34", Angle(0, 0, -96.35307)),
				Finger2 = pose("Right_Bone36", Angle(0, 0, -120.00947)),
				Finger21 = pose("Right_Bone37", Angle(0, 0, -40.7576)),
				Finger22 = pose("Right_Bone38", Angle(0, 0, -60.91398)),
				Finger1 = pose("Right_Bone40", Angle(0, 0, -63.46263)),
				Finger11 = pose("Right_Bone41", Angle(0, 0, -84.29976)),
				Finger12 = pose("Right_Bone42", Angle(0, 0, -122.0316)),
				Finger0 = pose("Right_Bone44", Angle(0, 0, -150.75008)),
				Finger01 = pose("Right_Bone45", Angle(0, 0, 152.00337)),
				Finger02 = pose("Right_Bone46", Angle(0, 0, -139.13116)),
				Ulna = pose("Right_Bone49", Angle(4.77385, -3.90521, -169.9423), Vector(5.41402, -0.36959, -0.45319)),
				Wrist = pose("Right_Bone27", Angle(-11.34093, -38.84591, 176.93844)),
			},
			right = {
				Clavicle = pose("Left_Bone01", Angle(0, 180, 84.08402)),
				UpperArm = pose("Left_Bone01", Angle(0, 180, -166.77308)),
				Forearm = pose("Left_Bone02", Angle(-4.60684, 178.94269, 175.99009)),
				Hand = pose("Left_Bone05", Angle(-62.04988, -32.55058, -119.11775)),
				Finger4 = pose("Left_Bone18", Angle(0, -180, 112.46571)),
				Finger41 = pose("Left_Bone19", Angle(0, 180, 81.80145)),
				Finger42 = pose("Left_Bone20", Angle(0, 180, 45.42207)),
				Finger3 = pose("Left_Bone14", Angle(0, 180, 103.29652)),
				Finger31 = pose("Left_Bone15", Angle(0, -180, 113.00693)),
				Finger32 = pose("Left_Bone16", Angle(0, -180, 105.81485)),
				Finger2 = pose("Left_Bone10", Angle(0, 180, 103.55944)),
				Finger21 = pose("Left_Bone11", Angle(0, -180, 125.48317)),
				Finger22 = pose("Left_Bone12", Angle(0, -180, 0.44554)),
				Finger1 = pose("Left_Bone06", Angle(0, 180, 92.02697)),
				Finger11 = pose("Left_Bone07", Angle(0, -180, -157.45978)),
				Finger12 = pose("Left_Bone08", Angle(0, -180, -137.57218)),
				Finger0 = pose("Left_Bone22", Angle(0, 180, 134.14712)),
				Finger01 = pose("Left_Bone23", Angle(0, 180, -179.78595)),
				Finger02 = pose("Left_Bone24", Angle(0, -180, 114.139)),
				Ulna = pose("Left_Bone02", Angle(-4.60684, 178.94269, 175.99474), Vector(-5.46715, 0.1009, 0.44061)),
				Wrist = pose("Left_Bone05", Angle(13.15852, 131.26651, -177.77416)),
			},
		},
	},
	["models/cotz/chands/e33ab5d990.mdl"] = {
		left = Vector(-0.18, -0.12, 0.02),
		right = Vector(-0.07, -0.07, -0.04),
	},
	["models/cotz/chands/675694415c.mdl"] = {
		right = Vector(-0.03, 0, -0.09),
		-- FingerN is a palm bone. Source leaves FingerN3 unflagged, so the fingertips follow FingerN2.
		-- The conversion laid both upper arms along the forearms, covering them; these follow the rig's upper arms.
		pose = {
			left = {
				Clavicle = pose("Bip01 L UpperArm", Angle(0, 0, -21.67), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 L UpperArm", Angle(0, 0, -118.339), Vector(-2.039, 0, 0)),
				Hand = pose("Bip01 L Hand", Angle(0.699, -4.105, -169.804), Vector(0.084, -0.041, -0.097)),
				Finger1 = pose("Bip01 L Finger11", Angle(0, 0, -167.485), Vector(-0.015, 0.025, -0.017)),
				Finger11 = pose("Bip01 L Finger12", Angle(-4.729, 4.872, -161.827), Vector(-0.018, 0.084, -0.031)),
				Finger12 = pose("Bip01 L Finger12", Angle(0, 44.765, -158.47), Vector(0.546, 0.132, 0.016)),
				Finger2 = pose("Bip01 L Finger21", Angle(0, 0, -178.525), Vector(-0.022, 0.046, -0.031)),
				Finger21 = pose("Bip01 L Finger22", Angle(-9.377, 22.693, -177.131), Vector(-0.072, 0.175, -0.055)),
				Finger22 = pose("Bip01 L Finger22", Angle(0, 15.301, -172.838), Vector(0.404, 0.373, 0.031)),
				Finger3 = pose("Bip01 L Finger31", Angle(0, 0, 178.205), Vector(-0.036, 0.052, -0.033)),
				Finger31 = pose("Bip01 L Finger32", Angle(-2.159, 21.857, 178.105), Vector(-0.029, 0.207, -0.073)),
				Finger32 = pose("Bip01 L Finger32", Angle(-4.712, 25.71, -178.834), Vector(0.502, 0.42, -0.051)),
				Finger4 = pose("Bip01 L Finger41", Angle(0, 0, 159.643), Vector(-0.039, 0.075, -0.048)),
				Finger41 = pose("Bip01 L Finger42", Angle(5.409, 19.181, 162.023), Vector(0.048, 0.246, -0.131)),
				Finger42 = pose("Bip01 L Finger42", Angle(1.608, 44.245, 169.077), Vector(0.604, 0.439, -0.186)),
			},
			right = {
				Clavicle = pose("Bip01 R UpperArm", Angle(0, 0, -63.702), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 R UpperArm", Angle(0, 0, 47.309), Vector(-2.039, 0, 0)),
			},
		},
	},
	-- The conversion laid both upper arms along the forearms, covering them; these follow the rig's upper arms.
	["models/cotz/chands/a1c272eedb.mdl"] = {
		pose = {
			left = {
				Clavicle = pose("Bip01 L UpperArm", Angle(0, 0, 81.843), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 L UpperArm", Angle(0, 0, -14.417), Vector(-2.039, 0, 0)),
			},
			right = {
				Clavicle = pose("Bip01 R UpperArm", Angle(0, 0, -69.261), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 R UpperArm", Angle(0, 0, 36.502), Vector(-2.039, 0, 0)),
			},
		},
	},
	["models/cotz/chands/a5cd11e4c7.mdl"] = {
		pose = {
			left = {
				Clavicle = pose("Bip01 L UpperArm", Angle(0, 0, 27.817), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 L UpperArm", Angle(0, 0, -68.126), Vector(-2.039, 0, 0)),
			},
			right = {
				Clavicle = pose("Bip01 R UpperArm", Angle(0, 0, -35.334), Vector(-4.039, 0, 0)),
				UpperArm = pose("Bip01 R UpperArm", Angle(0, 0, 66.441), Vector(-2.039, 0, 0)),
			},
		},
	},
	-- The conversion hung the right arm from the wrist joint, pointing the forearm past the muzzle.
	["models/cotz/chands/5b1bec8286.mdl"] = {
		pose = {
			right = {
				Clavicle = pose("j_shoulder_ri", Angle(0.002, 180, -82.483), Vector(2, 0, 0)),
				UpperArm = pose("j_shoulder_ri", Angle(0.002, 180, -122.034), Vector(0, 0, 0)),
				Forearm = pose("j_elbow_ri", Angle(0.002, -179.999, -156.963), Vector(0, 0, 0)),
				Ulna = pose("j_elbow_ri", Angle(0.002, -179.999, -156.959), Vector(-5.781, 0, 0)),
				Wrist = pose("j_wrist_ri", Angle(14.027, -168.427, -165.682), Vector(1.251, -0.018, 0.258)),
			},
		},
	},
	["models/cotz/chands/05ea6d8906.mdl"] = {
		left = Vector(-0.05, 0.12, 0.025),
	},
	["models/cotz/chands/20f646db9e.mdl"] = {
		right = Vector(-0.05, -0.05, -0.2),
	},
	["models/cotz/chands/25f67bd933.mdl"] = {
		right = Vector(-0.1, 0, 0),
	},
	["models/cotz/chands/3098015544.mdl"] = {
		left = Vector(-0.15, -0.1, 0.05),
	},
	["models/cotz/chands/cec299a416.mdl"] = {
		right = Vector(-0.075, 0.05, 0),
	},
	["models/cotz/chands/cd7cec0e41.mdl"] = {
		right = Vector(-0.1, -0.025, -0.05),
	},
	["models/cotz/chands/2f031e2195.mdl"] = {
		left = Vector(-0.3, -0.19, -0.04),
	},
}
