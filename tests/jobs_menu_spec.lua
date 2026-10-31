-- Run from the addon root: luatex --luaonly tests/jobs_menu_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local classes = {}
local methods = {}
local clock = 0
local activeJobs = {}
local sent = {}
local notifications = {}
local fieldActions = {}
local character = {GetJobs = function() return activeJobs end, GetData = function() return 0 end}
local client = {
	GetCharacter = function() return character end,
	Notify = function(_, text) notifications[#notifications + 1] = text end,
}
local function panel(class)
	local value = {class = class, children = {}, height = 20, width = 800, margin = {0, 0, 0, 0}}
	return setmetatable(value, {__index = function(_, key)
		return classes[class] and classes[class][key] or methods[key]
	end})
end
function methods:Add(class)
	local child = panel(class)
	child.parent = self
	self.children[#self.children + 1] = child
	if child.Init then child:Init() end

	return child
end
function methods:GetChildren() return self.children end
function methods:Clear() self.children = {} end
function methods:SetText(value) self.text = value end
function methods:SetFont(value) self.font = value end
function methods:SetTall(value) self.height = value end
function methods:GetTall() return self.height end
function methods:SetWide(value) self.width = value end
function methods:DockMargin(...) self.margin = {...} end
function methods:GetDockMargin() return table.unpack(self.margin) end
function methods:GetVBar()
	self.bar = self.bar or panel("VBar")
	self.bar.btnGrip = self.bar.btnGrip or panel("Grip")

	return self.bar
end
for _, name in ipairs({"Dock", "DockPadding", "SetTextColor", "SetWrap", "SetAutoStretchVertical",
	"SetHideButtons"}) do methods[name] = function() end end
TOP, FILL, RIGHT = 1, 2, 3
PLUGIN = {}
Color = function(...) return {...} end
ScrW = function() return 1920 end
ScrH = function() return 1080 end
RealTime = function() return clock end
LocalPlayer = function() return client end
SortedPairs = function(value)
	local keys = {}
	for key in pairs(value) do keys[#keys + 1] = key end
	table.sort(keys)
	local index = 0

	return function()
		index = index + 1
		local key = keys[index]
		if key then return key, value[key] end
	end
end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
surface = {CreateFont = function() end, SetFont = function() end,
	GetTextSize = function(text) return #text * 10, 17 end}
vgui = {Register = function(name, definition) classes[name] = definition end}
netstream = {
	Hook = function() end,
	Start = function(name, npc) sent[#sent + 1] = {name = name, npc = npc} end,
}
ix = {jobs = {
	list = {hunt = {}, survey = {}},
	getFormattedName = function(job) return "Task " .. job.identifier end,
	getFormattedDesc = function(job) return "Description with reward " .. job.reward end,
	field = {OpenMenu = function(npc, kind) fieldActions[#fieldActions + 1] = {npc = npc, kind = kind} end},
}}
dofile("gamemodes/ix_cotz/plugins/jobsystem/cl_plugin.lua")
local menu = panel("ixCharacterJournalPanel")
menu:Init()
check(menu.title.text == "TASKS · 0", "empty menu shows zero tasks")
check(menu.journal.class == "DScrollPanel", "task list scrolls independently")
check(menu.journal.children[1].text:find("No active tasks", 1, true), "empty menu explains how to find work")
activeJobs = {
	Zulu = {identifier = "survey", numberRec = 1, progress = 0, reward = "recorder", fieldTask = {kind = "sensor"}},
	Alpha = {identifier = "hunt", numberRec = 4, progress = 2, reward = "bandages"},
}
menu:Think()
check(menu.title.text == "TASKS · 2", "accepted jobs appear while the menu is open")
local card = menu.journal.children[1]
check(card.children[2].text == "Alpha", "tasks have stable contact ordering")
check(card.children[3].text == "Description with reward bandages", "cards show descriptions and rewards")
check(card.children[4].text == "Progress: 2 / 4", "cards show current objective progress")
card.children[3]:SetTall(160)
card:PerformLayout()
check(card:GetTall() > 200, "cards grow to fit a wrapped description")
local actions = card.children[6]
actions.children[1]:DoClick()
check(sent[1].name == "job_removeplayerjob" and sent[1].npc == "Alpha", "abandon targets the correct contact")
check(activeJobs.Alpha ~= nil, "abandon waits for authoritative state before removing the card")
function character:GetData() return os.time() + 30 end
actions.children[1]:DoClick()
check(#sent == 1 and #notifications == 1, "abandon cooldown prevents repeat requests")
local fieldButtons = menu.journal.children[2].children[6].children
fieldButtons[2]:DoClick()
check(fieldActions[1].npc == "Zulu" and fieldActions[1].kind == "sensor", "field action uses its own assignment")
activeJobs.Alpha.progress = 4
activeJobs.Alpha.isCompleted = true
clock = 1
menu:Think()
check(menu.journal.children[1].children[4].text == "Complete — return to Alpha",
	"completion refreshes the return instruction")
local stableCard = menu.journal.children[1]
clock = 2
menu:Think()
check(menu.journal.children[1] == stableCard, "unchanged jobs preserve cards and scroll state")
activeJobs.Alpha = nil
clock = 3
menu:Think()
check(menu.title.text == "TASKS · 1", "server removal updates the task count")
character = nil
clock = 4
menu:Think()
check(menu.title.text == "TASKS · 0", "character departure clears the displayed assignments")
print("PASS: " .. checks .. " task menu checks")
