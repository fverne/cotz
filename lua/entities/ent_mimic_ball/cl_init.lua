include("shared.lua")

ENT.GlowColor = Color(170, 90, 255)
ENT.GlowSize = 56
ENT.GlowJitter = 10

local WARP_MATERIAL = Material("particles/conc_warp")
local WARP_SIZE = 40

function ENT:Draw()
	self.BaseClass.Draw(self)

	render.SetMaterial(WARP_MATERIAL)
	render.DrawSprite(self:GetPos(), WARP_SIZE, WARP_SIZE, self.GlowColor)
end
