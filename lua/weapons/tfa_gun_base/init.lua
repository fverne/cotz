--[[ AddCSLua our other essential functions. ]]--

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

--[[ Load up our shared code. ]]--

include('shared.lua')

--[[ Include these modules]]--

for k,v in pairs(SWEP.SV_MODULES) do
	include(v)
end

--[[ Include these modules, and AddCSLua them, since they're shared.]]--

for k,v in pairs(SWEP.SH_MODULES) do
	AddCSLuaFile(v)
	include(v)
end

--[[ Include these modules if singleplayer, and AddCSLua them, since they're clientside.]]--

for k,v in pairs(SWEP.ClSIDE_MODULES) do
	AddCSLuaFile(v)
end
if game.SinglePlayer() then
	for k,v in pairs(SWEP.ClSIDE_MODULES) do
		include(v)
	end
end

--[[Actual serverside values]]--

SWEP.Weight				= 60		// Decides whether we should switch from/to this
SWEP.AutoSwitchTo			= true		// Auto switch to 
SWEP.AutoSwitchFrom			= true		// Auto switch from