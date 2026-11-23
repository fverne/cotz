local conversions = include("cotz_weapon_chands/sh_definitions.lua")

local function buildBoneTable(self)
	local viewModel = self.CW_VM
	local bones = {}

	for bone = 0, viewModel:GetBoneCount() - 1 do
		local boneName = viewModel:GetBoneName(bone)

		if boneName and boneName ~= "" and boneName ~= "__INVALIDBONE__" then
			-- CW's name lookup can return nil for an enumerated bone. Keep its original numeric index.
			bones[#bones + 1] = {
				boneName = boneName,
				bone = bone,
				curPos = Vector(0, 0, 0),
				curAng = Angle(0, 0, 0),
				targetPos = Vector(0, 0, 0),
				targetAng = Angle(0, 0, 0)
			}
		end
	end

	self.vmBones = bones
end

-- COTZ reskins some guns with Anomaly CW2.0 viewmodels, which already use the player's c_hands.
local ANOMALY_VIEWMODELS = "models/flaymi/anomaly/"

local function applyModels()
	for class, data in pairs(conversions) do
		local weapon = weapons.GetStored(class)

		if weapon and not string.StartWith(weapon.ViewModel or "", ANOMALY_VIEWMODELS) then
			weapon.ViewModel = data.model
			weapon.UseHands = true

			if CLIENT and weapons.IsBasedOn(class, "cw_base") then
				weapon.buildBoneTable = buildBoneTable
			end
		end
	end
end

hook.Add("Initialize", "cotz/weapon-hands/models", applyModels)
hook.Add("InitPostEntity", "cotz/weapon-hands/models", applyModels)
hook.Add("OnReloaded", "cotz/weapon-hands/models", applyModels)
