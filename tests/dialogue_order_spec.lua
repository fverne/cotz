-- Run from the addon root: luatex --luaonly tests/dialogue_order_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
ix = {util = {GetMaterial = function() end}}
hook = {Add = function() end}
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_dialogue.lua")
local original = {"GOODBYE", "BackgroundTopic", "AboutProgression", "TradeTopic", "RepairItems", "StartBarter"}
local ordered = ix.dialogue.OrderOptions(original, true)
check(table.concat(ordered, ",") == "TradeTopic,StartBarter,RepairItems,AboutProgression,BackgroundTopic,GOODBYE",
	"main menus consistently group trade, services, progression, information and exit")
check(original[1] == "GOODBYE", "ordering does not mutate supplied option tables")
local actions = ix.dialogue.OrderOptions({"GOODBYE", "BackTopic", "second", "first"})
check(table.concat(actions, ",") == "second,first,BackTopic,GOODBYE", "submenu choices retain their deliberate order")
net = {Receive = function() end}
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
check(labels[1].text == "Choose this." and labels[2].text == "Back." and labels[3].text == "Leave.",
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
SERVER, CLIENT = false, true
dofile("gamemodes/ix_cotz/plugins/dialogue/libs/sh_taskrewards.lua")
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
check(#labels == 1 and labels[1].text == "Let's talk about something else.",
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
check(labels[#labels].text == "I'll pass.", "task confirmation displays its decline action")
labels[#labels].DoClick()
check(clicked[1] == "BackTopic", "declining a task returns to the main dialogue instead of GOODBYE")
print(string.format("PASS: %d dialogue ordering checks", checks))
