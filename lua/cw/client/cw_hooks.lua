function CustomizableWeaponry.InitPostEntity()
	local ply = LocalPlayer()

	CustomizableWeaponry.initCWVariables(ply)
end

hook.Add("InitPostEntity", "CustomizableWeaponry.InitPostEntity", CustomizableWeaponry.InitPostEntity)

function CustomizableWeaponry.PreDrawPlayerHands(hands, viewModel, client, weapon)
	if IsValid(weapon) and weapon.CW20Weapon and IsValid(weapon.CW_VM) then
		local parent = weapon.CW_VM

		if hands:GetParent() ~= parent then
			hands:AddEffects(EF_BONEMERGE)
			hands:SetParent(parent)
		end

		hands.cotzCWViewModel = parent
		return
	end

	if hands.cotzCWViewModel and IsValid(viewModel) and hands:GetParent() == hands.cotzCWViewModel then
		hands:SetParent(viewModel)
	end

	hands.cotzCWViewModel = nil
end

hook.Add("PreDrawPlayerHands", "CustomizableWeaponry.PreDrawPlayerHands", CustomizableWeaponry.PreDrawPlayerHands)
