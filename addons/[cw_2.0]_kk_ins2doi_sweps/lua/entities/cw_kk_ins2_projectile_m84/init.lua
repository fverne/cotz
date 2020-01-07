AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MaxIntensityDistance = 384 -- if an entity is THIS close to the grenade upon explosion, the intensity of the flashbang will be maximum
ENT.FlashDistance = 1024 -- will decay over this much distance
ENT.FlashDuration = 3
ENT.Model = "models/weapons/w_m84.mdl"

local phys, ef

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end

	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	vel = physobj:GetVelocity()
	len = vel:Length()

	if len > 500 then -- let it roll
		physobj:SetVelocity(vel * 0.6) -- cheap as fuck, but it works
	end

	if len > 100 then
		CT = CurTime()

		if CT > self.NextImpact then
			self:EmitSound("CW_KK_INS2_M84_ENT_BOUNCE", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

local traceData = {}
traceData.mask = bit.bor(CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, CONTENTS_WATER)

function ENT:Fuse(t)
	t = t or 2.5

	timer.Simple(t, function()
		local fx = ents.Create("cw_kk_ins2_particles")
		fx:processProjectile(self)
		fx:Spawn()
	end)

	timer.Simple(t + 0.1, function()
		if self:IsValid() then
			local hitPos = self:GetPos()

			-- for key, obj in ipairs(player.GetAll()) do
			for key, obj in ipairs(ents.GetAll()) do
				if !obj.IsNPC and !obj.IsPlayer then
					continue
				end

				if !obj:IsNPC() and !obj:IsPlayer() then
					continue
				end

				if obj:IsNPC() or obj:Alive() then
					local bone = obj:LookupBone("ValveBiped.Bip01_Head1")

					if bone then
						traceData.filter = obj

						local headPos, headAng = obj:GetBonePosition(bone)
						local ourAimVec = self.Owner:GetAimVector()

						local direction = (hitPos - headPos):GetNormal()
						local dotToGeneralDirection = ourAimVec:DotProduct(direction)

						traceData.start = headPos
						traceData.endpos = traceData.start + direction * self.FlashDistance

						local trace = util.TraceLine(traceData)
						local ent = trace.Entity

						if IsValid(ent) and ent == self then
							local hitDistance = self.FlashDistance * trace.Fraction
							local isMaxIntensity = (hitDistance - self.MaxIntensityDistance) < 0
							local decay = self.FlashDistance - self.MaxIntensityDistance
							local intensity = 0

							if isMaxIntensity then
								intensity = 1
							else
								local decayDistance = hitDistance - self.MaxIntensityDistance
								intensity = 1 - decayDistance / decay
							end

							intensity = math.min((intensity + 0.25) * dotToGeneralDirection, 1)
							local duration = intensity * self.FlashDuration

							if obj:IsPlayer() then
								umsg.Start("CW_FLASHBANGED", obj)
									umsg.Float(intensity)
									umsg.Float(duration)
								umsg.End()
							end

							if obj:IsNPC() then
								-- obj:SetCondition(COND_NPC_FREEZE)
								obj:SetCondition(67)
								obj:ClearEnemyMemory()
								obj:SelectWeightedSequence(ACT_COWER)

								timer.Simple(5, function()
									if IsValid(obj) then
										obj:ClearEnemyMemory()
										-- obj:SetCondition(COND_NPC_UNFREEZE)
										obj:SetCondition(68)
									end
								end)
							end
						end
					end
				end
			end

			SafeRemoveEntity(self)
		end
	end)
end
