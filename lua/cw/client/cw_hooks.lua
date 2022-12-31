function CustomizableWeaponry.InitPostEntity()
	local ply = LocalPlayer()

	CustomizableWeaponry.initCWVariables(ply)
end

hook.Add("InitPostEntity", "CustomizableWeaponry.InitPostEntity", CustomizableWeaponry.InitPostEntity)

function CustomizableWeaponry.PreDrawPlayerHands(hands, viewModel, client, weapon)
	if (weapon.CW20Weapon) then
		hands:AddEffects(EF_BONEMERGE)
		hands:SetParent(weapon.CW_VM)
	end
end

hook.Add("PreDrawPlayerHands", "CustomizableWeaponry.PreDrawPlayerHands", CustomizableWeaponry.PreDrawPlayerHands)