
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Awaken = Sound( "ambient/atmosphere/cave_hit5.wav" )

ENT.Coughs = { "ambient/voices/cough1.wav",
"ambient/voices/cough2.wav",
"ambient/voices/cough3.wav",
"ambient/voices/cough4.wav",
"ambient/voices/citizen_beaten3.wav",
"ambient/voices/citizen_beaten4.wav" }

ENT.WaitTime = 5
ENT.KillRadius = 1200
ENT.Damage = 5

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	
	
	self.Entity:EmitSound( self.Awaken, 500, 80 )
	
	self.Timer = CurTime() + self.WaitTime
	self.KillTime = CurTime() + 60
	self.DamageTimer = 0
	
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

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:GetRadiationRadius()

	return 3000
end

function ENT:playerHasGasMask( items )
	for j, i in pairs(items) do
		if i.radProt then
			if ((i.radProt > 0) and i:GetData("equip") == true) then
				return true
			end
		end
		
	end
	return false
end

function ENT:Think()

	if self.Timer > CurTime() then return end
	
	for k,v in pairs( player.GetAll() ) do
	
		local pos = v:GetPos()
		pos.z = self.Entity:GetPos().z
		
		if pos:Distance( self.Entity:GetPos() ) < self.KillRadius then
		
			for i=1,3 do
			
				local vec = Vector( math.random( self.Right.x, self.Left.x ), math.random( self.Right.y, self.Left.y ), self.Entity:GetPos().z )
				
				local trace = {}
				trace.start = vec
				trace.endpos = v:GetPos() + Vector(0,0,30)
				trace.filter = self.Entity
				
				local tr = util.TraceLine( trace )
				
				if tr.Entity == v then//and not v:HasItem( "models/items/combine_rifle_cartridge01.mdl" ) then
				
					v.CoughTimer = v.CoughTimer or 0
					
					if v.CoughTimer < CurTime() then
					
						v:EmitSound( table.Random( self.Coughs ) )
						
						v.CoughTimer = CurTime() + math.Rand( 1.5, 3.0 )
					
					end
					
					if self.DamageTimer < CurTime() and !self:playerHasGasMask( v:GetCharacter():GetInventory():GetItems(true) ) then
					
						local dmg = DamageInfo()
						dmg:SetDamage( self.Damage )
						dmg:SetDamageType( DMG_AIRBOAT )
						dmg:SetAttacker( self.Entity )
						dmg:SetInflictor( self.Entity )
						
						v:TakeDamageInfo( dmg )
						
					end
				
				end
			end
		end
	end
	
	if self.DamageTimer < CurTime() then
	
		self.DamageTimer = CurTime() + 1
	
	end
end
