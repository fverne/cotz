include('shared.lua')

local Emitter = ParticleEmitter(Vector(0,0,0))

function ENT:Initialize()

	
	self.Timer = CurTime() + 3
	self.DustTimer = 0
	self.Distance = 1200
	self.SpawnTable = {}
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector(1200,1200,0)
	trace.ignoreworld = true 
	local tr = util.TraceLine( trace )
	
	self.Left = trace.start + Vector(1200,1200,0)
	
	if tr.Hit then
	
	--	self.Left = tr.HitPos
	
	end
	
	trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector(-1200,-1200,0)
	trace.ignoreworld = true 
	tr = util.TraceLine( trace )
	
	self.Right = trace.start + Vector(-1200,-1200,0)
	
	if tr.Hit then
	
	--	self.Right = tr.HitPos
	
	end
end

function ENT:Think()

	if self.Timer then
		if self.Timer > CurTime() then return end
	end
	
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then
	
		if self.DustTimer < CurTime() then
		
			self.DustTimer = CurTime() + 0.1
		
			local vec = Vector( math.random( self.Right.x, self.Left.x ), math.random( self.Right.y, self.Left.y ), self.Entity:GetPos().z )
			
			local trace = {}
			trace.start = Vector( math.random( self.Right.x, self.Left.x ), math.random( self.Right.y, self.Left.y ), self.Entity:GetPos().z )
			trace.endpos = Vector( math.random( self.Right.x, self.Left.x ), math.random( self.Right.y, self.Left.y ), self.Entity:GetPos().z - 9000 )
			trace.filter = self.Entity
			
			local tr = util.TraceLine( trace )
			
			local roll = math.random( -360, 360 )
		
			local particle = Emitter:Add( "particle/particle_smokegrenade", tr.HitPos )
			particle:SetDieTime( 10 )
			particle:SetStartAlpha( 0 )
			particle:SetEndAlpha( 150 )
			particle:SetStartSize( math.random( 400, 800 ) )
			particle:SetEndSize( 600 )
			particle:SetRoll( roll )
			particle:SetColor( 150, 150, 100 )
			
			table.insert( self.SpawnTable, { CurTime() + 10, tr.HitPos, roll } )
		
		end
		
		for k,v in pairs( self.SpawnTable ) do
		
			if v[1] <= CurTime() then
			
				local particle = Emitter:Add( "particle/particle_smokegrenade", v[2] )
				particle:SetVelocity( Vector( 0, 0, math.random( -10, 10 ) ) )
				particle:SetDieTime( 10 )
				particle:SetStartAlpha( 150 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 600 )
				particle:SetEndSize( math.random( 400, 800 ) )
				particle:SetRoll( v[3] )
				particle:SetColor( 150, 150, 100 )
				
				table.remove( self.SpawnTable, k )
				
				break
			end
		end
	end	
end

function ENT:OnRemove()

	if IsValid( Emitter ) then
		--Emitter:Finish()
	end
	
end

function ENT:Draw()
end
