if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Thrown smoke grenade"
ENT.Author = "Spy"
ENT.Information = "Thrown smoke grenade"
ENT.Spawnable = false
ENT.AdminSpawnable = false

CustomizableWeaponry:addRegularSound("CW_KK_INS2_SMOKE_ENT_BOUNCE", {"weapons/m18/m18_bounce_01.wav", "weapons/m18/m18_bounce_02.wav", "weapons/m18/m18_bounce_03.wav"})
CustomizableWeaponry:addRegularSound("CW_KK_INS2_SMOKE_ENT_DETONATE", "weapons/m18/m18_detonate.wav")
CustomizableWeaponry:addRegularSound("CW_KK_INS2_SMOKE_ENT_LOOP", "weapons/m18/m18_burn_loop.wav")
CustomizableWeaponry:addRegularSound("CW_KK_INS2_SMOKE_ENT_END", "weapons/m18/m18_burn_loop_end.wav")

CustomizableWeaponry:addRegularSound("CW_KK_INS2_SMOKE_ENT_FULL", "weapons/m18/smokeburn.wav")
