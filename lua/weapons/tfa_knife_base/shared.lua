DEFINE_BASECLASS("tfa_gun_base")

SWEP.Primary.RPM = 120 --Primary Slashs per minute
SWEP.Secondary.RPM = 60 --Secondary stabs per minute

SWEP.SlashDelay = 0.15 --Delay for Slash (primary)
SWEP.StabDelay = 0.33 --Delay for stab (secondary)

SWEP.SlashLength = 32
SWEP.StabLength = 24

SWEP.Primary.Sound	= Sound("Weapon_Knife.Slash") --Sounds
SWEP.KnifeShink = ("Weapon_Knife.HitWall") --Sounds
SWEP.KnifeSlash = ("Weapon_Knife.Hit") --Sounds
SWEP.KnifeStab = ("Weapon_Knife.Stab") --Sounds

SWEP.SlashTable = { "midslash1", "midslash2" } --Table of possible slash sequences
SWEP.StabTable = { "stab" } --Table of possible slash sequences
SWEP.StabMissTable = { "stab_miss" } --Table of possible slash sequences

SWEP.DisableIdleAnimations = false --Enable idles

--[[ Don't Edit Below ]]--

SWEP.DamageType = DMG_SLASH

SWEP.MuzzleFlashEffect = "" --No muzzle
SWEP.DoMuzzleFlash = false --No muzzle
SWEP.WeaponLength = 1 --No nearwall

SWEP.Primary.Ammo			= ""			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with

SWEP.data 				= {} --No ironsights
SWEP.data.ironsights			= 0 --No ironsights

SWEP.Callback = {}
SWEP.Callback.Deploy = function(self)
	self.Slash = math.random(1,#self.SlashTable)
	self.StabIndex = math.random(1,#self.SlashTable)
	self.StabMiss = math.random(1,#self.SlashTable)
end

function SWEP:PrimaryAttack()
	vm = self.Owner:GetViewModel()
	--[[self:CanPrimaryAttack()]]--
	if SERVER and self:GetNextPrimaryFire()<CurTime() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			self.Slash = self.Slash + 1
			if self.Slash > #self.SlashTable then
				self.Slash = 1
			end
			
			vm:SendViewModelMatchingSequence(vm:LookupSequence(self.SlashTable[self.Slash]))
			
			if game.SinglePlayer() then
				self:CallOnClient("AnimForce",self.SlashTable[self.Slash])
			end
			
			self.Weapon:EmitSound(self.Primary.Sound)//slash in the wind sound here
			
			timer.Create("cssslash"..self:EntIndex(), self.SlashDelay, 1, function() if not IsValid(self) then return end
				if IsValid(self.Owner) and IsValid(self.Weapon) then 
					self:PrimarySlash() 
				end
			end)

			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
			self.Weapon:SetNextSecondaryFire(CurTime()+1/(self.Primary.RPM/60))
			self:SetShooting(true)
			self:SetShootingEnd(CurTime()+1/(self.Primary.RPM/60)*3)
		end
	end
end

function SWEP:PrimarySlash()

	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	damagedice = math.Rand(.85,1.25)
	pain = self.Primary.Damage * damagedice
	if !pain or pain<=1 then pain = 40 * damagedice end
	self.Owner:LagCompensation(true)
	if IsValid(self.Owner) and IsValid(self.Weapon) then
		if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			local slash = {}
			slash.start = pos
			slash.endpos = pos + (ang * self.SlashLength)
			slash.filter = self.Owner
			slash.mins = Vector(-10, -5, 0)
			slash.maxs = Vector(10, 5, 5)
			local slashtrace = util.TraceHull(slash)
			if slashtrace.Hit then
				if slashtrace.Entity == nil then return end
				if game.GetTimeScale()>0.99 then
					self.Owner:FireBullets({
						Attacker = self.Owner,
						Inflictor = self,
						Damage = pain,
						Force = pain*0.1,
						Distance = self.SlashLength + 10,
						HullSize = 10,
						Tracer = 0,
						Src = self.Owner:GetShootPos(),
						Dir = slashtrace.Normal,
						Callback = function(a,b,c)
							if c then c:SetDamageType(DMG_SLASH) end
						end
					})
				else
					local dmg = DamageInfo()
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					dmg:SetDamagePosition(self.Owner:GetShootPos())
					dmg:SetDamageForce(self.Owner:GetAimVector()*(pain*0.25))
					dmg:SetDamage(pain)
					dmg:SetDamageType(DMG_SLASH)
					slashtrace.Entity:TakeDamageInfo(dmg)
				end
				targ = slashtrace.Entity
				if !(slashtrace.MatType != MAT_FLESH and slashtrace.MatType != MAT_ALIENFLESH ) then
					//find a way to splash a little blood
					self.Weapon:EmitSound(self.KnifeSlash)//stab noise
				else
					self.Weapon:EmitSound(self.KnifeShink)//SHINK!
				end
			end
		end
	end
	self.Owner:LagCompensation(false)
end


function SWEP:SecondaryAttack()
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	vm = self.Owner:GetViewModel()
	if self:GetNextSecondaryFire()<CurTime() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)//stab noise
			local stab = {}
			stab.start = pos
			stab.endpos = pos + (ang * self.StabLength)
			stab.filter = self.Owner
			stab.mins = Vector(-10,-5, 0)
			stab.maxs = Vector(10, 5, 5)
			local stabtrace = util.TraceHull(stab)
			if stabtrace.Hit then
				self.StabIndex = self.StabIndex + 1
				if self.StabIndex > #self.StabTable then
					self.StabIndex = 1
				end
				
				vm:SendViewModelMatchingSequence(vm:LookupSequence(self.StabTable[self.StabIndex]))
				
				if game.SinglePlayer() then
					self:CallOnClient("AnimForce",self.StabTable[self.StabIndex])
				end
			else
				self.StabMiss = self.StabMiss + 1
				if self.StabMiss > #self.StabMissTable then
					self.StabMiss = 1
				end
				
				vm:SendViewModelMatchingSequence(vm:LookupSequence(self.StabMissTable[self.StabMiss]))
				
				if game.SinglePlayer() then
					self:CallOnClient("AnimForce",self.StabMissTable[self.StabMiss])
				end
			end
			
			
			
			timer.Create("cssstab"..self:EntIndex(), self.StabDelay, 1 , function() if not IsValid(self) then return end
			if self.Owner and self.Weapon then 
				if IsValid(self.Owner) and IsValid(self.Weapon) then 
					if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then 
						self:Stab() 
					end
				end
			end	
			end)

			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Secondary.RPM/60))
			self.Weapon:SetNextSecondaryFire(CurTime()+1/(self.Secondary.RPM/60))
			self:SetShooting(true)
			self:SetShootingEnd(CurTime()+1.24)
		end
	end
end

function SWEP:Stab()

	pos2 = self.Owner:GetShootPos()
	ang2 = self.Owner:GetAimVector()
	damagedice = math.Rand(.85,1.25)
	pain = self.Secondary.Damage * damagedice
	if !pain or pain<=1 then pain = 100 * damagedice end
	self.Owner:LagCompensation(true)
	local stab2 = {}
	stab2.start = pos2
	stab2.endpos = pos2 + (ang2 * 24)
	stab2.filter = self.Owner
	stab2.mins = Vector(-10,-5, 0)
	stab2.maxs = Vector(10, 5, 5)
	local stabtrace2 =  util.TraceHull(stab2)

	if IsValid(self.Owner) and IsValid(self.Weapon) then
		if self.Owner:Alive() then if self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			if stabtrace2.Hit then
				if stabtrace2.Entity == nil then return end
				
				if game.GetTimeScale()>0.99 then
					self.Owner:FireBullets({
						Attacker = self.Owner,
						Inflictor = self,
						Damage = pain,
						Force = pain*0.1,
						Distance = self.StabLength + 10,
						HullSize = 10,
						Tracer = 0,
						Src = self.Owner:GetShootPos(),
						Dir = stabtrace2.Normal,
						Callback = function(a,b,c)
							if c then c:SetDamageType(DMG_SLASH) end
						end
					})
				else
					local dmg = DamageInfo()
					dmg:SetAttacker(self.Owner)
					dmg:SetInflictor(self)
					dmg:SetDamagePosition(self.Owner:GetShootPos())
					dmg:SetDamageForce(self.Owner:GetAimVector()*(pain*0.25))
					dmg:SetDamage(pain)
					dmg:SetDamageType(DMG_SLASH)
					stabtrace2.Entity:TakeDamageInfo(dmg)
				end
				targ = stabtrace2.Entity
				if !(stabtrace2.MatType != MAT_FLESH and stabtrace2.MatType != MAT_ALIENFLESH ) then
					//find a way to splash a little blood
					self.Weapon:EmitSound(self.KnifeSlash)//stab noise
				else
					self.Weapon:EmitSound(self.KnifeShink)//SHINK!
				end
			end
		end
	end end
	self.Owner:LagCompensation(false)
end

function SWEP:ThrowKnife()
	if !IsFirstTimePredicted() and CLIENT then return end
	
		self.Weapon:EmitSound(self.Primary.Sound)
		if (SERVER) then
			local knife = ents.Create("tfa_thrown_blade")
			if IsValid(knife) then
				knife:SetAngles(self.Owner:EyeAngles())
				knife:SetPos(self.Owner:GetShootPos())
				knife:SetOwner(self.Owner)
				knife:SetModel(self.WorldModel)
				knife:SetPhysicsAttacker(self.Owner)
				knife:Spawn()
				knife:Activate()
				knife:SetNWString("Wep", self.Gun)
				self.Owner:SetAnimation(PLAYER_ATTACK1)
				local phys = knife:GetPhysicsObject()
				phys:SetVelocity(self.Owner:GetAimVector() * 1500)
				phys:AddAngleVelocity(Vector(0, 500, 0))
				self.Owner:StripWeapon(self.Gun)
				
			end
		end
end

function SWEP:Reload()
	self:ThrowKnife()
end

SWEP.IsKnife = true