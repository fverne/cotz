include('shared.lua')

function ENT:Think()
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetAngles( self:GetUp():Angle() )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 1 )
	effectdata:SetRadius( 6 )
	effectdata:SetColor( 0 )
	effectdata:SetFlags( 0 )
	util.Effect( "AntlionGib", effectdata, true, true )
end

function ENT:Draw()
    //self:DrawModel()
end