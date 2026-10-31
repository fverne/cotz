-- Run from the addon root: luatex --luaonly tests/jobs_loading_spec.lua
local base = "gamemodes/ix_cotz/plugins/jobsystem/"
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
for _, realm in ipairs({"server", "client"}) do
	SERVER, CLIENT = realm == "server", realm == "client"
	PLUGIN = {}
	local loaded, registered = {}, {}
	local playerMeta = {}
	FindMetaTable = function() return playerMeta end
	Vector = function(x, y, z) return {x = x, y = y, z = z} end
	Color = function(...) return {...} end
	util = {AddNetworkString = function() check(SERVER, "network strings registered server-side") end}
	net = {Receive = function() end}
	netstream = {Hook = function() end}
	hook = {Add = function() end}
	vgui = {Register = function(name) registered[name] = true end}
	ix = {
		util = {}, type = {text = "text", character = "character"},
		char = {RegisterVar = function() end}, config = {Add = function() end},
		command = {Add = function() check(SERVER, "commands installed on the server") end},
	}
	ix.util.Include = function(path)
		-- Real Include uses filename prefixes; shared code must distribute each client file.
		local name = path:match("([^/]+)$")
		if name:sub(1, 3) == "sv_" and not SERVER then return end
		if name:sub(1, 3) == "cl_" and not CLIENT then return end
		loaded[name] = true
		return dofile(path:sub(1, 8) == "ix_cotz/" and "gamemodes/" .. path or base .. path)
	end
	-- Helix discovers libs before the entry point, in filename order.
	for _, name in ipairs({"sh_00_definitions", "sh_fieldtasks", "sh_jobs", "sh_taskrewards", "sh_tooljobs",
		"sv_taskrewards"}) do
		ix.util.Include("libs/" .. name .. ".lua")
	end
	ix.util.Include("sh_plugin.lua")
	local count = 0
	for _ in pairs(ix.jobs.list) do count = count + 1 end
	check(count == 337, realm .. ": all definitions load through production includes")
	check(ix.jobs.field.settings.recovery.sources[1] == "packages", realm .. ": existing map pools retained")
	check(ix.taskRewards.settings.difficultyReputation.hard == 1600, realm .. ": reward settings available")
	if SERVER then
		check(type(PLUGIN.Think) == "function" and type(PLUGIN.OnNPCKilled) == "function",
			"server hooks defined before registration finishes")
		check(not loaded["cl_plugin.lua"] and not registered.ixCharacterJournalPanel, "UI is not executed on server")
	else
		check(not loaded["sv_jobs.lua"] and not loaded["sv_fieldtasks.lua"], "server runtime excluded on client")
		check(type(PLUGIN.HUDPaint) == "function" and registered.ixCharacterJournalPanel,
			"client task menu and markers installed")
		check(playerMeta.ixJobAdd == nil, "authoritative character mutation stays server-side")
	end
end
print("PASS: " .. checks .. " jobsystem realm/loading checks")
