AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 100
ENT.flatbulletresistance = 40
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "mili_pistol_loot"

ENT.CombatRole = "pistolman"

ENT.ModelGroup = "mili"

ENT.weapons = {
	{{"makarov", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 2 }}, "weapon_npc_makarov"},
}

ENT.alertsounds = {
	"npc/military/enemy_1.ogg",
	"npc/military/enemy_2.ogg",
	"npc/military/enemy_3.ogg",
	"npc/military/enemy_4.ogg",
	"npc/military/enemy_5.ogg",
	"npc/military/enemy_6.ogg",
}

ENT.attacksounds = {
	"npc/military/attack_1.ogg",
	"npc/military/attack_2.ogg",
	"npc/military/attack_many_1.ogg",
	"npc/military/attack_many_2.ogg",
	"npc/military/attack_many_3.ogg",
	"npc/military/attack_many_4.ogg",
	"npc/military/attack_many_5.ogg",
	"npc/military/attack_many_6.ogg",
	"npc/military/attack_one_1.ogg",
	"npc/military/attack_one_2.ogg",
	"npc/military/attack_one_3.ogg",
	"npc/military/attack_one_4.ogg",
	"npc/military/attack_one_5.ogg",
}

ENT.hurtsounds = {
	"npc/military/hit_1.ogg",
	"npc/military/hit_2.ogg",
	"npc/military/hit_3.ogg",
	"npc/military/hit_4.ogg",
	"npc/military/hit_5.ogg",
	"npc/military/hit_6.ogg",
}

ENT.diesounds = {
	"npc/military/death_1.ogg",
	"npc/military/death_2.ogg",
	"npc/military/death_3.ogg",
	"npc/military/death_4.ogg",
	"npc/military/death_5.ogg",
}
