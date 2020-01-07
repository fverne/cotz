ENT.Type 			= "anim"
ENT.PrintName		= "Thrown Blade"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions		= ""
ENT.DoNotDuplicate = true 
ENT.DColDuplicator = true

MAT_DEF = 1

ENT.HitSounds = {
	[MAT_DEF] = {
		Sound("physics/metal/metal_grenade_impact_hard1.wav"),
		Sound("physics/metal/metal_grenade_impact_hard2.wav"),
		Sound("physics/metal/metal_grenade_impact_hard3.wav")	
	},
	[MAT_FLESH] = {
		Sound("physics/flesh/flesh_impact_bullet1.wav"),
		Sound("physics/flesh/flesh_impact_bullet2.wav"),
		Sound("physics/flesh/flesh_impact_bullet3.wav")
	}
}

ENT.Shink = Sound("weapons/blades/impact.mp3")

if SERVER then

	AddCSLuaFile()

	/*---------------------------------------------------------
	   Name: ENT:Initialize()
	---------------------------------------------------------*/
	function ENT:Initialize()
		
		local mdl = self:GetModel()
		
		if !mdl or mdl=="" or string.find(mdl,"error") then
			self:SetModel("models/weapons/w_knife_t.mdl")
		end
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		local phys = self:GetPhysicsObject()
		self:NextThink( CurTime() +  1 )

		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(10)
		end
		
		for k,v in pairs(self.HitSounds) do
		
			for i,o in pairs(v) do
				util.PrecacheSound(o)			
			end
		
		end
		
		local bounds = self:OBBMaxs()-self:OBBMins()
		
		if bounds.z>bounds.x and bounds.z>bounds.y then
			self.up = true
		elseif bounds.y>bounds.x and bounds.y>bounds.z then
			self.right = true
		end
		
		self:SetUseType(SIMPLE_USE)
		
		self:SetOwner(nil)
	end
	
	function ENT:Think()
		
		self.dietime = self.dietime or CurTime() + 30

		if CurTime() > self.dietime then
			self:Remove()
		end
	end
	
	function ENT:DCol()
		self.dietime = CurTime() + 60
		self:GetPhysicsObject():EnableMotion(false)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	end
	
	function ENT:PhysicsCollide(data, phys)
		
		local fwdang = self:GetAngles()
		local fwdvec
		if self.up then
			fwdvec = fwdang:Up()
		elseif self.right then
			fwdvec = fwdang:Right()
		else
			fwdvec = fwdang:Forward()
		end
		
		local ent = data.HitEntity
		if !IsValid(ent) and !(ent and ent:IsWorld() )then return end
		
		local dmg = self:GetNWInt("Damage",40)*math.sqrt(data.Speed/1500)
		
		if dmg>5 and ent and !ent:IsWorld() then
			
			local dmginfo = DamageInfo()
			dmginfo:SetDamage( dmg)
			dmginfo:SetDamagePosition(data.HitPos)
			dmginfo:SetDamageForce(data.OurOldVelocity)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamageType(DMG_SLASH)
			local att = self:GetPhysicsAttacker()
			
			if !IsValid(att) then att = self.Owner end
			if !IsValid(att) then att = self end
			
			dmginfo:SetAttacker(att)
			ent:TakeDamageInfo(dmginfo)
		
		end
		
		local traceres = util.QuickTrace(self:GetPos(),data.OurOldVelocity,self)
		
		if !traceres.HitPos then return end
		
		if data.Speed>50 then
			local soundtbl
				
			if self.HitSounds[traceres.MatType] then
				soundtbl = self.HitSounds[traceres.MatType]
			else
				soundtbl = self.HitSounds[MAT_DEF]
			end
			
			local snd = soundtbl[math.random(1,#soundtbl)]
			
			self:EmitSound( snd )
		end
		
		local dp = traceres.HitNormal:Dot(fwdvec)
		
		if dp>=-0.3 then
			local fx = EffectData()
			fx:SetOrigin(data.HitPos)
			fx:SetMagnitude(1)
			fx:SetScale( ( data.Speed/1500 * (dp+0.6) )/5 )
			util.Effect("Sparks", fx)			
		end
		
		local canstick = data.Speed>250 and dp<(-1 + data.Speed/1000*0.3)
		
		if ent:IsWorld() and canstick then
			
			util.Decal("ManhackCut", traceres.HitPos + traceres.HitNormal, traceres.HitPos - traceres.HitNormal)
			
			self:EmitSound(self.Shink)
			
			self:SetPos(traceres.HitPos + traceres.HitNormal * 12)
			local tmpang = data.HitNormal:Angle()
			tmpang:RotateAroundAxis(tmpang:Right(),270)
			--self:SetAngles(tmpang)
			local fx = EffectData()
			fx:SetOrigin(data.HitPos)
			fx:SetMagnitude(2)
			fx:SetScale( 0.1 )
			util.Effect("Sparks", fx)
			self:DCol()				
		elseif IsValid(ent) then
			
			if not(ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll") then
				if canstick then
					util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
				end
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
			
			if (ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll") then 
				local fx = EffectData()
				fx:SetOrigin(data.HitPos)
				util.Effect("BloodImpact", fx)
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				self:GetPhysicsObject():SetVelocity(-(data.OurOldVelocity / 8))
			end
			
		end
		
		if canstick then
			self:GetPhysicsObject():SetVelocity(-(data.OurOldVelocity / 16))
		end
		
		self:GetPhysicsObject():AddAngleVelocity(-self:GetPhysicsObject():GetAngleVelocity()/3)
	end
	
	function ENT:Use(ply, caller)
		local ow = self.Owner 	
		if !IsValid(ow) then ow = self:GetPhysicsAttacker()end
		if !IsValid(ow) then return end
		if ow != ply then return end
		
		local classname = self:GetNWString("Wep")
		if !classname or classname=="" then return end

		if (ply:IsPlayer()) and ply:GetWeapon(classname) == NULL then
			ply:Give(classname)
			self:Remove()
		end
		
	end

end

if CLIENT then
	function ENT:Draw()

		self:DrawModel()
	end
end
