local conversions = include("cotz_weapon_chands/sh_definitions.lua")
local grips = include("cotz_weapon_chands/cl_grips.lua")
local states = setmetatable({}, {__mode = "k"})

local function cacheBones(hands, boneCount, state)
	local pose = state.grip and state.grip.pose
	local sourceBones = {}
	if pose then
		for bone = 0, state.parent:GetBoneCount() - 1 do
			local name = state.parent:GetBoneName(bone)
			-- The hands' bonemerge only sets up bones carrying this flag; any other source matrix can be stale.
			if name and state.parent:BoneHasFlag(bone, BONE_USED_BY_BONE_MERGE) then sourceBones[name] = bone end
		end
	end

	state.bones = {}
	state.wrists = {}
	state.model = hands:GetModel()
	state.boneCount = boneCount

	for bone = 0, boneCount - 1 do
		local name = hands:GetBoneName(bone) or ""
		local letter, part = name:match("^ValveBiped%.Bip01_([LR])_(.+)$")
		if letter then
			local side = letter == "L" and "left" or "right"
			local source = pose and pose[side] and pose[side][part]
			local entry = {
				index = bone,
				side = side,
				source = source and sourceBones[source.bone],
				localPose = source and source.matrix,
				moveWithGrip = part == "Hand" or part == "Wrist" or part == "Ulna" or part:match("^Finger"),
			}

			state.bones[#state.bones + 1] = entry
			if part == "Hand" then state.wrists[side] = entry end
		end
	end
end

local function getBoneMatrix(hands, parent, bone)
	if bone.source then
		local source = parent:GetBoneMatrix(bone.source)
		if source then return source * bone.localPose end
	end

	return hands:GetBoneMatrix(bone.index)
end

local function gripTranslation(hands, state, side)
	local offset = state.grip and state.grip[side]
	local wrist = state.wrists[side]
	if not offset or not wrist then return end

	local matrix = getBoneMatrix(hands, state.parent, wrist)
	if matrix then
		return matrix * offset - matrix:GetTranslation()
	end
end

local function fitHands(hands, boneCount)
	local state = states[hands]
	if not state or not state.data or not IsValid(state.parent) or hands:GetParent() ~= state.parent then return end

	if state.model ~= hands:GetModel() or state.boneCount ~= boneCount then
		cacheBones(hands, boneCount, state)
	end

	local translations = state.translations
	translations.left = gripTranslation(hands, state, "left")
	translations.right = gripTranslation(hands, state, "right")

	-- Fit in the animated wrist frame so recoil, movement and magazine handling carry the adjustment.
	for _, bone in ipairs(state.bones) do
		local matrix = getBoneMatrix(hands, state.parent, bone)
		local translation = translations[bone.side]

		if matrix then
			if translation and bone.moveWithGrip then
				matrix:SetTranslation(matrix:GetTranslation() + translation)
			end

			matrix:Scale(state.data[bone.side])
			hands:SetBoneMatrix(bone.index, matrix)
		end
	end
end

hook.Add("PreDrawPlayerHands", "cotz/weapon-hands/fit", function(hands, viewModel, _, weapon)
	local hasWeapon = IsValid(weapon)
	local parent = hasWeapon and weapon.CW20Weapon and weapon.CW_VM or viewModel
	if not IsValid(parent) then parent = viewModel end

	local data = hasWeapon and conversions[weapon:GetClass()]
	local active = data and IsValid(parent) and weapon.ViewModel == data.model and parent:GetModel() == data.model
	local state = states[hands]

	if not state and hands.cotzWeaponHandsCallback then
		hands:RemoveCallback("BuildBonePositions", hands.cotzWeaponHandsCallback)
		hands.cotzWeaponHandsCallback = nil
	end

	if not state and active then
		state = {translations = {}}
		states[hands] = state
		hands.cotzWeaponHandsCallback = hands:AddCallback("BuildBonePositions", fitHands)
	end

	if IsValid(parent) and (active or (state and state.data)) and hands:GetParent() ~= parent then
		hands:SetParent(parent)
		hands:AddEffects(EF_BONEMERGE)
	end

	if not state then return end

	if active then
		if state.parent ~= parent or state.data ~= data then state.model = nil end
		state.parent = parent
		state.data = data
		state.grip = grips[data.model]
	elseif state.data then
		state.data = nil
	else
		return
	end

	-- CW has already posed its custom viewmodel for this pass.
	hands:InvalidateBoneCache()
end)
