
CustomizableWeaponry_KK.ins2.flashlight.v7 = CustomizableWeaponry_KK.ins2.flashlight.v7 or {}
setmetatable(CustomizableWeaponry_KK.ins2.flashlight.v7, CustomizableWeaponry_KK.ins2.flashlight)

if CLIENT then
	CustomizableWeaponry_KK.ins2.flashlight.v7.white = Color(255,255,255)
	CustomizableWeaponry_KK.ins2.flashlight.v7.texture = "effects/flashlight001"

	function CustomizableWeaponry_KK.ins2.flashlight.v7:Think()
		if true then return end

		local pt = ProjectedTexture()
		pt:SetTexture(self.texture)
		pt:SetEnableShadows(true)
		pt:SetFarZ(2048)
		pt:SetFOV(60)

	end

	hook.Add("Think", CustomizableWeaponry_KK.ins2.flashlight.v7, CustomizableWeaponry_KK.ins2.flashlight.v7.Think)

	function CustomizableWeaponry_KK.ins2.flashlight.v7:elementRender(attBeamSource)
		if not attBeamSource then return end

	end
end

function CustomizableWeaponry_KK.ins2.flashlight.v7:attach(att)
	self:SetNWInt("INS2LAMMode", 0)
end

function CustomizableWeaponry_KK.ins2.flashlight.v7:detach()
end
