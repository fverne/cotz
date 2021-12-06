include('shared.lua')

function ENT:Think()
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetAngles( self:GetUp():Angle() )
	effectdata:SetMagnitude( 0.8 )
	effectdata:SetScale( 0.8 )
	effectdata:SetRadius( 0.8 )
	effectdata:SetColor( 0 )
	effectdata:SetFlags( 0 )
	util.Effect( "StriderBlood", effectdata, true, true )
end

function ENT:Draw()
    //self:DrawModel()
end