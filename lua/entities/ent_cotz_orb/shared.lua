-- Shared mutant projectile. The server moves it with one hull trace per tick, so hits and damage never run
-- inside physics collision callbacks. Concrete orbs set their tuning and override Impact.
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "COTZ Mutant Orb"
ENT.Spawnable = false
ENT.AdminOnly = false
