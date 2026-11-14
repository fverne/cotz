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
local confirmation
local notifications = {}
local fieldActions = {}
local uiScale = 1.3
local fonts = {}
local currentMap = "swamps"
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
function methods:GetWide() return self.width end
function methods:SetImage(value) self.image = value end
function methods:SetKeepAspect(value) self.keepAspect = value end
function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:SetPos(x, y) self.x, self.y = x, y end
function methods:AddChoice(text, data, selected)
	self.choices = self.choices or {}
	self.choices[#self.choices + 1] = {text = text, data = data}
	if selected then self:SetText(text) end
end
function methods:DockMargin(...) self.margin = {...} end
function methods:GetDockMargin() return table.unpack(self.margin) end
function methods:GetVBar()
	self.bar = self.bar or panel("VBar")
	self.bar.btnGrip = self.bar.btnGrip or panel("Grip")

	return self.bar
end
for _, name in ipairs({"Dock", "DockPadding", "SetTextColor", "SetWrap", "SetAutoStretchVertical",
	"SetHideButtons", "SetPlaceholderText", "SetUpdateOnType", "SetSortItems", "SetTooltip"}) do
	methods[name] = function() end
end
TOP, FILL, RIGHT = 1, 2, 3
PLUGIN = {}
Color = function(...) return {...} end
ScrW = function() return 1920 end
ScrH = function() return 1080 end
RealTime = function() return clock end
LocalPlayer = function() return client end
game = {GetMap = function() return currentMap end}
string.Trim = function(value) return value:match("^%s*(.-)%s*$") end
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
surface = {CreateFont = function(name, definition) fonts[name] = definition end, SetFont = function() end,
	GetTextSize = function(text) return #text * 10, 17 end}
vgui = {Register = function(name, definition) classes[name] = definition end}
netstream = {
	Hook = function() end,
	Start = function(name, npc) sent[#sent + 1] = {name = name, npc = npc} end,
}
ix = {type = {bool = "bool"}, option = {Add = function() end}, cotzUI = {
StyleEntry = function(control) return control end, StyleCombo = function(control) return control end,
GetScale = function() return uiScale end, Query = function(text, title, cancel, onCancel, accept, onAccept)
	confirmation = {text = text, cancel = onCancel, accept = onAccept}
end}, jobs = {
	list = {hunt = {icon = "vgui/icons/snorkdead.png"}, survey = {}},
	getFormattedName = function(job) return "Task " .. job.identifier end,
	getFormattedDesc = function(job) return "Description with reward " .. job.reward end,
	GetMapName = function(map) return ({swamps = "Swamps", garbage = "Garbage"})[map] or map end,
	field = {runtimeSettings = {markerSeconds = 10}},
}, townNPCs = {byName = {Alpha = {map = "swamps"}, Zulu = {map = "garbage"}}}}
Vector = function() return {} end
net = {Receive = function() end}
dofile("gamemodes/ix_cotz/plugins/jobsystem/cl_fieldtasks.lua")
ix.jobs.field.RequestAction = function(npc, action)
	fieldActions[#fieldActions + 1] = {npc = npc, action = action}
end
ix.jobs.field.GetRecipientMap = function(state)
	local contact = ix.townNPCs.byName[state.recipient]

	return contact and contact.map or state.recipientMap
end
dofile("gamemodes/ix_cotz/plugins/jobsystem/cl_plugin.lua")
local menu = panel("ixCharacterJournalPanel")
menu:Init()
check(menu.title.text == "TASKS · 0", "empty menu shows zero tasks")
check(menu.journal.class == "DScrollPanel", "task list scrolls independently")
check(menu.journal.children[1].text:find("No active tasks", 1, true), "empty menu explains how to find work")
check(fonts.cotzTasksTitle.size == 33 and fonts.cotzTasksLabel.size == 25 and fonts.cotzTasksSmall.size == 22,
	"Tasks use the larger font scale for headings, names and body text")
activeJobs = {
	Zulu = {identifier = "survey", numberRec = 1, progress = 0, reward = "recorder", fieldTask = {kind = "sensor", stage = "deploy"}},
	Alpha = {identifier = "hunt", numberRec = 4, progress = 2, reward = "bandages"},
}
menu:Think()
check(menu.title.text == "TASKS · 2", "accepted jobs appear while the menu is open")
check(menu.journal.children[1].children[2].text == "Zulu", "field work sorts before ordinary tasks")
local card = menu.journal.children[2]
check(card.children[2].text == "Alpha", "ordinary tasks follow field work")
check(card.children[7].image == "vgui/icons/snorkdead.png" and card.children[7].keepAspect,
	"cards restore their definition image and preserve its aspect ratio")
check(menu.journal.children[1].children[7].image == "propic/event/area", "tasks without artwork use the area icon")
check(card.children[3].text == "Description with reward bandages", "cards show descriptions and rewards")
check(card.children[4].text == "Progress: 2 / 4", "cards show current objective progress")
card.children[3]:SetTall(160)
card:PerformLayout()
check(card:GetTall() > 200, "cards grow to fit a wrapped description")
local actions = card.children[6]
actions.children[1]:DoClick()
check(#sent == 0 and confirmation.text:find("Task hunt", 1, true), "abandon asks for confirmation with the task name")
confirmation.cancel()
check(#sent == 0, "cancelling abandonment sends nothing")
actions.children[1]:DoClick()
confirmation.accept()
check(sent[1].name == "job_removeplayerjob" and sent[1].npc == "Alpha", "abandon targets the correct contact")
check(activeJobs.Alpha ~= nil, "abandon waits for authoritative state before removing the card")
function character:GetData() return os.time() + 30 end
actions.children[1]:DoClick()
check(#sent == 1 and #notifications == 1, "abandon cooldown prevents repeat requests")
function character:GetData() return 0 end
actions.children[1]:DoClick()
local oldJob = activeJobs.Alpha
activeJobs.Alpha = {identifier = "survey", rewardKey = "replacement"}
confirmation.accept()
check(#sent == 1, "a stale confirmation cannot abandon a replacement assignment")
activeJobs.Alpha = oldJob
actions.children[1]:DoClick()
function character:GetData() return os.time() + 30 end
confirmation.accept()
check(#sent == 1, "confirmation rechecks a cooldown that began while the popup was open")
function character:GetData() return 0 end
actions.children[1]:DoClick()
local previousCharacter = character
character = {GetJobs = function() return activeJobs end}
confirmation.accept()
check(#sent == 1, "confirmation cannot abandon after a character switch")
character = previousCharacter
local fieldButtons = menu.journal.children[1].children[6].children
fieldButtons[3]:DoClick()
check(fieldActions[1].npc == "Zulu" and fieldActions[1].action == "deploy", "field action uses its own assignment")
activeJobs.Alpha.progress = 4
activeJobs.Alpha.isCompleted = true
clock = 1
menu:Think()
check(menu.journal.children[2].children[4].text == "Complete — return to Alpha",
	"completion refreshes the return instruction")
local stableCard = menu.journal.children[2]
clock = 2
menu:Think()
check(menu.journal.children[2] == stableCard, "unchanged jobs preserve cards and scroll state")
uiScale = 1
clock = 2.5
menu:Think()
check(fonts.cotzTasksSmall.size == 17 and menu.journal.children[2] ~= stableCard
	and menu.journal.children[2].children[6]:GetTall() == 30,
	"Changing font scale refreshes open task cards and action rows")
activeJobs.Alpha = nil
clock = 3
menu:Think()
check(menu.title.text == "TASKS · 1", "server removal updates the task count")
activeJobs.Alpha = oldJob
menu:Rebuild()
menu.status:OnSelect(3, "Completed", "completed")
check(menu.title.text == "TASKS · 1 / 2" and menu.journal.children[1].children[2].text == "Alpha",
	"completed filter includes tasks ready for return")
menu.status:OnSelect(2, "In progress", "progress")
check(menu.title.text == "TASKS · 1 / 2" and menu.journal.children[1].children[2].text == "Zulu",
	"in-progress filter excludes completed tasks")
menu.search:OnValueChange("  RECORDER  ")
check(menu.title.text == "TASKS · 1 / 2", "search matches descriptions without case or surrounding whitespace")
menu.search:OnValueChange("bandages")
check(menu.title.text == "TASKS · 0 / 2" and menu.journal.children[1].text:find("No matching", 1, true),
	"search combines with the status filter and explains empty results")
menu.status:OnSelect(1, "All tasks", "all")
check(menu.title.text == "TASKS · 1 / 2", "status changes preserve the search")
menu.search:OnValueChange("%")
check(menu.title.text == "TASKS · 0 / 2", "search treats Lua pattern characters literally")
menu.search:OnValueChange("ALPHA")
check(menu.title.text == "TASKS · 1 / 2", "search matches contact names")
menu.search:OnValueChange("survey")
check(menu.title.text == "TASKS · 1 / 2", "search matches task names")
menu.search:OnValueChange("")
menu.zone:OnSelect(2, "Current zone", "current")
local fieldJob = activeJobs.Zulu
fieldJob.fieldTask.map = "garbage"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 2" and menu.journal.children[1].children[2].text == "Alpha",
	"current zone shows completed work at its return contact and hides remote field work")
fieldJob.fieldTask.map = "swamps"
clock = 3.5
menu:Think()
check(menu.title.text == "TASKS · 2 / 2", "saved assignment map changes refresh the zone filter")
fieldJob.fieldTask.stage = "carrying"
clock = 4
menu:Think()
check(menu.title.text == "TASKS · 1 / 2", "carrying field cargo follows the return contact rather than the search map")
fieldJob.fieldTask.recipient = "Alpha"
clock = 4.5
menu:Think()
check(menu.title.text == "TASKS · 2 / 2", "carrying cargo follows the current receiving contact")
fieldJob.fieldTask.kind = "deadDrop"
fieldJob.fieldTask.recipient = nil
fieldJob.fieldTask.destinationMap = "garbage"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 2", "carrying dead-drop cargo follows its saved burial map")
fieldJob.fieldTask.stage = "delivered"
fieldJob.fieldTask.destinationMap = "swamps"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 2", "delivered routes follow their return contact")
currentMap = "garbage"
clock = 5
menu:Think()
check(menu.title.text == "TASKS · 1 / 2" and menu.journal.children[1].children[2].text == "Zulu",
	"changing zones refreshes the current-zone filter")
menu.zone:OnSelect(1, "All zones", "all")
menu.search:OnValueChange("swamps")
check(menu.title.text == "TASKS · 1 / 2", "search matches readable zone names")
menu.search:OnValueChange("")
activeJobs = {Alpha = {identifier = "hunt", progress = 0, numberRec = 1, reward = "bandages",
	targetMap = "garbage"}}
menu.zone:OnSelect(2, "Current zone", "current")
check(menu.title.text == "TASKS · 1 / 1", "regional combat follows the saved target map")
activeJobs.Alpha.progress = 1
clock = 5.5
menu:Think()
check(menu.title.text == "TASKS · 0 / 1", "numeric completion alone moves a task to its return zone")
activeJobs.Alpha.progress = 0
activeJobs.Alpha.targetMap = nil
activeJobs.Alpha.photoKind = "mutant"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 1", "photography remains available away from the issuer's zone")
activeJobs.Alpha.photoKind = nil
ix.jobs.list.hunt.listenTrigger = "mutantKilled"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 1", "unrestricted legacy kill work remains available in other zones")
ix.jobs.list.hunt.listenTrigger = nil
ix.townNPCs.byName.Alpha = nil
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 1", "tasks without known zones remain visible")
activeJobs = {Zulu = fieldJob}
fieldJob.fieldTask.kind = "courier"
fieldJob.fieldTask.stage = "issue"
fieldJob.fieldTask.map = "swamps"
menu:Rebuild()
check(menu.title.text == "TASKS · 1 / 1", "unissued couriers follow their issuing contact")
fieldJob.fieldTask.stage = "carrying"
fieldJob.fieldTask.recipient = "Remote"
fieldJob.fieldTask.recipientMap = "swamps"
menu:Rebuild()
check(menu.title.text == "TASKS · 0 / 1", "legacy receivers use the saved recipient map")
menu.zone:OnSelect(1, "All zones", "all")
ix.jobs.list.hunt.listenTrigger = "snorkKilled"
ix.jobs.list.survey.fieldType = "sensor"
ix.jobs.list.regional = {targetSpecies = "snork", icon = "propic/event/area"}
activeJobs = {
	Zulu = {identifier = "survey", progress = 0, numberRec = 1, reward = "sensor", fieldTask = {kind = "sensor"}},
	Beta = {identifier = "survey", progress = 0, numberRec = 1, reward = "sensor"},
	Alpha = {identifier = "regional", progress = 0, numberRec = 1, reward = "hunt"},
	Omega = {identifier = "hunt", progress = 0, numberRec = 1, reward = "hunt"},
}
menu:Rebuild()
local orderedNames = {}
for _, task in ipairs(menu.journal.children) do orderedNames[#orderedNames + 1] = task.children[2].text end
check(table.concat(orderedNames, ",") == "Beta,Zulu,Alpha,Omega",
	"saved and definition-only field tasks sort first, with contact ordering within each group")
local regionalCard = menu.journal.children[3]
check(regionalCard.children[7].image == "vgui/icons/snorkdead.png",
	"regional Snork hunts reuse the legacy species photo instead of generic area artwork")
regionalCard:PerformLayout()
local icon = regionalCard.children[7]
check(icon.x + icon.width == regionalCard:GetWide() - 16 and icon.y == 12,
	"task artwork sits inside the right edge of its card")
check(regionalCard:GetTall() >= icon.height + 24, "the card remains tall enough for its artwork")
character = nil
clock = 6
menu:Think()
check(menu.title.text == "TASKS · 0", "character departure clears the displayed assignments")
print("PASS: " .. checks .. " task menu checks")
