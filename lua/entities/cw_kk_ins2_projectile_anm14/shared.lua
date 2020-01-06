if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Thrown incendiary grenade"
ENT.Author = "Spy"
ENT.Information = "Thrown incendiary grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CustomizableWeaponry:addRegularSound("CW_KK_INS2_ANM14_ENT_BOUNCE", {"weapons/anm14/an_m14_bounce_01.wav", "weapons/anm14/an_m14_bounce_02.wav", "weapons/anm14/an_m14_bounce_03.wav"})
