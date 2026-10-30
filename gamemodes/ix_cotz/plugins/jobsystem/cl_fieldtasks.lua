local PLUGIN = PLUGIN
local marker
local nextRequest = 0
local MARKER_SECONDS = 30
local MARKER_COLOR = Color(235, 200, 100)
local METRES_PER_UNIT = 0.01905
local MARKER_OFFSET = Vector(0, 0, 24)
local ACTIONS = {status = "Show assignment", deploy = "Deploy sensor", read = "Take signal reading",
	start = "Start or restart research", deliver = "Deliver parcel"}

local function request(npc, action)
	if CurTime() < nextRequest then return end
	nextRequest = CurTime() + ix.jobs.field.actionInterval
	net.Start("cotz/jobsystem/field-action")
	net.WriteString(npc)
	net.WriteString(action)
	net.SendToServer()
end

function ix.jobs.field.OpenMenu(npc, kind)
	local menu = DermaMenu()
	menu:AddOption(ACTIONS.status, function() request(npc, "status") end)
	if kind == "sensor" then
		menu:AddOption(ACTIONS.deploy, function() request(npc, "deploy") end)
	elseif kind == "triangulation" then
		menu:AddOption(ACTIONS.read, function() request(npc, "read") end)
	elseif kind == "deadDrop" then
		menu:AddOption(ACTIONS.deliver, function() request(npc, "deliver") end)
	elseif kind == "defence" then
		menu:AddOption(ACTIONS.start, function() request(npc, "start") end)
	end
	menu:Open()
end

net.Receive("cotz/jobsystem/field-marker", function()
	marker = {position = net.ReadVector(), label = net.ReadString(), radius = net.ReadUInt(16),
		expires = CurTime() + MARKER_SECONDS, character = LocalPlayer():GetCharacter()}
end)

function PLUGIN:HUDPaint()
	if not marker or CurTime() > marker.expires then return end
	local client = LocalPlayer()
	if not client:Alive() or client:GetCharacter() ~= marker.character then marker = nil return end
	local screen = (marker.position + MARKER_OFFSET):ToScreen()
	if not screen.visible then return end
	local label = marker.label
	if marker.radius > 0 then
		label = label .. " (search within " .. math.ceil(marker.radius * METRES_PER_UNIT) .. " m)"
	end
	draw.SimpleTextOutlined(label, "DermaDefault", screen.x, screen.y, MARKER_COLOR,
		TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
end
