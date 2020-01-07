if not CustomizableWeaponry then return end

AddCSLuaFile()

CW_KK_ACTION = 11
CW_KK_QNADE = 12
CW_KK_QKNIFE = 13

KK_INS2_NO_ACTION = 0
KK_INS2_SHOTGUN_LOAD_FIRST = 1			// [1] = delay before SetClip1(+1)
KK_INS2_SHOTGUN_UNLOAD_ONE = 2			// [1] = delay before SetClip1(-1)
KK_INS2_RIFLEGL_UNLOAD_ONE = 3			// [4] = delay before SetClip1(-1)
KK_INS2_REVOLVER_SLOW_UNLOAD = 4		// [1] = delay before SetClip1(0)
KK_INS2_REVOLVER_SPEED_UNLOAD = 5		// [4] = delay before SetClip1(0)
KK_INS2_STRIPPERCLIP_UNLOAD_ONE = 3		// [4] = delay before SetClip1(-1)

CustomizableWeaponry_KK = CustomizableWeaponry_KK or {}
CustomizableWeaponry_KK.ins2 = CustomizableWeaponry_KK.ins2 or {}

CustomizableWeaponry_KK.ins2.firstDeployEnabled = true			// 2do
CustomizableWeaponry_KK.ins2.firstDeploySkip = -1				// 2do // -1 dont, n>0 - skip after n seconds of wep waiting in inventory
CustomizableWeaponry_KK.ins2.holsterTransitionsEnabled = true
CustomizableWeaponry_KK.ins2.discardEjectedAmmo = false

CustomizableWeaponry_KK.ins2.magnifierDependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies or {}
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_aimpoint = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_eotechxps = true
CustomizableWeaponry_KK.ins2.magnifierDependencies.kk_ins2_cstm_compm4s = true

CustomizableWeaponry_KK.ins2.slowGrenadeMenu = {{header = "CSGO", offset = {1000, -500}, atts = {"kk_counter"}, dependencies = {aintgonnahappen = true}, nadestuff = true}}

local folder = "cw_kk/ins2/core/"
for _,v in pairs({
	[1] = "sh_content_check",
	[2] = "cl_cvars",
}) do
	AddCSLuaFile(folder .. v .. ".lua")
	include(folder .. v .. ".lua")
end

local folder = "cw_kk/ins2/server/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	include(folder .. v)
end

local folder = "cw_kk/ins2/shared/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	AddCSLuaFile(folder .. v)
	include(folder .. v)
end

local folder = "cw_kk/ins2/client/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	AddCSLuaFile(folder .. v)
	if CLIENT then
		include(folder .. v)
	end
end

local folder = "cw_kk/ins2/ext/"
for k, v in pairs(file.Find(folder .. "*", "LUA")) do
	AddCSLuaFile(folder .. v)
	include(folder .. v)
end
