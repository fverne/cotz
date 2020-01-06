if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_kk_ins2_base_main"

SWEP.MuzzleEffectF = "doi_flamethrower"
SWEP.MuzzleEffectWorldF = "doi_flamethrower"

SWEP.FlamethrowerRange = 600
SWEP.FlamethrowerRicochetRange = 200
local FlamethrowerAfterBurnDuration = 5

PrecacheParticleSystem(SWEP.MuzzleEffectF)
PrecacheParticleSystem(SWEP.MuzzleEffectWorldF)
PrecacheParticleSystem("flamethrower_pilotLight")

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.035
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 30

if CLIENT then
	function SWEP:postPrimaryAttack()
		self:flamethrowerStartStuff()

		self.stopParticlesTime = CurTime() + 0.1
	end

	function SWEP:flamethrowerStartStuff()
		if not self.flamethrowerFXStuffStarted then
			-- if not self.AttachmentModelsVM then return end
			-- if not self.AttachmentModelsVM.muzzle then return end

			self.flamethrowerFXStuffStarted = true

			-- local vm = self.AttachmentModelsVM.muzzle.ent
			-- ParticleEffectAttach(self.MuzzleEffectF, PATTACH_POINT_FOLLOW, vm, 0)

			local vm = self.CW_VM
			ParticleEffectAttach(self.MuzzleEffectF, PATTACH_POINT_FOLLOW, vm, 1)
		end
	end

	function SWEP:flamethrowerStopStuff()
		if self.flamethrowerFXStuffStarted then
			-- if not self.AttachmentModelsVM then return end
			-- if not self.AttachmentModelsVM.muzzle then return end

			self.flamethrowerFXStuffStarted = false

			-- self.AttachmentModelsVM.muzzle.ent:StopParticles()

			local vm = self.CW_VM:StopParticles()
			self.flamethrowerFXPilotStarted = false
			self:flamethrowerStartPilot()
		end
	end

	function SWEP:flamethrowerStartPilot()
		if not self.flamethrowerFXPilotStarted then
			-- if not self.AttachmentModelsVM then return end
			-- if not self.AttachmentModelsVM.pilot then return end

			self.flamethrowerFXPilotStarted = true

			-- local vm = self.AttachmentModelsVM.pilot.ent
			-- ParticleEffectAttach("flamethrower_pilotLight", PATTACH_POINT_FOLLOW, vm, 0)

			local vm = self.CW_VM
			ParticleEffectAttach("flamethrower_pilotLight", PATTACH_POINT_FOLLOW, vm, 2)
		end
	end

	function SWEP:IndividualThink_INS2()
		self:flamethrowerStartPilot()

		if self.stopParticlesTime and CurTime() > self.stopParticlesTime then
			self:flamethrowerStopStuff()
		end
	end
end

function SWEP:DoImpactEffect()
	return true
end

//-----------------------------------------------------------------------------
// COPY-PASTA
//-----------------------------------------------------------------------------

local Dir, Dir2, dot, sp, ent, trace, seed, hm

SWEP.NormalTraceMask = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442, CONTENTS_WATER)
SWEP.WallTraceMask = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)

SWEP.NoPenetration = {[MAT_SLOSH] = true}
SWEP.NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true, [MAT_GRASS] = true}
SWEP.PenetrationMaterialInteraction = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, tr = {}, {}
local SP = game.SinglePlayer()
local zeroVec = Vector(0, 0, 0)

local reg = debug.getregistry()
local GetShootPos = reg.Player.GetShootPos

SWEP.bulletCallback = function(ply, tr, di)
	if SERVER then
		if tr.Hit then
			if IsValid(tr.Entity) then
				tr.Entity.kkDOIFTAttacker = ply
				tr.Entity.kkDOIFTInflictor = ply:GetActiveWeapon()
				tr.Entity:Ignite(FlamethrowerAfterBurnDuration, 0)
			end
		end
	end
end

function SWEP:canPenetrate(traceData, direction)
	local dot = nil

	if not self.NoPenetration[traceData.MatType] then
		dot = self:getSurfaceReflectionDotProduct(traceData, direction)
		ent = traceData.Entity

		if not ent:IsNPC() and not ent:IsPlayer() then
			if dot > 0.26 and self.CanPenetrate then
				return true, dot
			end
		end
	end

	return false, dot
end

function SWEP:getSurfaceReflectionDotProduct(traceData, dir)
	return -dir:DotProduct(traceData.HitNormal)
end

function SWEP:canRicochet(traceData, penetrativeRange)
	return true
end

function SWEP:FireBullet(damage, cone, clumpSpread, bullets)
	sp = GetShootPos(self.Owner)
	local commandNumber = self.Owner:GetCurrentCommand():CommandNumber()
	math.randomseed(commandNumber)

	if self.Owner:Crouching() then
		cone = cone * 0.85
	end

	Dir = (self.Owner:EyeAngles() + self.Owner:GetViewPunchAngles() + Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0) * 25):Forward()
	clumpSpread = clumpSpread or self.ClumpSpread

	CustomizableWeaponry.callbacks.processCategory(self, "adjustBulletStructure", bul)

	for i = 1, bullets do
		Dir2 = Dir

		if clumpSpread and clumpSpread > 0 then
			Dir2 = Dir + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * clumpSpread
		end

		bul.Num = 1
		bul.Src = sp
		bul.Dir = Dir2
		bul.Spread 	= zeroVec --Vector(0, 0, 0)
		bul.Tracer	= 0
		bul.Force	= 0
		bul.Damage = math.Round(damage)
		bul.Callback = self.bulletCallback
		bul.Distance = self.FlamethrowerRange
		bul.HullSize = 6

		self.Owner:FireBullets(bul)

		tr.start = sp
		tr.endpos = tr.start + Dir2 * self.PenetrativeRange
		tr.filter = self.Owner
		tr.mask = self.NormalTraceMask

		trace = util.TraceLine(tr)

		if trace.Hit and not trace.HitSky then
			local canPenetrate, dot = self:canPenetrate(trace, Dir2)

			if self:canRicochet(trace) then
				dot = dot or self:getSurfaceReflectionDotProduct(trace, Dir2)
				Dir2 = Dir2 + (trace.HitNormal * dot) * 3
				math.randomizeVector(Dir2, 0.06)

				bul.Num = 1
				bul.Src = trace.HitPos
				bul.Dir = Dir2
				bul.Spread 	= Vec0
				bul.Tracer	= 0
				bul.Force	= 0
				bul.Damage = bul.Damage * 0.75
				bul.Distance = self.FlamethrowerRicochetRange
				bul.HullSize = 6

				self.Owner:FireBullets(bul)
			end
		end
	end

	tr.mask = self.NormalTraceMask
end
