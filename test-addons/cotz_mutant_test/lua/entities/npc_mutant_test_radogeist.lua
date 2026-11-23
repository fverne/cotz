if SERVER then AddCSLuaFile() end

ENT.Base = "cotz_mutant_test_base"
ENT.Type = "ai"
ENT.PrintName = "Radogeist"
ENT.Category = "COTZ Mutant Tests"
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.Model = "models/monsters/goust.mdl"
ENT.IdleSequence = "stand_idle_0"
ENT.SNPCClass = "C_MONSTER_PLAYERFOCUS"
ENT.hullType = HULL_HUMAN
ENT.hullSize = Vector(18, 18, 70)
ENT.viewOffset = Vector(0, 0, 60)

ENT.hp = 155
ENT.hpvar = 15
ENT.noRagdoll = true
ENT.MeleeAttackDistance = 112
ENT.attacks = {
	{
		sequence = "stand_attack_0",
		windup = 0.7,
		damage = 50,
		damageType = DMG_RADIATION,
		arc = 360,
		bone = "bip01_r_hand",
	},
}

ENT.tint = Color(175, 215, 215, 120)
ENT.soundLevel = 76
ENT.windupSound = "hgn/stalker/creature/mutants/controller_tube_prepare.wav"
ENT.deathSound = "hgn/stalker/creature/mutants/controller_die_0.wav"
ENT.hitSound = "hgn/stalker/creature/mutants/controller_attack_hit_0.wav"
ENT.missSound = "hgn/stalker/creature/mutants/controller_whoosh.wav"

list.Set("NPC", "npc_mutant_test_radogeist", {
	Name = ENT.PrintName,
	Class = "npc_mutant_test_radogeist",
	Category = ENT.Category,
})
