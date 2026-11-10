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
local admin, observerAccess, inVehicle = false, true, false
MOVETYPE_NOCLIP = 8
local moveType = 2
local position = Vector(0, 0, 0)
local client = {
	GetCharacter = function() return character end,
	GetPos = function() return position end,
	IsAdmin = function() return admin end,
	GetMoveType = function() return moveType end,
	InVehicle = function() return inVehicle end,
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
local receivers = {}
net.Receive = function(name, callback) receivers[name] = callback end
local options, optionValues = {}, {}
ix.type = {bool = "bool"}
ix.option = {
	Add = function(key, _, default, data) options[key] = {default = default, data = data} end,
	Get = function(key, default)
		if optionValues[key] ~= nil then return optionValues[key] end

		return default
	end,
}
CAMI = {PlayerHasAccess = function() return observerAccess end}
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
dead = false
jobs.Recovery = {rewardKey = "recovery-claim", fieldTask = {kind = "recovery", map = "rp_marsh_cs",
	stage = "search", point = {1000, 0, 0}, search = {1192, 0, 0}, searchRadius = 384}}
local function showRecovery()
	local strings = {"Recovery", "recovery-claim"}
	net.ReadString = function() return table.remove(strings, 1) end
	receivers["cotz/jobsystem/recovery-marker"]()
end
local function paintRecovery(distance)
	position = Vector(1000 + distance, 0, 0)
	now = now + 0.2
	markers = {}
	PLUGIN:HUDPaint()

	return markers[1]
end
showRecovery()
local farMarker = paintRecovery(4096)
check(farMarker and farMarker.x == 1768 and farMarker.label:find("search within 30 m", 1, true),
	"nearby field work displays the saved approximate area in world space")
local midMarker = paintRecovery(2048)
local nearMarker = paintRecovery(0)
check(midMarker and midMarker.x < farMarker.x and midMarker.label:find("search within 15 m", 1, true)
	and nearMarker and nearMarker.x < midMarker.x and nearMarker.label:find("search within 5 m", 1, true),
	"active recovery marker narrows its position and displayed radius without another request")
check(not paintRecovery(4097), "walking outside the nearby area hides the recovery marker")
check(paintRecovery(2048), "returning nearby restores an unexpired recovery marker")
hidden = true
check(not paintRecovery(512), "game UI hides the recovery marker")
hidden, dead = false, true
check(not paintRecovery(512), "death hides the recovery marker")
dead = false
jobs.Recovery.fieldTask.stage = "carrying"
check(not paintRecovery(0), "collecting the cargo clears the search marker immediately")
jobs.Recovery.fieldTask.stage = "search"
showRecovery()
jobs.Recovery.rewardKey = "replacement-claim"
check(not paintRecovery(0), "a replacement assignment cannot inherit the old marker")
jobs.Recovery.rewardKey = "recovery-claim"
showRecovery()
local recoveryJob = jobs.Recovery
jobs.Recovery = nil
check(not paintRecovery(0), "abandoning the assignment clears its marker")
jobs.Recovery = recoveryJob
showRecovery()
local recoveryCharacter = character
character = {GetJobs = function() return {} end}
check(not paintRecovery(0), "switching characters clears the recovery marker")
character = recoveryCharacter
check(not paintRecovery(0), "returning to the previous character does not revive its cleared marker")
showRecovery()
now = now + ix.jobs.field.runtimeSettings.markerSeconds
check(not paintRecovery(0), "recovery marker expires after the normal assignment marker lifetime")
showRecovery()
check(paintRecovery(0), "field work can refresh an expired recovery marker")
game.GetMap = function() return "another-map" end
check(not paintRecovery(0), "recovery markers are hidden on the wrong map")
game.GetMap = function() return "rp_marsh_cs" end
jobs.Recovery.fieldTask.stage = "carrying"
paintRecovery(0)
local equipmentOption = options.observerFieldEquipmentESP
check(equipmentOption and equipmentOption.default == false and equipmentOption.data.category == "observer",
	"field equipment ESP is an opt-in Observer setting")
check(equipmentOption.data.hidden(), "non-admins cannot see the field equipment ESP setting")
admin, observerAccess = true, false
check(equipmentOption.data.hidden(), "admins without observer permission cannot see the setting")
observerAccess = true
check(not equipmentOption.data.hidden(), "admins with observer permission can see the setting")
local equipment = {
	GetPos = function() return Vector(2000, 200, 0) end,
	GetNWString = function(_, key) return key == "cotz/jobsystem/cargo-name" and "Recovered tools" end,
}
local scans = 0
ents.FindByClass = function(class)
	check(class == "ix_job_field_object", "ESP scans only field equipment")
	scans = scans + 1

	return {equipment}
end
check(not paintRecovery(0) and scans == 0, "disabled equipment ESP does not scan or draw entities")
optionValues.observerFieldEquipmentESP = true
check(not paintRecovery(0) and scans == 0, "equipment ESP requires observer noclip")
moveType = MOVETYPE_NOCLIP
local equipmentMarker = paintRecovery(0)
check(equipmentMarker and equipmentMarker.x == 2000 and equipmentMarker.y == 200
	and equipmentMarker.label == "Recovered tools", "enabled admin ESP draws the exact equipment position and name")
paintRecovery(0)
check(scans == 1, "equipment ESP caches entities between refreshes")
equipment.invalid = true
check(not paintRecovery(0), "removed equipment immediately disappears from the cached overlay")
equipment.invalid = false
admin = false
check(not paintRecovery(0), "non-admins cannot draw equipment ESP even with the option enabled")
admin, observerAccess = true, false
check(not paintRecovery(0), "losing observer access hides equipment ESP")
observerAccess, inVehicle = true, true
check(not paintRecovery(0), "vehicles hide equipment ESP")
inVehicle, optionValues.observerESP = false, false
check(not paintRecovery(0), "the master admin ESP setting also disables equipment ESP")
optionValues.observerESP = true
check(paintRecovery(0), "re-enabling master ESP restores the equipment overlay")
print("PASS: " .. checks .. " job overlay checks")
