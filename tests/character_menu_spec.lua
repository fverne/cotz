-- Run from the addon root: luatex --luaonly tests/character_menu_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local panels = {}
vgui = {Register = function(name, panel) panels[name] = panel end}
AccessorFunc = function() end
local file = assert(io.open("gamemodes/ix_cotz/schema/derma/cl_charload.lua"))
local source = file:read("*a")
file:close()
source = source:gsub("!=", "~="):gsub("!", "not ")
assert(load(source, "@cl_charload.lua"))()
local loadPanel = panels.ixCharMenuLoad

local function button()
	return {
		SetDisabled = function(self, value) self.disabled = value end,
		Show = function(self) self.visible = true end,
		Hide = function(self) self.visible = false end,
	}
end

local localCharacter
LocalPlayer = function()
	return {GetCharacter = function() return localCharacter end}
end
ix = {characters = {}, char = {loaded = {}}, faction = {indices = {}}}
color_white = {}
local sent, writtenID = {}, nil
net = {
	Start = function(name) check(name == "ixCharacterChoose", "choose retains the existing message") end,
	WriteUInt = function(id, bits)
		check(bits == 32, "choose retains a 32-bit character ID")
		writtenID = id
	end,
	SendToServer = function() sent[#sent + 1] = writtenID end,
}

local function character(id)
	return {
		GetID = function() return id end,
		GetFaction = function() return 1 end,
		GetName = function() return "Character " .. id end,
	}
end

local function panel()
	local parent = {mainPanel = {
		Undim = function(self) self.undimmed = true end,
		createButton = button(),
		loadButton = button(),
	}}
	local list = {buttons = {}}
	function list:Clear() self.buttons = {} end
	function list:SizeToContents() end
	function list:ScrollToChild() end
	function list:Add()
		return {
			SetBackgroundColor = function() end,
			SetText = function() end,
			SizeToContents = function() end,
			SetButtonList = function(self, buttons) buttons[#buttons + 1] = self end,
			SetSelected = function(self) self.OnSelected(self) end,
		}
	end
	local result = setmetatable({
		characterList = list,
		continueButton = button(),
		deleteButton = button(),
		carousel = {SetActiveCharacter = function(self, value) self.character = value end},
		bActive = true,
		visible = true,
		mouseEnabled = true,
		GetParent = function() return parent end,
		SetActiveSubpanel = function(self, name) self.activeSubpanel = name end,
		SetMouseInputEnabled = function(self, value) self.mouseEnabled = value end,
		Slide = function(self, direction, length, callback)
			self.pendingSlide = function()
				self.visible = direction ~= "down"
				callback(self)
			end
		end,
		SlideUp = function(self, length)
			self.recoveryLength = length
			self.visible = true
			self.mouseEnabled = true
			self:OnSlideUp()
		end,
		SlideDown = function(self, length)
			self.recoveryLength = length
			self.visible = false
			self.mouseEnabled = false
			self:OnSlideDown()
		end,
	}, {__index = loadPanel})
	parent.loadCharacterPanel = result

	return result, parent
end

local first, second = character(1), character(2)
local menu, parent = panel()
menu:Populate()
check(menu.character == nil, "an empty roster has no selection")
check(menu.continueButton.disabled and menu.deleteButton.disabled, "empty rosters disable character actions")
menu:ChooseCharacter()
check(menu.pendingSlide == nil and menu.mouseEnabled, "choosing without a character leaves the menu interactive")

ix.characters, ix.char.loaded = {1, 2}, {[1] = first, [2] = second}
localCharacter = first
menu:Populate()
check(menu.character == first, "the current character is selected when available")
check(not menu.continueButton.disabled and not menu.deleteButton.disabled, "a selection enables character actions")
menu:ChooseCharacter()
check(not menu.mouseEnabled, "choosing disables input during the transition")
menu.pendingSlide()
check(#sent == 1 and sent[1] == 1, "valid selections are sent after the transition")

menu, parent = panel()
menu:Populate()
menu:ChooseCharacter()
ix.char.loaded[1] = nil
ix.characters = {1}
menu.character = nil
menu.pendingSlide()
check(#sent == 1, "a character removed during the animation is never sent")
check(not menu.visible and parent.mainPanel.undimmed, "an invalidated empty selection restores the main menu")
check(menu.recoveryLength == 0, "empty recovery avoids reusing the completing animation slot")

ix.char.loaded[1] = first
ix.characters = {1, 2}
menu, parent = panel()
menu:Populate()
menu:ChooseCharacter()
menu.character = second
menu.pendingSlide()
check(#sent == 1, "a changed selection cannot send the stale character ID")
check(menu.visible and menu.mouseEnabled, "a changed selection restores an interactive load panel")
check(menu.recoveryLength == 0, "selection recovery avoids reusing the completing animation slot")

menu, parent = panel()
menu:Populate()
menu:ChooseCharacter()
ix.characters, ix.char.loaded = {}, {}
menu.pendingSlide()
check(menu.character == nil and not menu.visible, "a stale character reference is cleared before restoring the menu")
check(parent.mainPanel.undimmed, "deletion before acknowledgement restores the main menu")

ix.characters, ix.char.loaded = {1, 2}, {[1] = first, [2] = second}
menu, parent = panel()
menu:Populate(1)
check(menu.character == second and #menu.characterList.buttons == 1, "optimistic deletion selects another character")
ix.characters, ix.char.loaded = {2}, {[2] = second}
menu:OnCharacterDeleted(first)
check(menu.character == second and menu.activeSubpanel == "main", "deletion acknowledgement refreshes the selection")
check(menu.bActive, "deleting one of several characters keeps the load panel active")

menu:ChooseCharacter()
ix.characters, ix.char.loaded = {}, {}
menu:OnCharacterDeleted(second)
check(menu.character == nil and menu.carousel.character == nil, "deleting the last character clears its preview")
check(menu.continueButton.disabled and menu.deleteButton.disabled, "deleting the last character disables actions")
check(not menu.bActive and parent.mainPanel.undimmed, "deleting the last character returns to the main menu")
menu.pendingSlide()
check(#sent == 1, "even a stale animation callback cannot select the deleted character")

ix.characters, ix.char.loaded = {9, 2}, {[2] = second}
menu:Populate()
check(menu.character == second and #menu.characterList.buttons == 1, "missing sync entries are skipped")
ix.characters, ix.char.loaded = {9}, {}
menu:Populate()
check(menu.character == nil and menu.continueButton.disabled, "an unsynchronized roster cannot choose a character")

-- Verify that the owning menu exposes creation after the last deletion acknowledgement.
file = assert(io.open("gamemodes/ix_cotz/schema/derma/cl_character.lua"))
source = file:read("*a")
file:close()
local start = assert(source:find("function PANEL:OnCharacterDeleted(character)", 1, true))
local finish = assert(source:find("\nend", start, true)) + 3
local rootPanel = {}
assert(load(source:sub(start, finish):gsub("!", "not "), "@cl_character.lua", "t",
	setmetatable({PANEL = rootPanel}, {__index = _G})))()
ix.characters = {}
rootPanel.OnCharacterDeleted(parent, second)
check(parent.mainPanel.createButton.visible, "last deletion exposes character creation")
check(not parent.mainPanel.loadButton.visible, "last deletion hides the load button")

-- The initial roster message can arrive before LocalPlayer() has player methods.
local mainStart = assert(source:find("-- main character menu panel", 1, true))
local mainFinish = assert(source:find("-- container panel", mainStart, true)) - 1
local mainPlayer = {}
local directLoad = false
local mainEnvironment = setmetatable({
	PANEL = {},
	LocalPlayer = function() return mainPlayer end,
	ScrW = function() return 1920 end,
	ScrH = function() return 1080 end,
	Color = function() return {} end,
	L = function(value) return value end,
	GAMEMODE = {Version = "test"},
	Schema = {},
	hook = {Run = function() end},
}, {__index = _G})
ix.config = {Get = function(key, default)
	if key == "charloadremove" then return directLoad end

	return default
end}
assert(load(source:sub(mainStart, mainFinish):gsub("!=", "~="):gsub("!", "not "),
	"@cl_character.lua", "t", mainEnvironment))()
local mainPanel = panels.ixCharMenuMain

local function control()
	local result = button()
	result.visible = true
	result.SetText = function(self, value) self.text = value end
	result.GetWide = function() return 100 end
	result.GetTall = function() return 20 end
	result.Add = function() return control() end
	result.SetTextColor = function() end
	result.SetFont = function() end
	result.SizeToContents = function() end
	result.SetPos = function() end
	result.SetSize = function() end
	result.Dock = function() end
	result.SetWide = function() end

	return result
end

local function openMainMenu()
	local result = setmetatable({
		GetParent = function() return {} end,
		GetPadding = function() return 16 end,
		DockPadding = function() end,
		Add = function() return control() end,
	}, {__index = mainPanel})
	result:Init()

	return result
end

ix.characters, ix.char.loaded = {}, {}
menu = openMainMenu()
check(menu.createButton.visible, "an early empty roster exposes character creation")
check(not menu.loadButton.visible, "an early empty roster hides character loading")
check(menu.reloadMenuButton ~= nil, "an early empty roster finishes building recovery controls")
check(menu.returnButton.text == "exit the zone", "an early menu finishes building its exit button")

mainPlayer = {GetCharacter = function() return localCharacter end}
localCharacter = nil
menu = openMainMenu()
check(menu.createButton.visible and not menu.loadButton.visible, "a ready player with no characters can create one")

directLoad = true
ix.characters, ix.char.loaded = {1}, {[1] = first}
menu = openMainMenu()
check(menu.reloadMenuButton ~= nil, "an unloaded existing character retains the search button")
localCharacter = first
menu = openMainMenu()
check(menu.reloadMenuButton == nil, "a loaded single character does not get a search button")
check(menu.returnButton.text == "return", "a loaded character retains the return button")

ix.characters, ix.char.loaded = {1, 2}, {[1] = first, [2] = second}
menu = openMainMenu()
check(menu.reloadMenuButton ~= nil, "multiple characters retain the search button")

print("character_menu_spec: " .. checks .. " checks passed")
