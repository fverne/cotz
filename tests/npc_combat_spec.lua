-- Run from the addon root: luatex --luaonly tests/npc_combat_spec.lua
local fixture = dofile("tests/population_performance_spec.lua")
local manager = fixture.manager
PLUGIN, ix.eventController = manager, manager
fixture.Reset()
fixture.config.mutantLimit, fixture.config.mutantRegionLimit = 0, 0
fixture.config.mutantSearchBudget = 4
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z) return setmetatable({x = x, y = y or 0, z = z or 0}, vectorMeta) end
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2
end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta:GetNormalized()
	local length = math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)

	return Vector(self.x / length, self.y / length, self.z / length)
end
function vectorMeta:Angle() return {y = math.deg(math.atan(self.y, self.x))} end
math.NormalizeAngle = function(value) return (value + 180) % 360 - 180 end
D_HT, D_LI, D_NU = 1, 3, 4
HITGROUP_GENERIC, HITGROUP_HEAD, HITGROUP_CHEST = 0, 1, 2
MOVETYPE_OBSERVER, MOVETYPE_NOCLIP, SCHED_FORCED_GO_RUN = 10, 8, 200
GetConVar = function() return {GetInt = function() return 0 end} end
local function hitboxData(entity, hitbox, hitboxSet)
	return ((entity.hitboxSets or {})[hitboxSet] or {})[hitbox] or {}
end
local function mockHitboxes(entity)
	entity.GetHitboxSet = function(self) return self.hitboxSet end
	entity.GetHitBoxCount = function(self, hitboxSet)
		return ((self.hitboxSets or {})[hitboxSet] or {}).count
	end
	entity.GetHitBoxHitGroup = function(self, hitbox, hitboxSet)
		return hitboxData(self, hitbox, hitboxSet).group
	end
	entity.GetHitBoxBounds = function(self, hitbox, hitboxSet)
		local box = hitboxData(self, hitbox, hitboxSet)

		return box.mins, box.maxs
	end
	entity.GetHitBoxBone = function(self, hitbox, hitboxSet)
		return hitboxData(self, hitbox, hitboxSet).bone
	end
	entity.GetBoneMatrix = function(self, bone) return (self.boneMatrices or {})[bone] end
end
local serial = 1000
local function actor(class, x, pack)
	serial = serial + 1
	local entity = fixture.NewMutant(serial, x)
	entity.class, entity.position, entity.relationships = class, Vector(x, 0, 0), {}
	entity.GetAngles = function(self) return {y = self.facing or 0} end
	entity.SetHealth = function(self, health) self.health = health end
	mockHitboxes(entity)
	entity.WorldSpaceCenter = function(self) return self.position end
	entity.Visible = function(self, other) return not other.hidden end
	entity.SetSquad = function(self, squad) self.squad = squad end
	entity.SetSchedule = function(self, schedule)
		self.schedule, self.scheduleCalls = schedule, (self.scheduleCalls or 0) + 1
	end
	entity.IsCurrentSchedule = function(self, schedule) return self.schedule == schedule end
	entity.ClearSchedule = function(self)
		self.schedule, self.cleared, self.clearCalls = nil, true, (self.clearCalls or 0) + 1
	end
	entity.SetLastPosition = function(self, point) self.destination = point end
	entity.UpdateEnemyMemory = function(self, enemy, position)
		self.remembered, self.rememberedPosition = enemy, position
		self.memoryCalls = (self.memoryCalls or 0) + 1
	end
	entity.AddEntityRelationship = function(self, other, disposition) self.relationships[other] = disposition end
	entity.Disposition = function(self, other) return self.relationships[other] or D_NU end
	manager:RegisterCombatActor(entity, pack)

	return entity
end
local pack = manager:CreateCombatPack(Vector(0), false)
local bandit = actor("npc_human_bandit_pistolman", 0, pack)
local ally = actor("npc_human_bandit_rifleman", 900, pack)
local otherBandit = actor("npc_human_bandit_sniper", 1000)
local merc = actor("npc_human_merc_rifleman", 1100)
local military = actor("npc_human_mili_rifleman", 1200)
check(manager:ActorsAllied(bandit, ally) and manager:ActorsAllied(bandit, otherBandit),
	"faction allies remain friendly across weapon classes and encounter squads")
check(manager:CanActorAttack(bandit, merc) and manager:CanActorAttack(merc, military)
	and manager:CanActorAttack(military, bandit), "all three living factions are rivals")
local zombie = actor("npc_mutant_classiczombie", 1300)
zombie.cotzSpecies, zombie.cotzFaction = "zombie", "undead"
local zombified = actor("npc_human_z_merc_rifleman", 1400)
local lowMutant = actor("npc_mutant_dog", 500)
lowMutant.WorldSpaceCenter = function() return Vector(500, 0, 12) end
bandit.enemy = lowMutant
local spread = Vector(0.1, 0.1, 0)
local bullet = {Src = Vector(0, 0, 64), Dir = Vector(1, 0, 0), Spread = spread, Damage = 20, Num = 6}
check(manager:EntityFireBullets(bandit, bullet) == true and bullet.Dir.z < 0,
	"human shots aim down at a short mutant's collision center")
check(math.abs(64 + bullet.Dir.z * 500 / bullet.Dir.x - 12) < 0.001,
	"the corrected bullet ray intersects the mutant's body height")
check(bullet.Spread == spread and bullet.Damage == 20 and bullet.Num == 6,
	"aim correction preserves spread, damage and pellet count")
bandit.enemy = merc
check(manager:EntityFireBullets(bandit, bullet) == true and bullet.Dir.z < 0,
	"human targets without hitboxes use their collision center")
do
	local function aimMatrix(position, rotation, scale)
		return setmetatable({position = position, rotation = rotation or 0, scale = scale or 1}, {
			__mul = function(matrix, point)
				local sine, cosine = math.sin(matrix.rotation), math.cos(matrix.rotation)

				return matrix.position + Vector(
					point.x * cosine - point.y * sine,
					point.x * sine + point.y * cosine,
					point.z
				) * matrix.scale
			end,
		})
	end
	local function aimsAt(shooter, target, point, message)
		shooter.enemy = target
		check(manager:EntityFireBullets(shooter, bullet) == true, message .. " applies the bullet change")
		local expected = (point - bullet.Src):GetNormalized()
		check(bullet.Dir:DistToSqr(expected) < 0.000001, message)
	end
	merc.hitboxSet = 0
	merc.hitboxSets = {[0] = {
		count = 2,
		[0] = {group = HITGROUP_CHEST, bone = 0, mins = Vector(-4, -6, -24), maxs = Vector(4, 6, -12)},
		[1] = {group = HITGROUP_HEAD, bone = 1, mins = Vector(-3, -3, -3), maxs = Vector(3, 3, 3)},
	}}
	merc.boneMatrices = {[0] = aimMatrix(Vector(1100, 0, 60)), [1] = aimMatrix(Vector(1100, 0, 70))}
	aimsAt(bandit, merc, Vector(1100, 0, 42), "living gunmen aim at the chest hitbox center below its bone origin")
	aimsAt(zombified, merc, Vector(1100, 0, 42), "zombified gunmen use the same chest hitbox preference")
	merc.boneMatrices[0].position = Vector(1120, 20, 50)
	aimsAt(bandit, merc, Vector(1120, 20, 32), "each shot follows the target's current hitbox position")
	merc.hitboxSets[0][0].mins, merc.hitboxSets[0][0].maxs = Vector(2, -2, -12), Vector(10, 6, -4)
	merc.boneMatrices[0] = aimMatrix(Vector(1120, 20, 60), math.pi / 2, 2)
	aimsAt(bandit, merc, Vector(1116, 32, 44), "hitbox centers account for local offsets, rotation and model scale")
	merc.hitboxSet = 1
	merc.hitboxSets[1] = {
		count = 2,
		[0] = {group = HITGROUP_HEAD, bone = 1, mins = Vector(-3, -3, -3), maxs = Vector(3, 3, 3)},
		[1] = {group = HITGROUP_CHEST, bone = 2, mins = Vector(-4, -6, -10), maxs = Vector(4, 6, 0)},
	}
	merc.boneMatrices[2] = aimMatrix(Vector(1100, 0, 35))
	aimsAt(bandit, merc, Vector(1100, 0, 30), "the active hitbox set supplies the chest at any hitbox index")
	merc.hitboxSets[1][0].group = HITGROUP_CHEST
	merc.hitboxSets[1][0].mins = nil
	aimsAt(bandit, merc, Vector(1100, 0, 30), "an unusable chest hitbox does not hide another valid chest")
	lowMutant.hitboxSet = 0
	lowMutant.hitboxSets = {[0] = {
		count = 1,
		[0] = {group = HITGROUP_GENERIC, bone = 0, mins = Vector(-10, -4, -8), maxs = Vector(10, 4, 0)},
	}}
	lowMutant.boneMatrices = {[0] = aimMatrix(Vector(500, 0, 14))}
	aimsAt(bandit, lowMutant, Vector(500, 0, 10), "mutants without a chest group use an actual hitbox center")
	local client = {
		Health = function() return 100 end,
		IsNPC = function() return false end,
		IsPlayer = function() return true end,
		Alive = function() return true end,
		GetMoveType = function() return 0 end,
		GetClass = function() return "player" end,
		GetPos = merc.GetPos,
		WorldSpaceCenter = merc.WorldSpaceCenter,
		hitboxSet = 0,
		hitboxSets = merc.hitboxSets,
		boneMatrices = {[0] = aimMatrix(Vector(200, 0, 56))},
		position = Vector(200),
	}
	mockHitboxes(client)
	aimsAt(bandit, client, Vector(206, 2, 48), "players are also aimed at their chest hitbox center")
	aimsAt(zombified, client, Vector(206, 2, 48), "zombified gunmen aim at player chest hitboxes too")
	client.boneMatrices[0].position = Vector(200, 0, 32)
	aimsAt(bandit, client, Vector(206, 2, 24), "crouching updates the player hitbox aim height on the next shot")
	merc.hitboxSet = 0
	merc.hitboxSets[0][0].group = HITGROUP_GENERIC
	local previousRandom = math.random
	math.random = function(minimum, maximum)
		check(minimum == 0 and maximum == 1, "random fallback uses the entire zero-based hitbox range")

		return maximum
	end
	aimsAt(bandit, merc, Vector(1100, 0, 70), "a target without chest hitboxes selects a random hitbox")
	merc.boneMatrices[1] = nil
	aimsAt(bandit, merc, Vector(1116, 32, 44), "an unavailable random hitbox retries the other hitboxes")
	merc.hitboxSets[0][0].group = HITGROUP_CHEST
	merc.boneMatrices[1] = aimMatrix(Vector(1100, 0, 70))
	aimsAt(bandit, merc, Vector(1116, 32, 44), "a chest hitbox takes priority over the random fallback")
	merc.hitboxSets[0][0].maxs = nil
	aimsAt(bandit, merc, Vector(1100, 0, 70), "an unusable chest falls back to another hitbox center")
	merc.boneMatrices[1] = nil
	aimsAt(bandit, merc, merc.position, "missing hitbox bounds fall back safely when no other hitbox is usable")
	merc.hitboxSets[0][0].maxs = Vector(10, 6, -4)
	merc.hitboxSets[0][0].bone = -1
	aimsAt(bandit, merc, merc.position, "an invalid hitbox bone cannot become an aim point")
	merc.hitboxSets[0][0].bone = nil
	aimsAt(bandit, merc, merc.position, "a missing hitbox bone cannot become an aim point")
	merc.hitboxSets[0][0].bone = 0
	merc.boneMatrices = nil
	aimsAt(bandit, merc, merc.position, "unavailable hitbox transforms fall back to collision center")
	math.random = previousRandom
	merc.hitboxSets[0].count = 0
	aimsAt(bandit, merc, merc.position, "an empty hitbox set falls back without choosing a random hitbox")
	merc.hitboxSet, merc.hitboxSets = nil, nil
	aimsAt(bandit, merc, merc.position, "a model without hitboxes uses its collision center")
	bandit.enemy = ally
	check(manager:EntityFireBullets(bandit, bullet) == false, "aim correction cannot target faction allies")
	bandit.cotzSleeping, bandit.enemy = true, merc
	check(manager:EntityFireBullets(bandit, bullet) == false, "sleeping gunmen cannot shoot through aim correction")
	bandit.cotzSleeping = nil
	local direction = bullet.Dir
	check(manager:EntityFireBullets(lowMutant, bullet) == nil and bullet.Dir == direction,
		"unrelated shooters retain ordinary aim")
	merc.health, bandit.enemy = 0, merc
	check(manager:EntityFireBullets(bandit, bullet) == nil, "dead enemies leave bullets unchanged")
	merc.health = 100
end
bandit.enemy = lowMutant
lowMutant.cotzSleeping = true
check(manager:EntityFireBullets(bandit, bullet) == false, "sleeping mutants cannot be shot through aim correction")
lowMutant.cotzSleeping = nil
bandit.enemy = nil
check(manager:EntityFireBullets(bandit, bullet) == nil, "a missing enemy leaves bullets unchanged")
manager:RemoveCombatActor(lowMutant)
lowMutant.removed = true
bandit.enemy = nil
check(manager:ActorsAllied(zombified, zombie) and manager:CanActorAttack(zombified, merc),
	"zombified humans ally with undead rather than their former faction")
merc.cotzSleeping = true
check(not manager:CanActorAttack(bandit, merc) and not manager:CanActorAttack(merc, bandit),
	"both attacker and NPC target must be awake")
manager:SetCombatRelationship(bandit, merc)
check(bandit.relationships[merc] == D_NU, "sleeping rivals are neutral to engine acquisition")
bandit.enemy = merc
manager:ValidateCombatEnemy(bandit)
check(not bandit.enemy and bandit.forgot, "invalid targets are removed from enemy memory")
local damage = {amount = 20, GetAttacker = function() return bandit end, GetInflictor = function() end,
	SetDamage = function(self, value) self.amount = value end}
check(not manager:AllowCombatDamage(merc, damage) and damage.amount == 0,
	"delayed hits cannot damage a sleeping NPC")
check(not manager:AllowCombatDamage(ally, damage), "allied damage cannot cause retaliation")
merc.cotzSleeping = nil
check(manager:AllowCombatDamage(merc, damage), "awake rival damage remains possible")
local weapon = {GetOwner = function() return bandit end, IsNPC = function() return false end}
damage.GetAttacker = function() return weapon end
check(manager:GetCombatDamageActor(damage) == bandit and not manager:AllowCombatDamage(ally, damage),
	"weapon-owned damage obeys faction policy")
local player = {GetPos = function() return Vector(4000) end, IsNPC = function() return false end,
	IsPlayer = function() return true end, Alive = function() return true end, GetMoveType = function() return 0 end}
fixture.SetPlayers({player})
fixture.SetTime(fixture.GetTime() + 1)
manager:UpdateCombatActors()
check(not bandit.cotzSleeping and not merc.cotzSleeping, "player proximity activates both factions")
manager:FindCombatEnemy(bandit, 1500, 90, true)
check(bandit.enemy == merc and ally.enemy == merc, "visible rival acquisition alerts nearby faction allies")
merc.hidden, military.hidden, zombie.hidden, zombified.hidden = true, true, true, true
bandit.enemy = nil
manager:FindCombatEnemy(bandit, 1500, 90, true)
check(not bandit.enemy, "obscured rivals cannot be acquired")
merc.hidden, military.hidden, zombie.hidden, zombified.hidden = nil, nil, nil, nil
fixture.SetPlayers({})
fixture.SetTime(fixture.GetTime() + 16)
bandit.enemy, merc.enemy = merc, bandit
manager:UpdateCombatActors()
check(bandit.cotzSleeping and merc.cotzSleeping and not bandit.enemy and not merc.enemy,
	"off-screen NPC combat sleeps after player grace instead of maintaining itself")
fixture.Reset()
local dogPack = manager:CreateCombatPack(Vector(0))
local dog = actor("npc_mutant_dog", 0, dogPack)
dog.cotzSpecies = "blinddog"
local dogMate = actor("npc_mutant_pseudodog", 100, dogPack)
dogMate.cotzSpecies = "pseudodog"
local sameSpecies = actor("npc_mutant_dog", 200)
sameSpecies.cotzSpecies = "blinddog"
local prey = actor("npc_mutant_boar", 500)
check(not manager:ActorsHostile(dog, dogMate) and not manager:ActorsHostile(dog, sameSpecies),
	"mixed encounter packmates and same-species packs stay friendly")
local random = math.random
math.random = function() return 1 end
dogPack.nextAmbient = 0
manager:UpdateAmbientPack(dogPack, dog)
math.random = random
check(dogPack.opponent == prey.cotzCombatPack and manager:CanActorAttack(dog, prey),
	"an awake predator pack can initiate hunting a visible prey pack")
check(not manager:StartPackConflict(dogPack, sameSpecies.cotzCombatPack),
	"a pack cannot maintain two opponents")
fixture.SetTime(fixture.GetTime() + 91)
manager:UpdateAmbientPack(dogPack, dog)
check(not dogPack.opponent and not manager:ActorsHostile(dog, prey) and not dog.enemy,
	"expired conflicts clear hostility and targets")
check(not manager:StartPackConflict(dogPack, prey.cotzCombatPack), "cooldown prevents immediate renewed conflict")
local defence = actor("npc_mutant_cat", 600, manager:CreateCombatPack(Vector(600), true))
check(not manager:CanActorAttack(dog, defence) and not manager:CanActorAttack(defence, dog),
	"research wave packs are isolated from ambient NPC combat")
fixture.Reset()
pack = manager:CreateCombatPack(Vector(0))
bandit = actor("npc_human_bandit_pistolman", 0, pack)
ally = actor("npc_human_bandit_rifleman", 900, pack)
manager:RegroupCombatActor(ally, bandit)
check(ally.cotzRegrouping and ally.destination == bandit:GetPos(), "idle followers physically regroup")
fixture.SetTime(fixture.GetTime() + 1)
manager:RegroupCombatActor(ally, bandit)
check(not ally.cotzRegrouping and ally.cotzNextRegroup == fixture.GetTime() + 10,
	"blocked followers back off for ten seconds")
fixture.SetTime(fixture.GetTime() + 11)
ally.position = Vector(100)
manager:RegroupCombatActor(ally, bandit)
check(not ally.cotzRegrouping, "followers stop inside the regroup radius")
ally.position = Vector(3000)
manager:RegroupCombatActor(ally, bandit)
fixture.SetTime(fixture.GetTime() + 2)
manager:RegroupCombatActor(ally, bandit)
check(ally.destination == pack.origin, "out-of-range members return toward their encounter origin")
bandit.invalid = true
fixture.SetPlayers({player})
fixture.SetTime(fixture.GetTime() + 1)
manager:UpdateCombatActors()
check(pack.leader == ally, "a dead leader is replaced by a living squad member")
check(manager.combatPacks[pack.id] == pack, "a surviving follower retains the squad identity")
local singleton = actor("npc_mutant_dog", 10000)
local singletonPack = singleton.cotzCombatPack
manager:RemoveCombatActor(singleton)
check(not manager.combatPacks[singletonPack.id], "empty manual-spawn packs are removed")
local queuePack = manager:CreateCombatPack(Vector(50000))
check(manager:QueueMutant("npc_mutant_dog", Vector(50000), nil, false, queuePack), "pack spawn queues")
manager:ProcessMutantQueue()
check(next(queuePack.members) ~= nil, "spawn queue carries the encounter identity into the live actor")
local status = manager:GetCombatStatus()
check(status:find("humans:", 1, true) and status:find("pack conflicts:", 1, true),
	"population diagnostics expose human activity and pack conflicts")
local searchCalls = 0
local previousQuery = manager.NearbyCombatActors
manager.NearbyCombatActors = function(self, ...)
	searchCalls = searchCalls + 1
	return previousQuery(self, ...)
end
fixture.config.mutantSearchBudget = 1
fixture.SetTime(fixture.GetTime() + 1)
local queryActor = actor("npc_human_merc_pistolman", 20000)
local queryOther = actor("npc_human_mili_pistolman", 30000)
manager:FindCombatEnemy(queryActor, 7000, 45)
manager:FindCombatEnemy(queryOther, 7000, 45)
check(searchCalls == 1, "human searches share a bounded per-tick budget")
manager.NearbyCombatActors = previousQuery
fixture.config.mutantSearchBudget = 4
local oldCell = queryActor.cotzCombatCell
queryActor.position = Vector(80000)
manager:UpdateCombatCell(queryActor)
check(not manager.combatBuckets[oldCell] or not manager.combatBuckets[oldCell][queryActor],
	"moving actors retire their previous spatial-cell membership")
check(#manager:NearbyCombatActors(Vector(80000), 100) == 1,
	"spatial queries resolve the actor's updated position")
queryActor.cotzAwakeUntil = 0
local incoming = {GetAttacker = function() return queryOther end, GetInflictor = function() end,
	SetDamage = function() end}
manager:EntityTakeDamage(queryActor, incoming)
check(queryActor.cotzAwakeUntil == 0, "NPC damage cannot extend off-screen wake grace")
manager:SetCombatRelationship(queryActor, queryOther)
manager:RemoveCombatActor(queryOther)
check(not queryActor.cotzRelations[queryOther] and not queryActor.cotzOriginalRelations[queryOther],
	"removed actors are pruned from both relationship caches")
local observer = {IsNPC = function() return false end, IsPlayer = function() return true end,
	Alive = function() return true end, GetMoveType = function() return MOVETYPE_OBSERVER end}
check(not manager:CanActorAttack(queryActor, observer), "observers remain excluded from enemy selection")

local function targetPlayer(x)
	return {
		position = Vector(x), health = 100,
		GetClass = function() return "player" end,
		GetPos = function(self) return self.position end,
		IsNPC = function() return false end,
		IsPlayer = function() return true end,
		Alive = function(self) return self.health > 0 end,
		Health = function(self) return self.health end,
		GetMoveType = function(self) return self.moveType or 0 end,
	}
end
local function advance(seconds)
	fixture.SetTime(fixture.GetTime() + seconds)
end
for _, class in ipairs({"npc_mutant_dog", "npc_human_bandit_rifleman"}) do
	fixture.Reset()
	local subject = actor(class, 0)
	local rival = actor("npc_human_merc_rifleman", 600)
	local client = targetPlayer(300)
	fixture.SetPlayers({client})
	manager:FindCombatEnemy(subject, 1500, 90, true)
	check(subject.enemy == client and subject.cotzPlayerFocus == client, class .. " acquires player focus")
	manager:UpdateCombatSchedule(subject)
	local clears = subject.clearCalls
	rival.position = Vector(100)
	manager:FindCombatEnemy(subject, 1500, 90, true)
	manager:RetaliateCombatActor(subject, rival)
	manager:UpdateCombatSchedule(subject)
	check(subject.enemy == client and subject.clearCalls == clears,
		class .. " keeps a player over a closer rival without repeated schedule resets")
	local secondPlayer = targetPlayer(50)
	manager:RetaliateCombatActor(subject, secondPlayer)
	check(subject.enemy == client, class .. " keeps the engaged player when a different player attacks")
	check(not manager:SetCombatTarget(subject, rival), class .. " direct assignments cannot steal player focus")

	local contactPosition, contactTime = subject.cotzPlayerPosition, subject.cotzPlayerContact
	client.hidden, client.position = true, Vector(-700)
	advance(0.3)
	manager:ValidateCombatEnemy(subject)
	check(manager:UpdateCombatSchedule(subject) == true and subject.destination == contactPosition,
		class .. " pursues the last observed position after sight is lost")
	local memoryCalls, scheduleCalls = subject.memoryCalls, subject.scheduleCalls
	advance(1)
	manager:ValidateCombatEnemy(subject)
	manager:UpdateCombatSchedule(subject)
	check(subject.cotzPlayerContact == contactTime and subject.memoryCalls == memoryCalls
		and subject.cotzPlayerPosition == contactPosition and subject.scheduleCalls == scheduleCalls,
		class .. " neither tracks hidden movement nor restarts an active pursuit schedule")
	subject.position = contactPosition
	manager:UpdateCombatSchedule(subject)
	check(subject.schedule == nil, class .. " waits at the last known position instead of following hidden movement")
	subject.position = Vector(0)
	subject.enemy = nil
	manager:ValidateCombatEnemy(subject)
	check(subject.enemy == client and subject.rememberedPosition == contactPosition
		and subject.cotzPlayerContact == contactTime, class .. " restores an engine-lost target using existing knowledge")
	client.hidden = nil
	advance(0.3)
	manager:ValidateCombatEnemy(subject)
	manager:UpdateCombatSchedule(subject)
	check(subject.enemy == client and subject.cotzPlayerPosition == client.position
		and subject.cotzPlayerContact > contactTime and not subject.cotzPursuitScheduled,
		class .. " recognizes a remembered player behind it and resumes normal combat")
	client.hidden = true
	advance(10)
	manager:ValidateCombatEnemy(subject)
	check(not subject.enemy and not subject.cotzPlayerFocus, class .. " expires player focus after ten seconds")
	client.hidden = nil
	manager:FindCombatEnemy(subject, 1500, 90, true)
	check(subject.enemy == rival, class .. " returns to normal detection and acquires another target after expiry")

	manager:RetaliateCombatActor(subject, client)
	check(subject.enemy == client and subject.cotzPlayerPosition == client.position,
		class .. " player damage establishes contact from behind")
	client.hidden = true
	advance(5)
	manager:RetaliateCombatActor(subject, client)
	check(subject.cotzPlayerContact == fixture.GetTime(), class .. " new damage refreshes remembered contact")
	client.moveType = MOVETYPE_NOCLIP
	manager:ValidateCombatEnemy(subject)
	check(not subject.enemy and not subject.cotzPlayerFocus, class .. " immediately forgets noclip players")
	client.moveType, client.hidden = nil, nil
	manager:SetCombatTarget(subject, client)
	client.health = 0
	manager:ValidateCombatEnemy(subject)
	check(not subject.enemy and not subject.cotzPlayerFocus, class .. " releases dead player targets")
	client.health = 100
	manager:SetCombatTarget(subject, client)
	client.invalid = true
	manager:ValidateCombatEnemy(subject)
	check(not subject.enemy and not subject.cotzPlayerFocus, class .. " releases disconnected player targets")
	client.invalid = nil
	manager:SetCombatTarget(subject, client)
	local formerConVar = GetConVar
	GetConVar = function(name) return {GetInt = function() return name == "ai_ignoreplayers" and 1 or 0 end} end
	manager:ValidateCombatEnemy(subject)
	check(not subject.enemy and not subject.cotzPlayerFocus, class .. " honors ai_ignoreplayers during pursuit")
	GetConVar = formerConVar

	manager:SetCombatTarget(subject, rival)
	subject.cotzCombatScheduleDirty = nil
	rival.invalid = true
	manager:ValidateCombatEnemy(subject)
	fixture.config.mutantSearchBudget = 0
	manager:FindCombatEnemy(subject, 1500, 90)
	check(not subject.enemy and subject.cotzCombatScheduleDirty,
		class .. " clears a removed rival even while reacquisition has no budget")
	fixture.config.mutantSearchBudget = 4
	client.position = Vector(400)
	manager:FindCombatEnemy(subject, 1500, 90)
	check(subject.enemy == client, class .. " reacquires when search budget becomes available")
	subject.CurrentSchedule, subject.bDoingEngineSchedule = {}, true
	manager:UpdateCombatSchedule(subject)
	check(not subject.CurrentSchedule and not subject.bDoingEngineSchedule,
		class .. " target transitions clear both Lua and engine schedule bookkeeping")
	manager:ClearCombatEnemy(subject)
	check(not subject.cotzPlayerFocus, class .. " sleep cleanup discards remembered players")
	rival.invalid = nil
	manager:SetCombatTarget(subject, rival)
	rival.cotzSleeping = true
	manager:ValidateCombatEnemy(subject)
	manager:FindCombatEnemy(subject, 1500, 90, true)
	check(subject.enemy == client, class .. " replaces a sleeping rival with an eligible player")
	manager:ClearCombatEnemy(subject)
	rival.cotzSleeping = nil
	manager:SetCombatTarget(subject, rival)
	rival.cotzFaction = subject.cotzFaction or "undead"
	if not subject.cotzHuman then subject.cotzFaction = "undead" end
	manager:ValidateCombatEnemy(subject)
	manager:FindCombatEnemy(subject, 1500, 90, true)
	check(subject.enemy == client, class .. " replaces a newly friendly rival with an eligible player")
end

fixture.Reset()
local huntingDog = actor("npc_mutant_dog", 0)
huntingDog.cotzSpecies = "blinddog"
local huntingPrey = actor("npc_mutant_boar", 500)
local huntingPlayer = targetPlayer(300)
manager:SetCombatTarget(huntingDog, huntingPlayer)
huntingDog.cotzCombatPack.nextAmbient = 0
local savedRandom = math.random
math.random = function() return 1 end
manager:UpdateAmbientPack(huntingDog.cotzCombatPack, huntingDog)
math.random = savedRandom
check(not huntingDog.cotzCombatPack.opponent and huntingDog.enemy == huntingPlayer,
	"ambient hunting cannot start while its leader is engaged with a player")
huntingDog.PlayingAnimation, huntingDog.IsGrabbing = true, 2
manager:UpdateCombatSchedule(huntingDog)
check(huntingDog.cotzCombatScheduleDirty and not huntingDog.clearCalls,
	"schedule refresh waits for active mutant animations and grabs")
check(not manager:SetCombatTarget(huntingDog, huntingPrey), "active grabs do not voluntarily switch targets")
huntingDog.PlayingAnimation, huntingDog.IsGrabbing = false, 0
manager:UpdateCombatSchedule(huntingDog)
check(not huntingDog.cotzCombatScheduleDirty and huntingDog.clearCalls == 1,
	"schedule refresh runs once after grab recovery")
manager:ClearCombatEnemy(huntingDog)
huntingDog.PlayingAnimation, huntingDog.isAttacking = true, 2
manager:RetaliateCombatActor(huntingDog, huntingPlayer)
check(not huntingDog.enemy and huntingDog.cotzPlayerFocus == huntingPlayer,
	"damage during an attack remembers the player without interrupting recovery")
huntingDog.PlayingAnimation, huntingDog.isAttacking = false, 0
manager:ValidateCombatEnemy(huntingDog)
check(huntingDog.enemy == huntingPlayer, "deferred player retaliation takes effect after attack recovery")
local alertAlly = actor("npc_mutant_dog", 100, huntingDog.cotzCombatPack)
alertAlly.cotzSpecies = "blinddog"
huntingDog.enemy = nil
manager:ShareCombatThreat(alertAlly, huntingPrey)
check(not huntingDog.enemy and huntingDog.cotzPlayerFocus == huntingPlayer,
	"squad alerts cannot replace remembered player focus after engine target loss")
manager:ValidateCombatEnemy(huntingDog)
manager:ShareCombatThreat(huntingDog, huntingPlayer)
check(alertAlly.enemy == huntingPlayer and alertAlly.cotzPlayerPosition == huntingDog.cotzPlayerPosition,
	"squad player alerts carry an observed position")
local sharedContact = alertAlly.cotzPlayerContact
huntingPlayer.hidden, huntingPlayer.position = true, Vector(900)
advance(2)
alertAlly.enemy = nil
manager:ShareCombatThreat(huntingDog, huntingPlayer)
check(alertAlly.cotzPlayerContact == sharedContact and alertAlly.cotzPlayerPosition.x == 300,
	"repeated squad alerts cannot refresh stale contact or reveal hidden movement")
manager:RetaliateCombatActor(alertAlly, huntingPlayer)
local newerContact, newerPosition = alertAlly.cotzPlayerContact, alertAlly.cotzPlayerPosition
alertAlly.enemy = nil
manager:ShareCombatThreat(huntingDog, huntingPlayer)
check(alertAlly.cotzPlayerContact == newerContact and alertAlly.cotzPlayerPosition == newerPosition,
	"stale squad alerts cannot overwrite an ally's more recent contact")
manager:RemoveCombatActor(alertAlly)
check(not alertAlly.cotzPlayerFocus and not alertAlly.cotzCombatScheduleDirty,
	"actor removal clears player memory and queued schedule work")

local function loadEntityMethod(path, method)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local start = assert(source:find("function ENT:" .. method .. "(", 1, true))
	local finish = source:find("\nfunction ENT:", start + 1, true)
	source = source:sub(start, finish and finish - 1 or #source)
	source = source:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
	source = source:gsub("//([^\n]*)", "--%1")
	ENT = {}
	assert(load(source, "@" .. path .. ":" .. method))()

	return ENT[method]
end

do
	fixture.Reset()
	local researcher = actor("npc_mutant_dog", 0, manager:CreateCombatPack(Vector(0), true))
	local sampler = {GetPos = function() return Vector(1000) end}
	local defender = targetPlayer(300)
	defender.hidden = true
	fixture.SetPlayers({defender})
	researcher.cotzCombatObjective, researcher.cotzCombatObjectiveRadius = sampler, 160
	manager:FindCombatEnemy(researcher, 1500, 90, true)
	local selectSchedule = loadEntityMethod("lua/entities/stalker_ai/schedules.lua", "SelectSchedule")
	selectSchedule(researcher)
	check(not researcher.enemy and researcher.destination.x == 1000
		and researcher.schedule == SCHED_FORCED_GO_RUN,
		"research attackers approach the device through real schedule selection without knowing hidden players")
	local scheduleCalls = researcher.scheduleCalls
	advance(2)
	selectSchedule(researcher)
	check(researcher.scheduleCalls == scheduleCalls, "device pursuit does not restart an active path every update")
	researcher.position = Vector(900)
	selectSchedule(researcher)
	check(not researcher.schedule and not researcher.cotzPursuitScheduled,
		"attackers stop inside the visible device's disruption radius instead of wandering or overlapping it")
	sampler.hidden = true
	advance(1)
	selectSchedule(researcher)
	check(researcher.schedule == SCHED_FORCED_GO_RUN,
		"a wall inside the disruption radius cannot make an attacker stop approaching the device")
	sampler.hidden, researcher.position, defender.hidden = false, Vector(0), false
	advance(1)
	manager:FindCombatEnemy(researcher, 1500, 90, true)
	check(researcher.enemy == defender, "seeing a defender replaces device pursuit with player combat")
	check(manager:UpdateCombatSchedule(researcher) == nil and not researcher.schedule,
		"visible player combat releases the device movement schedule")
	defender.hidden, defender.position = true, Vector(-900)
	advance(0.3)
	manager:ValidateCombatEnemy(researcher)
	manager:UpdateCombatSchedule(researcher)
	check(researcher.destination.x == 300,
		"player pursuit retains last contact instead of returning to the device early")
	advance(11)
	manager:ValidateCombatEnemy(researcher)
	selectSchedule(researcher)
	check(not IsValid(researcher.enemy) and researcher.destination.x == 1000,
		"expired player contact returns research attackers to the device")
	manager:RetaliateCombatActor(researcher, defender)
	manager:UpdateCombatSchedule(researcher)
	check(researcher.enemy == defender and researcher.destination.x == -900,
		"being shot by an unseen player behind the attacker interrupts device pursuit")
	researcher.PlayingAnimation = true
	defender.health = 0
	manager:ValidateCombatEnemy(researcher)
	scheduleCalls = researcher.scheduleCalls
	manager:UpdateCombatSchedule(researcher)
	check(researcher.scheduleCalls == scheduleCalls, "returning to the device cannot interrupt attack recovery")
	researcher.PlayingAnimation = false
	manager:UpdateCombatSchedule(researcher)
	check(researcher.destination.x == 1000, "player death releases the attacker back to the device")
	sampler.invalid = true
	check(manager:UpdateCombatSchedule(researcher) == nil, "removed devices stop owning movement schedules")
	manager:RemoveCombatActor(researcher)
	check(not researcher.cotzCombatObjective and not researcher.cotzCombatObjectiveRadius,
		"actor cleanup releases device references")
end

fixture.Reset()
local recoveringMutant = actor("npc_mutant_dog", 0)
local recoveryPlayer = targetPlayer(500)
manager:SetCombatTarget(recoveringMutant, recoveryPlayer)
recoveringMutant.CurrentSchedule, recoveringMutant.bDoingEngineSchedule = {}, true
recoveryPlayer.hidden = true
manager:RetaliateCombatActor(recoveringMutant, recoveryPlayer)
manager:UpdateCombatSchedule(recoveringMutant)
check(not recoveringMutant.CurrentSchedule and not recoveringMutant.bDoingEngineSchedule
	and recoveringMutant.destination.x == 500,
	"damage contact during the visibility-check cooldown still refreshes lost-sight schedules")
recoveryPlayer.hidden, recoveryPlayer.position = true, Vector(900)
advance(0.3)
local recoveryTicks, newAttacks = 0, 0
recoveringMutant.PlayingAnimation, recoveringMutant.isAttacking = true, 2
recoveringMutant.STALKERNPCCancelPendingTargetAbilities = function() end
recoveringMutant.STALKERNPCThink = function() recoveryTicks = recoveryTicks + 1 end
recoveringMutant.STALKERNPCAnimationIsPlaying = function() end
recoveringMutant.STALKERNPCTryEnemySearch = function() return false end
recoveringMutant.STALKERNPCProcessMeleeAttacks = function() end
recoveringMutant.STALKERNPCIsEnemyNPC = function() return false end
recoveringMutant.STALKERNPCIsEnemyPlayer = function() return true end
recoveringMutant.STALKERNPCThinkNoEnemy = function() end
recoveringMutant.STALKERNPCThinkEnemyValidNoAnimCheck = function() newAttacks = newAttacks + 1 end
loadEntityMethod("lua/entities/stalker_ai/init.lua", "Think")(recoveringMutant)
check(recoveryTicks == 1 and newAttacks == 0 and recoveringMutant.isAttacking == 2,
	"real mutant Think continues attack recovery without starting new combat work during occlusion")
recoveringMutant.PlayingAnimation, recoveringMutant.isAttacking = false, 0
loadEntityMethod("lua/entities/stalker_ai/schedules.lua", "SelectSchedule")(recoveringMutant)
check(recoveringMutant.destination.x == 500 and recoveringMutant.schedule == SCHED_FORCED_GO_RUN,
	"real mutant SelectSchedule pursues remembered positions after recovery")

recoveringMutant.cotzNavigationRecovery = {attempts = 1}
recoveringMutant.cotzNavigationIntent = Vector(-100)
recoveringMutant.destination = recoveringMutant.cotzNavigationIntent
local recoveryScheduleCalls = recoveringMutant.scheduleCalls
check(manager:UpdateCombatSchedule(recoveringMutant) == true
	and recoveringMutant.destination.x == -100 and recoveringMutant.scheduleCalls == recoveryScheduleCalls,
	"remembered pursuit yields to physical recovery instead of replacing its escape destination")
recoveringMutant.cotzNavigationRecovery = nil
recoveringMutant.cotzNavigationRetreat = {distance = 2500}
recoveringMutant.cotzCombatScheduleDirty = true
check(manager:UpdateCombatSchedule(recoveringMutant) == true
	and recoveringMutant.destination.x == -100 and recoveringMutant.scheduleCalls == recoveryScheduleCalls,
	"enemy-memory updates cannot replace an active retreat with another pursuit")
recoveringMutant.cotzNavigationRetreat = nil
recoveringMutant.position = recoveringMutant.cotzPlayerPosition
recoveringMutant.cotzNavigationMotion = {since = 0}
manager:UpdateCombatSchedule(recoveringMutant)
check(not recoveringMutant.cotzNavigationIntent and not recoveringMutant.cotzNavigationMotion,
	"arrival at the remembered position discards stale physical movement tracking")

manager:OnUnload()
check(not recoveringMutant.cotzPlayerFocus and not recoveringMutant.enemy
	and not recoveringMutant.cotzCombatScheduleDirty, "plugin unload discards player memory and queued work")
ix.eventController = manager
-- Execute every armed-human definition's real integration methods, rather than matching source text.
local formerFind = ents.FindByClass
ents.FindByClass = function() error("combat integration must not rescan all NPC classes") end
AddCSLuaFile, include = function() end, function() end
ai_schedule = {New = function() return {EngTask = function() end} end}
fixture.Reset()
local friendly = actor("npc_human_bandit_rifleman", 100)
local enemy = actor("npc_human_merc_rifleman", 200)
local paths = assert(io.popen("rg --files lua/entities | rg 'npc_human_.*/init.lua$'"))
for path in paths:lines() do
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	source = source:gsub("!=", "~="):gsub("&&", "and"):gsub("||", "or"):gsub("!", "not ")
	source = source:gsub("//([^\n]*)", "--%1")
	ENT = {}
	assert(load(source, "@" .. path))()
	local human = actor(path:match("entities/([^/]+)/"), 0)
	human.InitEnemies = ENT.InitEnemies
	ENT.InitEnemies(human)
	check(manager.combatActors[human], "human relationship refresh uses the actor registry")
	human.cotzSleeping = true
	ENT.FindEnemyDan(human)
	check(not human.enemy, "sleeping humans cannot search for enemies")
	local ownDamage = {GetAttacker = function() return human end, GetInflictor = function() end,
		SetDamage = function() end}
	local before = human:Health()
	ENT.OnTakeDamage(human, ownDamage)
	check(human:Health() == before, "human damage callback rejects blocked damage before armour minimums")
	human.cotzSleeping = nil
	human.SpawnBlood, human.StopSpeechSounds, human.PlayRandomSound = function() end, function() end, function() end
	local attackingPlayer = targetPlayer(-300)
	local playerDamage = {
		GetAttacker = function() return attackingPlayer end,
		GetInflictor = function() end,
		IsDamageType = function() return false end,
		GetDamage = function() return 1 end,
	}
	ENT.OnTakeDamage(human, playerDamage)
	check(human.enemy == attackingPlayer and human.cotzPlayerFocus == attackingPlayer,
		"every human damage callback remembers player contact, including non-bullet damage from behind")
	local npcDamage = {
		GetAttacker = function() return enemy end,
		GetInflictor = function() end,
		IsDamageType = function() return false end,
		GetDamage = function() return 1 end,
	}
	-- The mercenary target is allied to mercenary variants, whose damage must remain blocked.
	npcDamage.SetDamage = function() end
	ENT.OnTakeDamage(human, npcDamage)
	check(human.enemy == attackingPlayer, "every human retaliation callback protects player focus")
	attackingPlayer.hidden, attackingPlayer.position = true, Vector(-900)
	advance(0.3)
	human.HasLOS = function() error("remembered pursuit must bypass live-target combat schedules") end
	ENT.Think(human)
	ENT.SelectSchedule(human)
	check(human.destination.x == -300 and human.schedule == SCHED_FORCED_GO_RUN,
		"every human Think and SelectSchedule integration pursues the last observed player position")
	manager:RemoveCombatActor(human)
end
paths:close()
ents.FindByClass = formerFind
print("PASS: " .. checks .. " NPC combat checks")
