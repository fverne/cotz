AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 150
ENT.flatbulletresistance = 5
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "z_rookie_pistol_loot"

-- Zombies do not take cover, crouch or sneak.
ENT.Undead = true

ENT.CombatRole = "pistolman"

ENT.ModelGroup = "zombie_rookie"

ENT.weapons = {
	{{"makarov", { ["durability"] = 5, ["wear"] = 6, ["ammo"] = 2 }}, "weapon_npc_makarov"},
	{{"tokarev", { ["durability"] = 5, ["wear"] = 6, ["ammo"] = 2 }}, "weapon_npc_tokarev"},
	{{"brhp", { ["durability"] = 5, ["wear"] = 6, ["ammo"] = 2 }}, "weapon_npc_brhp"},
	{{"rugermk3", { ["durability"] = 5, ["wear"] = 6, ["ammo"] = 2 }}, "weapon_npc_rugermk3"},
	{{"nagantrev", { ["durability"] = 5, ["wear"] = 15, ["ammo"] = 3 }}, "weapon_npc_brhp"},
}

ENT.alertsounds = {
	"npc/zombied/enemy_1.mp3",
	"npc/zombied/enemy_2.mp3",
	"npc/zombied/enemy_3.mp3",
	"npc/zombied/enemy_4.mp3",
	"npc/zombied/enemy_5.mp3",
}

ENT.attacksounds = {
	"npc/zombied/attack_1.mp3",
	"npc/zombied/attack_2.mp3",
	"npc/zombied/attack_3.mp3",
	"npc/zombied/attack_4.mp3",
	"npc/zombied/attack_5.mp3",
	"npc/zombied/attack_6.mp3",
	"npc/zombied/attack_7.mp3",
	"npc/zombied/attack_7.mp3",
}

ENT.hurtsounds = {
	"npc/zombied/hit_1.mp3",
	"npc/zombied/hit_2.mp3",
	"npc/zombied/hit_3.mp3",
}

ENT.diesounds = {
	"npc/zombied/death_1.mp3",
	"npc/zombied/death_2.mp3",
	"npc/zombied/death_3.mp3",
	"npc/zombied/death_4.mp3",
	"npc/zombied/death_5.mp3",
	"npc/zombied/death_6.mp3",
}
