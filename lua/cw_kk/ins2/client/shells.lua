
CustomizableWeaponry_KK.ins2.shells = CustomizableWeaponry_KK.ins2.shells or {}
CustomizableWeaponry_KK.ins2.shells._cache = CustomizableWeaponry_KK.ins2.shells._cache or {}

function CustomizableWeaponry_KK.ins2.shells:_rebuildCache()
	local i = 1

	for _ = 1, #self._cache do
		if !IsValid(self._cache[i]) then
			table.remove(self._cache, i)
		else
			i = i + 1
		end
	end

	self.cacheSize = #self._cache
end

CustomizableWeaponry_KK.ins2.shells:_rebuildCache()

local CurTime = CurTime
local soundPlay = sound.Play

CustomizableWeaponry_KK.ins2.shells.shellMeta = {}
local shellMeta = CustomizableWeaponry_KK.ins2.shells.shellMeta

function shellMeta:PhysicsCollide()
	if (self:WaterLevel() != 0) then
		return
	end

	local CT = CurTime()

	if self._nextSoundTime and CT < self._nextSoundTime then
		return
	end

	self._nextSoundTime = CT + 0.3
	soundPlay(self._ss, self:GetPos())
end

function shellMeta:Think()
	self._lastWL = self._lastWL or self:WaterLevel()
	local newWl = self:WaterLevel()

	if (newWl == 3) and (newWl != self._lastWL) then
		local pos = self:GetPos()
		soundPlay("CW_KK_INS2_SHELL_SPLASH", pos)

		local e = EffectData()
		e:SetOrigin(pos)
		util.Effect("waterripple", e)
	end

	self._lastWL = newWl

	if self._ttl > CurTime() then return end

	SafeRemoveEntity(self)

	CustomizableWeaponry_KK.ins2.shells:_rebuildCache()
end

local cvarSSF = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_sound"]
local cvarSLT = CustomizableWeaponry_KK.ins2.conVars.main["cw_kk_ins2_shell_time"]

function CustomizableWeaponry_KK.ins2.shells:make(pos, ang, velocity, angleVelocity, t, scale)
	pos = pos or EyePos()
	ang = ang or EyeAngles()
	velocity = velocity or Vector()
	angleVelocity = angleVelocity or Vector()
	t = t or CustomizableWeaponry.shells:getShell("mainshell")
	scale = scale or 1

	t.bbmin = t.bbmin or Vector(-0.5, -0.15, -0.5)
	t.bbmax = t.bbmax or Vector(0.5, 0.15, 0.5)

	velocity.x = velocity.x + math.Rand(-5, 5)
	velocity.y = velocity.y + math.Rand(-5, 5)
	velocity.z = velocity.z + math.Rand(-5, 5)

	angleVelocity.x = angleVelocity.x + math.Rand(-5, 5)
	angleVelocity.y = angleVelocity.y + math.Rand(-5, 5)
	angleVelocity.z = angleVelocity.z + math.Rand(-5, 5)

	local ent = ClientsideModel(t.m, RENDERGROUP_BOTH)
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetModelScale(scale, 0)
	ent:PhysicsInitBox(t.bbmin * scale, t.bbmax * scale)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	ent:SetSolid(SOLID_VPHYSICS)
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	local phys = ent:GetPhysicsObject()

	if cvarSSF:GetInt() == 1 then // no function lol
		phys:SetMaterial("grenade")
	else
		phys:SetMaterial("gmod_silent")
	end

	phys:SetMass(10)
	phys:SetVelocity(velocity)
	phys:AddAngleVelocity(angleVelocity)

	if cvarSSF:GetInt() == 2 then // function creation spam
		timer.Simple(0.5, function()
			if t.s and IsValid(ent) then
				soundPlay(t.s, ent:GetPos())
			end
		end)
	end

	if cvarSSF:GetInt() == 3 then // recycled function
		ent._ss = t.s
		ent._ssp = false
		ent:AddCallback("PhysicsCollide", self.shellMeta.PhysicsCollide)
	end

	if cvarSSF:GetInt() == 4 then // fail
		phys:SetMaterial(t.s)
	end

	ent._ttl = CurTime() + (cvarSLT:GetFloat())
	hook.Add("Think", ent, self.shellMeta.Think)

	table.insert(self._cache, ent)
	self.cacheSize = #self._cache

	return ent
end

function CustomizableWeaponry_KK.ins2.shells:cleanUpShells()
	for _,v in pairs(self._cache) do
		SafeRemoveEntity(v)
	end

	self:_rebuildCache()
end
