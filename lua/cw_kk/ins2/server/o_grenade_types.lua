
function CustomizableWeaponry.grenadeTypes:createGrenadeEntity(name)
	local pos = self.Owner:GetShootPos()
	local eyeAng = self.Owner:EyeAngles()
	local forward = eyeAng:Forward()
	local offset = forward * 30 + eyeAng:Right() * 4 - eyeAng:Up() * 3

	local nade = ents.Create(name)
	nade:SetPos(pos + offset)
	nade:SetAngles(eyeAng)
	nade:Spawn()
	nade:Activate()
	nade:SetOwner(self.Owner)

	if self.CW_KK_40MM_MDL then
		nade:SetModel(self.CW_KK_40MM_MDL)
		nade:PhysicsDestroy()
		nade:PhysicsInit(SOLID_VPHYSICS)
	end

	local phys = nade:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetVelocity(forward * 2996)
	end
end
