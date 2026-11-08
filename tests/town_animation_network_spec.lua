-- Run from the addon root: luatex --luaonly tests/town_animation_network_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
SERVER, CLIENT = true, false
ENT = {}
dofile("gamemodes/ix_cotz/plugins/vendor_adv/entities/entities/ix_vendor_adv.lua")
local vendor = ENT
local sharedStrings = {}
local function makeEntity()
	local entity = setmetatable({slots = {}, sequence = -1, resets = 0}, {__index = vendor})
	function entity:NetworkVar(kind, slot, name)
		local limit = kind == "String" and 4 or 32
		check(slot >= 0 and slot < limit, name .. " uses a legal engine datatable slot")
		local key = kind .. "/" .. slot
		check(not self.slots[key], name .. " has its own datatable slot")
		self.slots[key] = true
		self["Get" .. name] = function(self) return self[key] or (kind == "String" and "" or 0) end
		self["Set" .. name] = function(self, value) self[key] = value end
	end
	function entity:GetNWString(key, default) return sharedStrings[key] or default end
	function entity:SetNWString(key, value) sharedStrings[key] = value end
	function entity:LookupSequence(name) return ({idle = 0, sit = 7})[name] or -1 end
	function entity:GetSequence() return self.sequence end
	function entity:IsSequenceFinished() return self.finished end
	function entity:ResetSequence(sequence) self.sequence = sequence self.resets = self.resets + 1 end
	function entity:SetCycle(cycle) self.cycle = cycle self.finished = false end
	entity:SetupDataTables()

	return entity
end
local server = makeEntity()
server:SetDisplayName("Old Timer")
server:SetIdleAnim("idle")
check(server:GetTownSpawnAnim() == "", "unconfigured vendors have no session animation")
server:SetTownSpawnAnim("sit")
server:SetAnim()
check(server:GetDisplayName() == "Old Timer" and server:GetIdleAnim() == "idle",
	"selecting a pose preserves vendor identity and saved idle")
check(server.sequence == 7 and server.cycle == 0, "real vendor playback applies the selected networked pose")
local client = makeEntity()
check(client:GetTownSpawnAnim() == "sit", "a newly observing client reads the selected pose independently of identity")
client:SetAnim()
check(client.sequence == 7, "the real client playback consumes the networked pose")
server:SetTownSpawnAnim("idle")
client:SetAnim()
check(client.sequence == 0 and server:GetDisplayName() == "Old Timer", "sequence zero switches without identity corruption")
server:SetTownSpawnAnim("")
check(client:GetTownSpawnAnim() == "", "clearing the session override propagates")
print("PASS: " .. checks .. " animation networking checks")
