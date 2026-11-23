if SERVER then AddCSLuaFile() end

ENT.Base = "cotz_mutant_test_base"
ENT.Type = "ai"
ENT.PrintName = "Tarakan"
ENT.Category = "COTZ Mutant Tests"
ENT.Spawnable = false

ENT.Model = "models/monsters/tarakan.mdl"
ENT.IdleSequence = "idle_0"
ENT.SNPCClass = "C_MONSTER_RAT"
ENT.hullType = HULL_TINY
ENT.hullSize = Vector(14, 12, 16)
ENT.viewOffset = Vector(0, 0, 10)

ENT.hp = 12
ENT.hpvar = 2
ENT.noRagdoll = true
ENT.MeleeAttackDistance = 22
ENT.attacks = {
	{sequence = "attack_0", windup = 0.36, damage = 7, damageType = DMG_SLASH, arc = 110, bone = "bip01_head"},
	{sequence = "attack_1", windup = 0.28, damage = 6, damageType = DMG_SLASH, arc = 110, bone = "bip01_head"},
}

ENT.soundLevel = 62
ENT.windupSound = "hgn/stalker/creature/rodent/tushkano_attack_0.wav"
ENT.deathSound = "hgn/stalker/creature/rodent/tushkano_death_2.wav"
ENT.hitSound = "Stalker.Claw.Hit"
ENT.missSound = "Stalker.Dog.Miss1"

list.Set("NPC", "npc_mutant_test_tarakan", {
	Name = ENT.PrintName,
	Class = "npc_mutant_test_tarakan",
	Category = ENT.Category,
})
