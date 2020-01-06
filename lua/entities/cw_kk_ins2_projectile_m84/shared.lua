if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Thrown smoke grenade"
ENT.Author = "Spy"
ENT.Information = "Thrown smoke grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CustomizableWeaponry:addRegularSound("CW_KK_INS2_M84_ENT_BOUNCE", {"weapons/m84/m84_bounce_01.wav", "weapons/m84/m84_bounce_02.wav", "weapons/m84/m84_bounce_03.wav"})
