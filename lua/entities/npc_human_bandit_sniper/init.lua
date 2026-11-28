AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 100
ENT.flatbulletresistance = 10
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "bandit_sniper_loot"

ENT.CombatRole = "sniper"

ENT.ModelGroup = "bandit"

ENT.weapons = {
	{{"obrez", { ["durability"] = 5, ["wear"] = 10, ["ammo"] = 2 }}, "weapon_npc_obrez"},
	{{"mp18", { ["durability"] = 5, ["wear"] = 10, ["ammo"] = 1 }}, "weapon_npc_obrez"},
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
