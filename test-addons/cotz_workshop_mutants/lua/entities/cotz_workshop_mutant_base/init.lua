AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
include("sv_attacks.lua")
include("sv_movement.lua")

local SUMMON_OFFSET = Vector(90, 0, 12)
local SUMMON_INTERVAL = 12
local SUMMON_LIFETIME = 25
local SUMMON_RANGE_SQR = 750 ^ 2
local CLOAK_RANGE_SQR = 225 ^ 2
local CLOAK_ALPHA = 55
local CLOAK_CHECK_INTERVAL = 0.35
local SHIELD_DAMAGE_SCALE = 0.35

local function reject(npc, reason)
	ErrorNoHalt(string.format("[COTZ Workshop Mutants] %s: %s\n", npc:GetClass(), reason))
	npc:Remove()
end

local function heartbeatEnabled(profile)
	return profile.ranged or profile.leap or profile.cloak or profile.summon
		or profile.movement == "fly" or profile.movement == "swim"
end

function ENT:Initialize()
	if not self.workshopProfile or not self.STALKERNPCInit then
		reject(self, "this class needs the COTZ stalker_ai base and a concrete profile")
		return
	end

	local profile = self.workshopVariants and table.Random(self.workshopVariants) or self.workshopProfile
	local model = table.Random(profile.models)
	if not util.IsValidModel(model) then
		reject(self, "missing mounted model " .. model)
		return
	end

	self.workshopProfile = profile
	self.workshopActive = heartbeatEnabled(profile)
	self.Model = model
	self.SNPCClass = profile.faction
	self.noRagdoll = profile.alpha ~= nil or profile.bounds[3] <= 22 or profile.movement == "hold"
	self:SetHullType(_G[profile.hull] or HULL_HUMAN)
	self:STALKERNPCInit(Vector(unpack(profile.bounds)), MOVETYPE_STEP)
	self:SetViewOffset(Vector(0, 0, profile.bounds[3] * 0.75))
	if profile.skins then
		local skins = {}
		for _, skin in ipairs(profile.skins) do
			if skin < self:SkinCount() then skins[#skins + 1] = skin end
		end
		if #skins > 0 then self:SetSkin(table.Random(skins)) end
	end
	self:SetHealth(profile.health)
	self:SetMaxHealth(profile.health)

	if profile.alpha or profile.cloak then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:DrawShadow(false)
		self:SetWorkshopAlpha(profile.alpha or 255)
	end

	self:ConfigureWorkshopAttacks(profile)
	self:ConfigureWorkshopMovement(profile)
	if profile.lifetime then
		SafeRemoveEntityDelayed(self, profile.lifetime)
	end
end

function ENT:SetWorkshopAlpha(alpha)
	if self.workshopAlpha == alpha then return end
	self.workshopAlpha = alpha
	self:SetColor(Color(255, 255, 255, alpha))
end

function ENT:STALKERNPCTryToFindEnemy()
	if self.workshopProfile.passive then return 0 end

	return baseclass.Get("stalker_ai").STALKERNPCTryToFindEnemy(self)
end

function ENT:UpdateWorkshopSummon(target, now)
	if self.workshopSummoned or IsValid(self.workshopSummon) then return end
	if now < (self.workshopNextSummon or 0) then return end
	if self:GetPos():DistToSqr(target:GetPos()) > SUMMON_RANGE_SQR then return end
	self.workshopNextSummon = now + SUMMON_INTERVAL

	local child = self:STALKERNPCSpawnSummon("npc_mutant_workshop_" .. self.workshopProfile.summon, SUMMON_OFFSET)
	if not IsValid(child) then return end
	self.workshopSummon = child
	child.workshopSummoned = true
	SafeRemoveEntityDelayed(child, SUMMON_LIFETIME)
end

function ENT:STALKERNPCThink()
	if not self.workshopActive then return end
	if self.workshopAction then
		self:UpdateWorkshopAction()
		return
	end

	local now = CurTime()
	if now < (self.workshopNextUpdate or 0) then return end
	self.workshopNextUpdate = now + self.workshopUpdateInterval
	local target = self:GetEnemy()
	local visible = false
	if IsValid(target) then visible = self:CanWorkshopAttack(target) end

	if self.workshopProfile.cloak and now >= (self.workshopNextCloak or 0) then
		self.workshopNextCloak = now + CLOAK_CHECK_INTERVAL
		local near = IsValid(target) and self:GetPos():DistToSqr(target:GetPos()) <= CLOAK_RANGE_SQR
		self:SetWorkshopAlpha((near or self.PlayingAnimation) and 255 or CLOAK_ALPHA)
	end

	if visible and not self.PlayingAnimation then
		if self.workshopProfile.summon then self:UpdateWorkshopSummon(target, now) end
		if self:TryWorkshopAttack(target, now) then return end
	end
	self:UpdateWorkshopMovement(target, visible)
end

function ENT:STALKERNPCOnEnemyCountFinded(count)
	if count == 0 or self.workshopAlerted then return end
	self.workshopAlerted = true
	self:PlayWorkshopSound(self.workshopProfile.alertSounds)
end

function ENT:STALKERNPCDamageTake(_, multiplier)
	if self.workshopProfile and self.workshopProfile.summon == "burer2" and IsValid(self.workshopSummon) then
		return multiplier * SHIELD_DAMAGE_SCALE
	end

	return multiplier
end

function ENT:STALKERNPCRemove()
	if IsValid(self.workshopSummon) then SafeRemoveEntity(self.workshopSummon) end
end

function ENT:STALKERNPCOnDeath()
	local sounds = self.workshopProfile.deathSounds
	if sounds then sound.Play(table.Random(sounds), self:GetPos()) end
	self:STALKERNPCRemove()
end
