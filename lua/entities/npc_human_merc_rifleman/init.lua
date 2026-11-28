AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 100
ENT.flatbulletresistance = 25
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "merc_rifle_loot"

ENT.CombatRole = "rifleman"

ENT.ModelGroup = "merc"

ENT.weapons = {
	{{"mp5k", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 9 }}, "weapon_npc_mp5"},
	{{"uzi", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 13 }}, "weapon_npc_skorpion"},
	{{"lr300", { ["durability"] = 5, ["wear"] = 7, ["ammo"] = 7 }}, "weapon_npc_lr300"},
}

ENT.alertsounds = {
	"npc/killer/enemy_1.ogg",
	"npc/killer/enemy_2.ogg",
	"npc/killer/enemy_3.ogg",
	"npc/killer/enemy_4.ogg",
	"npc/killer/enemy_5.ogg",
	"npc/killer/enemy_6.ogg",
	"npc/killer/enemy_7.ogg",
	"npc/killer/enemy_8.ogg",
	"npc/killer/enemy_9.ogg",
	"npc/killer/enemy_10.ogg",
}

ENT.attacksounds = {
	"npc/killer/attack_1.ogg",
	"npc/killer/attack_2.ogg",
	"npc/killer/attack_3.ogg",
	"npc/killer/attack_4.ogg",
	"npc/killer/attack_5.ogg",
	"npc/killer/attack_6.ogg",
	"npc/killer/attack_7.ogg",
	"npc/killer/attack_8.ogg",
}

ENT.hurtsounds = {
	"npc/killer/hit_1.ogg",
	"npc/killer/hit_2.ogg",
	"npc/killer/hit_3.ogg",
	"npc/killer/hit_4.ogg",
	"npc/killer/hit_5.ogg",
	"npc/killer/hit_6.ogg",
	"npc/killer/hit_7.ogg",
	"npc/killer/hit_8.ogg",
}

ENT.diesounds = {
	"npc/killer/death_1.ogg",
	"npc/killer/death_2.ogg",
	"npc/killer/death_3.ogg",
	"npc/killer/death_4.ogg",
	"npc/killer/death_5.ogg",
	"npc/killer/death_6.ogg",
	"npc/killer/death_7.ogg",
}
