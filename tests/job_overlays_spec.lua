-- Run from the addon root: luatex --luaonly tests/job_overlays_spec.lua
dofile("tests/field_tasks_spec.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
SERVER, CLIENT = false, true
PLUGIN = {}
local now = 100
CurTime = function() return now end
local positionMeta = getmetatable(Vector(0, 0, 0))
function positionMeta:ToScreen() return {x = self.x, y = self.y, visible = true} end
SortedPairs = pairs
local jobs = {
	Mute = {fieldTask = {kind = "triangulation", map = "rp_marsh_cs", stage = "search", point = {1000, 0, 0},
		readings = {{20, 40, 0, bearing = 90}}}},
	Atlas = {photoKind = "mutant", numberRec = 3, photoTypes = {boar = true, blinddog = true}},
	Anomalies = {photoKind = "anomaly", numberRec = 3, photoTypes = {anom_jarka = true}},
}
local character = {GetJobs = function() return jobs end}
local weapon
local hidden, dead = false, false
local client = {
	GetCharacter = function() return character end,
	GetActiveWeapon = function() return weapon end,
	Alive = function() return not dead end,
	ShouldDrawLocalPlayer = function() return false end,
}
LocalPlayer = function() return client end
game.GetMap = function() return "rp_marsh_cs" end
gui = {IsGameUIVisible = function() return hidden end}
ScrH = function() return 1080 end
local markers, lines = {}, {}
ix.cotzUI = {
	colors = {}, Scale = function(value) return value end,
	DrawMarker = function(label, x, y) markers[#markers + 1] = {label = label, x = x, y = y} end,
}
draw = {SimpleTextOutlined = function(text) lines[#lines + 1] = text end}
ix.plugin.list.anomalycontroller = {anomalydefs = {{name = "Burner", entityname = "anom_jarka"}}}
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_regionaljobs.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/cl_fieldtasks.lua")
PLUGIN:HUDPaint()
check(#markers == 1 and markers[1].x == 20 and markers[1].y == 40,
	"saved reading is marked at its recorded world position without a transient status request")
check(markers[1].label:find("90°", 1, true), "world marker displays the recorded bearing")
check(#lines == 0, "photography ledger is hidden while the camera is put away")
weapon = {GetClass = function() return "ix_camera" end}
PLUGIN:HUDPaint()
check(#lines == 0, "camera HUD has no captured-types ledger for either photography job")
jobs.Mute.fieldTask.stage = "carrying"
now = now + 1
markers = {}
PLUGIN:HUDPaint()
check(#markers == 0, "recovered transmitters clear their reading markers")
character = {GetJobs = function() return {} end}
markers, lines = {}, {}
PLUGIN:HUDPaint()
check(#markers == 0 and #lines == 0, "character switching clears cached overlays immediately")
character = {GetJobs = function() return jobs end}
hidden = true
PLUGIN:HUDPaint()
check(#lines == 0, "game UI hides the camera ledger")
hidden, dead = false, true
PLUGIN:HUDPaint()
check(#lines == 0, "death hides the camera ledger")
print("PASS: " .. checks .. " job overlay checks")
