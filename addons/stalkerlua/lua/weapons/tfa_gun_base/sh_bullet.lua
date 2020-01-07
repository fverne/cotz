TRACER_FLAG_USEATTACHMENT       = 0x0002;
SWEP.lastbul = nil
SWEP.lastbulnoric = false

--[[ 
Function Name:  cpbullet
Syntax: self:cpbullet( bullet table 1, bullet table 2 ). 
Returns:   Nothing.
Notes:    Copies bullet 2's properties to bullet 1, reducing table count.
Purpose:  Utility
]]--

function cpbullet(tb1, tb2)
	tb1.Num = tb2.Num
	tb1.Src = tb2.Src
	tb1.Dir = tb2.Dir
	tb1.Spread = tb2.Spread
	tb1.Tracer = tb2.Tracer
	tb1.TracerName = tb2.TracerName
	tb1.Force = tb2.Force
	tb1.Damage = tb2.Damage
	tb1.IsFirst = tb2.IsFirst
end

--[[ 
Function Name:  TFBulletCallback
Syntax: self:TFBulletCallback( player, traceresult, damageinfo ). 
Returns:   Nothing.
Notes:    Used to calculate bullet range and call the penetration/ricochet function.  Also used for impact effect(s).
Purpose:  Bullet
]]--

local function TFBulletCallback(a,b,c)
	
	if SERVER and IsValid(a) and a:IsPlayer() and IsValid(b.Entity) and ( b.Entity:IsPlayer() or b.Entity:IsNPC() ) then
		net.Start("tfaHitmarker")
		net.Send(a)
	end
	
	local cary,ply,self=PlayerCarryingTFAWeapon(a)
	
	--print(cary)
	
	if !cary or !IsValid(self) then 
		return
	end
	
	local bul = nil
	
	if self.lastbul then
		bul=self.lastbul
	end
	
	local bulletdistance =  ( ( b.HitPos - b.StartPos ):Length( ) )
	local damagescale = 0
	damagescale = 1-( (bulletdistance-self.Primary.Range*self.Primary.RangeFalloff)/(self.Primary.Range * (1-self.Primary.RangeFalloff)) )
	damagescale = ( 1-GetConVarNumber("sv_tfa_range_modifier",0.5) ) + ( math.Clamp(damagescale,0,1) * GetConVarNumber("sv_tfa_range_modifier",0.5) )
	
	if c then
		c:ScaleDamage(damagescale)
	end
	
	if self.DamageType then
		c:SetDamageType(self.DamageType)
		if c:IsDamageType(DMG_SHOCK) or c:IsDamageType(DMG_BLAST) then
			if b.Hit and IsValid(b.Entity) then
				if b.Entity:GetClass()=="npc_strider" then
					b.Entity:SetHealth(math.max(b.Entity:Health()-c:GetDamage(),2))
					if b.Entity:Health()<=3 then
						b.Entity:Extinguish()
						b.Entity:Fire("sethealth","-1",0.01)
						c:ScaleDamage(0)
					end
				end
			end
		end
		if c:IsDamageType(DMG_BURN) then
			if b.Hit and IsValid(b.Entity) and !b.HitWorld and !b.HitSky then
				if c:GetDamage()>1 then
					if b.Entity.Ignite then
						b.Entity:Ignite(c:GetDamage()/2,1)
					end
				end
			end
		end
		if c:IsDamageType(DMG_BLAST) then
			if b.Hit then
				local tmpdmg = c:GetDamage()
				util.BlastDamage(self,self.Owner,b.HitPos,tmpdmg/2,tmpdmg)
				local fx = EffectData()
				fx:SetOrigin(b.HitPos)
				fx:SetNormal(b.HitNormal)
				if tmpdmg>90 then
					util.Effect("Explosion",fx)
				elseif tmpdmg>45 then
					util.Effect("cball_explode",fx)				
				else
					util.Effect("ManhackSparks",fx)
				end
				c:ScaleDamage(0.15)
			end
		end
	else
		c:SetDamageType(DMG_BULLET)
	end
	
	if bul then
		if bul.IsFirst then
			a.LastBulletHitPos = b.HitPos
		end
		
		bul.IsFirst = false
	
		TFACheckRicochetGateway(self, bul, b)
	end
end

local mainbul = {}

mainbul.Num 		= 1
mainbul.Src 		= Vector(0,0,0)		-- Source
mainbul.Dir 		= Vector(0,0,0)			-- Dir of bullet
mainbul.Spread 	= Vector(0,0,0)			-- Aim Cone
mainbul.Tracer	= 0							-- Show a tracer on every x bullets
mainbul.TracerName = "None"
mainbul.Force	= 0.01
mainbul.Damage	= 0.01
mainbul.Callback = TFBulletCallback
	
local penbul = {}

penbul.Num 		= 1
penbul.Src 		= Vector(0,0,0)		-- Source
penbul.Dir 		= Vector(0,0,0)			-- Dir of bullet
penbul.Spread 	= Vector(0,0,0)			-- Aim Cone
penbul.Tracer	= 0							-- Show a tracer on every x bullets
mainbul.TracerName = "None"
penbul.Force	= 0.01
penbul.Damage	= 0.01
penbul.Callback = TFBulletCallback

local ricbul = {}

ricbul.Num 		= 1
ricbul.Src 		= Vector(0,0,0)		-- Source
ricbul.Dir 		= Vector(0,0,0)			-- Dir of bullet
ricbul.Spread 	= Vector(0,0,0)			-- Aim Cone
ricbul.Tracer	= 0							-- Show a tracer on every x bullets
ricbul.TracerName = "None"
ricbul.Force	= 0.01
ricbul.Damage	= 0.01
ricbul.Callback = TFBulletCallback

--minifunc 

function SWEP:ToggleAkimbo()

	if self.Callback.ToggleAkimbo then
		local val = self.Callback.ToggleAkimbo(self)
		if val then return val end
	end
	
	if self.Akimbo then
		self.AnimCycle = 1-self.AnimCycle
	end

end

--[[ 
Function Name:  ShootBulletInformation
Syntax: self:ShootBulletInformation( ). 
Returns:   Nothing.
Notes:    Used to generate a bullet table which is then sent to self:ShootBullet, and also to call shooteffects.
Purpose:  Bullet
]]--

function SWEP:ShootBulletInformation( ifp )

	if self.Callback.ShootBulletInformation then
		local val = self.Callback.ShootBulletInformation(self, ifp)
		if val then return val end
	end
	
	self.lastbul = nil
	self.lastbulnoric = false
	
	self.ConDamageMultiplier = GetConVar("sv_tfa_damage_multiplier"):GetFloat()
	if (CLIENT and !game.SinglePlayer()) and !ifp then return end
	
	if SERVER and game.SinglePlayer() and self.Akimbo then self:CallOnClient("ToggleAkimbo","") end
	
	self:ToggleAkimbo()

	local CurrentDamage
	local CurrentCone, CurrentRecoil = self:CalculateConeRecoil()
	
	local tmpranddamage = math.Rand(GetConVarNumber("sv_tfa_damage_mult_min",0.95),GetConVarNumber("sv_tfa_damage_mult_max",1.05))
	
	basedamage = self.ConDamageMultiplier * self.Primary.Damage
	CurrentDamage = basedamage * tmpranddamage
	
	--[[
	if self.DoMuzzleFlash and ( (SERVER) or ( CLIENT and !self.AutoDetectMuzzleAttachment ) or (CLIENT and !self:IsFirstPerson() ) ) then
		self:ShootEffects()
	end
	]]--
	
	if !self.AutoDetectMuzzleAttachment then
		self:ShootEffectsCustom( ifp )
	end
	
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
end

--[[ 
Function Name:  ShootBullet
Syntax: self:ShootBullet(damage, recoil, number of bullets, spray cone, disable ricochet, override the generated bullet table with this value if you send it). 
Returns:   Nothing.
Notes:    Used to shoot a bullet.
Purpose:  Bullet
]]--

local soundspeed = 1125.33 * 16

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)

	if self.Callback.ShootBullet then
		local val = self.Callback.ShootBullet(self, damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
		if val then return val end
	end

	if (CLIENT and !game.SinglePlayer()) and !IsFirstTimePredicted() then return end
	
	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0
	
	if self.ProjectileEntity then
		if SERVER then
			local i=0
			local shots = {}
			
			while i<num_bullets do
				local ent = ents.Create(self.ProjectileEntity)
				local dir
				local ang = self.Owner:EyeAngles()
				ang:RotateAroundAxis(ang:Right(),-aimcone/2 + math.Rand(0,aimcone))
				ang:RotateAroundAxis(ang:Up(),-aimcone/2 + math.Rand(0,aimcone))
				dir = ang:Forward()
				ent:SetPos(self.Owner:GetShootPos())
				ent.Owner = self.Owner
				ent:SetAngles(self.Owner:EyeAngles())
				ent.damage = self.Primary.Damage
				ent.mydamage = self.Primary.Damage
				if self.ProjectileModel then
					ent:SetModel(self.ProjectileModel)
				end
				ent:Spawn()
				ent:SetVelocity(dir * self.ProjectileVelocity )
				local phys = ent:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:SetVelocity(dir*self.ProjectileVelocity)
				end
				
				if self.ProjectileModel then
					ent:SetModel(self.ProjectileModel)
				end
				
				ent.Owner = self.Owner
				constraint.NoCollide(ent,self.Owner,0,0)
				
				table.insert(shots,#shots+1,ent)
				
				constraint.NoCollide(ent,self.Owner,0,0)
				i=i+1
			end
			
			for k,v in pairs(shots) do
				for k2,v2 in pairs(shots) do
					if v!=v2 then
						constraint.NoCollide(v,v2,0,0)
					end
				end
			end
			
		end		
	else
		
		local TracerName
		
		if self.Tracer == 1 then
			TracerName = "Ar2Tracer"
		elseif self.Tracer == 2 then
			TracerName = "AirboatGunHeavyTracer"
		else
			TracerName = "Tracer"
		end
		if self.TracerName and self.TracerName != "" then
			TracerName = self.TracerName
		end
		
		mainbul.Attacker 		= self.Owner
		mainbul.Inflictor 		= self
		mainbul.Num 		= num_bullets
		mainbul.Src 		= self.Owner:GetShootPos()			-- Source
		mainbul.Dir 		= self.Owner:GetAimVector()			-- Dir of bullet
		mainbul.HullSize = self.Primary.HullSize or 0
		mainbul.Spread.x=aimcone-- Aim Cone X
		mainbul.Spread.y=aimcone-- Aim Cone Y
		mainbul.Tracer	= self.TracerCount and self.TracerCount or 3		-- Show a tracer on every x bullets
		mainbul.IsFirst = true
		mainbul.AmmoType = self:GetPrimaryAmmoType()
		if self.ProjectileVelocity and self.ProjectileVelocity>0 then
			mainbul.Velocity = self.ProjectileVelocity
		else
			mainbul.Velocity = self.Primary.Velocity or self.Velocity or math.sqrt(self.Primary.Damage/25)*soundspeed
		end
		penbul.Tracer = 0
		penbul.TracerName = ""
		ricbul.Tracer = 0
		ricbul.TracerName = ""
		
		if !self.TracerLua then
			mainbul.TracerName = TracerName
		else
			mainbul.Tracer = 0
			mainbul.TracerName = ""
		end
		
		mainbul.Force	= damage/3 * math.sqrt((self.Primary.KickUp+self.Primary.KickDown+self.Primary.KickHorizontal )) * GetConVarNumber("sv_tfa_force_multiplier",1) * self:GetAmmoForceMultiplier()				-- Amount of force to give to phys objects
		mainbul.Damage	= damage
		
		if bulletoverride then
			cpbullet(mainbul,bulletoverride)
		end
		
		self.lastbul = mainbul
		self.lastbulnoric = disablericochet
		
		if self.CustomBulletCallback then
			mainbul.Callback = self.CustomBulletCallback
		else
			mainbul.Callback = TFBulletCallback
		end
		
		self.Owner:FireBullets(mainbul)
		--ShootPhysicalBullet(mainbul)
		
	end
end

--[[ 
Function Name:  TFACheckRicochetGateway
Syntax: TFACheckRicochetGateway(self, bullet table, traceres). 
Returns:   Nothing.
Notes:    Used to pick up the proper weapon entitity and bullet table and do the ricochet check on it.
Purpose:  Bullet
]]--

function TFACheckRicochetGateway(self, bullet, tr)
	
	--print("ric check gateway")

	if !bullet then
		return
	end
	
	if !self.lastbulnoric then
		if (GetConVarNumber("sv_tfa_bullet_penetration",1)==1 and GetConVarNumber("sv_tfa_bullet_ricochet",1)==0) then
			self:CheckPenetration(bullet, tr)
		elseif GetConVarNumber("sv_tfa_bullet_ricochet",1)==1 then
			self:CheckRicochet(bullet, tr)
		else
			--Nothing
		end
	end
	
end

--[[ 
Function Name:  CheckRicochet
Syntax: self:CheckRicochet(bullet table, traceres). 
Returns:   Nothing.
Notes:    Used to test ricochet and call the penetration function.
Purpose:  Bullet
]]--

function SWEP:CheckRicochet(bullet, tr)

	if self.Callback.CheckRicochet then
		local val = self.Callback.CheckRicochet(self, bullet, tr)
		if val then return val end
	end
	
	--print("ric check")

	if ( CLIENT and !SERVER) and !IsFirstTimePredicted() then return false end
	
	if !tr.Hit or tr.HitSky then return false end
	
	self.PenetrationCounter = self.PenetrationCounter + 1
	if self.PenetrationCounter > self.MaxPenetrationCounter then
		self.PenetrationCounter = 0
		return
	end
		
	local bulletdistance =  ( ( tr.HitPos - tr.StartPos ):Length( ) )
	local damagescale = bulletdistance / self.Primary.Range
	damagescale = math.Clamp(damagescale - self.Primary.RangeFalloff,0,1)
	damagescale = math.Clamp(damagescale / math.max(1-self.Primary.RangeFalloff,0.01),0,1)
	damagescale = ( 1-GetConVarNumber("sv_tfa_range_modifier",0.5) ) + ( math.Clamp(1-damagescale,0,1) * GetConVarNumber("sv_tfa_range_modifier",0.5) )
	
	bullet.Damage = bullet.Damage * damagescale
	bullet.Force = bullet.Force * damagescale
	bullet.IsFirst = false
	
	local matname = self:GetMaterialConcise( tr.MatType )
	local ricochetchance = 1
	local dir = (tr.HitPos-tr.StartPos)
	dir:Normalize()
	local dp =  dir:Dot(tr.HitNormal*-1)
	if matname == "glass" then
		ricochetchance = 0
	elseif matname == "plastic" then
		ricochetchance = 0.01
	elseif matname == "dirt" then
		ricochetchance = 0.01
	elseif matname == "grass" then
		ricochetchance = 0.01
	elseif matname == "sand" then
		ricochetchance = 0.01
	elseif matname == "ceramic" then
		ricochetchance = 0.15
	elseif matname == "metal" then
		ricochetchance = 0.7
	elseif matname == "default" then
		ricochetchance = 0.5
	else
		ricochetchance = 0
	end
	
	ricochetchance = ricochetchance * 0.5 * self:GetAmmoRicochetMultiplier()
	
	local riccbak = ricochetchance / 0.7
	local ricothreshold = 0.6
	ricochetchance = math.Clamp(ricochetchance + ricochetchance * math.Clamp(1-(dp+ricothreshold),0,1) * 0.5,0,1)
	if dp<=ricothreshold then
		if math.Rand(0,1)<ricochetchance then
			cpbullet(ricbul,bullet)
			ricbul.Damage = ricbul.Damage * 0.5
			ricbul.Force = ricbul.Force * 0.5
			ricbul.Num = 1
			ricbul.Spread = vector_origin
			ricbul.Src=tr.HitPos
			ricbul.Dir=((2 * tr.HitNormal * dp) + tr.Normal) + (VectorRand() * 0.02)
			ricbul.Tracer=0--(self.TracerName and self.TracerName!="")
			ricbul.TracerName = ""--self.TracerName or "None"
			ricbul.IsFirst = false
			if GetTFARicochetEnabled() then
				local fx = EffectData()
				fx:SetOrigin(ricbul.Src)
				fx:SetNormal(ricbul.Dir)
				fx:SetMagnitude(riccbak)
				util.Effect("tfa_ricochet",fx)
			end
			
			if IsValid(self) then
				self:ShootBullet(0,0,0,vector_origin,false,ricbul)
			end
			
			return true
		end
	end
	
	if (GetConVarNumber("sv_tfa_bullet_penetration",1)==1) then
		self:CheckPenetration(bullet, tr)
	end
	
	return false
end

--[[ 
Function Name:  CheckPenetration
Syntax: self:CheckPenetration(bullet table, traceres). 
Returns:   Nothing.
Notes:    Used to test penetration.
Purpose:  Bullet
]]--

local TFADecalMats = {
	[MAT_ANTLION] = "Impact.Antlion",
	[MAT_ALIENFLESH] = "Impact.Antlion",
	[MAT_FLESH] = "Impact.BloodyFlesh",
	[MAT_GLASS] = "Impact.Glass",
	[MAT_GRATE] = "Impact.Metal",
	[MAT_METAL] = "Impact.Metal",
	[MAT_VENT] = "Impact.Metal",
	[MAT_COMPUTER] = "Impact.Metal",
	[MAT_SAND] = "Impact.Sand",
	[MAT_WOOD] = "Impact.Wood"
}

function SWEP:CheckPenetration(bullet, tr2)

	if self.Callback.CheckPenetration then
		local val = self.Callback.CheckPenetration(self, bullet, tr2)
		if val then return val end
	end

	--print("pen check")

	if !IsValid(self) or !IsValid(self.Owner) then return false end
	
	local dir=tr2.Normal
	
	dir:Normalize()
	
	local tracelen = 64
	local trace={}
	trace.start = tr2.HitPos + dir*(0.1)
	trace.endpos = tr2.HitPos + dir * tracelen
	trace.mask = MASK_SHOT
	trace.filter = { self.Owner }
	trace.ignoreworld = false
	
	local trt = util.TraceLine(trace)
	
	local solidfraction = trt.FractionLeftSolid * (trt.StartSolid and 1 or 0)
	
	local tr = {}
	tr.StartPos = trace.start
	tr.HitPos = trace.endpos
	tr.Normal = (tr.HitPos - tr.StartPos):GetNormalized()
	tr.Entity = tr2.Entity
	tr.PenetrationPos = tr.StartPos+tr.Normal*tracelen*solidfraction
	if IsValid(tr2.Entity) and not (tr2.HitWorld or tr2.HitSky) then
		local trace2 = {}
		trace2.start = tr.HitPos
		trace2.endpos = tr.StartPos
		trace2.ignoreworld = true
		trace2.mask = MASK_SHOT
		trace2.filter = function (ent)
			if ent!=tr.Entity then
				return false
			end
			return true
		end
		local tr3 = util.TraceLine(trace2)
		tr.PenetrationPos = tr3.HitPos
		solidfraction = ( (tr.PenetrationPos-tr.StartPos):Length() ) / ( (tr.HitPos-tr.StartPos):Length() )
	end
	tr.PenetrationDist = (tr.PenetrationPos-tr.StartPos):Length()
	tr.FractionLeftSolid = solidfraction
	local penetrationdistance = bullet.Force * 0.5
	penetrationdistance = penetrationdistance * self:GetPenetrationMultiplier(tr2.MatType)
	
	if tr.PenetrationDist < penetrationdistance and (tr.HitPos:Distance(tr.PenetrationPos)>0.1) then
		cpbullet(penbul,bullet)
		local mult = 1-math.Clamp( tr.PenetrationDist/penetrationdistance ,0,1)
		local hitpos = tr.PenetrationPos + tr.Normal
		penbul.Damage = (penbul.Damage + penbul.Damage * mult * 2)/3
		penbul.Force = (penbul.Force + penbul.Force * mult * 2)/3
		penbul.Num = 1
		penbul.Spread.x = 0.01
		penbul.Spread.y = 0.01
		penbul.Src=hitpos
		penbul.Dir=bullet.Dir*1
		penbul.Range = 56756
		penbul.Distance = 56756
		penbul.Tracer=self.TracerName and 1 or 0
		penbul.TracerName = self.TracerName or ""
		penbul.IsFirst = false
			
		if GetConVarNumber("cl_tfa_fx_impact_enabled",1)==1 then
			local fx = EffectData()
			fx:SetOrigin(penbul.Src)
			fx:SetNormal(penbul.Dir)
			fx:SetMagnitude(1)
			fx:SetEntity(self)
			util.Effect("tfa_penetrate",fx)
		end
		
		self:ShootBullet(0,0,0,vector_origin,false,penbul)
		
		local trace3 = {}
		trace3.start = hitpos
		trace3.endpos = hitpos + tr2.Normal:GetNormalized() * -16
		trace3.ignoreworld = false
		trace3.mask = MASK_SHOT
		local tr4 = util.TraceLine(trace3)
		if tr4.Hit and tr4.HitPos:Distance(hitpos)<4 then
			penbul.Src = hitpos
			penbul.Dir = tr2.Normal * -1
			penbul.Spread = vector_origin
			penbul.Num = 1
			penbul.Damage = 0
			penbul.Force = 0.01
			penbul.Range = 1
			penbul.Distance = 1
			penbul.Tracer = 0
			penbul.TracerName = "None"
			penbul.IsFirst = false
			self:ShootBullet(0,0,0,vector_origin,true,penbul)
		end
		bullet.IsFirst = false
		return true
	end
	
	return false
end

--[[ 
Function Name:  Recoil
Syntax: self:Recoil( recoil amount ). 
Returns:   Nothing.
Notes:    Used to add recoil to the player owner.
Purpose:  Bullet
]]--

function SWEP:Recoil( recoil, ifp )
	if !IsValid(self) or !IsValid(self.Owner) then return end
	
	math.randomseed(CurTime())
	
	local tmprecoilang = Angle(math.Rand(self.Primary.KickDown,self.Primary.KickUp) * recoil * -1, math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal) * recoil, 0)
	
	local maxdist =   math.min(math.max(0,  89 + self.Owner:EyeAngles().p - math.abs(self.Owner:GetViewPunchAngles().p * 2)),88.5)
	local tmprecoilangclamped = Angle(math.Clamp(tmprecoilang.p,-maxdist,maxdist),tmprecoilang.y,0)
	self.Owner:ViewPunch(tmprecoilangclamped * (1 - self.Primary.StaticRecoilFactor))
	
	--[[
	if SERVER and game.SinglePlayer() and !self.Owner:IsNPC()  then 
		local sp_eyes = self.Owner:EyeAngles()
		local vpa = self.Owner:GetViewPunchAngles()
		--sp_eyes:RotateAroundAxis(sp_eyes:Right(), tmprecoilang.p)
		--sp_eyes:Normalize()
		--sp_eyes:RotateAroundAxis(sp_eyes:Up(), tmprecoilang.y)
		sp_eyes.p = sp_eyes.p + tmprecoilang.p * self.Primary.StaticRecoilFactor
		sp_eyes:Normalize()
		self.Owner:SetEyeAngles(sp_eyes)
	end
	
	if CLIENT and !game.SinglePlayer() and !self.Owner:IsNPC() then
		local tmprecoilang2 = Angle(math.Rand(self.Primary.KickDown,self.Primary.KickUp) * recoil * -1, math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal) * recoil, 0)

		local eyes = self.Owner:EyeAngles()
		--local vpa = self.Owner:GetViewPunchAngles()
		--eyes:RotateAroundAxis(eyes:Right(), tmprecoilang2.p)
		--eyes:Normalize()
		--eyes:RotateAroundAxis(eyes:Up(), tmprecoilang2.y)
		eyes.p = eyes.p + tmprecoilang2.p * self.Primary.StaticRecoilFactor
		eyes:Normalize()
		self.Owner:SetEyeAngles(eyes)
	end
	]]--
	
	if (game.SinglePlayer() and SERVER) or ( CLIENT and ifp ) then
		local neweyeang = self.Owner:EyeAngles() + tmprecoilang*self.Primary.StaticRecoilFactor
		neweyeang.p = math.Clamp(neweyeang.p,-90+math.abs(self.Owner:GetViewPunchAngles().p),90-math.abs(self.Owner:GetViewPunchAngles().p))
		self.Owner:SetEyeAngles( neweyeang )
	end
	
	--[[
	local nvpa = self.Owner:GetViewPunchAngles()
	local overamount = math.abs(self.Owner:EyeAngles().p + nvpa.p)-89
	
	self.Owner:SetViewPunchAngles( Angle(math.Approach(nvpa.p,0,overamount),nvpa.y,nvpa.r) )
	]]--
end