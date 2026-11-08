-- Run from the addon root: luatex --luaonly tests/shared_commands_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
SERVER, CLIENT = false, true
ix = {type = {character = 1, string = 2, optional = 4}, command = {}}
bit = {bor = function(first, second) return first + second end}
local commands = {}
ix.command.Add = function(name, command) commands[name] = command end
local groups = {
	["equipmentslots/sh_commands.lua"] = {"CharTakeInventory"},
	["jobsystem/libs/sh_commands.lua"] = {"CharResetJobs"},
	["progression/libs/sh_commands.lua"] = {"ProgressionGrant", "ProgressionAudit"},
	["townnpcs/libs/sh_commands.lua"] = {"TownNPCPreview", "TownNPCGetSpawnPoint", "TownNPCClearSpawnPoints",
		"TownNPCExportSpawnPoints", "TownNPCAddFieldPoint", "TownNPCRemoveFieldPoint", "TownNPCPlace",
		"TownNPCExportFieldPoints"},
}
for path, names in pairs(groups) do
	local owner = {}
	PLUGIN = owner
	dofile("gamemodes/ix_cotz/plugins/" .. path)
	for _, name in ipairs(names) do
		local command = commands[name]
		check(command and command.adminOnly and command.OnRun, "client sees each admin command and its permission")
		local received
		owner["RunCommand" .. name] = function(self, ...)
			check(self == owner, "command callback retains its loader-provided owner")
			received = {...}
			return "server result"
		end
		PLUGIN = {}
		check(command:OnRun("client", "argument", "sequence") == "server result",
			"shared callback delegates to its owning server handler")
		if name ~= "ProgressionAudit" then check(received[1] == "client", "handler retains client identity") end
	end
end
check(#commands.TownNPCPreview.arguments == 2 and commands.TownNPCPreview.argumentNames[2] == "sequence",
	"posing syntax and typed arguments are visible in chat completion")
check(commands.TownNPCPreview.arguments[2] == 6, "sequence is optional in shared chat completion")
print("PASS: " .. checks .. " shared command checks")
