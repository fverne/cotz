include('shared.lua')

local ballmat = Material("effects/fastcontrolerball.png")

function ENT:Think()
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 54
		dlight.g = 117
		dlight.b = 136
		dlight.brightness = 8
		dlight.Decay = 100
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.6
	end
end

function ENT:Draw()
	cam.Start3D()
		render.SetMaterial( ballmat )
		render.DrawSprite( self:GetPos() + Vector(math.random(-8,8),math.random(-8,8),math.random(-8,8)), 64, 64, Color(255,255,255,155) )
	cam.End3D()
    //self:DrawModel()
end
