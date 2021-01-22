AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
ENT.delayTime = 0
ENT.range = 512
ENT.radiationamount = 1
ENT.geigerHeavy = {"geiger/heavy/geiger_heavy_1.wav", "geiger/heavy/geiger_heavy_2.wav", "geiger/heavy/geiger_heavy_3.wav", "geiger/heavy/geiger_heavy_4.wav", "geiger/heavy/geiger_heavy_5.wav", }
ENT.geigerLight = {"geiger/light/geiger_light_1.wav", "geiger/light/geiger_light_2.wav", "geiger/light/geiger_light_3.wav", "geiger/light/geiger_light_4.wav", "geiger/light/geiger_light_5.wav", }

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:OnRemove()
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetPersistent(true)
        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Think()
	if self.delayTime < CurTime() then
		self.delayTime = CurTime() + 0.2
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 2560 )  ) do
			if (v:IsPlayer() and v:GetCharacter() and v:GetMoveType() != MOVETYPE_NOCLIP) then
				if v:GetPos( ):Distance( self:GetPos( ) ) <= self.range then
				
					local TEMP_TargetDamage = DamageInfo()
								
					TEMP_TargetDamage:SetDamage(self.radiationamount)
					TEMP_TargetDamage:SetInflictor(self)
					TEMP_TargetDamage:SetDamageType(DMG_RADIATION)
					TEMP_TargetDamage:SetAttacker(self)

					v:TakeDamageInfo(TEMP_TargetDamage)
					
					if v:hasGeiger() then
						local randomsound = table.Random(self.geigerHeavy)
						v:EmitSound(randomsound)
					end
				elseif v:GetPos( ):Distance( self:GetPos( ) ) <= self.range + 256 then
					if v:hasGeiger() then
						local randomsound = table.Random(self.geigerLight)
						v:EmitSound(randomsound)
					end
				end
			end
		end
	end
end

function ENT:Use( activator, caller, type, value )
end

function ENT:KeyValue( key, value )
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end
