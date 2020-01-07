AddCSLuaFile()

local ang0 = Angle(0, 0, 0)

local ent, pos, tweakData

function EFFECT:Init(fx)
	ent = fx:GetEntity()
	ent:SetAngles(ang0)

	pos = ent:GetPos()

	tweakData = ent:getTweakData()

	if ent:WaterLevel() == 0 then
		for _,p in pairs(tweakData.explosionParticles) do
			-- ParticleEffect(p, pos, ang0)
			ParticleEffectAttach(p, PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end
		sound.Play(tweakData.explosionSound0, pos, 180)
	else
		for _,p in pairs(tweakData.explosionParticlesWater) do
			-- ParticleEffect(p, pos, ang, ent)
			ParticleEffectAttach(p, PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end

		sound.Play(tweakData.explosionSoundW0, pos, 180)
	end

	self.ent = ent
end

function EFFECT:Think()
	ent = self.ent

	if IsValid(ent) then
		dlight = DynamicLight(ent:EntIndex())

		dlight.r = 255
		dlight.g = 100
		dlight.b = 50
		dlight.style = math.pow(6,math.random(0,1))
		dlight.Brightness = 1
		dlight.Pos = ent:GetPos()
		dlight.Size = 256
		dlight.Decay = 256
		dlight.DieTime = CurTime() + FrameTime()

		return true
	end

	return false
end

function EFFECT:Render()
end
