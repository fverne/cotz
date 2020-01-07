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

CustomizableWeaponry:addRegularSound("CW_KK_INS2_DOI_C4_US_ENT_BOUNCE", {"weapons/compositonb/compositonb_bounce_01.wav", "weapons/compositonb/compositonb_bounce_02.wav", "weapons/compositonb/compositonb_bounce_03.wav"})
