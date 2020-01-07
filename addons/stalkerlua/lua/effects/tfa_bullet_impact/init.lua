function EFFECT:Init( data )
	
	local posoffset = data:GetOrigin()

	local emitter = ParticleEmitter( posoffset )

		for i = 0,5 do
			local p = emitter:Add( "particle/particle_smokegrenade", posoffset )

			p:SetVelocity( math.random(12,16) * math.sqrt(i) * data:GetNormal() * 3 + 2 * VectorRand() )
			p:SetAirResistance(400)

			p:SetStartAlpha( math.Rand( 255, 255 ) )
			p:SetEndAlpha( 0 )
			p:SetDieTime( math.Rand( 0.5, 1.5 ) )

			p:SetStartSize( math.Rand( 5, 8 ) *math.Clamp(i,1,4) * 0.166 )
			p:SetEndSize( math.Rand( 16, 24 ) * math.sqrt(math.Clamp(i,1,4)) * 0.166 )

			p:SetRoll( math.Rand( -25, 25 ) )
			p:SetRollDelta( math.Rand( -0.05, 0.05 ) )

			p:SetColor( 135, 135, 135 )
		end
		
		if GetTFAGasEnabled() then
			local p = emitter:Add( "sprites/heatwave", posoffset )

			p:SetVelocity( 50 * data:GetNormal() + 0.5 * VectorRand() )
			p:SetAirResistance( 200 )

			p:SetStartSize( math.random(12.5,17.5) )
			p:SetEndSize( 2 )
			p:SetDieTime( math.Rand(0.15, 0.225) )


			p:SetRoll( math.Rand(-180,180) )
			p:SetRollDelta( math.Rand(-0.75,0.75) )
		end
		
	emitter:Finish()
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
	return false
end