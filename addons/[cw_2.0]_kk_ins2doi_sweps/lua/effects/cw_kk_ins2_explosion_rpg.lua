AddCSLuaFile()

local td = {}
local down = Vector(0, 0, -50)
local ang0 = Angle(-90, 0, 0)

local ent, pos, ang, tr, tweakData, waterLevel

function EFFECT:Init(fx)
	ent = fx:GetEntity()

	pos = ent:GetPos()
	ang = ang0

	tweakData = ent:getTweakData()

	if ent:WaterLevel() == 0 then
		for _,p in pairs(tweakData.explosionParticles) do
			ParticleEffect(p, pos, ang, ent)
		end

		sound.Play(tweakData.explosionSound0, pos, 180)
	else
		for _,p in pairs(tweakData.explosionParticlesWater) do
			ParticleEffect(p, pos, ang, ent)
		end

		sound.Play(tweakData.explosionSoundW0, pos, 180)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
