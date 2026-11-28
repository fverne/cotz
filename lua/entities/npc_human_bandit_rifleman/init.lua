AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 100
ENT.flatbulletresistance = 10
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "bandit_rifle_loot"

ENT.CombatRole = "rifleman"

ENT.ModelGroup = "bandit"

ENT.weapons = {
	{{"ppsh", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 7 }}, "weapon_npc_ppsh"},
	{{"skorpion", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 5 }}, "weapon_npc_skorpion"},
	{{"saigasemi545", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 3 }}, "weapon_npc_rugermini14"},
	{{"ruger1022", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 5 }}, "weapon_npc_rugermini14"},
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
