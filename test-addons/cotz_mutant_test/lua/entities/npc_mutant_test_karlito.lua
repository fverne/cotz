if SERVER then AddCSLuaFile() end

ENT.Base = "cotz_mutant_test_base"
ENT.Type = "ai"
ENT.PrintName = "Karlito"
ENT.Category = "COTZ Mutant Tests"
ENT.Spawnable = false

ENT.Model = "models/monsters/karlito.mdl"
ENT.IdleSequence = "stand_idle_0"
ENT.SNPCClass = "C_MONSTER_SAVAGE"
ENT.hullType = HULL_WIDE_HUMAN
ENT.hullSize = Vector(27, 24, 60)
ENT.viewOffset = Vector(0, 0, 49)

ENT.hp = 310
ENT.hpvar = 25
ENT.MeleeAttackDistance = 52
ENT.attacks = {
	{
		sequence = "stand_attack_0",
		windup = 0.63,
		damage = 44,
		damageType = DMG_CLUB,
		arc = 160,
		bone = "bip01_l_hand",
	},
}

ENT.soundLevel = 78
ENT.windupSound = "hgn/stalker/creature/zombie/zombie_attack_7.wav"
ENT.deathSound = "hgn/stalker/creature/zombie/zombie_die_2.wav"
ENT.hitSound = "Stalker.Claw.Hit"
ENT.missSound = "Stalker.Izlom.Miss1"

list.Set("NPC", "npc_mutant_test_karlito", {
	Name = ENT.PrintName,
	Class = "npc_mutant_test_karlito",
	Category = ENT.Category,
})
