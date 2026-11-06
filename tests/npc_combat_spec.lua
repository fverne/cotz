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
function vectorMeta:Angle() return {y = math.deg(math.atan(self.y, self.x))} end
math.NormalizeAngle = function(value) return (value + 180) % 360 - 180 end
D_HT, D_LI, D_NU = 1, 3, 4
MOVETYPE_OBSERVER, MOVETYPE_NOCLIP, SCHED_FORCED_GO_RUN = 10, 8, 200
GetConVar = function() return {GetInt = function() return 0 end} end
local serial = 1000
local function actor(class, x, pack)
	serial = serial + 1
	local entity = fixture.NewMutant(serial, x)
	entity.class, entity.position, entity.relationships = class, Vector(x, 0, 0), {}
	entity.GetAngles = function() return {y = 0} end
	entity.Visible = function(self, other) return not other.hidden end
	entity.SetSquad = function(self, squad) self.squad = squad end
	entity.SetSchedule = function(self, schedule) self.schedule = schedule end
	entity.SetLastPosition = function(self, point) self.destination = point end
	entity.UpdateEnemyMemory = function(self, enemy) self.remembered = enemy end
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
	manager:RemoveCombatActor(human)
end
paths:close()
ents.FindByClass = formerFind
print("PASS: " .. checks .. " NPC combat checks")
