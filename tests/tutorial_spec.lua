local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local receivers, messages, timers = {}, {}, {}
local now, incomingID, outgoing = 0, nil, nil
local client = {}
function client:GetCharacter() return self.character end
local function character(id, pending)
	local result = {id = id, data = {cotzTutorialPending = pending}, owner = client, saves = 0}
	function result:GetID() return self.id end
	function result:GetPlayer() return self.owner end
	function result:GetData(key) return self.data[key] end
	function result:SetData(key, value) self.data[key] = value end
	function result:Save() self.saves = self.saves + 1 end

	return result
end
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.removed end
util = {AddNetworkString = function() end}
net = {
	Receive = function(name, callback) receivers[name] = callback end,
	ReadUInt = function(bits) assert(bits == 32) return incomingID end,
	Start = function(name) outgoing = {name = name} end,
	WriteUInt = function(value, bits) assert(bits == 32) outgoing.id = value end,
	Send = function(target) outgoing.target = target messages[#messages + 1] = outgoing end,
	SendToServer = function() messages[#messages + 1] = outgoing end,
}
local popupEnabled = true
local config = {Get = function() return popupEnabled end, Add = function() end}
ix = {config = config}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/encyclopedia/sv_tutorial.lua")
local server = PLUGIN
local newPayload = {data = {otherFeature = 7}}
server:AdjustCreationPayload(client, {}, newPayload)
check(newPayload.data.cotzTutorialPending == true and newPayload.data.otherFeature == 7,
	"Creation seeds eligibility without replacing other creation data")
local emptyPayload = {}
server:AdjustCreationPayload(client, {}, emptyPayload)
check(emptyPayload.data.cotzTutorialPending, "Creation initializes missing data")

local legacy = character(1)
client.character = legacy
server:PlayerLoadedCharacter(client, legacy)
check(#messages == 0 and not client.cotzTutorialCharacter, "Existing characters are excluded")
local fresh = character(2, true)
client.character = fresh
popupEnabled = false
server:PlayerLoadedCharacter(client, fresh)
check(#messages == 0 and fresh.data.cotzTutorialPending, "Disabled popup preserves eligibility without sending")
popupEnabled = true
server:PlayerLoadedCharacter(client, fresh)
check(messages[1].id == 2 and messages[1].target == client, "Pending requests target only their owner")
check(fresh.data.cotzTutorialPending, "Sending a request does not mark it shown")
local acknowledge = receivers["cotz/tutorial/shown"]
local function ack(id)
	incomingID = id
	now = now + 1
	acknowledge(32, client)
end
ack(1)
check(fresh.saves == 0, "Other character IDs cannot be acknowledged")
fresh.owner = {}
ack(2)
check(fresh.saves == 0, "Acknowledgement verifies ownership")
fresh.owner = client
client.character = legacy
ack(2)
check(fresh.saves == 0, "Character switches invalidate acknowledgements")
client.character = fresh
server:PlayerLoadedCharacter(client, fresh)
check(#messages == 2, "Interrupted pending requests are sent again on reload")
ack(2)
check(fresh.data.cotzTutorialPending == false and fresh.saves == 1, "Successful display clears and saves once")
ack(2)
check(fresh.saves == 1, "Duplicate acknowledgements do not save again")
server:PlayerLoadedCharacter(client, fresh)
check(#messages == 2, "Viewed characters do not automatically open again")
local reconnect = character(2, false)
client.character = reconnect
server:PlayerLoadedCharacter(client, reconnect)
check(#messages == 2, "Restored shown state remains excluded after reconnect")
local another = character(3, true)
client.character = another
ack(3)
check(another.saves == 0, "Pending state alone does not authorize an unissued acknowledgement")
server:PlayerLoadedCharacter(client, another)
incomingID = 999
acknowledge(32, client)
incomingID = 3
acknowledge(32, client)
check(another.saves == 0, "Invalid requests also consume the acknowledgement cooldown")
ack(3)
check(another.saves == 1, "Acknowledgement succeeds after the cooldown")

local methods = {}
local function panel(class)
	return setmetatable({class = class, children = {}, width = 600, height = 100}, {__index = methods})
end
function methods:Add(class)
	local child = panel(class)
	self.children[#self.children + 1] = child

	return child
end
function methods:GetChildren() return self.children end
function methods:SetTall(value) self.height = value end
function methods:GetTall() return self.height end
function methods:SetText(value) self.text = value end
function methods:IsVisible() return self.visible ~= false end
function methods:Close() self.removed = true if self.OnRemove then self:OnRemove() end end
methods.Remove = methods.Close
for _, name in ipairs({"Dock", "DockMargin", "SetContentAlignment", "SetTitle", "SetSize", "SetPos", "MakePopup",
	"ShowCloseButton", "SetDraggable", "SetTextColor", "SetFont", "SizeToContents", "Center", "SetTall",
	"SetWide", "SetHeight", "SetAlpha", "AlphaTo"}) do
	if not methods[name] then methods[name] = function() end end
end
function methods:GetSize() return 600, 400 end
local introBusy, suppressed, gameUI = false, false, false
local creation = {IsIntroActive = function() return introBusy end}
ix = {config = config, gui = {}, plugin = {Get = function(id) assert(id == "charcreation") return creation end}, cotzUI = {
	StyleScroll = function() end,
	PaintCard = function() end,
	Label = function(parent, text) local label = parent:Add("DLabel") label:SetText(text) return label end,
	Card = function(parent) return parent:Add("DPanel") end,
}}
TOP, FILL = 1, 2
local screenHeight = 1080
ScrH = function() return screenHeight end
ScrW = function() return 1920 end
LocalPlayer = function() return client end
gui = {IsGameUIVisible = function() return gameUI end}
hook = {Run = function(name) assert(name == "ShouldSuppressMenu") return suppressed end}
timer = {
	Create = function(name, _, _, callback) timers[name] = callback end,
	Remove = function(name) timers[name] = nil end,
}
local materialsLoaded, drawn = 0, nil
Material = function(path)
	materialsLoaded = materialsLoaded + 1
	return {IsError = function() return path == "missing" end,
		Width = function() return 800 end, Height = function() return 400 end}
end
surface = {SetDrawColor = function() end, SetMaterial = function() end,
	DrawTexturedRect = function(x, y, width, height) drawn = {x, y, width, height} end}
local menusCreated = 0
local function makeMenu()
	menusCreated = menusCreated + 1
	local menu = panel("ixMenu")
	local help = panel("ixHelpMenu")
	help.categories = {tutorial = true}
	help.categorySubpanels = {tutorial = panel("DScrollPanel")}
	function help:OnCategorySelected(name) self.activeCategory = self.categorySubpanels[name] end
	local container = panel("EditablePanel")
	container.children = {panel("OtherChild"), help}
	function menu:GetSubpanel(id) assert(id == 97) return container end
	function menu:GetActiveTab() return self.activeTab end
	menu.tabs = {buttons = {{name = "tasks"}, {name = "help", id = 97,
		SetSelected = function() menu.activeTab = "help" end}}}
	ix.gui.menu = menu

	return menu
end
vgui = {Create = function(class) assert(class == "ixMenu") return makeMenu() end}
local function resetClient()
	PLUGIN = {}
	dofile("gamemodes/ix_cotz/plugins/encyclopedia/cl_tutorial.lua")
	ix.gui = {}
	timers, messages = {}, {}
	introBusy, suppressed, gameUI = false, false, false
	client.character = character(10, true)
	PLUGIN:CharacterLoaded(client.character)

	return PLUGIN
end
local function request(id)
	incomingID = id
	receivers["cotz/tutorial/open"]()
end
local function tick()
	local callback = timers["cotz/tutorial/open"]
	if callback then callback() end
end

local tutorial = resetClient()
request(10)
ix.gui.characterMenu = panel("ixCharMenu")
tick()
check(not ix.gui.menu, "Waits through the character menu transition")
ix.gui.characterMenu = nil
introBusy = true
tick()
check(not ix.gui.menu, "Waits for the intro prompt and playback")
introBusy, suppressed = false, true
tick()
check(not ix.gui.menu, "Honors menu suppression")
suppressed, gameUI = false, true
tick()
check(not ix.gui.menu, "Waits for the game UI to close")
gameUI = false
request(10)
tick()
check(ix.gui.menu:GetActiveTab() == "help" and #messages == 0, "Selects Encyclopedia by name before acknowledging")
local opened = ix.gui.menu
tick()
check(#messages == 1 and messages[1].id == 10 and messages[1].name == "cotz/tutorial/shown",
	"Acknowledges the visible Tutorial on the next UI tick")
request(10)
tick()
check(#messages == 1 and not timers["cotz/tutorial/open"], "Duplicate opening requests are ignored")
local reused, help = tutorial:OpenTutorial()
check(reused == opened and help.activeCategory == help.categorySubpanels.tutorial,
	"Manual access reuses the PDA and selects Tutorial")

resetClient()
request(10)
introBusy = true
client.character = character(11)
PLUGIN:CharacterLoaded(client.character)
introBusy = false
tick()
check(not ix.gui.menu and #messages == 0 and not timers["cotz/tutorial/open"],
	"Character switching cancels deferred opening without acknowledgement")
resetClient()
request(10)
client.character = nil
tick()
check(not ix.gui.menu, "Waits for the active character to become available")
client.character = character(9)
tick()
check(not ix.gui.menu and timers["cotz/tutorial/open"], "Tolerates late active-character replication")
client.character = character(10, true)
tick()
ix.gui.menu.bClosing = true
tick()
check(#messages == 0 and not timers["cotz/tutorial/open"], "Interrupted display is not acknowledged")
request(10)
ix.gui.menu = nil
tick()
tick()
check(#messages == 1, "An interrupted opening remains eligible on a later request")

tutorial = resetClient()
request(10)
popupEnabled = false
tick()
check(not ix.gui.menu and not timers["cotz/tutorial/open"], "Disabling config cancels deferred opening")
popupEnabled = true
local tabs = {}
tutorial:PopulateTutorial(tabs)
check(type(tabs.tutorial) == "function" and #tutorial.tutorialSections == 5, "Registers the five-section Tutorial")
local includes = {}
ix.util = {Include = function(path) includes[#includes + 1] = path end}
local pluginFile = assert(io.open("gamemodes/ix_cotz/plugins/encyclopedia/sh_plugin.lua"))
local pluginSource = pluginFile:read("*a")
pluginFile:close()
assert(load(pluginSource:gsub("/%*.-%*/", ""), "@encyclopedia/sh_plugin.lua"))()
PLUGIN:PopulateHelpMenu(tabs)
check(type(tabs.readme) == "function" and type(tabs.keybinds) == "function"
	and type(tabs.tutorial) == "function", "Tutorial coexists with the existing Encyclopedia categories")
check(includes[1] == "sv_tutorial.lua" and includes[2] == "cl_tutorial.lua",
	"Shared entry point includes server and client modules through Helix")
local container = panel("DScrollPanel")
tabs.tutorial(container)
check(#container.children == 6, "Guide renders a title and five cards")
for index, section in ipairs(tutorial.tutorialSections) do
	local card = container.children[index + 1]
	check(section.image == "" and section.caption:find("Image placeholder", 1, true),
		"Each section has a labeled image placeholder")
	check(card.children[1].text == section.title and card.children[2].text == section.text,
		"Each card contains its guide text")
	local image = card.children[3]
	for _, viewport in ipairs({{1024, 768}, {1920, 1080}, {3440, 1440}, {3840, 2160}}) do
		screenHeight = viewport[2]
		image:PerformLayout(viewport[1] * 0.5)
		check(image.height > 0 and image.height <= viewport[2] * 0.35, "Placeholder fits the viewport")
	end
end
tutorial.tutorialSections[1].image = "cotz/tutorial/test.png"
container = panel("DScrollPanel")
tabs.tutorial(container)
local image = container.children[2].children[3]
image:PerformLayout(300)
image:Paint(300, image.height)
check(materialsLoaded == 1 and drawn[3] / drawn[4] == 2, "Screenshot preserves its aspect ratio")
image:Paint(300, image.height)
check(materialsLoaded == 1, "Drawing reuses the loaded material")
tutorial.tutorialSections[1].image = "missing"
container = panel("DScrollPanel")
tabs.tutorial(container)
check(container.children[2].children[3].children[1].text == "Screenshot to be added",
	"Missing materials retain the placeholder")

-- Exercise the real intro entry points and final-screen removal, without running the cinematic timers.
local delayed, frames = {}, {}
timer.Simple = function(delay, callback) delayed[delay] = callback end
timer.Exists = function() return false end
surface.CreateFont = function() end
Color = function(...) return {...} end
ScreenScale = function(value) return value end
CreateSound = function() return {Play = function() end} end
Derma_Anim = function() return {Start = function() end} end
sound = {PlayFile = function() end}
vgui.Create = function(class, parent)
	local result = panel(class)
	frames[#frames + 1] = result

	return result
end
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/charcreation/derma/cl_cotzintro.lua")
local intro = PLUGIN
check(not intro:IsIntroActive(), "Disabled or unused intro does not block Tutorial")
intro.RequestContinue()
check(intro:IsIntroActive(), "Intro prompt exposes active state")
requestButtonN.DoClick()
check(not intro:IsIntroActive(), "Declining intro releases Tutorial")
intro.RequestContinue()
requestButtonY.DoClick()
check(intro:IsIntroActive(), "Accepting intro stays active after prompt closes")
delayed[48]()
local finalScreen
for _, frame in ipairs(frames) do if frame.OnRemove then finalScreen = frame end end
check(finalScreen and intro:IsIntroActive(), "Final Enter screen still blocks Tutorial")
finalScreen:Remove()
check(not intro:IsIntroActive(), "Removing the final intro screen releases Tutorial")

print(string.format("PASS: %d tutorial checks", checks))
