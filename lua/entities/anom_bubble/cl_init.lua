include('shared.lua')

local Emitter = ParticleEmitter(Vector(0,0,0))

function ENT:Initialize()

	self.Fraction = 0
	self.Size = 80

end

function ENT:Think()

end

function ENT:OnRemove()

	if IsValid( Emitter ) then
		Emitter:Finish()
	end

end

local matRefract = Material( "effects/strider_pinch_dudv" )

function ENT:Draw()

	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 2000) then

		self.Fraction = 0.15 + math.sin( CurTime() ) * 0.15

		matRefract:SetFloat( "$refractamount", self.Fraction )
		
		if render.GetDXLevel() >= 80 then
			render.UpdateRefractTexture()
			render.SetMaterial( matRefract )
			render.DrawQuadEasy( self.Entity:GetPos() + Vector(0,0,5),
						 ( EyePos() - self.Entity:GetPos() ):GetNormal(),
						 self.Size + math.sin( CurTime() ) * 10, self.Size + math.sin( CurTime() ) * 10,
						 Color( 255, 255, 255, 255 ) )
		end
	end
end
