local file = assert(io.open("lua/weapons/cw_base/shared.lua", "r"))
local source = file:read("*a")
file:close()

local now = 100
local inserts = 0
local weapon = {
	ReloadSpeed = 2,
	Animations = {},
	Primary = {Ammo = "test", ClipSize = 2},
	Owner = {
		SetAnimation = function() end,
		KeyPressed = function(owner) return owner.attackPressed end,
		GetAmmoCount = function(owner) return owner.ammo end,
		SetAmmo = function(owner, amount) owner.ammo = amount end,
	},
	Clip1 = function(self) return self.clip end,
	SetClip1 = function(self, amount) self.clip = amount end,
	GetOwner = function(self) return self.Owner end,
	RefreshInventoryAmmo = function() end,
	SetNextPrimaryFire = function(self, time) self.nextPrimaryFire = time end,
	SetNextSecondaryFire = function() end,
	sendWeaponAnim = function(self, animation) self.animation = animation end,
}
local environment = {
	math = math,
	type = type,
	isstring = function(value) return type(value) == "string" end,
	SWEP = weapon,
	SERVER = true,
	SP = false,
	CurTime = function() return now end,
	net = {Start = function() end, Send = function() end},
	CustomizableWeaponry = {callbacks = {processCategory = function() end}},
	hook = {
		Run = function(name)
			assert(name == "ProcessShotgunReload")
			inserts = inserts + 1
		end,
	},
}

local beginReload = assert(source:match("(function SWEP:beginReload%(%)\n.-\nend)"))
assert(load(beginReload, nil, "t", environment))()

local animationsFile = assert(io.open("lua/weapons/cw_base/sh_anims.lua", "r"))
local animationsSource = animationsFile:read("*a")
animationsFile:close()
for _, method in ipairs({"GetLoadedReloadCut", "playAnim"}) do
	local definition = assert(animationsSource:match("(function SWEP:" .. method .. "%([^)]+%)\n.-\nend)"))
	assert(load(definition, nil, "t", environment))()
end

local shotgunReload = assert(source:match("(local function finishShotgunReload.-)\nfunction SWEP:CycleFiremodes"))
local updateReload = assert(load(shotgunReload .. "\nreturn updateShotgunReload", nil, "t", environment))()

weapon.ReloadTime = 2
weapon.ReloadHalt = 2
weapon.ReloadTime_Empty = 4
weapon.ReloadHalt_Empty = 4
weapon.Animations.reload_empty = "empty"
weapon.clip = 0
weapon:beginReload()
assert(weapon.animation == "reload_empty" and weapon.ReloadDelay == 102 and weapon.nextPrimaryFire == 102)

weapon.clip = 1
weapon:beginReload()
assert(weapon.animation == "reload" and weapon.ReloadDelay == 101 and weapon.nextPrimaryFire == 101)

weapon.Animations.reload_empty = nil
weapon.clip = 0
weapon:beginReload()
assert(weapon.animation == "reload" and weapon.ReloadDelay == 102)

weapon.Animations.reload = "shared"
weapon.Animations.reload_empty = "shared"
weapon.ReloadChamberCuts = {shared = {from = 0.5, to = 1.5}}
weapon.Sounds = {}
weapon.removeCurSoundTable = function() end
weapon.clip = 1
weapon:beginReload()
assert(weapon.animation == "reload" and weapon.ReloadDelay == 100.5 and weapon.nextPrimaryFire == 100.5)
weapon:playAnim("reload")
assert(weapon.ActiveReloadChamberCut == weapon.ReloadChamberCuts.shared)

local modelFile = assert(io.open("lua/weapons/cw_base/cl_model.lua", "r"))
local modelSource = modelFile:read("*a")
modelFile:close()
local advanceDefinition = assert(modelSource:match("(local function advanceReloadChamberCut.-\nend)"))
local advanceCut = assert(load(advanceDefinition .. "\nreturn advanceReloadChamberCut"))()
local vm = {
	cycle = 0.24,
	SequenceDuration = function() return 2 end,
	GetCycle = function(self) return self.cycle end,
	SetCycle = function(self, cycle) self.cycle = cycle end,
	InvalidateBoneCache = function() end,
}
advanceCut(weapon, vm)
assert(vm.cycle == 0.24)
vm.cycle = 0.25
advanceCut(weapon, vm)
assert(vm.cycle == 0.75)
advanceCut(weapon, vm)
assert(vm.cycle == 0.75)

weapon.clip = 0
weapon:beginReload()
assert(weapon.animation == "reload_empty" and weapon.ReloadDelay == 102 and weapon.nextPrimaryFire == 102)
weapon:playAnim("reload_empty")
assert(weapon.ActiveReloadChamberCut == nil)

weapon.ShotgunReload = true
weapon.AlwaysPlayReloadEnd = true
weapon.ReloadStartTime = 0.5
weapon.ReloadStartTime_Empty = 2
weapon.InsertShellTime = 1
weapon.ReloadFinishWait = 0.6
weapon.ReloadFinishWait_Empty = 0.9
weapon.Animations.reload_start_empty = "empty_start"
weapon.Animations.insert_empty = "empty_insert"
weapon.Animations.reload_end_empty = "empty_end"
weapon.clip = 0
weapon.Owner.ammo = 2
weapon:beginReload()
assert(weapon.animation == "reload_start_empty" and weapon.ReloadDelay == 101)
updateReload(weapon, 101.1)
assert(weapon.animation == "insert_empty" and weapon.clip == 0 and weapon.Owner.ammo == 2)
updateReload(weapon, 101.4)
assert(weapon.clip == 0 and inserts == 0)
updateReload(weapon, 101.7)
assert(weapon.clip == 1 and weapon.Owner.ammo == 1)
updateReload(weapon, 102.3)
assert(weapon.animation == "reload_end_empty" and weapon.nextPrimaryFire == 102.75)
assert(weapon.clip == 2 and weapon.Owner.ammo == 0 and inserts == 2)

weapon.clip = 1
weapon.Owner.ammo = 1
weapon:beginReload()
assert(weapon.animation == "reload_start" and weapon.ReloadDelay == 100.25)
updateReload(weapon, 100.3)
assert(weapon.animation == "insert" and weapon.clip == 1)
updateReload(weapon, 100.9)
assert(weapon.animation == "reload_end" and weapon.clip == 2 and weapon.Owner.ammo == 0)

weapon.clip = 0
weapon.Owner.ammo = 1
weapon.ReloadStartLoadsRound_Empty = true
weapon:beginReload()
updateReload(weapon, 100.9)
assert(weapon.clip == 0 and weapon.Owner.ammo == 1)
updateReload(weapon, 101.1)
assert(weapon.animation == "reload_end_empty" and weapon.clip == 1 and weapon.Owner.ammo == 0 and inserts == 4)

weapon.clip = 0
weapon.Owner.ammo = 3
weapon.Chamberable = true
weapon.ReloadStartChambersRound_Empty = true
weapon:beginReload()
updateReload(weapon, 101.1)
assert(not weapon.WasEmpty and weapon.clip == 1 and weapon.Owner.ammo == 2)
assert(weapon.animation == "insert")
updateReload(weapon, 101.7)
assert(weapon.clip == 2)
updateReload(weapon, 102.3)
assert(weapon.animation == "reload_end" and weapon.clip == 3 and weapon.Owner.ammo == 0)

weapon.clip = 1
weapon.Owner.ammo = 2
weapon:beginReload()
updateReload(weapon, 100.3)
weapon.Owner.attackPressed = true
updateReload(weapon, 100.5)
assert(weapon.clip == 1 and weapon.ShotgunReloadState == 2)
weapon.Owner.attackPressed = false
updateReload(weapon, 100.9)
assert(weapon.animation == "reload_end" and weapon.clip == 2 and weapon.Owner.ammo == 1)

weapon.clip = 1
weapon.Owner.ammo = 1
weapon:beginReload()
updateReload(weapon, 100.3)
weapon.Owner.ammo = 0
updateReload(weapon, 100.9)
assert(weapon.animation == "reload_end" and weapon.clip == 1 and weapon.Owner.ammo == 0)

weapon.clip = 0
weapon.Owner.ammo = 3
weapon.ReloadStartLoadsRound_Empty = false
weapon:beginReload()
updateReload(weapon, 101.1)
updateReload(weapon, 101.7)
updateReload(weapon, 102.3)
assert(weapon.animation == "reload_end_empty" and weapon.clip == 2 and weapon.ShotgunReloadState == 1)
updateReload(weapon, 102.8)
assert(weapon.animation == "insert" and weapon.clip == 2)
updateReload(weapon, 103.4)
assert(weapon.animation == "reload_end" and weapon.clip == 3 and weapon.Owner.ammo == 0)

weapon.clip = 0
weapon.Owner.ammo = 3
weapon:beginReload()
updateReload(weapon, 101.1)
updateReload(weapon, 101.7)
updateReload(weapon, 102.3)
weapon.Owner.attackPressed = true
updateReload(weapon, 102.5)
weapon.Owner.attackPressed = false
updateReload(weapon, 102.8)
assert(weapon.animation == "reload_end_empty" and weapon.nextPrimaryFire == 102.75)
assert(weapon.clip == 2 and weapon.Owner.ammo == 1 and weapon.ShotgunReloadState == 0)
