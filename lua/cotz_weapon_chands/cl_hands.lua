local conversions = include("cotz_weapon_chands/sh_definitions.lua")
local states = setmetatable({}, {__mode = "k"})

local function scaleHands(hands, boneCount)
	local client = LocalPlayer()
	local weapon = client:GetActiveWeapon()
	local data = IsValid(weapon) and conversions[weapon:GetClass()]
	-- Weapons that kept their own viewmodel (Anomaly reskins) need no conversion fitting.
	if data and weapon.ViewModel ~= data.model then data = nil end

	if not data then return end

	local state = states[hands]
	local model = hands:GetModel()

	if state.model ~= model then
		state.model = model
		state.bones = {}

		for bone = 0, boneCount - 1 do
			local name = hands:GetBoneName(bone)
			local side

			if string.StartWith(name, "ValveBiped.Bip01_L_") then
				side = "left"
			elseif string.StartWith(name, "ValveBiped.Bip01_R_") then
				side = "right"
			end

			if side then
				state.bones[#state.bones + 1] = {index = bone, side = side}
			end
		end
	end

	-- Resize the whole arm mesh around its animated joints, preserving grip positions.
	for _, bone in ipairs(state.bones) do
		local matrix = hands:GetBoneMatrix(bone.index)

		if matrix then
			matrix:Scale(data[bone.side])
			hands:SetBoneMatrix(bone.index, matrix)
		end
	end
end

hook.Add("PreDrawPlayerHands", "cotz/weapon-hands/fit", function(hands, viewModel, client, weapon)
	local data = IsValid(weapon) and conversions[weapon:GetClass()]
	local active = data ~= nil and weapon.ViewModel == data.model
	local state = states[hands]

	if not state and active then
		state = {}
		states[hands] = state

		if hands.cotzWeaponHandsCallback then
			hands:RemoveCallback("BuildBonePositions", hands.cotzWeaponHandsCallback)
		end

		hands.cotzWeaponHandsCallback = hands:AddCallback("BuildBonePositions", scaleHands)
	end

	if state then
		if IsValid(weapon) and (active or state.active) then
			local parent = weapon.CW20Weapon and weapon.CW_VM or viewModel

			if IsValid(parent) and hands:GetParent() ~= parent then
				hands:SetParent(parent)
				hands:AddEffects(EF_BONEMERGE)
			end
		end

		if active or state.active ~= active then
			hands:InvalidateBoneCache()
		end

		state.active = active
	end
end)
