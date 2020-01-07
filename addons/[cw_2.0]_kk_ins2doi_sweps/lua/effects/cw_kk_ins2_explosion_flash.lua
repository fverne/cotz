AddCSLuaFile()

local ang0 = Angle(-90, 0, 0)

local ent, pos, dl, tweakData

function EFFECT:Init(fx)
	ent = fx:GetEntity()

	dl = DynamicLight(ent:EntIndex())

	dl.r = 255
	dl.g = 255
	dl.b = 255
	dl.Brightness = 4
	dl.Pos = ent:GetPos()
	dl.Size = 256
	dl.Decay = 128
	dl.DieTime = CurTime() + 0.1

	pos = ent:GetPos()

	tweakData = ent:getTweakData()

	if ent:WaterLevel() == 0 then
		for _,p in pairs(tweakData.explosionParticles) do
			ParticleEffect(p, pos, ang0)
		end
		sound.Play(tweakData.explosionSound0, pos, 180)
	else
		sound.Play(tweakData.explosionSound2, pos, 180)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
