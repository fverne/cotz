DEFINE_BASECLASS("tfa_nmrih_base")

local lastresortnanim = -2

SWEP.Type = "Melee"

SWEP.LuaShellEject = false

SWEP.Primary.Blunt = false
SWEP.Primary.Damage = 60
SWEP.Primary.Reach = 75
SWEP.Primary.RPM = 60
SWEP.Primary.SoundDelay = 0.2
SWEP.Primary.Delay = 0.35
SWEP.Primary.Window = 0.3

SWEP.Secondary.Blunt = false
SWEP.Secondary.RPM = 45 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 120
SWEP.Secondary.Reach = 70
SWEP.Secondary.SoundDelay = 0.05
SWEP.Secondary.Delay = 0.25

SWEP.Secondary.BashDamage = 25
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashLength = 65
SWEP.Secondary.BashDamageType = DMG_CLUB

SWEP.DisableChambering = true
SWEP.Primary.Motorized = false
SWEP.Primary.Motorized_ToggleBuffer = 0.1 --Blend time to idle when toggling
SWEP.Primary.Motorized_ToggleTime = 1.5 --Time until we turn on/off, independent of the above
SWEP.Primary.Motorized_IdleSound = Sound("Weapon_Chainsaw.IdleLoop") --Idle sound, when on
SWEP.Primary.Motorized_SawSound = Sound("Weapon_Chainsaw.SawLoop") --Rev sound, when on
SWEP.Primary.Motorized_AmmoConsumption_Idle = 100/120 --Ammo units to consume while idle
SWEP.Primary.Motorized_AmmoConsumption_Saw = 100/15 --Ammo units to consume while sawing
SWEP.Primary.Motorized_RPM = 600
SWEP.Primary.Motorized_Damage = 100 --DPS
SWEP.Primary.Motorized_Reach = 60 --DPS

SWEP.Slot = 0
SWEP.DrawCrosshair = false

SWEP.AnimSequences = {
	attack_quick = "Attack_Quick",
	--attack_quick2 = "Attack_Quick2",
	charge_begin = "Attack_Charge_Begin",
	charge_loop = "Attack_Charge_Idle",
	charge_end = "Attack_Charge_End",
	turn_on = "TurnOn",
	turn_off = "TurnOff",
	idle_on = "IdleOn",
	attack_enter = "Idle_To_Attack",
	attack_loop = "Attack_On",
	attack_exit = "Attack_To_Idle"
}

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.Sound = Sound("Weapon_Melee.FireaxeLight")
SWEP.Primary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Light",
	blunt = "Weapon_Melee_Blunt.Impact_Light"
}

SWEP.Secondary.Sound = Sound("Weapon_Melee.FireaxeHeavy")
SWEP.Secondary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Heavy",
	blunt = "Weapon_Melee_Blunt.Impact_Heavy"
}


SWEP.InspectPos = Vector(4.84, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.RunSightsPos = Vector(-2.15, 1.4, 0)
SWEP.RunSightsAng = Vector(-5, -0.301, -5)

--[[ Don't Edit Below ]]--

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return true end
	
	local ib = self.GetBashing and self:GetBashing()
	
	if ib and self.Secondary.BashDamageType == DMG_GENERIC then return true end

	if ( self:GetNWInt("ChargeStatus",2) and self:GetNWBool("On",false) ) or ( tr.MatType!=MAT_FLESH and tr.MatType!=MAT_ALIENFLESH and ( ( self.LastAttackType == 1 and !self.Primary.Blunt ) or ( self.LastAttackType == 2 and !self.Secondary.Blunt ) or ( self.LastAttackType == 3 and self.Primary.BashDamageType==DMG_SLASH ) ) ) then
		util.Decal("ManhackCut",tr.HitPos - tr.HitNormal,tr.HitPos + tr.HitNormal)
		return true
	end
end

SWEP.HitSounds = {
	[-1] = Sound("Weapon_Melee.Impact_Generic"),
	[MAT_METAL] = Sound("Weapon_Melee.Impact_Metal"),
	[MAT_GRATE] = Sound("Weapon_Melee.Impact_Metal"),
	[MAT_COMPUTER] = Sound("Weapon_Melee.Impact_Metal"),
	[MAT_VENT] = Sound("Weapon_Melee.Impact_Metal"),
	[MAT_TILE] = Sound("Weapon_Melee.Impact_Brick"),
	[MAT_WOOD] = Sound("Weapon_Melee.Impact_Wood"),
	[MAT_CONCRETE] = Sound("Weapon_Melee.Impact_Concrete"),
	[MAT_EGGSHELL] = Sound("Weapon_Melee.Impact_Cardboard"),
	[MAT_DEFAULT] = Sound("Weapon_Melee.Impact_Cardboard"),
	[MAT_CLIP] = "",
	[MAT_WARPSHIELD] = ""
}

SWEP.DamageType = DMG_SLASH

SWEP.MuzzleFlashEffect = "" --No muzzle
SWEP.DoMuzzleFlash = false --No muzzle
SWEP.WeaponLength = 1 --No nearwall

SWEP.Primary.Ammo			= ""			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with

SWEP.data 				= {} --No ironsights
SWEP.data.ironsights			= 0 --No ironsights

function SWEP:HitSound(mat,heavy,hitnpc)
	local snd = self.HitSounds[mat]
	if !snd then snd = self.HitSounds[-1] end
	if mat==MAT_FLESH or mat==MAT_ALIENFLESH or hitnpc then
		snd = heavy and self.Secondary.HitSound_Flesh[self.Secondary.Blunt and "blunt" or "sharp"] or self.Primary.HitSound_Flesh[self.Primary.Blunt and "blunt" or "sharp"] 
	end
	if snd and snd!="" then self:EmitSound(snd) end
end

function SWEP:SendWeaponSequence(seq,vm,idledelay,noidle)
	if !vm then vm = self.Owner:GetViewModel() end
	if !IsValid(vm) then return end
	
	local ind = seq
	if self.AnimSequences[seq] then
		ind = self.AnimSequences[seq]
		if type(ind) == "table" then
			math.randomseed(CurTime())
			ind = table.Random(ind)
		end
	end
	
	--[[
	if seq == "idle_on" and self.Primary.Motorized_IdleSound then
		self:StopSound(self.Primary.Motorized_SawSound)
		self:EmitSound(self.Primary.Motorized_IdleSound)
	end
	]]--
	
	if seq == "attack_exit" and self.Primary.Motorized_IdleSound then
		self:StopSound(self.Primary.Motorized_SawSound)
		self:EmitSound(self.Primary.Motorized_IdleSound)
	end
	
	if seq == "attack_enter" and self.Primary.Motorized_SawSound then
		self:StopSound(self.Primary.Motorized_IdleSound)
		self:EmitSound(self.Primary.Motorized_SawSound)
	end
	
	--[[
	if seq == "attack_on" and self.Primary.Motorized_SawSound then
		self:StopSound(self.Primary.Motorized_IdleSound)
		self:EmitSound(self.Primary.Motorized_SawSound)
	end
	]]--
	local seq2 = vm:LookupSequence(ind)
	if !seq2 or seq2<=-1 then return end
	vm:SendViewModelMatchingSequence(seq2)
		
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",ind)
	end
	
	timer.Simple( idledelay and (idledelay - 0.1) or (60/self.Primary.RPM-0.1),function()
		if IsValid(self) and !noidle then
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end)
	
	timer.Simple( idledelay or (60/self.Primary.RPM),function()
		if IsValid(self) then
			if noidle then
				--self:SendWeaponSequence(seq2,vm,idledelay,noidle)
			else
				if lastresortnanim>-2 then
					self:SendWeaponAnim(lastresortnanim)
				end
			end
		end
	end)
		
	self:SetNextIdleAnim(CurTime()+vm:SequenceDuration())
end

SWEP.Callback = {}
SWEP.Callback.Initialize = function(self)
	self.AttackStart = -1
	self.ChargeTransition = false
	self.LastAttackType = -1
	self:SetNWBool("On",false)
	self:SetNWInt("ChargeStatus",0)
	self:SetNWFloat("Clip",math.Clamp(self.Primary.DefaultClip,0,self.Primary.ClipSize))
end
SWEP.Callback.Deploy = function(self)
	self.AttackStart = -1
	self.ChargeTransition = false
	self.LastAttackType = -1
	self:SetNWBool("On",false)
	self:SetNWInt("ChargeStatus",0)
	if self:GetNWBool("On",false) then
		self:EmitSound(self.Primary.Motorized_IdleSound)	
	end
	self:UpdateClip1()
end
SWEP.Callback.Holster = function(self)
	self:StopSound(self.Primary.Motorized_SawSound)	
	self:StopSound(self.Primary.Motorized_IdleSound)
end
SWEP.Callback.OnDrop = function(self)
	self:StopSound(self.Primary.Motorized_SawSound)	
	self:StopSound(self.Primary.Motorized_IdleSound)
end
SWEP.Callback.OnRemove = function(self)
	self:StopSound(self.Primary.Motorized_SawSound)	
	self:StopSound(self.Primary.Motorized_IdleSound)
end

function SWEP:UpdateClip1()
	if !self.oldclip then
		self.oldclip = -1
		self:SetClip1(math.ceil(self:GetNWFloat("Clip",0)))
	end
	local nc = math.ceil(self:GetNWFloat("Clip",0))
	if nc!=self.oldclip then
		self:SetClip1(math.max(nc,0))
		self.oldclip = nc
	end
end

function SWEP:Cough()
	if !self:OwnerIsValid() then return end
	local vm = self.Owner:GetViewModel()
	
	self:StopSound(self.Primary.Motorized_SawSound)	
	self:StopSound(self.Primary.Motorized_IdleSound)
	
	self:SendWeaponSequence("turn_off",vm,-1,true)
	self:SetNWInt("ChargeStatus",1)
	self.ChargeTransition = true
	
	timer.Simple( 0.2,function()
		if IsValid(self) then
			self:SetNWBool("On",false)
		end		
	end)
		
	local waittime = math.max(vm:SequenceDuration() - self.Primary.Motorized_ToggleBuffer,0)
	self:SetNextIdleAnim( CurTime() +  waittime )
	self:SetNextSecondaryFire( CurTime() +  waittime )
	
	timer.Simple(waittime,function()
		if IsValid(self) then
			self:SetNWInt("ChargeStatus",0)
			self.ChargeTransition = false
		end
	end)

end

function SWEP:Reload()
	if !self:OwnerIsValid() then return end
	if !self.Primary.Motorized then return end
	if !self.Owner:KeyPressed(IN_RELOAD) then return end
	if self.Owner:KeyDown(IN_ATTACK) then return end
	if ( self:GetNWInt("ChargeStatus",0)>0 ) or self.ChargeTransition or self:GetNextSecondaryFire()>CurTime() then return end
	local am = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
	if !self:GetNWBool("On",false) then
		if am<=0 and self:GetNWFloat("Clip",0)<=0 then return end
		local ammototake = math.max(math.min(am,self.Primary.ClipSize-self:GetNWFloat("Clip",0)),0)
		self:SetNWFloat("Clip",self:GetNWFloat("Clip",0)+ammototake)
		self.Owner:SetAmmo(am-ammototake,self:GetPrimaryAmmoType())
	end
	
	
	local vm = self.Owner:GetViewModel()
	if (CLIENT and IsFirstTimePredicted()) or SERVER then
		if self.ChargeTransition or self:GetNWInt("ChargeStatus",0)>0 then return end
		local on = self:GetNWBool("On",false)
		local ind = on and "turn_off" or "turn_on"
		self:SendWeaponSequence(ind,vm,-1,true)
		self:SetNWInt("ChargeStatus",1)
		self.ChargeTransition = true
		local waittime = math.max(vm:SequenceDuration() - self.Primary.Motorized_ToggleBuffer,0)
		self:SetNextIdleAnim( CurTime() +  waittime )
		self:SetNextSecondaryFire( CurTime() +  waittime )
		
		timer.Simple(waittime,function()
			if IsValid(self) then
				self:SetNWInt("ChargeStatus",0)
				self.ChargeTransition = false	
				if !on then
					self:SendWeaponSequence( "idle_on",vm,math.huge,false)
					self:EmitSound(self.Primary.Motorized_IdleSound)
				else
					self:StopSound(self.Primary.Motorized_SawSound)	
					self:StopSound(self.Primary.Motorized_IdleSound)				
				end
			end
		end)
		
		timer.Simple( on and 0.2 or self.Primary.Motorized_ToggleTime,function()
			if IsValid(self) then
				self:SetNWBool("On",!on)
			end		
		end)
		
		self:SetNextSecondaryFire(CurTime()+vm:SequenceDuration())
	end
end

function SWEP:PrimaryAttack()
	if !self:OwnerIsValid() then return end
	
	if self:GetInspecting() then return end
	
	if (CLIENT and IsFirstTimePredicted()) or SERVER then
		if self:GetNWInt("ChargeStatus",0)>0 or self.ChargeTransition or self:GetNextSecondaryFire()>CurTime() or self:GetBashing() then return end
		--if self:GetShooting() or self.Owner:KeyPressed(IN_ATTACK) then-- and self:GetNextPrimaryFire()<=CurTime() and !self:GetSprinting() then
		if self.AttackStart == -1 then
			self.AttackStart = CurTime()
		end
	end
	hook.Run("WeaponFired", self.Owner)
end

function SWEP:SecondaryAttack()
	
end

function SWEP:Think()
	if !self:OwnerIsValid() then return end
	if self.Callback and self.Callback.Think then self.Callback.Think(self) end
	local vm = self.Owner:GetViewModel()
	if (CLIENT and IsFirstTimePredicted()) or SERVER then
		if !self.AttackStart then self.AttackStart = -1 end
		if self:GetNWBool("On",false) then
			if vm:GetSkin()!=1 then vm:SetSkin(1) end
			self.AttackStart = -1
			local cs = self:GetNWInt("ChargeStatus",0)
			
			if self:GetNWFloat("Clip",0)<=0 and !self.ChargeTransition then
				self:Cough()
			end
			
			if !self:GetBashing() then
				
				if cs==0 and self.Owner:KeyDown(IN_ATTACK) then
					self:SetNWInt("ChargeStatus",1)
					cs = 1
					self.ChargeTransition = true
					self:SendWeaponSequence("attack_enter",vm,math.huge,false)
					local waittime = math.max(vm:SequenceDuration()-0.1,0)
					self:SetNextIdleAnim( CurTime() +  waittime )
					timer.Simple(waittime,function()
						if IsValid(self) then
							self:SetNWInt("ChargeStatus",2)
							self.ChargeTransition = false
							self:SendWeaponSequence( "attack_loop",vm,math.huge,false)
						end
					end)
				end
				
				if cs==2 and !self.Owner:KeyDown(IN_ATTACK) then
					self:SetNWInt("ChargeStatus",1)
					cs = 1
					self.ChargeTransition = true
					self:SendWeaponSequence("attack_exit",vm,math.huge,false)
					local waittime = math.max(vm:SequenceDuration()-0.1,0)
					self:SetNextIdleAnim( CurTime() +  waittime )
					timer.Simple(waittime,function()
						if IsValid(self) then
							self:SetNWInt("ChargeStatus",0)
							self.ChargeTransition = false
							self:SendWeaponSequence( "idle_on",vm,math.huge,false)
						end
					end)
				end
				
				if CurTime()>=self:GetNextIdleAnim()-0.05 and cs!=1 then
					self:SendWeaponSequence( (cs == 2) and "attack_loop" or "idle_on",vm,math.huge,false)
					self:SetNextIdleAnim( CurTime() + vm:SequenceDuration() )
				end
				
				if cs==2 and self:GetNextSecondaryFire()<=CurTime() and self.Owner:KeyDown(IN_ATTACK) then
					self:MotorSlash()
				end
			
			end
			
			self:SetNWFloat("Clip",self:GetNWFloat("Clip",100)-FrameTime()*(cs==2 and self.Primary.Motorized_AmmoConsumption_Saw or self.Primary.Motorized_AmmoConsumption_Idle ) )
			
			self:UpdateClip1()
			
			return
		else
			if vm:GetSkin()!=0 then vm:SetSkin(0) end		
		end
		if self:GetInspecting() then
			self:SetNWInt("ChargeStatus", 0)
			self.AttackStart = -1
			return
		end
		if self.AttackStart != -1 then
			if !self.ChargeTransition then
				local t = CurTime() - self.AttackStart
				if t<self.Primary.Window then
					if self.Owner:KeyReleased(IN_ATTACK) then
						self.LastAttackType = 1
						self.AttackStart = -1
						if self.AnimSequences.attack_quick2 and math.random(1,2)==1 then
							self:SendWeaponSequence("attack_quick2",vm)
						else
							self:SendWeaponSequence("attack_quick",vm)
						end
						self.Owner:SetAnimation( PLAYER_ATTACK1 )
						self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
						self:SetShooting(true)
						self:SetShootingEnd(CurTime()+vm:SequenceDuration())
						self:SetNextSecondaryFire(CurTime()+60/self.Primary.RPM)
						
						timer.Simple(self.Primary.SoundDelay,function()
							if !IsValid(self) or !self:OwnerIsValid() then return end
							self:EmitSound(self.Primary.Sound)
						end)
						
						timer.Simple(self.Primary.Delay,function()
							if !IsValid(self) or !self:OwnerIsValid() then return end
							self:PrimarySlash()
						end)
						
					end
				else
					if self:GetNWInt("ChargeStatus",0) == 0  then
						self:SendWeaponSequence("charge_begin",vm,math.huge)
						self.ChargeTransition = true
						self:SetNextIdleAnim( CurTime() + vm:SequenceDuration())
						self:SetNWInt("ChargeStatus", 1)
						
						timer.Simple(vm:SequenceDuration(),function()
							if !IsValid(self) or !self:OwnerIsValid() then return end
							self.ChargeTransition = false
							self:SetNWInt("ChargeStatus", 2)
						end)
						
					elseif self:GetNWInt("ChargeStatus",0) == 2 then
						if !self.Owner:KeyDown(IN_ATTACK) then
						
							self.LastAttackType = 2
							self.AttackStart = -1
							self:SendWeaponSequence("charge_end",vm,math.huge)
							self.Owner:SetAnimation( PLAYER_ATTACK1 )
							self.ChargeTransition = false							
							self:SetNextIdleAnim( CurTime() + vm:SequenceDuration() )
							self:SetNextSecondaryFire(CurTime()+60/self.Secondary.RPM)
							self:SetNWInt("ChargeStatus", 0)
							
							self:SetShooting(true)
							self:SetShootingEnd(CurTime()+vm:SequenceDuration())
							
							timer.Simple(self.Secondary.SoundDelay,function()
								if !IsValid(self) or !self:OwnerIsValid() then return end
								self:EmitSound(self.Secondary.Sound)
							end)
							
							timer.Simple(self.Secondary.Delay,function()
								if !IsValid(self) or !self:OwnerIsValid() then return end
								self:SecondarySlash()
							end)
							
						elseif CurTime()>self:GetNextIdleAnim() then
							self:SendWeaponSequence("charge_loop",vm,math.huge)
							self:SetNextIdleAnim( CurTime() + vm:SequenceDuration() )
						end
					end
				end
			end
		end
	end
end

function SWEP:PrimarySlash()
	if !self.meleedmgcvar then
		self.meleedmgcvar = GetConVar("sv_tfa_nmrih_melee_multiplier")
	end
	
	self.Owner.tmpdmgtype = self.Primary.Blunt and DMG_CLUB or DMG_SLASH
	
	local pain = self.Primary.Damage * math.Rand(0.9,1.1)
	
	if self.meleedmgcvar then pain = pain * self.meleedmgcvar:GetFloat() end
	
	if game.GetTimeScale()>0.99 then
		self.Owner:FireBullets({
			Attacker = self.Owner,
			Inflictor = self,
			Damage = pain,
			Force = pain*0.3,
			Distance = self.Primary.Reach,
			HullSize = 10,
			Tracer = 0,
			Src = self.Owner:GetShootPos(),
			Dir = self.Owner:EyeAngles():Forward(),
			Callback = function(a,b,c)
				if b and IsValid(self) then
					self:HitSound(b.MatType,false,b.Entity:IsNPC() or b.Entity:IsPlayer())
					--self:ApplyForce(b.Entity,self.Primary.Damage,b.HitPos,b.PhysicsBone)
				end
				if c then c:SetDamageType(a.tmpdmgtype or DMG_SLASH) end
			end
		})
	else
		self.Owner:LagCompensation(true)
		local pos = self.Owner:GetShootPos()
		local slash = {}
		slash.start = pos
		slash.endpos = pos + (self.Owner:EyeAngles():Forward() * self.Primary.Reach)
		slash.filter = self.Owner
		slash.mins = Vector(-10, -5, 0)
		slash.maxs = Vector(10, 5, 5)
		local slashtrace = util.TraceHull(slash)
		if slashtrace.Hit then
			if !slashtrace.HitSky then self:HitSound(slashtrace.MatType,false,slashtrace.Entity:IsNPC() or slashtrace.Entity:IsPlayer()) end
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.Owner:GetShootPos())
			dmg:SetDamageForce(self.Owner:GetAimVector()*(pain*0.25))
			dmg:SetDamage(pain)
			dmg:SetDamageType(DMG_SLASH)
			slashtrace.Entity:TakeDamageInfo(dmg)
			self:ApplyForce(slashtrace.Entity,pain,slashtrace.HitPos,slashtrace.PhysicsBone)
		end
		self.Owner:LagCompensation(false)
	end
end

function SWEP:MotorSlash()
	if !self.meleedmgcvar then
		self.meleedmgcvar = GetConVar("sv_tfa_nmrih_melee_multiplier")
	end
	
	local delta = 60/self.Primary.Motorized_RPM
	
	self:SetNextSecondaryFire(CurTime()+delta)
	
	self.Owner.tmpdmgtype = self.Primary.Blunt and DMG_CLUB or DMG_SLASH
	local pain = self.Primary.Motorized_Damage * delta
	
	if self.meleedmgcvar then pain = pain * self.meleedmgcvar:GetFloat() end
	
	if game.GetTimeScale()>0.99 then
		self.Owner:FireBullets({
			Attacker = self.Owner,
			Inflictor = self,
			Damage = pain,
			Force = pain*0.3,
			Distance = self.Primary.Motorized_Reach,
			HullSize = 10,
			Tracer = 0,
			Src = self.Owner:GetShootPos(),
			Dir = self.Owner:EyeAngles():Forward(),
			Callback = function(a,b,c)
				--if b and IsValid(self) then
				--	self:HitSound(b.MatType,false,b.Entity:IsNPC() or b.Entity:IsPlayer())
					--self:ApplyForce(b.Entity,self.Primary.Damage,b.HitPos,b.PhysicsBone)
				--end
				if c then c:SetDamageType(bit.bor(DMG_SLASH,DMG_ALWAYSGIB)) end
			end
		})
	else
		self.Owner:LagCompensation(true)
		local pos = self.Owner:GetShootPos()
		local slash = {}
		slash.start = pos
		slash.endpos = pos + (self.Owner:EyeAngles():Forward() * self.Primary.Motorized_Reach)
		slash.filter = self.Owner
		slash.mins = Vector(-10, -5, 0)
		slash.maxs = Vector(10, 5, 5)
		local slashtrace = util.TraceHull(slash)
		if slashtrace.Hit then
			--if !slashtrace.HitSky then self:HitSound(slashtrace.MatType,false,slashtrace.Entity:IsNPC() or slashtrace.Entity:IsPlayer()) end
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.Owner:GetShootPos())
			dmg:SetDamageForce(self.Owner:GetAimVector()*(pain*0.25))
			dmg:SetDamage(pain)
			dmg:SetDamageType(bit.bor(DMG_SLASH,DMG_ALWAYSGIB))
			slashtrace.Entity:TakeDamageInfo(dmg)
			self:ApplyForce(slashtrace.Entity,pain,slashtrace.HitPos,slashtrace.PhysicsBone)
		end
		self.Owner:LagCompensation(false)
	end
end

function SWEP:SecondarySlash()
	if !self.meleedmgcvar then
		self.meleedmgcvar = GetConVar("sv_tfa_nmrih_melee_multiplier")
	end
	
	self.Owner.tmpdmgtype = self.Secondary.Blunt and DMG_CLUB or DMG_SLASH
	
	local pain = self.Secondary.Damage * math.Rand(0.9,1.1)
	
	if self.meleedmgcvar then pain = pain * self.meleedmgcvar:GetFloat() end
	
	if game.GetTimeScale()>0.99 then
		self.Owner:FireBullets({
			Attacker = self.Owner,
			Inflictor = self,
			Damage = pain,
			Force = pain*0.1,
			Distance = self.Secondary.Reach,
			HullSize = 10,
			Tracer = 0,
			Src = self.Owner:GetShootPos(),
			Dir = self.Owner:EyeAngles():Forward(),
			Callback = function(a,b,c)
				if b and IsValid(self) then self:HitSound(b.MatType,true,b.Entity:IsNPC() or b.Entity:IsPlayer()) end
				if c then c:SetDamageType(a.tmpdmgtype or DMG_SLASH) end
			end
		})
	else
		self.Owner:LagCompensation(true)
		local pos = self.Owner:GetShootPos()
		local slash = {}
		slash.start = pos
		slash.endpos = pos + (self.Owner:EyeAngles():Forward() * self.Secondary.Reach)
		slash.filter = self.Owner
		slash.mins = Vector(-10, -5, 0)
		slash.maxs = Vector(10, 5, 5)
		local slashtrace = util.TraceHull(slash)
		if slashtrace.Hit then
			if !slashtrace.HitSky then self:HitSound(slashtrace.MatType,true,slashtrace.Entity:IsNPC() or slashtrace.Entity:IsPlayer()) end
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.Owner:GetShootPos())
			dmg:SetDamageForce(self.Owner:GetAimVector()*(pain*0.25))
			dmg:SetDamage(pain)
			dmg:SetDamageType(self.Owner.tmpdmgtype)
			slashtrace.Entity:TakeDamageInfo(dmg)
			self:ApplyForce(slashtrace.Entity,pain,slashtrace.HitPos,slashtrace.PhysicsBone)
		end
		self.Owner:LagCompensation(false)
	end
end

function SWEP:ApplyForce(ent,dmg,pos,physbone)
	if IsValid(ent) and ent.GetPhysicsObject then
		
		local phys
		
		if ent:IsRagdoll() then
			phys = ent:GetPhysicsObjectNum(physbone or 0)
		else						
			phys = ent:GetPhysicsObject()
		end
		
		if IsValid(phys) then
			if ent:IsPlayer() or ent:IsNPC() then
				ent:SetVelocity(ent:GetVelocity()+self.Owner:GetAimVector()*math.sqrt(dmg)*100)
				phys:SetVelocity(phys:GetVelocity()+self.Owner:GetAimVector()*math.sqrt(dmg)*100)
			else
				phys:ApplyForceOffset(self.Owner:GetAimVector()*math.sqrt(dmg),pos)
			end
		end
	end
end
/*
function SWEP:AltAttack()
	if !self:OwnerIsValid() then return end

	if ( self:GetHolstering() ) then
		if (self.ShootWhileHolster==false) then
			return
		else
			self:SetHolsteringEnd(CurTime()-0.1)
			self:SetHolstering(false)
		end
	end
	
	if ( self:GetNWInt("ChargeStatus",0)>0 ) or self.ChargeTransition or self:GetNextSecondaryFire()>CurTime() then return end
	
	if (self:GetReloading() and self.Shotgun and !self:GetShotgunPumping() and !self:GetShotgunNeedsPump()) then
		self:SetShotgunCancel( true )
		--[[
		self:SetShotgunInsertingShell(true)
		self:SetShotgunPumping(false)
		self:SetShotgunNeedsPump(true)
		self:SetReloadingEnd(CurTime()-1)
		]]--
		return
	end
	
	if self:IsSafety() then return end
	
	if (self:GetChangingSilence()) then return end
	
	if self:GetNextSecondaryFire()>CurTime() then return end
	
	if self:GetReloading() then
		self:CompleteReload()
	end
	
	local vm = self.Owner:GetViewModel()
	
	--if SERVER then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	--else
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	--end
	
	self.LastAttackType = 3
	self.AttackStart = -1
	
	
	if !game.SinglePlayer() then
		timer.Simple(vm:SequenceDuration()-0.05,function()
			if IsValid(self) and self:OwnerIsValid() then
				if ( self:GetNWInt("ChargeStatus",0)>0 ) or self.ChargeTransition  then return end
				self:SendWeaponAnim(ACT_VM_IDLE)
				if self:GetNWBool("On",false) then
					self:StopSound(self.Primary.Motorized_IdleSound)	
					self:StopSound(self.Primary.Motorized_SawSound)	
					self:EmitSound(self.Primary.Motorized_IdleSound)					
				end
			end
		end)
		
		timer.Simple(vm:SequenceDuration()-0.01,function()
			if IsValid(self) and self:OwnerIsValid() then
				if ( self:GetNWInt("ChargeStatus",0)>0 ) or self.ChargeTransition then return end
				if lastresortnanim>-2 then
					self:SendWeaponAnim(lastresortnanim)
				end
			end
		end)
	end
	
	self.tmptoggle = !self.tmptoggle
	
	self:SetNextPrimaryFire(CurTime()+vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime()+vm:SequenceDuration())
	
	if CLIENT then
		self:EmitSound(self.Secondary.BashSound )
	end
	
	timer.Simple(self.Secondary.BashDelay,function()
		if IsValid(self) and self.OwnerIsValid and self:OwnerIsValid() then
			if (SERVER) then
				local pos = self.Owner:GetShootPos()
				local av = self.Owner:EyeAngles():Forward()
				
				local slash = {}
				slash.start = pos
				slash.endpos = pos + (av * self.Secondary.BashLength)
				slash.filter = self.Owner
				slash.mins = Vector(-10, -5, 0)
				slash.maxs = Vector(10, 5, 5)
				local slashtrace = util.TraceHull(slash)
				local pain = self.Secondary.BashDamage
				
				
				
				if slashtrace.Hit then
					if slashtrace.Entity:GetClass() == "func_door_rotating" or slashtrace.Entity:GetClass() == "prop_door_rotating" then
						local ply = self.Owner
						ply:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(80, 120))
						
						ply.oldname = ply:GetName()
						
						ply:SetName( "bashingpl" .. ply:EntIndex() )
						
						slashtrace.Entity:SetKeyValue( "Speed", "500" )
						slashtrace.Entity:SetKeyValue( "Open Direction", "Both directions" )
						slashtrace.Entity:Fire( "unlock", "", .01 )
						slashtrace.Entity:Fire( "openawayfrom", "bashingpl" .. ply:EntIndex() , .01 )
						
						timer.Simple(0.02, function()
							if IsValid(ply) then
								ply:SetName(ply.oldname)
							end
						end)
						
						timer.Simple(0.3, function()
							if IsValid(slashtrace.Entity) then
								slashtrace.Entity:SetKeyValue( "Speed", "100" )
							end
						end)
						
					end
					self:EmitSound( (slashtrace.MatType == MAT_FLESH or slashtrace.MatType == MAT_ALIENFLESH) and self.Secondary.BashHitSound_Flesh or self.Secondary.BashHitSound  )
					if game.GetTimeScale()>0.99 then
						self.Owner:FireBullets({
							Attacker = self.Owner,
							Inflictor = self,
							Damage = pain,
							Force = pain,
							Distance = self.Secondary.BashLength + 10,
							HullSize = 10,
							Tracer = 0,
							Src = self.Owner:GetShootPos(),
							Dir = slashtrace.Normal,
							Callback = function(a,b,c)
								if c then c:SetDamageType(self.Secondary.BashDamageType) end
							end
						})
					else
						local dmg = DamageInfo()
						dmg:SetAttacker(self.Owner)
						dmg:SetInflictor(self)
						dmg:SetDamagePosition(self.Owner:GetShootPos())
						dmg:SetDamageForce(self.Owner:GetAimVector()*(pain))
						dmg:SetDamage(pain)
						dmg:SetDamageType(self.Secondary.BashDamageType)
						slashtrace.Entity:TakeDamageInfo(dmg)
					end		
					
					local ent = slashtrace.Entity
					self:ApplyForce(ent,self.Secondary.BashDamage,slashtrace.HitPos,slashtrace.PhysicsBone)
				end
			end
		end
	end)
end
*/
function SWEP:ToggleInspect()

	if self.Callback.ToggleInspect then
		local val = self.Callback.ToggleInspect(self)
		if val then return val end
	end
	
	if ( self:GetNWInt("ChargeStatus",0)>0 )or self.ChargeTransition or self:GetNextSecondaryFire()>CurTime() then
		return
	end
	
	if !self:GetIronSights() and self:GetRunSightsRatio()<0.1 and self:GetNearWallRatio()<0.1 and !self:GetDrawing() and !self:GetHolstering() and !self:GetReloading() then
	
		local oldinsp = self:GetInspecting()
		self:SetInspecting(!oldinsp)
		if CLIENT then
			net.Start("tfaInspect")
			net.WriteBool(!oldinsp)
			net.SendToServer()
		end
		self:SetNextIdleAnim( CurTime() - 1)
		
	end
end


SWEP.IsKnife = true