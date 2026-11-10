local PLUGIN = PLUGIN
local marker
local nextRequest = 0
local nextOverlayUpdate = 0
local overlayCharacter
local readingMarkers = {}
local MARKER_SECONDS = ix.jobs.field.runtimeSettings.markerSeconds
local METRES_PER_UNIT = 0.01905
local MARKER_OFFSET = Vector(0, 0, 24)
local ACTIONS = {status = "Show assignment", deploy = "Deploy sensor", read = "Take signal reading",
	start = "Start or restart research", deliver = "Deliver parcel", issue = "Collect parcel from issuer"}

local function request(npc, action)
	if CurTime() < nextRequest then return end
	nextRequest = CurTime() + ix.jobs.field.actionInterval
	net.Start("cotz/jobsystem/field-action")
	net.WriteString(npc)
	net.WriteString(action)
	net.SendToServer()
end

function ix.jobs.field.RequestAction(npc, action)
	request(npc, action)
end

function ix.jobs.field.GetActions(job)
	local state = job.fieldTask
	local actions = {{action = "status", label = "Field work"}}
	if state.stage == "carrying" or state.stage == "delivered" then return actions end
	local action = ({sensor = "deploy", triangulation = "read", defence = "start", courier = "issue"})[state.kind]
	if state.kind == "sensor" and state.stage ~= "deploy" then action = nil end
	if action then actions[#actions + 1] = {action = action, label = ACTIONS[action]} end

	return actions
end

net.Receive("cotz/jobsystem/field-marker", function()
	marker = {position = net.ReadVector() + MARKER_OFFSET, label = net.ReadString(), radius = net.ReadUInt(16),
		expires = CurTime() + MARKER_SECONDS, character = LocalPlayer():GetCharacter()}
end)

net.Receive("cotz/jobsystem/recovery-marker", function()
	marker = {npc = net.ReadString(), claim = net.ReadString(), label = "Recovery area",
		expires = CurTime() + MARKER_SECONDS, character = LocalPlayer():GetCharacter(), nextUpdate = 0}
end)

local function updateRecoveryMarker(client, character)
	local job = character:GetJobs()[marker.npc]
	local state = job and job.fieldTask
	if not state or job.rewardKey ~= marker.claim or state.stage ~= "search" then
		marker = nil
		return
	end
	if CurTime() < marker.nextUpdate then return end
	marker.nextUpdate = CurTime() + ix.jobs.field.runtimeSettings.recoveryMarkerUpdateInterval
	marker.position, marker.radius = ix.jobs.field.GetRecoverySearchArea(state, client:GetPos())
	if marker.position then marker.position = marker.position + MARKER_OFFSET end
end

local function updateOverlays(character)
	if character == overlayCharacter and CurTime() < nextOverlayUpdate then return end
	overlayCharacter, nextOverlayUpdate = character, CurTime() + 0.5
	readingMarkers = {}
	for npc, job in SortedPairs(character:GetJobs()) do
		local state = job.fieldTask
		if state and state.kind == "triangulation" and state.map == game.GetMap() and state.stage == "search" then
			for index, reading in ipairs(state.readings) do
				readingMarkers[#readingMarkers + 1] = {
					position = ix.jobs.field.Unpack(reading) + MARKER_OFFSET,
					label = string.format("%s: reading %d, bearing %.0f°", npc, index,
						ix.jobs.field.ReadingBearing(state, reading)),
				}
			end
		end
	end
end

local function drawOverlays(client, character)
	updateOverlays(character)
	for _, reading in ipairs(readingMarkers) do
		local screen = reading.position:ToScreen()
		if screen.visible then
			ix.cotzUI.DrawMarker(reading.label, screen.x, screen.y, ix.cotzUI.colors.teal)
		end
	end
end

function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	local character = client:GetCharacter()
	if not client:Alive() or not character or client:ShouldDrawLocalPlayer() or gui.IsGameUIVisible() then return end
	drawOverlays(client, character)
	if not marker or CurTime() > marker.expires then return end
	if character ~= marker.character then marker = nil return end
	if marker.npc then
		updateRecoveryMarker(client, character)
		if not marker or not marker.position then return end
	end
	local screen = marker.position:ToScreen()
	if not screen.visible then return end
	local label = marker.label
	if marker.radius > 0 then
		label = label .. " (search within " .. math.ceil(marker.radius * METRES_PER_UNIT) .. " m)"
	end
	ix.cotzUI.DrawMarker(label, screen.x, screen.y, ix.cotzUI.colors.amber)
end
