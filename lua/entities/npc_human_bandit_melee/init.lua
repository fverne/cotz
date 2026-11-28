AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 100
ENT.flatbulletresistance = 10
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "bandit_pistol_loot"

ENT.ModelGroup = "bandit"

-- hand is the weapon's position and angle in the right hand's frame, with the handle in the palm.
ENT.MeleeLoadouts = {
	{
		model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl",
		damage = 30,
		hand = {pos = {-3.92, -3.29, -4.93}, ang = {-5.1, -0.6, 178.1}},
	},
	{
		model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
		damage = 30,
		hand = {pos = {-3.85, -3.43, -3.82}, ang = {-5.1, -0.6, 178.1}},
	},
	{
		model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
		damage = 30,
		hand = {pos = {-3.14, -0.34, -3.65}, ang = {-5.1, -0.6, 178.1}},
	},
}

ENT.alertsounds = {
	"npc/bandit/enemy_1.ogg",
	"npc/bandit/enemy_2.ogg",
	"npc/bandit/enemy_3.ogg",
	"npc/bandit/enemy_4.ogg",
	"npc/bandit/enemy_5.ogg",
	"npc/bandit/enemy_6.ogg",
	"npc/bandit/enemy_7.ogg",
}

ENT.attacksounds = {
	"npc/bandit/attack_1.ogg",
	"npc/bandit/attack_2.ogg",
	"npc/bandit/attack_3.ogg",
	"npc/bandit/attack_4.ogg",
	"npc/bandit/attack_5.ogg",
	"npc/bandit/attack_6.ogg"
}

ENT.hurtsounds = {
	"npc/bandit/hit_1.ogg",
	"npc/bandit/hit_2.ogg",
	"npc/bandit/hit_3.ogg",
	"npc/bandit/hit_4.ogg",
	"npc/bandit/hit_5.ogg",
	"npc/bandit/hit_6.ogg",
	"npc/bandit/hit_7.ogg"
}

ENT.diesounds = {
	"npc/bandit/death_1.ogg",
	"npc/bandit/death_2.ogg",
	"npc/bandit/death_3.ogg",
	"npc/bandit/death_4.ogg",
	"npc/bandit/death_5.ogg",
	"npc/bandit/death_6.ogg"
}
