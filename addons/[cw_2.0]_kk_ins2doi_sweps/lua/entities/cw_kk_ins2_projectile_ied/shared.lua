if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Planted IED"
ENT.Author = "Spy"
ENT.Information = "Planted IED"
ENT.Spawnable = false
ENT.AdminSpawnable = false

-- ENT.BlastDamage = 100
-- ENT.BlastRadius = 434

ENT.BlastDamage = 380
ENT.BlastRadius = 600 // 1200

ENT.KKIN2RCEprojetile = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Detonator")
end

CustomizableWeaponry:addRegularSound("CW_KK_INS2_IED_ENT_BOUNCE", {"weapons/ied/ied_bounce_01.wav", "weapons/ied/ied_bounce_02.wav", "weapons/ied/ied_bounce_03.wav"})
