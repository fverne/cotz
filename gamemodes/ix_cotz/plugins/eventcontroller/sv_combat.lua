local CELL_SIZE = 2048
local RELATION_PRIORITY = 99
local AMBIENT_RANGE = 1500
local AMBIENT_INTERVAL = 30
local CONFLICT_SECONDS = 90
local CONFLICT_COOLDOWN = 120
local REGROUP_START = 512
local REGROUP_STOP = 256
local HOME_RANGE = 2048
local REGROUP_RETRY = 10
local PLAYER_MEMORY_SECONDS = 10
local PLAYER_CONTACT_INTERVAL = 0.25
local PURSUIT_RETRY = 1
local PURSUIT_ARRIVAL = 64
local AIM_BONES = {
	"chest", "Chest", "thorax", "Thorax",
	"ValveBiped.Bip01_Spine2", "bip01_spine2", "Bip01 Spine2", "spine_03",
	"ValveBiped.Bip01_Spine1", "bip01_spine1", "Bip01 Spine1", "spine_02",
	"ValveBiped.Bip01_Spine", "bip01_spine", "Bip01 Spine", "spine", "spine_01",
}
local TARGET_ABILITIES = {"isAttacking", "IsJumping", "IsLongJumping", "isBigJumping", "IsSuccing", "IsGrabbing"}
local PREDATORS = {blinddog = true, pseudodog = true, psydog = true, cat = true, bloodsucker = true,
	chimera = true, electrochimera = true, hellhound = true, spider = true, sprig = true}
local PREY = {boar = true, flesh = true, tark = true, rodent = true, tushkano = true}
local SPECIES_ALIASES = {dog = "blinddog", psydog_phantom = "psydog", rodent = "tushkano",
	chimera_electro = "electrochimera", classiczombie = "zombie", classiczombie_babka = "zombie",
	classiczombie_radio = "zombie", classiczombie_volatile = "zombie"}

PLUGIN.combatActors = {}
PLUGIN.combatPacks = {}
PLUGIN.combatBuckets = {}
local nextPackID = 0

local function living(entity)
	return IsValid(entity) and entity:Health() > 0 and entity.IsAlive ~= false and not entity.cotzPopulationRejected
end

local function cellKey(position)
	return math.floor(position.x / CELL_SIZE) .. ":" .. math.floor(position.y / CELL_SIZE)
end

local function targetBusy(actor)
	if actor.PlayingAnimation then return true end
	for _, field in ipairs(TARGET_ABILITIES) do
		if (actor[field] or 0) ~= 0 then return true end
	end

	return false
end

function PLUGIN:IsCombatActor(entity)
	if not IsValid(entity) or not entity:IsNPC() then return false end
	local class = entity:GetClass()

	return class:sub(1, 11) == "npc_mutant_" or class:sub(1, 10) == "npc_human_"
end

local function aimBonePosition(enemy, bone)
	local position = enemy:GetBonePosition(bone)
	-- An uninitialized bone cache can return the entity origin instead of the bone's position.
	if not position or position == enemy:GetPos() then
		local matrix = enemy:GetBoneMatrix(bone)

		return matrix and matrix:GetTranslation()
	end

	return position
end

local function enemyAimPosition(enemy)
	for _, name in ipairs(AIM_BONES) do
		local bone = enemy:LookupBone(name)
		if bone then
			local position = aimBonePosition(enemy, bone)
			if position then return position end
		end
	end

	local boneCount = enemy:GetBoneCount()
	if boneCount > 0 then
		local firstBone = math.random(0, boneCount - 1)
		for offset = 0, boneCount - 1 do
			local position = aimBonePosition(enemy, (firstBone + offset) % boneCount)
			if position then return position end
		end
	end

	return enemy:WorldSpaceCenter()
end

function PLUGIN:EntityFireBullets(entity, data)
	if not entity:IsNPC() or entity:GetClass():sub(1, 10) ~= "npc_human_" then return end
	local enemy = entity:GetEnemy()
	if not living(enemy) then return end
	if not self:CanActorAttack(entity, enemy) then return false end

	data.Dir = (enemyAimPosition(enemy) - data.Src):GetNormalized()

	return true
end

function PLUGIN:CreateCombatPack(origin, isolated)
	nextPackID = nextPackID + 1

	return {id = nextPackID, origin = origin, isolated = isolated, members = {},
		nextAmbient = CurTime() + (nextPackID % AMBIENT_INTERVAL), cooldown = 0}
end

function PLUGIN:RemoveCombatActor(entity)
	self:ClearCombatPlayerFocus(entity)
	self.combatActors[entity] = nil
	local bucket = self.combatBuckets[entity.cotzCombatCell]
	if bucket then
		bucket[entity] = nil
		if not next(bucket) then self.combatBuckets[entity.cotzCombatCell] = nil end
	end
	local pack = entity.cotzCombatPack
	if pack then
		pack.members[entity] = nil
		if not next(pack.members) then
			self:EndPackConflict(pack)
			self.combatPacks[pack.id] = nil
		end
	end
	for actor in pairs(self.combatActors) do
		if actor.cotzRelations then actor.cotzRelations[entity] = nil end
		if actor.cotzOriginalRelations then actor.cotzOriginalRelations[entity] = nil end
	end
	entity.cotzCombatCell, entity.cotzCombatPack = nil, nil
	entity.cotzRelations, entity.cotzOriginalRelations = nil, nil
	entity.cotzCombatEnemy, entity.cotzCombatScheduleDirty = nil, nil
	entity.cotzPursuitScheduled, entity.cotzNextPursuit = nil, nil
	entity.cotzCombatObjective, entity.cotzCombatObjectiveRadius = nil, nil
end

function PLUGIN:RegisterCombatActor(entity, pack)
	if not self:IsCombatActor(entity) or not living(entity) then return end
	pack = pack or entity.cotzCombatPack
	if self.combatActors[entity] and entity.cotzCombatPack == pack then return end
	if self.combatActors[entity] then self:RemoveCombatActor(entity) end
	local class = entity:GetClass()
	entity.cotzHuman = class:sub(1, 10) == "npc_human_"
	local species = class:gsub("^npc_mutant_", "")
	entity.cotzSpecies = ix.jobs and ix.jobs.regional and ix.jobs.regional.Species(class)
		or SPECIES_ALIASES[species] or species
	entity.cotzFaction = entity.cotzHuman and class:match("^npc_human_([^_]+)_") or nil
	if entity.cotzFaction == "z" or entity.cotzSpecies == "zombie" then entity.cotzFaction = "undead" end
	pack = pack or self:CreateCombatPack(entity:GetPos())
	nextPackID = math.max(nextPackID, pack.id)
	entity.cotzCombatPack, entity.cotzRelations = pack, {}
	pack.members[entity] = true
	self.combatActors[entity], self.combatPacks[pack.id] = true, pack
	if entity.cotzHuman and entity.SetSquad then
		if entity.cotzOriginalSquad == nil then
			entity.cotzOriginalSquad = entity.GetSquad and entity:GetSquad() or false
		end
		entity:SetSquad("cotz/encounter/" .. pack.id .. "/" .. (entity.cotzFaction or "human"))
	end
	self:UpdateCombatCell(entity)
end

function PLUGIN:UpdateCombatCell(entity)
	local key = cellKey(entity:GetPos())
	if key == entity.cotzCombatCell then return end
	local previous = self.combatBuckets[entity.cotzCombatCell]
	if previous then
		previous[entity] = nil
		if not next(previous) then self.combatBuckets[entity.cotzCombatCell] = nil end
	end
	self.combatBuckets[key] = self.combatBuckets[key] or {}
	self.combatBuckets[key][entity] = true
	entity.cotzCombatCell = key
end

function PLUGIN:NearbyCombatActors(position, range)
	local result = {}
	local minX, maxX = math.floor((position.x - range) / CELL_SIZE), math.floor((position.x + range) / CELL_SIZE)
	local minY, maxY = math.floor((position.y - range) / CELL_SIZE), math.floor((position.y + range) / CELL_SIZE)
	for x = minX, maxX do
		for y = minY, maxY do
			for entity in pairs(self.combatBuckets[x .. ":" .. y] or {}) do
				if living(entity) and entity:GetPos():DistToSqr(position) <= range ^ 2 then
					result[#result + 1] = entity
				end
			end
		end
	end

	return result
end

function PLUGIN:ActorsHostile(first, second)
	if first == second then return false end
	local firstPack, secondPack = first.cotzCombatPack, second.cotzCombatPack
	if firstPack and firstPack == secondPack then return false end
	if (firstPack and firstPack.isolated) or (secondPack and secondPack.isolated) then return false end
	if first.cotzFaction and second.cotzFaction then return first.cotzFaction ~= second.cotzFaction end
	if first.cotzFaction or second.cotzFaction then return true end
	if first.cotzSpecies == second.cotzSpecies then return false end

	return firstPack ~= nil and firstPack.opponent == secondPack and CurTime() < firstPack.conflictUntil
end

function PLUGIN:ActorsAllied(first, second)
	if first.cotzCombatPack == second.cotzCombatPack then return true end
	if first.cotzCombatPack.isolated or second.cotzCombatPack.isolated then return false end
	if first.cotzFaction or second.cotzFaction then return first.cotzFaction == second.cotzFaction end

	return first.cotzSpecies == second.cotzSpecies
end

function PLUGIN:CanActorAttack(actor, target)
	if not living(actor) or actor.cotzSleeping or not IsValid(target) or target == actor then return false end
	if self:IsCombatActor(target) then
		return living(target) and not target.cotzSleeping and self:ActorsHostile(actor, target)
	end
	if target:IsPlayer() then
		return target:Alive() and GetConVar("ai_ignoreplayers"):GetInt() == 0
			and target:GetMoveType() ~= MOVETYPE_OBSERVER and target:GetMoveType() ~= MOVETYPE_NOCLIP
	end

	return true
end

function PLUGIN:ClearCombatPlayerFocus(actor)
	local focus = actor.cotzPlayerFocus
	if focus then actor.cotzCombatScheduleDirty = true end
	if IsValid(actor) and IsValid(focus) then actor:ClearEnemyMemory(focus) end
	actor.cotzPlayerFocus, actor.cotzPlayerPosition, actor.cotzPlayerContact = nil, nil, nil
	actor.cotzPlayerVisible, actor.cotzNextContactCheck = nil, nil
end

function PLUGIN:GetCombatPlayerFocus(actor)
	local focus = actor.cotzPlayerFocus
	if focus and self:CanActorAttack(actor, focus)
		and CurTime() - actor.cotzPlayerContact < PLAYER_MEMORY_SECONDS then
		return focus
	end
end

function PLUGIN:RememberCombatPlayer(actor, client, position, contactTime)
	contactTime = contactTime or CurTime()
	if actor.cotzPlayerFocus == client and contactTime < actor.cotzPlayerContact then return end

	actor.cotzPlayerFocus = client
	actor.cotzPlayerPosition = position
	actor.cotzPlayerContact = contactTime
	actor.cotzNextContactCheck = 0
end

function PLUGIN:ClearCombatEnemy(actor, preserveFocus)
	local enemy = actor:GetEnemy()
	if IsValid(enemy) then actor:ClearEnemyMemory(enemy) end
	actor:SetEnemy(NULL)
	actor.RegEnemy = nil
	actor.cotzRegrouping = nil
	actor.cotzCombatEnemy = nil
	actor.cotzCombatScheduleDirty = true
	actor.cotzNextEnemySearch, actor.cotzNextHumanSearch = 0, 0
	if not preserveFocus then self:ClearCombatPlayerFocus(actor) end
end

function PLUGIN:ValidateCombatEnemy(actor)
	local enemy = actor:GetEnemy()
	if (IsValid(enemy) and not self:CanActorAttack(actor, enemy))
		or (actor.cotzCombatEnemy and not IsValid(enemy)) then
		self:ClearCombatEnemy(actor, true)
		enemy = nil
	end
	if not living(actor) or actor.cotzSleeping then
		self:ClearCombatPlayerFocus(actor)
		return
	end
	if GetConVar("ai_disabled"):GetInt() ~= 0 then return end

	local focus = actor.cotzPlayerFocus
	if focus and not self:GetCombatPlayerFocus(actor) then
		self:ClearCombatPlayerFocus(actor)
		if enemy == focus then
			self:ClearCombatEnemy(actor)
			enemy = nil
		end
		focus = nil
	end
	if not focus and IsValid(enemy) and enemy:IsPlayer() then
		if actor:Visible(enemy) then
			self:RememberCombatPlayer(actor, enemy, enemy:GetPos())
			focus = enemy
		else
			self:ClearCombatEnemy(actor)
			enemy = nil
		end
	end
	if IsValid(enemy) then
		if actor.cotzCombatEnemy ~= enemy then actor.cotzCombatScheduleDirty = true end
		actor.cotzCombatEnemy = enemy
	end
	if not focus then return end

	if CurTime() >= (actor.cotzNextContactCheck or 0) then
		actor.cotzNextContactCheck = CurTime() + PLAYER_CONTACT_INTERVAL
		local visible = actor:Visible(focus)
		if actor.cotzPlayerVisible ~= visible then actor.cotzCombatScheduleDirty = true end
		actor.cotzPlayerVisible = visible
		if visible then
			actor.cotzPlayerPosition, actor.cotzPlayerContact = focus:GetPos(), CurTime()
			actor:UpdateEnemyMemory(focus, actor.cotzPlayerPosition)
		end
	end
	if enemy ~= focus and not targetBusy(actor) then
		self:SetCombatTarget(actor, focus, actor.cotzPlayerPosition, actor.cotzPlayerContact)
	end
end

function PLUGIN:UpdateCombatSchedule(actor)
	if actor.cotzSleeping or not living(actor) or GetConVar("ai_disabled"):GetInt() ~= 0 then return end
	if targetBusy(actor) then return end
	if actor.cotzNavigationRecovery or actor.cotzNavigationRetreat then return true end

	if actor.cotzCombatScheduleDirty then
		actor.cotzNavigationIntent, actor.cotzNavigationMotion = nil, nil
		actor.cotzNavigationIntentGrounded = nil
		actor:ClearSchedule()
		if actor.ScheduleFinished then actor:ScheduleFinished() end
		if actor.EngineScheduleFinish then actor:EngineScheduleFinish() end
		actor.cotzCombatScheduleDirty, actor.cotzPursuitScheduled, actor.cotzNextPursuit = nil, nil, nil
	end
	local focus = self:GetCombatPlayerFocus(actor)
	local destination, arrivalRadius, objective
	if focus and actor.cotzPlayerVisible == false and actor:GetEnemy() == focus then
		-- Use the observed position, never the hidden player's current position, for pursuit.
		destination, arrivalRadius = actor.cotzPlayerPosition, PURSUIT_ARRIVAL
	elseif not IsValid(actor:GetEnemy()) and IsValid(actor.cotzCombatObjective) then
		-- Task devices are props, so idle mutants approach them without making them combat enemies.
		objective = actor.cotzCombatObjective
		destination = objective:GetPos()
		arrivalRadius = actor.cotzCombatObjectiveRadius or PURSUIT_ARRIVAL
	else
		return
	end

	if actor:GetPos():DistToSqr(destination) <= arrivalRadius ^ 2 and (not objective or actor:Visible(objective)) then
		actor.cotzNavigationIntent, actor.cotzNavigationMotion = nil, nil
		actor.cotzNavigationIntentGrounded = nil
		if actor.cotzPursuitScheduled then actor:ClearSchedule() end
		actor.cotzPursuitScheduled = nil
		return true
	end
	if CurTime() >= (actor.cotzNextPursuit or 0) then
		actor.cotzNextPursuit = CurTime() + PURSUIT_RETRY
		if not actor.cotzPursuitScheduled or not actor:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
			actor.cotzNavigationIntent = destination
			actor.cotzNavigationIntentGrounded = nil
			actor:SetLastPosition(destination)
			actor:SetSchedule(SCHED_FORCED_GO_RUN)
			actor.cotzPursuitScheduled = true
		end
	end

	return true
end

function PLUGIN:SetCombatRelationship(first, second)
	local hostile = self:CanActorAttack(first, second)
	local disposition = hostile and D_HT or (self:ActorsHostile(first, second) and D_NU or D_LI)
	first.cotzRelations = first.cotzRelations or {}
	if first.cotzRelations[second] == disposition then return end
	first.cotzOriginalRelations = first.cotzOriginalRelations or {}
	if first.cotzOriginalRelations[second] == nil then
		first.cotzOriginalRelations[second] = first:Disposition(second)
	end
	first.cotzRelations[second] = disposition
	first:AddEntityRelationship(second, disposition, RELATION_PRIORITY)
end

function PLUGIN:RefreshCombatRelationships(actor)
	for other in pairs(actor.cotzRelations or {}) do
		if living(other) then
			self:SetCombatRelationship(actor, other)
			self:SetCombatRelationship(other, actor)
			self:ValidateCombatEnemy(other)
		end
	end
end

function PLUGIN:SetCombatTarget(actor, target, knownPosition, contactTime)
	if not self:CanActorAttack(actor, target) then return false end
	local previous = actor:GetEnemy()
	local focus = self:GetCombatPlayerFocus(actor)
	if not focus and IsValid(previous) and previous:IsPlayer() and self:CanActorAttack(actor, previous)
		and actor:Visible(previous) then
		self:RememberCombatPlayer(actor, previous, previous:GetPos())
		actor.cotzPlayerVisible = true
		focus = previous
	end
	if focus and focus ~= target then return false end
	if previous ~= target and targetBusy(actor) then return false end
	if target:IsPlayer() then
		local visible = actor:Visible(target)
		if visible then
			knownPosition = target:GetPos()
			contactTime = CurTime()
		elseif not knownPosition then
			return false
		end
		self:RememberCombatPlayer(actor, target, knownPosition, contactTime)
		knownPosition = actor.cotzPlayerPosition
		if actor.cotzPlayerVisible ~= visible then actor.cotzCombatScheduleDirty = true end
		actor.cotzPlayerVisible = visible
		actor.cotzNextContactCheck = CurTime() + PLAYER_CONTACT_INTERVAL
	end
	if self.combatActors[target] then
		self:SetCombatRelationship(actor, target)
		self:SetCombatRelationship(target, actor)
	else
		actor:AddEntityRelationship(target, D_HT, RELATION_PRIORITY)
	end
	actor.cotzRegrouping = nil
	if previous ~= target then
		actor:SetEnemy(target)
		actor.cotzCombatScheduleDirty = true
	end
	actor.cotzCombatEnemy = target
	actor:UpdateEnemyMemory(target, knownPosition or target:GetPos())

	return true
end

function PLUGIN:RetaliateCombatActor(actor, attacker)
	if not IsValid(attacker) or not (attacker:IsPlayer() or attacker:IsNPC()) then return end
	if not self:CanActorAttack(actor, attacker) then return end
	self:ValidateCombatEnemy(actor)
	local focus = self:GetCombatPlayerFocus(actor)
	if focus and focus ~= attacker then return end
	if attacker:IsPlayer() then
		self:RememberCombatPlayer(actor, attacker, attacker:GetPos())
		self:SetCombatTarget(actor, attacker, actor.cotzPlayerPosition, actor.cotzPlayerContact)
	elseif not targetBusy(actor) then
		local enemy = actor:GetEnemy()
		if actor.cotzHuman or not IsValid(enemy)
			or actor:GetPos():DistToSqr(attacker:GetPos()) < actor:GetPos():DistToSqr(enemy:GetPos()) then
			self:SetCombatTarget(actor, attacker)
		end
	end
end

function PLUGIN:FindCombatEnemy(actor, range, halfAngle, budgetTaken)
	if actor.cotzSleeping or GetConVar("ai_disabled"):GetInt() ~= 0 then return end
	if not budgetTaken then
		if (actor.cotzNextHumanSearch or 0) > CurTime() or not self:TakeSearchBudget() then return end
		actor.cotzNextHumanSearch = CurTime() + 2 + (actor:EntIndex() % 10) * 0.03
	end
	self:ValidateCombatEnemy(actor)
	local focus = self:GetCombatPlayerFocus(actor)
	if focus then return focus, 0 end
	if targetBusy(actor) then return end
	self:UpdatePlayerCache()
	local candidates = self:NearbyCombatActors(actor:GetPos(), range)
	for _, client in ipairs(self.combatPlayers or {}) do candidates[#candidates + 1] = client end
	local nearest, bestDistance, count = nil, range ^ 2, 0
	for _, target in ipairs(candidates) do
		if IsValid(target) and target ~= actor then
			if self.combatActors[target] then
				self:SetCombatRelationship(actor, target)
				self:SetCombatRelationship(target, actor)
			end
			local distance = actor:GetPos():DistToSqr(target:GetPos())
			if distance < bestDistance and self:CanActorAttack(actor, target) and actor:Visible(target) then
				local yaw = (target:GetPos() - actor:GetPos()):Angle().y - actor:GetAngles().y
				if math.abs(math.NormalizeAngle(yaw)) <= halfAngle then
					nearest, bestDistance = target, distance
					count = count + 1
				end
			end
		end
	end
	if nearest and self:SetCombatTarget(actor, nearest) then
		self:ShareCombatThreat(actor, nearest)
	end

	return nearest, count
end

function PLUGIN:ShareCombatThreat(actor, target)
	for _, ally in ipairs(self:NearbyCombatActors(actor:GetPos(), AMBIENT_RANGE)) do
		if ally ~= actor and not ally.cotzSleeping and self:ActorsAllied(actor, ally)
			and self:CanActorAttack(ally, target) and not IsValid(ally:GetEnemy()) then
			local position = target:IsPlayer() and actor.cotzPlayerPosition or nil
			self:SetCombatTarget(ally, target, position, actor.cotzPlayerContact)
		end
	end
end

function PLUGIN:EndPackConflict(pack)
	local opponent = pack.opponent
	if not opponent then return end
	pack.opponent, opponent.opponent = nil, nil
	pack.cooldown, opponent.cooldown = CurTime() + CONFLICT_COOLDOWN, CurTime() + CONFLICT_COOLDOWN
	for _, group in ipairs({pack, opponent}) do
		for actor in pairs(group.members) do
			if living(actor) then
				self:RefreshCombatRelationships(actor)
				self:ValidateCombatEnemy(actor)
			end
		end
	end
end

function PLUGIN:StartPackConflict(first, second)
	if first == second or first.isolated or second.isolated or first.opponent or second.opponent then return false end
	if CurTime() < first.cooldown or CurTime() < second.cooldown then return false end
	first.opponent, second.opponent = second, first
	first.conflictUntil, second.conflictUntil = CurTime() + CONFLICT_SECONDS, CurTime() + CONFLICT_SECONDS

	return true
end

function PLUGIN:UpdateAmbientPack(pack, leader)
	if pack.opponent and CurTime() >= pack.conflictUntil then self:EndPackConflict(pack) end
	if GetConVar("ai_disabled"):GetInt() ~= 0 then return end
	if pack.isolated or pack.opponent or CurTime() < pack.nextAmbient then return end
	pack.nextAmbient = CurTime() + AMBIENT_INTERVAL
	if not leader or leader.cotzHuman or leader.cotzSleeping or CurTime() < pack.cooldown then return end
	if self:GetCombatPlayerFocus(leader) or IsValid(leader:GetEnemy()) or targetBusy(leader) then return end
	if not self:TakeSearchBudget() then pack.nextAmbient = CurTime() + 1 return end
	local prey, rival
	for _, other in ipairs(self:NearbyCombatActors(leader:GetPos(), AMBIENT_RANGE)) do
		local otherPack = other.cotzCombatPack
		if otherPack ~= pack and not otherPack.isolated and not otherPack.opponent and not other.cotzSleeping
			and not other.cotzHuman and other.cotzSpecies ~= leader.cotzSpecies
			and not self:ActorsAllied(leader, other)
			and CurTime() >= otherPack.cooldown and leader:Visible(other) then
			rival = rival or other
			if PREDATORS[leader.cotzSpecies] and PREY[other.cotzSpecies] then prey = prey or other end
		end
	end
	local target
	if prey and math.random(100) <= 50 then target = prey
	elseif rival and math.random(100) <= 10 then target = rival end
	if target and self:StartPackConflict(pack, target.cotzCombatPack) then
		self:SetCombatTarget(leader, target)
		self:ShareCombatThreat(leader, target)
	end
end

function PLUGIN:RegroupCombatActor(actor, leader)
	if GetConVar("ai_disabled"):GetInt() ~= 0 then return end
	if not actor.cotzHuman or actor.cotzSleeping or actor.cotzCombatPack.isolated or not leader
		or leader.cotzSleeping or IsValid(actor:GetEnemy()) then actor.cotzRegrouping = nil return end
	if (actor.cotzNextRegroup or 0) > CurTime() then return end
	actor.cotzNextRegroup = CurTime() + 1
	local origin = actor.cotzCombatPack.origin
	local destination = leader:GetPos():DistToSqr(origin) <= HOME_RANGE ^ 2 and leader:GetPos() or origin
	if actor:GetPos():DistToSqr(origin) > HOME_RANGE ^ 2 then destination = origin end
	local distance = actor:GetPos():DistToSqr(destination)
	if distance <= REGROUP_STOP ^ 2 then
		if actor.cotzRegrouping then actor:ClearSchedule() end
		actor.cotzRegrouping = nil
		return
	end
	if distance < REGROUP_START ^ 2 and not actor.cotzRegrouping then return end
	if actor.cotzRegrouping then
		local moved = actor:GetPos():DistToSqr(actor.cotzRegroupPosition)
		if moved < 16 ^ 2 then
			actor.cotzRegrouping = nil
			actor.cotzNextRegroup = CurTime() + REGROUP_RETRY
			actor:ClearSchedule()
			return
		end
	end
	actor.cotzRegrouping, actor.cotzRegroupPosition = true, actor:GetPos()
	actor:SetLastPosition(destination)
	actor:SetSchedule(SCHED_FORCED_GO_RUN)
	self.combatRegroups = (self.combatRegroups or 0) + 1
end

function PLUGIN:UpdateCombatActors()
	self.combatRegroups = 0
	for actor in pairs(self.combatActors) do
		if not living(actor) then self:RemoveCombatActor(actor)
		else
			self:UpdateCombatCell(actor)
			local sleeping = actor.cotzSleeping
			actor:STALKERNPCUpdateSleep()
			self:ValidateCombatEnemy(actor)
			self:UpdateCombatSchedule(actor)
			if sleeping ~= actor.cotzSleeping then self:RefreshCombatRelationships(actor) end
		end
	end
	for _, pack in pairs(self.combatPacks) do
		local leader
		for actor in pairs(pack.members) do
			if not living(actor) then pack.members[actor] = nil
			elseif not leader or actor:EntIndex() < leader:EntIndex() then leader = actor end
		end
		pack.leader = leader
		if not leader then
			self:EndPackConflict(pack)
			self.combatPacks[pack.id] = nil
		end
		self:UpdateAmbientPack(pack, leader)
		for actor in pairs(pack.members) do self:RegroupCombatActor(actor, leader) end
	end
end

function PLUGIN:GetCombatStatus()
	local awake, sleeping, conflicts = 0, 0, 0
	for actor in pairs(self.combatActors) do
		if living(actor) and actor.cotzHuman then
			if actor.cotzSleeping then sleeping = sleeping + 1 else awake = awake + 1 end
		end
	end
	for _, pack in pairs(self.combatPacks) do if pack.opponent then conflicts = conflicts + 1 end end

	return string.format("; humans: %d awake / %d sleeping; pack conflicts: %d; regroups: %d; searches: %d",
		awake, sleeping, conflicts / 2, self.combatRegroups or 0, self.combatSearches or 0)
end

function PLUGIN:GetCombatDamageActor(damage)
	local attacker = damage:GetAttacker()
	if not self:IsCombatActor(attacker) and IsValid(attacker) and attacker.GetOwner then
		local owner = attacker:GetOwner()
		if self:IsCombatActor(owner) then attacker = owner end
	end
	if self:IsCombatActor(attacker) then return attacker end
	local inflictor = damage:GetInflictor()
	if IsValid(inflictor) and inflictor.GetOwner and self:IsCombatActor(inflictor:GetOwner()) then
		return inflictor:GetOwner()
	end
end

function PLUGIN:AllowCombatDamage(victim, damage)
	local attacker = self:GetCombatDamageActor(damage)
	if not attacker then return true end
	self:RegisterCombatActor(attacker)
	if self:IsCombatActor(victim) then self:RegisterCombatActor(victim) end
	if self:CanActorAttack(attacker, victim) then return true end
	damage:SetDamage(0)

	return false
end
