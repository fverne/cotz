if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Activated frag grenade"
ENT.Author = "Spy"
ENT.Information = "Activated frag grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.fuseParticles = "weapon_compB_fuse"
PrecacheParticleSystem(ENT.fuseParticles)

CustomizableWeaponry:addRegularSound("CW_KK_INS2_DOI_C4_DE_ENT_BOUNCE", {"weapons/tnt/tnt_bounce_01.wav", "weapons/tnt/tnt_bounce_02.wav", "weapons/tnt/tnt_bounce_03.wav"})
