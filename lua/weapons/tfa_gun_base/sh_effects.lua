local fx,sp

function SWEP:MakeShellBridge()
		--self:MakeShell(self.LuaShellEffect or self.Blowback_Shell_Effect,self.LuaShellEjectDelay)
		
		if self.LuaShellEjectDelay>0 then
			timer.Simple(self.LuaShellEjectDelay, function()
				if IsValid(self) and self:OwnerIsValid() then
					self:MakeShell(ef)					
				end
			end)
		else
			self:MakeShell(ef)
		end
		
end

function SWEP:MakeShell(ef)
	if IsValid(self) and self:OwnerIsValid() then
		local vm = ( !self.Owner.ShouldDrawLocalPlayer or self.Owner:ShouldDrawLocalPlayer() ) and self.Owner:GetViewModel() or self
		if IsValid(vm) then
			local fx = EffectData()
			fx:SetEntity(vm)
			local attid = vm:LookupAttachment(self.ShellAttachment)
			attid = math.Clamp(attid and attid or 2,1,127)
			--[[
			local fx = EffectData()
			fx:SetEntity(vm)
			local attid = vm:LookupAttachment(self.ShellAttachment)
			attid = math.Clamp(attid and attid or 2,1,127)
			fx:SetAttachment(attid)
			local attpos = vm:GetAttachment(attid)
			
			if attpos and attpos.Pos and attpos.Ang and self.ViewModelFlip then
				local localpos = vm:WorldToLocal(attpos.Pos)
				local localang = vm:WorldToLocalAngles(attpos.Ang)
				localpos = localpos * Vector(-1,1,1)
				localang = Angle(localang.p,localang.y+180,localang.r)
				local worldpos = vm:LocalToWorld(localpos)
				local worldang = vm:LocalToWorldAngles(localang)
				attpos.Pos = worldpos
				attpos.Ang = worldang
			end
			
			if attpos and attpos.Pos then
				if game.SinglePlayer() and SERVER then
					fx:SetOrigin(attpos.Pos + self.Owner:GetShootPos() - self.Owner:GetPos() )
				elseif game.SinglePlayer() then
					attpos.Pos = attpos.Pos + Vector(0,0,16)
					print(attpos.Pos)
					debugoverlay.Cross(attpos.Pos,5,5,color_white,true)					
				else
					fx:SetOrigin(attpos.Pos)
				end
				--fx:SetStart(attpos.Pos)
			end
			
			--debugoverlay.Axis(attpos.Pos,attpos.Ang,64,15,true)
				
			if attpos and attpos.Ang then
				fx:SetAngles(attpos.Ang)
				fx:SetNormal(attpos.Ang:Forward())
			end
			
			fx:SetMagnitude(100)
			fx:SetScale(100)
			
			--debugoverlay.Axis( attpos.Pos, attpos.Ang, 15, 5, true)
			util.Effect(ef,fx)
			]]--
			local angpos = vm:GetAttachment(attid)
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetAttachment(attid)
			fx:SetMagnitude(1)
			fx:SetScale(1)
			fx:SetOrigin(angpos.Pos)
			fx:SetNormal(angpos.Ang:Forward())
			util.Effect("tfa_shell",fx)
		end
	end
end


--[[ 
Function Name:  CleanParticles
Syntax: self:CleanParticles(). 
Returns:  Nothing.
Notes:    Cleans up particles.
Purpose:  FX
]]--

function SWEP:CleanParticles()
	if !IsValid(self) then return end
	if self.StopParticles then
		self:StopParticles()
	end
	
	if self.StopParticleEmission then
		self:StopParticleEmission()
	end
	
	if !self:OwnerIsValid() then return end
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		if vm.StopParticles then
			vm:StopParticles()
		end
		if vm.StopParticleEmission then
			vm:StopParticleEmission()
		end
	end
end

--[[ 
Function Name:  EjectionSmoke
Syntax: self:EjectionSmoke(). 
Returns:  Nothing.
Notes:    Puff of smoke on shell attachment.
Purpose:  FX
]]--

function SWEP:EjectionSmoke()
	if !IsValid(self) then return end
	if !self:OwnerIsValid() then return end
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		local att = vm:LookupAttachment(self.ShellAttachment)
		if !att or att<=0 then att = 2 end
		local angpos = vm:GetAttachment(self.ShellAttachment)
		if angpos and angpos.Pos then
			local fx = EffectData()
			fx:SetEntity(vm)
			fx:SetOrigin(angpos.Pos)
			fx:SetAttachment(att)
			fx:SetNormal(angpos.Ang:Forward())
			util.Effect("tfa_shelleject_smoke",fx)
		end
	end
end

--[[ 
Function Name:  ShootEffectsCustom
Syntax: self:ShootEffectsCustom(). 
Returns:  Nothing.
Notes:    Calls the proper muzzleflash, muzzle smoke, muzzle light code.
Purpose:  FX
]]--

function SWEP:ShootEffectsCustom( ifp, tp )
	
	if !sp then sp = game.SinglePlayer() end
	
	if ( SERVER and sp and self.ParticleMuzzleFlash ) or ( SERVER and !sp ) then
		net.Start("tfa_base_muzzle_mp")
		net.WriteEntity(self)
		if (sp) then net.Broadcast() else net.SendOmit(self.Owner) end
	end
	
	--if sp and !CLIENT then self:CallOnClient("ShootEffectsCustom","") return end
	
	if ( CLIENT and ifp ) or (sp) then
	
		local att = math.max(1,self.MuzzleAttachmentRaw or self:LookupAttachment(self.MuzzleAttachment))
		
		if self.Akimbo then
			att = 2-self.AnimCycle
		end
		
		self:CleanParticles()
		
		fx = EffectData()
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:EyeAngles():Forward())
		fx:SetEntity(self)
		fx:SetAttachment( att )
		
		util.Effect("tfa_muzzlesmoke", fx)
			
		if (self:GetSilenced()) then
			util.Effect("tfa_muzzleflash_silenced", fx)
		else
			util.Effect(self.MuzzleFlashEffect or "", fx)
		end
	end
	
end

--[[ 
Function Name:  ShootEffects
Syntax: self:ShootEffects(). 
Returns:  Nothing.
Notes:    --USED TO-- Calls the proper muzzleflash, muzzle smoke, muzzle light code.
Purpose:  FX
]]--
	
local blankvec = Vector(0,0,0)

function SWEP:ShootEffects( )
	
	--if ( ( (CLIENT and !SERVER) and !game.SinglePlayer() ) and !IsFirstTimePredicted() and !self.AutoDetectMuzzleAttachment and !ovrarg ) then print("canceled") return end
	
	--[[
	if game.SinglePlayer() then
		if !self.Owner.ShouldDrawLocalPlayer then
			self:CallOnClient("ShootEffects","")
			return
		end
	end
	]]--
	
	if !self:OwnerIsValid() then return end
	
	--self:MuzzleLight()
	
	local fp =  self:IsFirstPerson()
	local vm = self.Owner:GetViewModel()
	
	self:CleanParticles()
	
	local ht = self.DefaultHoldType and self.DefaultHoldType or self.HoldType
	local tent = self
	local attid = 1
	
	if fp then
		tent = self.Owner:GetViewModel() 
		attid=self:GetFPMuzzleAttachment()--tent:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "muzzle" )
		if self.Akimbo then
			attid = 2-self.AnimCycle
		end
	else
		attid = self:LookupAttachment("muzzle_flash" )
		if attid == 0 then
			attid = self:LookupAttachment(self.MuzzleAttachment )
		end
		if self.MuzzleAttachmentRaw then
			attid = self.MuzzleAttachmentRaw
		end
		if self.Akimbo then
			attid = 2-self.AnimCycle
		end
	end
	
	if attid == 0 then
		attid = 1
	end
	
	if SERVER and !CLIENT and game.SinglePlayer() and self.AutoDetectMuzzleAttachment then
		self:MakeMuzzleSmoke(tent,attid)
		self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
	end
	
	if ( ( CLIENT and !game.SinglePlayer() ) or ( SERVER and game.SinglePlayer() and !self.AutoDetectMuzzleAttachment ) or (CLIENT and self.AutoDetectMuzzleAttachment) or ( self.Akimbo and game.SinglePlayer()  ) and self.DoMuzzleFlash and self.CustomMuzzleFlash ) then
		if !self:IsCurrentlyScoped() then
			if fp then
				self:MakeMuzzleSmoke(tent,attid)
				self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
				--[[
				if false then--self.AttachmentCache[attid] then
					local cach = self.AttachmentCache[attid]
					local tmppos2, tmpang2 = LocalToWorld(cach[1],cach[2],self.Owner:GetShootPos(),self.Owner:EyeAngles())
					self:MakeMuzzleFlash(tmppos2,self.Owner:EyeAngles():Forward(),tent,attid,true,true)
				else
					self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
				end
				]]--
			else
				self:MakeMuzzleSmoke(tent,attid)
				self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
			end
		else
			if fp then
				local temppos = self.Owner:GetShootPos()
				local tempang = self.Owner:EyeAngles()
				temppos:Add( tempang:Forward()*9 )
				temppos:Add( tempang:Up()*(-3) )
				self:MakeMuzzleFlash(temppos,tempang:Forward(),tent,attid,true,true)
			else
				self:MakeMuzzleSmoke(tent,attid)
				self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
			end
		end
	end
	
	tent = self
	attid = self:LookupAttachment("muzzle_flash" )
	if attid == 0 then
		attid = self:LookupAttachment(self.MuzzleAttachment )
	end
	
	if attid == 0 then
		attid = 1
	end
	
	if SERVER and !game.SinglePlayer() then
		--self:MakeMuzzleFlashSV(vector_origin,vector_origin,self,attid,false,false)
		net.Start("tfa_base_muzzle_mp")
		net.WriteEntity(self)
		net.Broadcast()
		--self:CallOnClient("MakeMuzzleFlashMP","MakeMuzzleFlashMP")
	end
	
end

--[[ 
Function Name:  MakeMuzzleFlashMP
Syntax: self:MakeMuzzleFlash( )
Returns:  Nothing.
Notes:    Used to make the muzzle flash effect, clientside, if you don't own the weapon.
Purpose:  FX
]]--

local partcache = {}

function SWEP:MakeMuzzleFlashMP()	
	--[[
	if partcache[fxname] == nil then
		
		partcache[fxname] = false
	
		local fname = "lua/effects/"..fxname.."/shared.lua"
		
		local f = file.Open( fname, "r", "GAME" )
		
		if f then
			local str = f:Read( f:Size() )
			if str and string.find(str,"ParticleEffect") then
				partcache[fxname] = true
			end
		end
	
	end
	
	if partcache[fxname] == false then
		return false
	end
	]]--
	
	self:StopParticles()
	
	local lpl = LocalPlayer()
	
	if lpl==self.Owner then return end
	
	local fp = false
	
	local entity = self
	
	local attachment = self:LookupAttachment("muzzle_flash" )
	
	if attachment == 0 then
		attachment = self:LookupAttachment(self.MuzzleAttachment )
	end
	
	if attachment == 0 then
		attachment = 1
	end
	
	self:MakeMuzzleSmokeSV(attachment)
	
	local ef = EffectData()
	
	ef:SetOrigin(self:GetPos())
	ef:SetEntity(self)
		
	ef:SetStart( Vector( self.Owner:EntIndex(),1,self:EntIndex() ) )
	
	local rpos = entity:GetAttachment(attachment)
	
	local ang = self.Owner:EyeAngles()
	ef:SetNormal(self.Owner:GetAimVector())
	--ef:SetNormal(Angle(math.Clamp(ang.p,-55,55),ang.y,ang.r):Forward())
	

	local fxname = self.MuzzleFlashEffect and self.MuzzleFlashEffect or ""
	
	if (self:GetSilenced()) then
		util.Effect("tfa_muzzleflash_silenced", ef)
	else
		util.Effect(fxname, ef)
	end
	
	if self.TracerLua then
		ef:SetOrigin(self.Owner.LastBulletHitPos and self.Owner.LastBulletHitPos or self.Owner:GetEyeTrace().HitPos)
		
		ef:SetFlags(TRACER_FLAG_USEATTACHMENT)
		
		if math.random(self.TracerCount and self.TracerCount or 0, 1)<=1 and self.TracerCount != 0 then
			timer.Simple(self.TracerDelay and self.TracerDelay or 0, function()
				if IsValid(self) and self.TracerName then
					ef:SetOrigin(self.Owner.LastBulletHitPos and self.Owner.LastBulletHitPos or self.Owner:GetEyeTrace().HitPos)
					util.Effect(self.TracerName,ef)
				end
			end)
		end
	end
	
end


local svflashvec = Vector(1,1,1)

--[[ 
Function Name:  MakeMuzzleFlashSV
Syntax: self:MakeMuzzleFlashSV(position, normal (angle:Up()), attachment id, use the position, use the normal ). 
Returns:  Nothing.
Notes:    Used to make multiplayer muzzleflashes.
Purpose:  FX
]]--

function SWEP:MakeMuzzleFlashSV(pos,normal,ent, attachment, usepos, usenormal)
	
	local entity = ent and ent or self
	
	if !IsValid(self.Owner) then return end
	
	local fp = self:IsFirstPerson()
	
	local ef = EffectData()
	
	ef:SetOrigin(blankvec)
	ef:SetEntity(self)
	
	ef:SetAttachment( attachment )
	
	ef:SetStart( Vector( self.Owner:EntIndex(),1,self:EntIndex() ) )	
	
	local rpos = entity:GetAttachment(attachment)
	
	local ang = self.Owner:EyeAngles()
	ef:SetNormal(Angle(math.Clamp(ang.p,-55,55),ang.y,ang.r):Forward())
	
	if usepos then
		ef:SetOrigin(pos)
	end

	if usenormal then
		ef:SetNormal(normal)
	end
	
	if !self.MuzzleFlashEffect then
		if (self:GetSilenced()) then
			util.Effect("tfa_muzzleflash_silenced", ef)
		else
			local a=string.lower(self.Primary.Ammo)
			if a=="buckshot" or a=="slam" or a=="airboatgun" then
				util.Effect("tfa_muzzleflash_shotgun", ef)
			else
				util.Effect("tfa_muzzleflash_rifle", ef)
			end
		end
	else
		util.Effect(self.MuzzleFlashEffect, ef)
	end
	
	if self.TracerLua then
		ef:SetOrigin(self.Owner.LastBulletHitPos and self.Owner.LastBulletHitPos or self.Owner:GetEyeTrace().HitPos)
		
		ef:SetFlags(TRACER_FLAG_USEATTACHMENT)
		
		if math.random(self.TracerCount and self.TracerCount or 0, 1)<=1 and self.TracerCount != 0 then
			timer.Simple(self.TracerDelay and self.TracerDelay or 0, function()
				if IsValid(self) and self.TracerName then
					ef:SetOrigin(self.Owner.LastBulletHitPos and self.Owner.LastBulletHitPos or self.Owner:GetEyeTrace().HitPos)
					util.Effect(self.TracerName,ef)
				end
			end)
		end
	end
	
end

--[[ 
Function Name:  MakeMuzzleSmokeSV
Syntax: self:MakeMuzzleSmokeSV( attachment ). 
Returns:  Nothing.
Notes:    Used to make multiplayer muzzle smoke.  Don't call this unless you verify the attachment exists.
Purpose:  FX
]]--

function SWEP:MakeMuzzleSmokeSV(attachment)
	
	local ef = EffectData()
	ef:SetEntity(self)
	ef:SetMagnitude(1)
	ef:SetAttachment(attachment)
	util.Effect("tfa_particle_smoketrail", ef)
	
end

--[[ 
Function Name:  MuzzleLight
Syntax: self:MuzzleLight( ). 
Returns:  Nothing.
Notes:    Used to make the muzzle light.
Purpose:  FX
]]--

function SWEP:MuzzleLight()
	if !CLIENT then return end
	
	if !self:GetSilenced() then
		if self:OwnerIsValid() then
			self.Owner:MuzzleFlash()
		end
		--[[
		local att,dylight
		if self:IsFirstPerson() then
			local vm = self.Owner:GetViewModel()
			att = vm:GetAttachment(vm:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "1" ) )
		else
			att = self:GetAttachment(self:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "1" ) )
		end
		
		dylight = DynamicLight(self:EntIndex()..","..self:GetClass())
			
		dylight.r = 255 
		dylight.g = 215
		dylight.b = 56
		dylight.brightness = 7
		local tpos =  self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * self.WeaponLength
		dylight.Pos = self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * self.WeaponLength
		if att and att.Pos then
			tpos=(att.Pos) + self.Owner:GetAimVector() * 1.5
			dylight.pos = tpos
		else
			tpos=self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.WeaponLength
			dylight.pos = tpos
		end
		debugoverlay.Cross(tpos,5,5,Color(255,255,255,255), true)
		dylight.size = 64
		local lifetime = 10/60
		dylight.decay = 1000/(lifetime*3)
		dylight.dieTime = CurTime() + lifetime
		dylight.style = 3
		dylight.key = true
		]]--
	end
	
end
