--[[ 
Function Name:  FireAnimationEvent
Syntax: self:FireAnimationEvent( position, angle, event id, options). 
Returns:  Nothing.
Notes:    Used to capture and disable viewmodel animation events, unless you disable that feature.
Purpose:  FX
]]--

function SWEP:FireAnimationEvent(pos, ang, event, options)
	if self.CustomMuzzleFlash or !self.DoMuzzleFlash then
	
		-- Disables animation based muzzle event
		if ( event == 21 ) then return true end	

		-- Disable thirdperson muzzle flash
		if ( event == 5003 ) then return true end
		-- Disable CS-style muzzle flashes, but chance our muzzle flash attachment if one is given.
		if (event == 5001 or event == 5011 or event == 5021 or event == 5031) then 
			if self.AutoDetectMuzzleAttachment then
				self.MuzzleAttachmentRaw = math.Clamp( math.floor( ( event - 4991 ) / 10 ), 1, 4)
				net.Start("tfa_base_muzzle_mp")
				net.SendToServer()
				timer.Simple(0, function()
					if IsValid(self) then
						self:ShootEffectsCustom( true )
					end
				end)
			end
			return true 
		end 
	end
	if self.LuaShellEject then
		if ( event == 6001 or event>5031 ) then return true end		
	end
end

--[[ 
Function Name:  MakeMuzzleSmoke
Syntax: self:MakeMuzzleSmoke( entity, attachment). 
Returns:  Nothing.
Notes:    Used to make the muzzle smoke effect, clientside.
Purpose:  FX
]]--

function SWEP:MakeMuzzleSmoke(entity,attachment)
	
	self:CleanParticles()
	
	local ht = self.DefaultHoldType and self.DefaultHoldType or self.HoldType
	if ( (CLIENT ) and GetTFAMZSmokeEnabled() ) then
		if IsValid(entity) then
			if attachment and attachment!=0 then
				ParticleEffectAttach(self.SmokeParticles[ht],PATTACH_POINT_FOLLOW,entity,attachment)
			end
		end
	end
	
end

--[[ 
Function Name:  MakeMuzzleFlash
Syntax: self:MakeMuzzleFlash( pos, normal (ang:Up()), entity, attachment, actually use the given position, use the given normal). 
Returns:  Nothing.
Notes:    Used to make the muzzle flash effect, clientside.
Purpose:  FX
]]--
	
local blankvec = Vector(0,0,0)

function SWEP:MakeMuzzleFlash(pos,normal,entity,attachment, usepos, usenormal)
	
	if !IsValid(self.Owner) then return end
	--[[
	print("Making muzzle flash clientside.")
	print("Pos:")
	print(pos)
	print("Normal:")
	print(normal)
	print("Ent:")
	print(entity)
	print("Att:")
	print(attachment)
	print("Use pos?")
	print(usepos)
	print("Use Normal?")
	print(usenormal)
	]]--
	local fp = self:IsFirstPerson()
	
	local ef = EffectData()
	
	if IsValid(entity) then
		ef:SetEntity(entity)
		ef:SetOrigin(blankvec)
	else
		ef:SetOrigin(blankvec)
		ef:SetEntity(self)
	end
	
	ef:SetAttachment( attachment )
	
	if LocalPlayer then
		ef:SetStart( Vector( LocalPlayer():EntIndex(),0,self:EntIndex() ) )
	else
		ef:SetStart( Vector( Entity(1):EntIndex(),0,self:EntIndex() ) )	
	end
	
	local rpos = entity:GetAttachment(attachment)
	
	if fp then
		ef:SetNormal(self.Owner:EyeAngles():Forward())
	else
		local ang = self.Owner:EyeAngles()
		ef:SetNormal(Angle(math.Clamp(ang.p,-55,55),ang.y,ang.r):Forward())
	end
	
	if usepos then
		ef:SetOrigin(pos)
	else
		--[[
		local tpos = self:GetMuzzlePos()
		if tpos and tpos.Pos then
			print(tpos.Pos)
			ef:SetOrigin(tpos.Pos)
		end
		]]--
	end

	if usenormal then
		ef:SetNormal(normal)
	end

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
	
local blankvec = Vector(0,0,0)

--[[ 
Function Name:  ImpactEffect
Syntax: self:ImpactEffect( position, normal (ang:Up()), materialt ype). 
Returns:  Nothing.
Notes:    Used to make the impact effect.  See utilities code for CanDustEffect.
Purpose:  FX
]]--

function SWEP:DoImpactEffect(tr,dmgtype)
	
	if tr.HitSky then return true end
	
	local ib = self.BashBase and IsValid(self) and self:GetBashing()
	
	local dmginfo = DamageInfo()
	dmginfo:SetDamageType(dmgtype)
	if dmginfo:IsDamageType(DMG_SLASH) or (ib and self.Secondary.BashDamageType == DMG_SLASH and tr.MatType != MAT_FLESH and tr.MatType != MAT_ALIENFLESH ) or  (self and self.DamageType and self.DamageType==DMG_SLASH) then
		util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
		return true
	end
	
	if ib and self.Secondary.BashDamageType == DMG_GENERIC then return true end
	
	if ib then return end
	
	if IsValid(self) then
		self:ImpactEffectFunc(tr.HitPos,tr.HitNormal,tr.MatType)
	end
end

local impact_cl_enabled = GetConVar("cl_tfa_fx_impact_enabled")
local impact_sv_enabled = GetConVar("sv_tfa_fx_impact_override")

function SWEP:ImpactEffectFunc(pos, normal, mattype)
	
	local enabled
	if impact_cl_enabled then
		enabled = impact_cl_enabled:GetBool()
	else
		enabled = true
	end
	if impact_sv_enabled and impact_sv_enabled:GetInt()>=0 then enabled=impact_sv_enabled:GetBool() end
	
	if enabled then
		
		local fx = EffectData()
		fx:SetOrigin(pos)
		fx:SetNormal(normal)
	
		if self:CanDustEffect(mattype) then
			util.Effect("tfa_bullet_impact",fx)
		end
		
		if self:CanSparkEffect(mattype) then
			util.Effect("tfa_metal_impact",fx)
		end
		
		if self.ImpactEffect then
			util.Effect(self.ImpactEffect,fx)		
		end
		
	end
end