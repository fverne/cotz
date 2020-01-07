if not CustomizableWeaponry then return end
if not CustomizableWeaponry.magSystem then return end

ENT.Type = "anim"
ENT.Base = "cw_mag_base"
ENT.PrintName = "[INS2] Revolver loader"
ENT.PackageText = "Revolver loader"
ENT.Category = "CW 2.0 Magazines"
ENT.Author = "Spy"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Model = "models/weapons/unloaded/snip_awp_mag.mdl"

ENT.magazines = {revLoader = 1}
