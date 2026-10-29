-- Run from the addon root: luatex --luaonly tests/dialogue_order_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
ix = {util = {GetMaterial = function() end, Include = function(filename)
	dofile("gamemodes/" .. filename)
end}}
net = {Receive = function() end}
hook = {Add = function() end}
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua")
check(type(ix.dialogue.ConfigureTaskRewards) == "function", "reward integration loads before NPC conversations")
local original = {"GOODBYE", "BackgroundTopic", "AboutProgression", "TradeTopic", "RepairItems", "StartBarter"}
local ordered = ix.dialogue.OrderOptions(original, true)
check(table.concat(ordered, ",") == "TradeTopic,StartBarter,RepairItems,AboutProgression,BackgroundTopic,GOODBYE",
	"main menus consistently group trade, services, progression, information and exit")
check(original[1] == "GOODBYE", "ordering does not mutate supplied option tables")
local actions = ix.dialogue.OrderOptions({"GOODBYE", "BackTopic", "second", "first"})
check(table.concat(actions, ",") == "second,first,BackTopic,GOODBYE", "submenu choices retain their deliberate order")
net = {Receive = function() end}
local pauseMenuHook
hook.Add = function(event, _, callback)
	if event == "OnPauseMenuShow" then pauseMenuHook = callback end
end
local panelType
vgui = {Register = function(_, panel) panelType = panel end}
dofile("gamemodes/ix_cotz/plugins/dialogue/derma/cl_dialogue.lua")
LocalPlayer = function() return {} end
Color = function() return {} end
local labels, clicked = {}, nil
local panel = setmetatable({
	tree = {
		GOODBYE = {statement = "Goodbye."},
		BackTopic = {statement = "Back."},
		action = {statement = "Action."},
	},
	options = {Add = function()
		local label = {
			Dock = function() end, DockMargin = function() end,
			SetTextColor = function() end, SetFont = function() end,
			SetMouseInputEnabled = function() end,
			SetWrap = function(self, value) self.wrap = value end,
			SetAutoStretchVertical = function(self, value) self.autoStretch = value end,
			IsHovered = function() return false end,
			SizeToContentsY = function(self) self.height = self.contentHeight end,
			Think = function(self)
				self.baseThinkCalls = (self.baseThinkCalls or 0) + 1
				if self.autoStretch then self:SizeToContentsY() end
			end,
			SetText = function(self, text) self.text = text end,
		}
		labels[#labels + 1] = label

		return label
	end},
	startTopic = function(_, topic, data) clicked = {topic, data} end,
	ResolveDynamicOption = function(_, topic, _, _, data) return topic, data end,
}, {__index = panelType})
panel:prepareDynamicOptions({
	{topicID = "GOODBYE", statement = "Leave."},
	{topicID = "action", statement = "Choose this.", dyndata = {value = 17}},
}, {"BackTopic"})
check(labels[1].text == "1. Choose this." and labels[2].text == "2. Back." and labels[3].text == "3. Leave.",
	"dynamic and static options share one ordered list with goodbye last")
check(labels[1].wrap and labels[1].autoStretch, "dialogue options enable wrapping and content-based height")
labels[1].contentHeight = 64
labels[1].Think()
check(labels[1].baseThinkCalls == 1 and labels[1].height == 64,
	"hover styling preserves the inherited label update that sizes wrapped text")
labels[1].contentHeight = 96
labels[1].Think()
check(labels[1].height == 96, "option height follows wrapped content when the layout changes")
labels[1].DoClick()
check(clicked[1] == "action" and clicked[2].value == 17, "sorting preserves the dynamic action and payload")
labels[3].DoClick()
check(clicked[1] == "GOODBYE", "the final dynamic exit still closes through GOODBYE")
KEY_0, KEY_9, KEY_PAD_0, KEY_PAD_9 = 1, 10, 37, 46
IsValid = function(value) return type(value) == "table" end
local now = 0
RealTime = function() return now end
gui = {EnableScreenClicker = function() end}
panel.HasFocus = function() return true end
panel:OnKeyCodePressed(KEY_0 + 1)
check(clicked[1] == "action" and clicked[2].value == 17, "number keys preserve dynamic action payloads")
panel:OnKeyCodePressed(KEY_PAD_0 + 3)
check(clicked[1] == "GOODBYE", "numpad keys select the matching visible option")
clicked = nil
panel:OnKeyCodePressed(KEY_0 + 9)
panel:OnKeyCodePressed(KEY_0)
check(clicked == nil, "unassigned number keys do nothing")
panel.tree.hidden = {statement = "Hidden.", ShouldAdd = function() return false end}
panel.tree.action.ShouldAdd = function() return true end
panel.tree.GOODBYE.ShouldAdd = function() return true end
labels = {}
panel:prepareOptions({"hidden", "action", "GOODBYE"})
check(#panel.buttonList == 2 and labels[1].text == "1. Action." and labels[2].text == "2. Goodbye.",
	"hidden static options leave no gaps in numbering or shortcut indices")
panel:OnKeyCodePressed(KEY_0 + 2)
check(clicked[1] == "GOODBYE", "static shortcuts use the displayed ordering")
local manyOptions = {}
for index = 1, 12 do
	manyOptions[index] = {topicID = "action", statement = "Choice " .. index, dyndata = {value = index}}
end
labels = {}
panel:prepareDynamicOptions(manyOptions, {})
clicked = nil
panel:OnKeyCodePressed(KEY_0 + 1)
check(clicked == nil, "ambiguous digits wait for a possible second digit")
panel:OnKeyCodePressed(KEY_0 + 2)
check(clicked[2].value == 12, "multi-digit shortcuts reach options beyond nine")
panel:OnKeyCodePressed(KEY_0 + 1)
now = 1
panel:Think()
check(clicked[2].value == 1, "a brief pause selects an ambiguous single-digit option")
panel.loading = true
clicked = nil
panel:OnKeyCodePressed(KEY_0 + 2)
panel.loading = false
panel.exiting = true
panel:OnKeyCodePressed(KEY_0 + 2)
check(clicked == nil, "loading and closing dialogues cannot activate shortcuts")
panel.exiting = false
SERVER, CLIENT = false, true
dofile("gamemodes/ix_cotz/plugins/jobsystem/integrations/sh_dialogue.lua")
local workDialogue = {tree = {
	GREETING = {options = {"AboutWorkTopic", "GOODBYE"}},
	BackTopic = {statement = "Let's talk about something else.", options = {"GOODBYE"}},
	AboutWorkTopic = {statement = "About work...", options = {"BackTopic"}},
}}
workDialogue.addTopic = function(id, data) workDialogue.tree[id] = data end
ix.dialogue.ConfigureTaskRewards(workDialogue)
-- After the last task and reward disappear, the renderer hides the work topic.
workDialogue.tree.AboutWorkTopic.ShouldAdd = function() return false end
panel.tree = workDialogue.tree
labels = {}
panel:prepareDynamicOptions({}, workDialogue.tree.TaskRewardChoices.options)
check(#labels == 1 and labels[1].text == "1. Let's talk about something else.",
	"empty supplies retain a visible exit after the last job and reward are gone")
labels[1].DoClick()
check(clicked[1] == "BackTopic", "empty supplies exit reaches the main conversation menu")
local previewDialogue = {tree = {
	GREETING = {options = {"GetTaskByDifficulty", "GOODBYE"}},
	BackTopic = {statement = "Let's talk about something else.", options = {"GOODBYE"}},
	GetTaskByDifficulty = {},
}}
previewDialogue.addTopic = function(id, data) previewDialogue.tree[id] = data end
ix.dialogue.ConfigureTaskRewards(previewDialogue)
panel.tree = previewDialogue.tree
panel.ResolveDynamicOption = panelType.ResolveDynamicOption
isfunction = function(value) return type(value) == "function" end
labels = {}
local confirmation = previewDialogue.tree.ConfirmSupplyTask.GetDynamicOptions(nil,
	{cotzTaskPreview = {difficulty = "easy", choices = {{label = "Bandage"}}}})
panel:prepareDynamicOptions(confirmation, {})
check(labels[#labels].text == #labels .. ". I'll pass.", "task confirmation displays its decline action")
labels[#labels].DoClick()
check(clicked[1] == "BackTopic", "declining a task returns to the main dialogue instead of GOODBYE")
local messages, removed, animations = 0, false, 0
local keyboardEnabled, mouseEnabled = true, true
local typewriterRemoved = false
timer = {
	Exists = function() return true end,
	Remove = function() typewriterRemoved = true end,
}
net.Start = function(name) check(name == "ixDialogueFreeze", "closing sends the unfreeze message") end
net.WriteBool = function(value) check(value == false, "closing requests unfreeze") end
net.SendToServer = function() messages = messages + 1 end
local finishClosing
local closingPanel = setmetatable({
	loading = true,
	optionInput = "1",
	optionInputDeadline = 10,
	HasFocus = function() return true end,
	SetKeyboardInputEnabled = function(_, value) keyboardEnabled = value end,
	SetMouseInputEnabled = function(_, value) mouseEnabled = value end,
	AlphaTo = function(_, _, _, _, callback)
		animations = animations + 1
		finishClosing = callback
	end,
	Remove = function() removed = true end,
}, {__index = panelType})
ix.gui = {dialogue = closingPanel}
check(pauseMenuHook() == false, "Escape closes even a loading dialogue and suppresses the pause menu")
check(messages == 1 and ix.gui.dialogue == nil, "Escape immediately unfreezes and clears the active dialogue")
check(not keyboardEnabled and not mouseEnabled and typewriterRemoved,
	"closing disables input and removes the typewriter timer")
check(closingPanel.optionInput == nil and closingPanel.optionInputDeadline == nil,
	"Escape cancels a pending numbered choice")
closingPanel:exit()
closingPanel:Think()
closingPanel:startTopic("missing")
closingPanel:dialogue("NPC", "late response", true)
check(messages == 1 and animations == 1, "repeated close and late responses cannot restart a closing dialogue")
finishClosing()
check(removed, "the closing animation removes the dialogue panel")
check(pauseMenuHook() == nil, "Escape leaves the pause menu available when dialogue is closed")
ix.gui.dialogue = {HasFocus = function() return false end}
check(pauseMenuHook() == nil, "Escape does not close dialogue behind another focused menu")
local vendorFile = assert(io.open("gamemodes/ix_cotz/plugins/vendor_adv/derma/cl_vendor.lua"))
local vendorSource = vendorFile:read("*a")
vendorFile:close()
local vendorRemoval = assert(vendorSource:match("(function PANEL:OnRemove%(%)%s.-)\nfunction PANEL:Think"))
local vendorType = {}
assert(load(vendorRemoval, "vendor-removal", "t", setmetatable({PANEL = vendorType}, {__index = _G})))()
local dialogueFocused, dialogueClosed, tradeClosed = false, 0, 0
ix.gui.dialogue = {
	HasFocus = function() return dialogueFocused end,
	RequestFocus = function() dialogueFocused = true end,
	exit = function() dialogueClosed = dialogueClosed + 1 end,
}
local closeMessage
net.Start = function(name) closeMessage = name end
ix.gui.vendor = setmetatable({
	IsVisible = function() return true end,
	Close = function(self)
		tradeClosed = tradeClosed + 1
		self:OnRemove()
	end,
}, {__index = vendorType})
check(pauseMenuHook() == false and tradeClosed == 1 and dialogueClosed == 0,
	"the first Escape closes trading without closing the underlying dialogue")
check(closeMessage == "ixVendorAdvClose" and ix.gui.vendor == nil,
	"closing trading runs its server cleanup and clears the vendor panel reference")
check(dialogueFocused, "closing trading returns keyboard focus to the dialogue")
check(pauseMenuHook() == false and dialogueClosed == 1 and tradeClosed == 1,
	"the second Escape closes the dialogue without closing trading again")
print(string.format("PASS: %d dialogue ordering checks", checks))
