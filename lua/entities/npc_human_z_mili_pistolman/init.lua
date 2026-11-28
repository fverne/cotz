AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.StartHealth = 150
ENT.flatbulletresistance = 15
ENT.percentbulletresistance = 20
ENT.lootChance = 60
ENT.lootGroup = "z_mili_pistol_loot"

-- Zombies do not take cover, crouch or sneak.
ENT.Undead = true

ENT.CombatRole = "pistolman"

ENT.ModelGroup = "zombie_mili"

ENT.weapons = {
	{{"makarov", { ["durability"] = 5, ["wear"] = 6, ["ammo"] = 5 }}, "weapon_npc_makarov"},
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
