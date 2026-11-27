-- Run from the addon root: luatex --luaonly tests/npc_combat_spec.lua
-- Engine constants exist before plugin files load; sv_combat.lua captures them at file scope.
HITGROUP_GENERIC, HITGROUP_HEAD, HITGROUP_CHEST, HITGROUP_STOMACH, HITGROUP_LEFTLEG = 0, 1, 2, 3, 6
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
function vectorMeta:Angle()
	return {p = math.deg(math.atan(-self.z, math.sqrt(self.x ^ 2 + self.y ^ 2))), y = math.deg(math.atan(self.y, self.x))}
end
function Lerp(fraction, from, to) return from + (to - from) * fraction end
math.NormalizeAngle = function(value) return (value + 180) % 360 - 180 end
D_HT, D_LI, D_NU = 1, 3, 4
MOVETYPE_OBSERVER, MOVETYPE_NOCLIP, SCHED_FORCED_GO_RUN = 10, 8, 200
GetConVar = function() return {GetInt = function() return 0 end, GetBool = function() return false end} end
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
check(manager:ActorsBlockEachOther(bandit, lowMutant) and manager:ActorsBlockEachOther(lowMutant, bandit),
	"living gunmen and hostile mutants collide so bullet traces can hit")
check(manager:ActorsBlockEachOther(bandit, merc), "rival human factions collide so their bullets hit")
check(not manager:ActorsBlockEachOther(bandit, ally) and not manager:ActorsBlockEachOther(bandit, otherBandit),
	"faction allies keep passing through each other")
check(not manager:ActorsBlockEachOther(zombified, lowMutant) and not manager:ActorsBlockEachOther(zombie, lowMutant),
	"undead and mutants share a side and pass through each other")
check(manager:ActorsBlockEachOther(zombified, bandit), "zombified gunmen collide with living factions")
check(not manager:ActorsBlockEachOther(zombie, actor("npc_mutant_boar", 1500)),
	"mutant-only pairs keep passing through regardless of timed species conflicts")
check((lowMutant.collisionRefreshes or 0) > 0, "registering a combat actor refreshes cached collision rules")
local refreshesBeforeRemoval = lowMutant.collisionRefreshes
manager:RemoveCombatActor(lowMutant)
check(lowMutant.collisionRefreshes == refreshesBeforeRemoval + 1, "removing a combat actor refreshes collision rules")
manager:RegisterCombatActor(lowMutant)
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
	lowMutant.hitboxSets[0] = {
		count = 3,
		[0] = {group = HITGROUP_LEFTLEG, bone = 0, mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2)},
		[1] = {group = HITGROUP_STOMACH, bone = 1, mins = Vector(-8, -4, -4), maxs = Vector(8, 4, 4)},
		[2] = {group = HITGROUP_HEAD, bone = 2, mins = Vector(-3, -3, -3), maxs = Vector(3, 3, 3)},
	}
	lowMutant.boneMatrices = {[0] = aimMatrix(Vector(500, 0, 1)), [1] = aimMatrix(Vector(500, 0, 23)),
		[2] = aimMatrix(Vector(520, 0, 35))}
	aimsAt(bandit, lowMutant, Vector(500, 0, 23), "mutants with a stomach-tagged torso are aimed at the torso, not a paw")
	lowMutant.hitboxSets[0][0].group = HITGROUP_CHEST
	aimsAt(bandit, lowMutant, Vector(500, 0, 1), "a chest hitbox still takes priority over the stomach")
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
local controller = actor("npc_mutant_controller", 1350)
check(not manager:ActorsHostile(zombie, controller) and not manager:CanActorAttack(zombie, controller)
	and not manager:CanActorAttack(controller, zombie) and not manager:CanActorAttack(zombified, controller),
	"undead never fight mutants from other packs")
check(manager:CanActorAttack(zombie, merc) and manager:CanActorAttack(merc, zombie),
	"undead remain hostile to living human factions")
manager:SetCombatRelationship(controller, zombie)
check(controller.relationships[zombie] == D_LI, "mutants treat undead as friendly in engine targeting")
local mutantDamage = {amount = 20, GetAttacker = function() return controller end, GetInflictor = function() end,
	SetDamage = function(self, value) self.amount = value end}
check(not manager:AllowCombatDamage(zombie, mutantDamage), "mutant damage cannot hurt undead")
manager:RemoveCombatActor(controller)
controller.removed = true
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
local deathDamage = {
	amount = 20,
	GetAttacker = function() return zombie end,
	GetInflictor = function() return zombie end,
	SetDamage = damage.SetDamage,
}
zombie.health, zombie.IsAlive = 0, false
check(not manager:AllowCombatDamage(player, deathDamage) and deathDamage.amount == 0,
	"dead mutants cannot deal ordinary damage")
zombie.cotzApplyingDeathEffect = true
deathDamage.amount = 20
check(manager:AllowCombatDamage(player, deathDamage) and deathDamage.amount == 20,
	"direct mutant death effects can damage living players")
check(manager:AllowCombatDamage(merc, deathDamage), "direct mutant death effects can damage hostile NPCs")
check(not manager:AllowCombatDamage(zombified, deathDamage), "mutant death effects still protect allied NPCs")
check(not manager:CanActorAttack(zombie, player), "death effects do not let dead mutants select targets")
deathDamage.GetInflictor = function() return weapon end
check(not manager:AllowCombatDamage(player, deathDamage), "indirect damage still requires a living mutant")
zombie.cotzApplyingDeathEffect = nil
deathDamage.GetInflictor = deathDamage.GetAttacker
check(not manager:AllowCombatDamage(player, deathDamage), "death effect damage is limited to the callback")
zombie.health, zombie.IsAlive = 100, true
fixture.SetPlayers({player})
fixture.SetTime(fixture.GetTime() + 1)
manager:UpdateCombatActors()
check(not bandit.cotzSleeping and not merc.cotzSleeping, "player proximity activates both factions")
manager:FindCombatEnemy(bandit, 1500, 90, true)
check(bandit.enemy == merc and not ally.enemy and ally.cotzCombatApproach.x == 1100,
	"visible rival acquisition sends nearby faction allies toward the rival without assigning it")
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
huntingDog.PlayingAnimation, huntingDog.cotzAbility = true, {}
manager:UpdateCombatSchedule(huntingDog)
check(huntingDog.cotzCombatScheduleDirty and not huntingDog.clearCalls,
	"schedule refresh waits for active mutant animations and grabs")
check(not manager:SetCombatTarget(huntingDog, huntingPrey), "active grabs do not voluntarily switch targets")
huntingDog.PlayingAnimation, huntingDog.cotzAbility = false, nil
manager:UpdateCombatSchedule(huntingDog)
check(not huntingDog.cotzCombatScheduleDirty and huntingDog.clearCalls == 1,
	"schedule refresh runs once after grab recovery")
manager:ClearCombatEnemy(huntingDog)
huntingDog.PlayingAnimation, huntingDog.cotzAbility = true, {}
manager:RetaliateCombatActor(huntingDog, huntingPlayer)
check(not huntingDog.enemy and huntingDog.cotzPlayerFocus == huntingPlayer,
	"damage during an attack remembers the player without interrupting recovery")
huntingDog.PlayingAnimation, huntingDog.cotzAbility = false, nil
manager:ValidateCombatEnemy(huntingDog)
check(huntingDog.enemy == huntingPlayer, "deferred player retaliation takes effect after attack recovery")
local alertAlly = actor("npc_mutant_dog", 100, huntingDog.cotzCombatPack)
alertAlly.cotzSpecies = "blinddog"
huntingDog.enemy = nil
manager:ShareCombatThreat(alertAlly, huntingPrey)
check(not huntingDog.enemy and not huntingDog.cotzCombatApproach and huntingDog.cotzPlayerFocus == huntingPlayer,
	"squad alerts cannot replace remembered player focus after engine target loss")
manager:ValidateCombatEnemy(huntingDog)
manager:ShareCombatThreat(huntingDog, huntingPlayer)
check(not alertAlly.enemy and not alertAlly.cotzPlayerFocus
	and alertAlly.cotzCombatApproach == huntingDog.cotzPlayerPosition,
	"squad player alerts send allies to the observed position without assigning the player")
huntingPlayer.hidden, huntingPlayer.position = true, Vector(900)
advance(2)
manager:ShareCombatThreat(huntingDog, huntingPlayer)
check(alertAlly.cotzCombatApproach.x == 300, "repeated squad alerts cannot reveal hidden movement")
manager:UpdateCombatSchedule(alertAlly)
check(alertAlly.schedule == SCHED_FORCED_GO_RUN and alertAlly.destination.x == 300,
	"alerted allies run toward the reported position")
local alertRival = actor("npc_human_merc_rifleman", 150)
manager:FindCombatEnemy(alertAlly, 1500, 90, true)
check(alertAlly.enemy == alertRival and manager:UpdateCombatSchedule(alertAlly) == nil
	and not alertAlly.cotzCombatApproach and not alertAlly.schedule,
	"alerted allies engage a different target spotted on the way")
manager:RemoveCombatActor(alertRival)
manager:RemoveCombatActor(alertAlly)
check(not alertAlly.cotzPlayerFocus and not alertAlly.cotzCombatScheduleDirty and not alertAlly.cotzCombatApproach,
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
	local mutant = actor("npc_mutant_dog", 0, manager:CreateCombatPack(Vector(0), true))
	local initialDefender, visibleDefender = targetPlayer(500), targetPlayer(700)
	initialDefender.hidden = true
	fixture.SetPlayers({initialDefender})
	manager:SetCombatApproach(mutant, initialDefender:GetPos())
	initialDefender.position = Vector(900)
	manager:FindCombatEnemy(mutant, 1500, 90, true)
	manager:UpdateCombatSchedule(mutant)
	check(mutant.destination.x == 500 and mutant.schedule == SCHED_FORCED_GO_RUN
		and not mutant.enemy and not mutant.cotzPlayerFocus and not mutant.memoryCalls,
		"the spawn approach uses a fixed point without engaging or tracking the hidden defender")

	fixture.SetPlayers({initialDefender, visibleDefender})
	advance(1)
	manager:FindCombatEnemy(mutant, 1500, 90, true)
	check(manager:UpdateCombatSchedule(mutant) == nil and mutant.enemy == visibleDefender
		and not mutant.cotzCombatApproach and not mutant.schedule,
		"normal sight-based acquisition cancels the spawn approach for a different defender")

	local idleMutant = actor("npc_mutant_dog", 0)
	manager:SetCombatApproach(idleMutant, Vector(500))
	manager:UpdateCombatSchedule(idleMutant)
	idleMutant.position = Vector(490)
	check(manager:UpdateCombatSchedule(idleMutant) == nil and not idleMutant.schedule
		and not idleMutant.cotzCombatApproach, "arrival releases movement to normal AI")
	manager:SetCombatApproach(idleMutant, Vector(1000))
	manager:UpdateCombatSchedule(idleMutant)
	advance(10)
	check(manager:UpdateCombatSchedule(idleMutant) == nil and not idleMutant.schedule
		and not idleMutant.cotzCombatApproach, "an unfinished approach expires")
end

do
	fixture.Reset()
	local researcher = actor("npc_mutant_dog", 0, manager:CreateCombatPack(Vector(0), true))
	local sampler = {GetPos = function() return Vector(1000) end}
	local defender = targetPlayer(300)
	defender.hidden = true
	fixture.SetPlayers({defender})
	researcher.cotzCombatObjective, researcher.cotzCombatObjectiveRadius = sampler, 160
	researcher.cotzCombatLeash = 2048
	researcher.cotzCombatObjectiveApproach = Vector(700)
	manager:FindCombatEnemy(researcher, 1500, 90, true)
	local selectSchedule = loadEntityMethod("lua/entities/stalker_ai/schedules.lua", "SelectSchedule")
	selectSchedule(researcher)
	check(not researcher.enemy and researcher.destination.x == 700
		and researcher.schedule == SCHED_FORCED_GO_RUN, "research attackers immediately move toward the connected node")
	researcher.position = Vector(700)
	selectSchedule(researcher)
	check(not researcher.enemy and researcher.destination.x == 1000
		and researcher.schedule == SCHED_FORCED_GO_RUN and not researcher.cotzCombatObjectiveApproach,
		"research attackers continue from the node to the sampler without knowing hidden players")
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
	defender.health, defender.hidden, defender.position = 100, false, Vector(3000)
	check(manager:SetCombatTarget(researcher, defender), "research attackers can fight inside the defence area")
	defender.position = Vector(3100)
	manager:ValidateCombatEnemy(researcher)
	manager:UpdateCombatSchedule(researcher)
	check(not IsValid(researcher:GetEnemy()) and researcher.destination.x == 1000
		and not manager:SetCombatTarget(researcher, defender),
		"players leaving the defence radius cannot pull attackers with them or reacquire them")
	sampler.invalid = true
	check(manager:UpdateCombatSchedule(researcher) == nil, "removed devices stop owning movement schedules")
	manager:RemoveCombatActor(researcher)
	check(not researcher.cotzCombatObjective and not researcher.cotzCombatObjectiveRadius
		and not researcher.cotzCombatLeash,
		"actor cleanup releases device references")
end

do
	local runAway = loadEntityMethod("lua/entities/npc_mutant_dog/init.lua", "RunAway")
	local dog = {SetSchedule = function(self) self.fleeScheduled = true end}
	dog.cotzCombatLeash = 2048
	runAway(dog)
	check(not dog.MustFlee and not dog.fleeScheduled, "research dogs ignore pack-death fleeing")
	dog.cotzCombatLeash = nil
	runAway(dog)
	check(dog.MustFlee and dog.fleeScheduled, "ambient dogs retain pack-death fleeing")
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
recoveringMutant.PlayingAnimation, recoveringMutant.cotzAbility = true, {}
recoveringMutant.STALKERNPCUpdateAbility = function() end
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
check(recoveryTicks == 1 and newAttacks == 0 and recoveringMutant.cotzAbility,
	"real mutant Think continues attack recovery without starting new combat work during occlusion")
recoveringMutant.PlayingAnimation, recoveringMutant.cotzAbility = false, nil
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
ACT_IDLE, ACT_IDLE_ANGRY, ACT_WALK, ACT_WALK_AIM, ACT_RUN, ACT_RUN_AIM = 1, 2, 3, 4, 5, 6
ACT_CROUCHIDLE, ACT_WALK_CROUCH, ACT_WALK_CROUCH_AIM = 7, 8, 9
ACT_RELOAD_SMG1, ACT_RUN_RIFLE, ACT_COVER_LOW, ACT_JUMP, ACT_TURN_LEFT = 10, 11, 12, 13, 14
ACT_HL2MP_IDLE_AR2, ACT_HL2MP_IDLE_RPG, ACT_HL2MP_RUN_AR2, ACT_HL2MP_RUN_RPG = 101, 102, 103, 104
ACT_HL2MP_IDLE_CROUCH_RPG, ACT_HL2MP_WALK_CROUCH_RPG = 105, 106
isstring = function(value) return type(value) == "string" end
isnumber = function(value) return type(value) == "number" end
SCHED_TAKE_COVER_FROM_ENEMY = 201
ENT = {}
dofile("lua/entities/cotz_human_base/init.lua")
local humanBase = ENT
dofile("lua/entities/cotz_human_base/weaponprops.lua")
dofile("lua/entities/cotz_human_base/models.lua")
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
	setmetatable(ENT, {__index = humanBase})
	local group = humanBase.FactionModels[ENT.ModelGroup]
	check(group and #group > 0, "every human's model group has an active model: " .. path)
	for _, model in ipairs(group) do
		check(model:find("^models/flaymi/anomaly/stalker_%a+/[%w_]+%.mdl$"), "humans use Anomaly models: " .. model)
	end
	check((path:find("/npc_human_z_", 1, true) ~= nil) == (ENT.Undead == true), "only zombified humans are undead: " .. path)
	local human = actor(path:match("entities/([^/]+)/"), 0)
	local mutantMethods = getmetatable(human) and getmetatable(human).__index
	setmetatable(human, {__index = function(_, key)
		local method = ENT[key]
		if method ~= nil then return method end
		if type(mutantMethods) == "function" then return mutantMethods(human, key) end

		return (mutantMethods or {})[key]
	end})
	human.NextThink = function() end
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

local cornered = setmetatable(actor("npc_human_bandit_sniper", 0), {__index = humanBase})
cornered.combatProfile = {range = 4000, retreat = 750, burst = 1}
cornered.EngineScheduleFinish, cornered.StopMoving = function() end, function() end
cornered.SetPoseParameter = function() end
cornered.UpdateFiringMovement = function() end
local weapon = {
	Primary = {NumShots = 1, Cone = 4, Damage = 20, Force = 10, Tracer = 1, Ammo = "SMG1", Delay = 3},
	GetMaxClip1 = function() return 1 end,
	EmitSound = function() end,
}
cornered.clip = 1
cornered.GetActiveWeapon = function() return weapon end
cornered.GetCombatLane = function() return true, Vector(0), Vector(100) end
cornered.FaceCombatTarget = function() return true end
cornered.PlayCombatGesture = function() return 1 end
cornered.MuzzleFlash = function() end
local rounds = 0
cornered.FireBullets = function(_, data)
	rounds = rounds + 1
	check(data.Damage == 20 and data.Inflictor == weapon, "the managed shot keeps SWEP damage and attribution")
end
local raises = 0
cornered.IsMoving, cornered.ResetIdealActivity = function() return false end, function() raises = raises + 1 end
cornered:UpdateGunCombat(enemy, manager, 5.4, 100 ^ 2)
check(rounds == 0 and raises == 1, "an engaged shooter raises its gun before the first shot")
cornered:UpdateGunCombat(enemy, manager, 5.8, 100 ^ 2)
check(rounds == 0 and raises == 1, "the shooter keeps raising its gun for a moment")
cornered:UpdateGunCombat(enemy, manager, 6, 100 ^ 2)
check(rounds == 1 and cornered.clip == 0, "a cornered sniper fires and spends one round")
check(weapon.clip == nil, "the engine weapon clip is never emptied, so the engine cannot start its own reload")
cornered:UpdateGunCombat(enemy, manager, 6.1, 100 ^ 2)
check(rounds == 1, "the sniper respects its weapon fire delay")
cornered:UpdateGunCombat(enemy, manager, 9.2, 100 ^ 2)
check(rounds == 1 and cornered.reloadAt, "an empty weapon starts a bounded reload")
cornered.reloadAt, cornered.NextThink, cornered.GetEnemy = CurTime() - 1, function() end, function() end
cornered.FindEnemyDan, cornered.STALKERNPCClearAnimation = function() end, function() end
humanBase.Think(cornered)
check(cornered.clip == 1 and not cornered.reloadAt, "a finished reload refills the managed clip")

-- Moving fire: forced-go moves around the target, which combat conditions cannot interrupt.
SCHED_FORCED_GO, SCHED_CHASE_ENEMY = SCHED_FORCED_GO or 199, SCHED_CHASE_ENEMY or 198
local mover = setmetatable(actor("npc_human_bandit_rifleman", 0), {__index = humanBase})
mover.combatProfile = {range = 2000, retreat = 550, burst = 99}
for _, name in ipairs({"GetActiveWeapon", "GetCombatLane", "FaceCombatTarget", "PlayCombatGesture", "MuzzleFlash"}) do
	mover[name] = cornered[name]
end
mover.AimAt, mover.StopMoving, mover.EngineScheduleFinish = function() end, function() end, function() end
mover.ResetIdealActivity = function() end
local unaware = false
mover.IsTargetUnaware = function() return unaware end
mover.IsWeaponRaised = function() return true end
local moving, waypoint, shots = true, Vector(300, 0, 0), 0
mover.IsMoving = function() return moving end
mover.GetCurWaypointPos = function() return waypoint end
mover.FireBullets = function() shots = shots + 1 end
local wallFraction, groundHit = 1, true
util = util or {}
local formerTraceLine = util.TraceLine
util.TraceLine = function(data)
	if data.endpos.z < data.start.z then return {Hit = groundHit, HitPos = Vector(data.start.x, data.start.y, 0)} end

	return {Fraction = wallFraction}
end
local formerRandom, formerRand = math.random, math.Rand
math.random = function() return 1 end
math.Rand = function(low) return low end
local clock = 200
local function shoot(distance)
	clock = clock + 2
	mover.clip, mover.nextShot = 5, 0
	local before = shots
	mover:UpdateGunCombat(enemy, manager, clock, distance ^ 2)

	return shots > before
end
check(shoot(100) and mover.schedule == SCHED_FORCED_GO_RUN and mover.destination.x < 0
	and mover.moveFireTarget == enemy, "a cornered shooter runs back from the target while it fires")
local goal = mover.destination
mover.destination = nil
check(shoot(100) and not mover.destination, "a running firing move is not restarted")
mover.schedule, mover.combatMovement, mover.firingMove = SCHED_CHASE_ENEMY, SCHED_CHASE_ENEMY, nil
mover.nextMovement = math.huge
check(shoot(1500) and mover.schedule == SCHED_FORCED_GO_RUN and mover.destination.x > 0,
	"a chase that reaches firing range keeps advancing as a firing move")
mover:ClearSchedule()
check(shoot(1000) and mover.schedule == SCHED_FORCED_GO and math.abs(mover.destination.y) > 0,
	"a shooter inside its holding distance strafes while it fires")
mover:ClearSchedule()
wallFraction = 0.5
check(shoot(1000) and not mover.schedule and not mover.combatMovement, "a wall in the way leaves the shooter standing")
wallFraction, groundHit = 1, false
check(shoot(1000) and not mover.schedule, "a goal without ground is never used")
groundHit, mover.crouching, mover.crouchUntil = true, true, math.huge
check(shoot(1000) and not mover.schedule, "a crouching shooter holds still")
mover.crouching, unaware = nil, true
check(shoot(1000) and not mover.schedule, "a sneaking shooter stands for its first shot")
unaware = false

mover.Undead, mover.moveFireTarget = true, nil
waypoint = enemy:GetPos()
check(shoot(1500) and mover.schedule == SCHED_FORCED_GO and mover.destination.x > 0
	and math.abs(mover.destination.y) < 0.001 and not mover.moveFireTarget,
	"a zombie walks straight at the target while it fires and keeps the engine's facing")
mover:ClearSchedule()
check(shoot(200) and not mover.schedule, "a zombie stops walking once it is close")
mover.schedule, mover.combatMovement, mover.firingMove = SCHED_FORCED_GO, SCHED_FORCED_GO, true
waypoint = Vector(0, 100, 0)
check(not shoot(1500), "a zombie never fires while its path turns sideways")
waypoint = Vector(-100, 0, 0)
check(not shoot(1500), "a zombie never fires while moving backward")
moving = false
check(shoot(1500), "a standing zombie can fire")
math.random, math.Rand, util.TraceLine = formerRandom, formerRand, formerTraceLine
check(goal.x == -96, "moves keep their clearance from where the probe ended")

local blend, turnedTo = {}, nil
mover.SetPoseParameter = function(_, name, value) blend[name] = value end
mover.SetIdealYawAndUpdate = function(_, yaw) turnedTo = yaw end
mover.GetAngles = function() return {y = 0} end
mover.GetEnemy = function() return enemy end
local function step(x, y)
	local direction = Vector(x, y, 0)

	return mover:OverrideMoveFacing(0.1, {dir = direction})
end
local function blends(x, y) return math.abs(blend.move_x - x) < 0.001 and math.abs(blend.move_y - y) < 0.001 end
mover.moveFireTarget = enemy
check(step(-1, 0) and turnedTo == 0 and blends(-1, 0), "backing away faces the target and backpedals")
check(step(0, 1) and blends(0, -1), "a path to the left strafes left")
check(step(0, -1) and blends(0, 1), "a path to the right strafes right")
check(step(-1, -1) and blends(-1, 1), "diagonals stay on the edge of the blend")
mover.moveFireTarget = nil
check(not step(0, 1) and blends(0, 0), "without a shot the engine faces the path and runs forward")
mover.moveFireTarget, mover.cotzSleeping = enemy, true
mover.NextThink, mover.STALKERNPCClearAnimation = function() end, function() end
humanBase.Think(mover)
check(not mover.moveFireTarget, "a think that cannot shoot releases the facing")

local melee = setmetatable(actor("npc_human_bandit_melee", 0), {__index = humanBase})
melee.stance, melee.meleeDamage = {calm = "melee2", aim = "melee2"}, 7
melee.FaceCombatTarget = function() return true end
melee.PlayCombatGesture = function() end
local clear = true
melee.GetCombatLane = function() return clear, Vector(0), Vector(40) end
DMG_CLUB = 128
DamageInfo = function()
	return {SetAttacker = function() end, SetInflictor = function() end, SetDamagePosition = function() end,
		SetDamageType = function(self, kind) self.kind = kind end,
		SetDamage = function(self, amount) self.amount = amount end}
end
local hits = 0
enemy.TakeDamageInfo = function(_, info)
	check(info.kind == DMG_CLUB and info.amount == 7, "melee uses only low blunt damage")
	hits = hits + 1
end
melee:UpdateMeleeCombat(enemy, manager, 0, 40 ^ 2)
melee:UpdateMeleeCombat(enemy, manager, 0.5, 90 ^ 2)
check(hits == 0, "a target that leaves reach dodges the swing")
melee:UpdateMeleeCombat(enemy, manager, 2, 40 ^ 2)
clear = false
melee:UpdateMeleeCombat(enemy, manager, 2.5, 40 ^ 2)
check(hits == 0, "cover blocks a swing at impact")
clear = true
melee:UpdateMeleeCombat(enemy, manager, 4, 40 ^ 2)
melee:UpdateMeleeCombat(enemy, manager, 4.5, 40 ^ 2)
melee:UpdateMeleeCombat(enemy, manager, 4.6, 40 ^ 2)
check(hits == 1, "one completed swing deals damage once")


-- Stances: calm poses while patrolling, raised-gun poses once an enemy is engaged.
local sequenceIds = {idle_ar2 = 1, run_mp_ar2 = 2, idle_rpg = 3, run_mp_rpg = 4, cidle_rpg = 5, cwalk_mp_rpg = 6}
local sequenceActivities = {ACT_HL2MP_IDLE_AR2, ACT_HL2MP_RUN_AR2, ACT_HL2MP_IDLE_RPG, ACT_HL2MP_RUN_RPG,
	ACT_HL2MP_IDLE_CROUCH_RPG, ACT_HL2MP_WALK_CROUCH_RPG}
local engaged
local gunman = setmetatable(actor("npc_human_bandit_rifleman", 0), {__index = humanBase})
gunman.LookupSequence = function(_, name) return sequenceIds[name] or -1 end
gunman.GetSequenceActivity = function(_, index) return sequenceActivities[index] end
gunman.SelectWeightedSequence = function(_, activity) return activity == ACT_JUMP and 5 or -1 end
gunman.GetEnemy = function() return engaged end
gunman.stanceActivities = {
	calm = gunman:BuildStanceActivities({"ar2", "rpg"}),
	aim = gunman:BuildStanceActivities({"rpg", "ar2"}),
}
check(gunman:TranslateActivity(ACT_IDLE) == ACT_HL2MP_IDLE_AR2, "patrolling riflemen use the calm two-handed idle")
check(gunman:TranslateActivity(ACT_RUN) == ACT_HL2MP_RUN_AR2, "patrolling riflemen use the calm two-handed run")
check(gunman:TranslateActivity(ACT_IDLE_ANGRY) == ACT_HL2MP_IDLE_RPG, "an alerted idle raises the gun")
engaged = enemy
check(gunman:TranslateActivity(ACT_IDLE) == ACT_HL2MP_IDLE_RPG, "an engaged rifleman idles with the rpg pose")
check(gunman:TranslateActivity(ACT_RUN) == ACT_HL2MP_RUN_RPG, "an engaged rifleman runs with the rpg pose")
check(gunman:TranslateActivity(ACT_RUN_AIM) == ACT_HL2MP_RUN_RPG, "aimed running uses the rpg pose")
check(gunman:TranslateActivity(ACT_RELOAD_SMG1) == ACT_HL2MP_IDLE_RPG, "engine reloads hold an aimed pose, not a T-pose")
check(gunman:TranslateActivity(ACT_RUN_RIFLE) == ACT_HL2MP_RUN_RPG, "weapon-specific run activities still run")
check(gunman:TranslateActivity(ACT_COVER_LOW) == ACT_HL2MP_IDLE_CROUCH_RPG, "cover activities without a sequence crouch")
check(gunman:TranslateActivity(ACT_TURN_LEFT) == ACT_HL2MP_IDLE_RPG, "turn activities without a sequence idle")
check(gunman:TranslateActivity(ACT_WALK) == ACT_HL2MP_IDLE_RPG, "a pose without a walk sequence idles instead of T-posing")
check(gunman:TranslateActivity(9999) == ACT_HL2MP_IDLE_RPG, "unknown activities idle")
check(gunman:TranslateActivity(ACT_JUMP) == nil, "activities the model animates itself are left alone")
gunman.crouching = true
check(gunman:TranslateActivity(ACT_IDLE_ANGRY) == ACT_HL2MP_IDLE_CROUCH_RPG, "a crouching shooter idles crouched")
check(gunman:TranslateActivity(ACT_RUN) == ACT_HL2MP_RUN_RPG, "crouching alone does not slow movement")
gunman.crouching, gunman.sneaking = nil, true
check(gunman:TranslateActivity(ACT_RUN) == ACT_HL2MP_WALK_CROUCH_RPG, "a sneaking NPC creeps instead of running")
check(gunman:TranslateActivity(ACT_WALK_AIM) == ACT_HL2MP_WALK_CROUCH_RPG, "a sneaking NPC creeps instead of walking")
check(gunman:TranslateActivity(ACT_IDLE) == ACT_HL2MP_IDLE_RPG, "sneaking leaves standing idles alone")
gunman.sneaking = nil
gunman.dead = true
check(gunman:TranslateActivity(ACT_IDLE) == nil, "a dying NPC is not translated")
gunman.dead = nil
engaged = nil

-- The arms follow the bullets' aim point: pitch is positive downward, yaw positive to the left of the body.
local posed = {}
gunman.SetPoseParameter = function(_, name, value) posed[name] = value end
gunman.GetAngles = function() return {y = 90} end
for _ = 1, 12 do gunman:AimAt(Vector(0, 0, 55), Vector(0, 100, 55 - 100 * math.tan(math.rad(10)))) end
check(math.abs(posed.aim_pitch - 10) < 0.1, "a lower target pitches the arms down")
check(math.abs(posed.aim_yaw) < 0.1, "a target straight ahead needs no yaw")
for _ = 1, 12 do gunman:AimAt(Vector(0, 0, 55), Vector(-100, 100, 55)) end
check(math.abs(posed.aim_yaw - 45) < 0.1 and math.abs(posed.aim_pitch) < 0.1, "a target to the left yaws the arms left")
gunman.ClearSchedule = gunman.ClearSchedule or function() end
humanBase.STALKERNPCClearAnimation(gunman)
check(posed.aim_pitch == 0 and posed.aim_yaw == 0 and not gunman.aimPitch, "ending combat lowers the arms")

-- Zombies do not retreat, crouch or sneak.
gunman.Undead = true
gunman.combatProfile = {range = 2000, retreat = 500}
local forward = gunman:GetFiringMove(100 ^ 2)
check(forward == 1, "zombies do not back away")
gunman.nextCrouchRoll, gunman.crouching = 0, nil
gunman:UpdateCrouch(100, 800 ^ 2)
check(not gunman.crouching, "zombies do not crouch")
check(not gunman:IsTargetUnaware(hunter), "zombies do not sneak up on anyone")
gunman.Undead, gunman.combatProfile, gunman.nextCrouchRoll = nil, nil, nil

-- Crouching: occasional while shooting from a distance, never up close, and ended by movement.
local resets = 0
gunman.IsMoving = function() return false end
gunman.ResetIdealActivity = function() resets = resets + 1 end
local roll = 1
local formerRandom, formerRand = math.random, math.Rand
math.random = function() return roll end
math.Rand = function(low) return low end
gunman:UpdateCrouch(10, 100 ^ 2)
check(not gunman.crouching, "shooters do not crouch point-blank")
gunman:UpdateCrouch(10, 800 ^ 2)
check(not gunman.crouching, "crouching is rolled at an interval")
gunman:UpdateCrouch(15, 800 ^ 2)
check(not gunman.crouching, "a failed roll keeps the shooter standing")
roll, gunman.nextCrouchRoll = 0, 0
gunman:UpdateCrouch(20, 800 ^ 2)
check(gunman.crouching and gunman.crouchUntil == 22.5 and resets == 1, "a successful roll crouches and refreshes the pose")
gunman:UpdateCrouch(21, 800 ^ 2)
check(gunman.crouching and resets == 1, "the shooter stays crouched for a while")
gunman:UpdateCrouch(23, 800 ^ 2)
check(not gunman.crouching and resets == 2, "the shooter stands up again afterwards")
math.random, math.Rand = formerRandom, formerRand
gunman.crouching = true
gunman.SetSchedule, gunman.IsCurrentSchedule = function(self, schedule) self.schedule = schedule end, function() return false end
gunman:StartCombatMovement(SCHED_CHASE_ENEMY, 50, true)
check(gunman.sneaking and not gunman.crouching, "moving ends a crouch and starts sneaking")
local scheduled = gunman.schedule
gunman.IsCurrentSchedule = function(self, schedule) return self.schedule == schedule end
local scheduleCalls = 0
gunman.SetSchedule = function(self, schedule) self.schedule, scheduleCalls = schedule, scheduleCalls + 1 end
gunman:StartCombatMovement(SCHED_CHASE_ENEMY, 52, true)
check(scheduleCalls == 0, "an unchanged sneak does not restart its movement")
gunman:StartCombatMovement(SCHED_CHASE_ENEMY, 54, false)
check(scheduleCalls == 1 and gunman.schedule == SCHED_CHASE_ENEMY and not gunman.sneaking,
	"being noticed restarts movement upright")
local notPlayer = function() return false end
local watcher = {IsPlayer = notPlayer, GetEnemy = function() return gunman end}
local hunter = {IsPlayer = notPlayer, GetEnemy = function() end}
check(not gunman:IsTargetUnaware(watcher), "a target fighting us has engaged us")
check(gunman:IsTargetUnaware(hunter), "targets fighting someone else have not engaged us")
function vectorMeta:Dot(other) return self.x * other.x + self.y * other.y + self.z * other.z end
local looking, visible = Vector(1, 0, 0), true
local watcherPlayer = {
	IsPlayer = function() return true end, EyePos = function() return Vector(-100, 0, 0) end,
	GetAimVector = function() return looking end, Visible = function() return visible end,
}
check(not gunman:IsTargetUnaware(watcherPlayer), "a player looking straight at the NPC has noticed it")
looking = Vector(0, 1, 0)
check(not gunman:IsTargetUnaware(watcherPlayer), "a noticing player stays noticed for a few seconds")
gunman.noticedUntil = nil
check(gunman:IsTargetUnaware(watcherPlayer), "a player looking away has not noticed the NPC")
looking, visible = Vector(1, 0, 0), false
check(gunman:IsTargetUnaware(watcherPlayer), "a player facing the NPC through a wall has not noticed it")
visible = true
looking = Vector(0.9, 0.436, 0)
check(gunman:IsTargetUnaware(watcherPlayer), "a player looking well off to the side has not noticed the NPC")
gunman.noticedUntil = nil
gunman.provokedBy = hunter
check(not gunman:IsTargetUnaware(hunter), "a target that shot us has engaged us")
gunman.provokedBy = nil

-- Weapon props sit on the right hand's attachment at the placement stored for their weapon.
function Angle(pitch, yaw, roll) return {pitch = pitch, yaw = yaw, roll = roll} end
local props = {}
ents.Create = function()
	local prop = {}
	for _, name in ipairs({"SetModel", "SetPos", "SetKeyValue", "Spawn"}) do prop[name] = function() end end
	function prop:SetParent(parent, attachment) self.parent, self.attachment = parent, attachment end
	function prop:SetLocalPos(position) self.localPosition = position end
	function prop:SetLocalAngles(angles) self.localAngles = angles end
	props[#props + 1] = prop

	return prop
end
util = util or {}
util.IsValidModel = function(model) return model ~= "models/missing.mdl" end
ErrorNoHalt = function(message) error(message) end
local holder = setmetatable(actor("npc_human_bandit_rifleman", 0), {__index = humanBase})
holder.LookupAttachment = function() return 7 end
holder.DeleteOnRemove = function() end
local placed = holder:AttachCombatProp(humanBase.WeaponProps.ak74)
local hand = humanBase.WeaponProps.ak74.hand
check(placed.parent == holder and placed.attachment == 7, "weapon props parent to the right hand")
check(placed.localPosition.x == hand.pos[1] and placed.localPosition.y == hand.pos[2]
	and placed.localPosition.z == hand.pos[3], "weapon props use their stored hand position")
check(placed.localAngles.pitch == hand.ang[1] and placed.localAngles.yaw == hand.ang[2]
	and placed.localAngles.roll == hand.ang[3], "weapon props use their stored hand angles")
check(holder:AttachCombatProp({model = "models/missing.mdl", hand = hand}) == nil, "missing models attach nothing")
holder.LookupAttachment = function() return 0 end
check(not pcall(holder.AttachCombatProp, holder, humanBase.WeaponProps.ak74), "a rig without a hand attachment is reported")
holder.LookupAttachment = function() return 7 end

-- Initialization: model before hull, raised-gun capabilities, the dropped weapon's own prop and stance.
local calls = {}
local function spawnHuman(fields)
	local human = setmetatable({}, {__index = function(self, key)
		if fields[key] ~= nil then return fields[key] end
		if humanBase[key] ~= nil then return humanBase[key] end

		return function(_, ...)
			calls[#calls + 1] = key
			return ...
		end
	end})
	human.SkinCount, human.LookupSequence = function() return 1 end, function() return -1 end
	human.GetSequenceActivity, human.LookupAttachment = function() return -1 end, function() return 7 end
	human.InitEnemies = function() end
	human:Initialize()

	return human
end
bit = bit or {bor = function(...) local sum = 0 for _, value in ipairs({...}) do sum = sum + (value or 0) end return sum end}
CAP_USE_WEAPONS, CAP_AIM_GUN = 16, 32
local equipped = {GetMaxClip1 = function() return 30 end, SetNoDraw = function(self, hidden) self.hidden = hidden end}
local base = {
	ModelGroup = "bandit",
	StartHealth = 100, Give = function() return equipped end, GetActiveWeapon = function() return equipped end,
}
base.weapons = {{{"mp18", {}}, "weapon_npc_ppsh"}}
props = {}
local rifleman = spawnHuman(base)
check(calls[1] == "SetModel" and calls[#calls] ~= nil, "the model is set before anything else")
local hullIndex
for index, name in ipairs(calls) do if name == "SetHullType" then hullIndex = index end end
check(hullIndex and hullIndex > 1, "the collision hull is configured after the model")
check(rifleman.clip == 30 and rifleman.stance.aim == "rpg" and rifleman.stance.calm == "passive",
	"a two-handed firearm patrols passively and aims with the rpg stance")
check(rifleman.combatProp == props[1] and props[1].attachment == 7 and equipped.hidden,
	"the mp18 loadout shows the mp18 prop and hides the engine weapon")
base.weapons = {{{"tokarev", {}}, "weapon_npc_tokarev"}}
equipped.hidden = nil
local pistolman = spawnHuman(base)
check(pistolman.stance.aim == "revolver" and pistolman.stance.calm == "all",
	"a one-handed pistol idles with the all stance and aims with the revolver stance")
base.weapons = false
base.MeleeLoadouts = {{model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl", damage = 6,
	hand = {pos = {1, 1, 1}, ang = {0, 0, 0}}}}
local brawler = spawnHuman(base)
check(brawler.stance.aim == "melee2" and brawler.meleeDamage == 6 and brawler.combatProp,
	"melee bandits hold their weapon with the two-handed melee stance")

print("PASS: " .. checks .. " NPC combat checks")
