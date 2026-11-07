-- Run from the repository root: luatex --luaonly tests/gear_menu_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end
table.Copy = copy
table.GetKeys = function(value)
	local keys = {}
	for key in pairs(value) do keys[#keys + 1] = key end

	return keys
end
IsValid = function(value) return type(value) == "table" and value.valid == true end
Vector = function(...) return {...} end
Angle = Vector
local now = 1
RealTime = function() return now end
local timers = {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
LEFT, FILL, BOTTOM, TOP = 1, 2, 3, 4
local panels = {}
local methods = {}
local function entity()
	local result = {valid = true, attachments = {}, removals = {}}
	function result:SetSkin() end
	function result:SetBodygroup() end
	function result:LookupSequence() return 1 end
	function result:SetSequence() end
	function result:AttachPACPart(tree) self.attachments[#self.attachments + 1] = tree end
	function result:RemovePACPart(tree) self.removals[#self.removals + 1] = tree end

	return result
end
local function panel(class)
	local result = setmetatable({valid = true, class = class, children = {}, enabled = true}, {__index = methods})
	panels[#panels + 1] = result

	return result
end
function methods:Add(class)
	local child = panel(class)
	self.children[#self.children + 1] = child

	return child
end
function methods:Remove()
	if not self.valid then return end
	self.valid = false
	if self.OnRemove then self:OnRemove() end
	for _, child in ipairs(self.children) do child:Remove() end
end
methods.Close = methods.Remove
function methods:Clear() for _, child in ipairs(self.children) do child:Remove() end self.children = {} end
function methods:SetModel(model) self.model = model self.Entity = entity() end
function methods:GetModel() return self.model end
function methods:SetText(text) self.text = text end
function methods:AddChoice(name, id, selected)
	self.choices = self.choices or {}
	self.choices[#self.choices + 1] = {name = name, id = id, selected = selected}
end
function methods:SetEnabled(value) self.enabled = value end
function methods:SetWide(value) self.width = value end
for _, name in ipairs({"Dock", "SetFOV", "SetLookAt", "SetCamPos", "SetSortItems", "SetMinMax",
	"SetDecimals", "SetValue", "MakePopup"}) do methods[name] = function() end end
local frames, queries = {}, {}
ix = {gearAppearance = {}, gui = {}, cotzUI = {}, currency = {Get = function(value) return value .. " rubles" end}}
ix.cotzUI.Scale = function(value) return value end
ix.cotzUI.Frame = function()
	local frame = panel("DFrame")
	frame.Think, frame.PerformLayout = function() end, function() end
	frames[#frames + 1] = frame

	return frame, frame:Add("DScrollPanel")
end
ix.cotzUI.StyleCombo = function(control) return control end
ix.cotzUI.StyleButton = ix.cotzUI.StyleCombo
ix.cotzUI.StyleScroll, ix.cotzUI.SetHeight = function() end, function() end
ix.cotzUI.Label = function(parent, text)
	local control = parent:Add("DLabel")
	control:SetText(text)

	return control
end
ix.cotzUI.Query = function(text, _, _, accept, _, cancel)
	local query = panel("Query")
	query.text, query.accept, query.cancel = text, accept, cancel
	queries[#queries + 1] = query

	return query
end
local renderSteps = {}
pac = {
	SetupENT = function() end,
	ShowEntityParts = function(entity) renderSteps[#renderSteps + 1] = {"show", entity} end,
	RenderOverride = function(entity, pass) renderSteps[#renderSteps + 1] = {pass, entity} end,
	SetupBones = function(entity) renderSteps[#renderSteps + 1] = {"bones", entity} end,
}
local item = {
	id = 2, uniqueID = "helmet", data = {equip = true},
	appearanceCustomization = {targets = {{1}}, defaultSkin = "green", bodygroups = {}, skins = {
		{id = "green", name = "Green", skin = 0}, {id = "black", name = "Black", skin = 1},
	}},
	pacData = {{self = {ClassName = "model2", Model = "helmet.mdl", Skin = 0}, children = {}}},
}
function item:GetData(key, default) if self.data[key] == nil then return default end return self.data[key] end
function item:GetID() return self.id end
function item:GetName() return "Helmet" end
local inventory = {GetItems = function() return {[2] = item} end}
local character = {GetInventory = function() return inventory end}
local currentCharacter = character
local position = {distance = 0, DistToSqr = function(self) return self.distance end}
local player = {GetCharacter = function() return currentCharacter end, GetModel = function() return "player.mdl" end,
	GetSkin = function() return 0 end, GetBodyGroups = function() return {} end,
	GetPos = function() return position end, Notify = function() end}
LocalPlayer = function() return player end
local vendor = {valid = true, GetPos = function() return {} end,
	GetDisplayName = function() return "'Technut'" end}
net = {receivers = {}, sent = {}}
net.Receive = function(name, callback) net.receivers[name] = callback end
local data, cursor, message = {}, 1
for _, kind in ipairs({"String", "UInt", "Bool", "Entity"}) do
	net["Write" .. kind] = function(value) data[#data + 1] = value end
	net["Read" .. kind] = function() local value = data[cursor] cursor = cursor + 1 return value end
end
net.Start = function(name) message, data, cursor = name, {}, 1 end
net.SendToServer = function() net.sent[#net.sent + 1] = {name = message, data = data} end
local root = "gamemodes/ix_cotz/plugins/gearcustomization/"
dofile(root .. "sh_appearance.lua")
dofile(root .. "cl_menu.lua")
local function find(class, text)
	for index = #panels, 1, -1 do
		local control = panels[index]
		if control.valid and control.class == class and (not text or control.text == text) then return control end
	end
end
local function receive(name, values)
	data, cursor = values, 1
	net.receivers["cotz/gear-appearance/" .. name]()
end
ix.gearAppearance.OpenMenu(vendor)
local frame, model = frames[#frames], find("DModelPanel")
model:PreDrawModel(model.Entity)
check(#renderSteps == 4 and renderSteps[1][1] == "show" and renderSteps[2][1] == "update"
	and renderSteps[3][1] == "update_legacy_bones" and renderSteps[4][1] == "bones",
	"PAC updates bonemerge parenting and bone modifiers before drawing the preview character")
model:PostDrawModel(model.Entity)
check(#renderSteps == 6 and renderSteps[5][1] == "opaque" and renderSteps[6][1] == "translucent",
	"Both gear render passes follow character bone setup")
for _, step in ipairs(renderSteps) do
	check(step[2] == model.Entity, "PAC preview updates target the preview character rather than the player")
end
frame:Think()
local apply = find("DButton", "Apply — 100 rubles")
check(not apply.enabled and item.data.gearAppearance == nil, "Opening uses factory state without a purchase")
local finish = find("DComboBox")
finish:OnSelect(2, "Black", "black")
frame:Think()
check(apply.enabled and frame.selection.skin == "black", "Choosing an alternative enables Apply")
check(model.Entity.attachments[#model.Entity.attachments][1].self.Skin == 1
	and item.data.gearAppearance == nil, "Preview changes only the detached model tree")
find("DButton", "Reset Preview"):DoClick()
frame:Think()
check(not apply.enabled and frame.selection.skin == "green", "Reset restores the current saved appearance")
finish = find("DComboBox")
finish:OnSelect(2, "Black", "black")
apply:DoClick()
timers[#timers]()
check(net.sent[#net.sent].name == "cotz/gear-appearance/quote" and net.sent[#net.sent].data[2] == 2,
	"Apply requests a server quote for the exact instance")
finish:OnSelect(1, "Green", "green")
check(frame.selection.skin == "black", "Pending requests cannot change the selected purchase")
receive("quote", {123, 2, 100, "black", 0})
check(queries[#queries].text:find("Black", 1, true) and queries[#queries].text:find("100 rubles", 1, true),
	"Confirmation shows the server-quoted appearance and price")
queries[#queries].accept()
timers[#timers]()
check(net.sent[#net.sent].name == "cotz/gear-appearance/confirm" and net.sent[#net.sent].data[1] == 123,
	"Acceptance submits only the quote token and decision")
item.data.gearAppearance = {skin = "black", bodygroups = {}}
receive("result", {true, "Gear customized."})
frame:Think()
check(frame.selection.skin == "black" and not apply.enabled,
	"Success refreshes saved controls and prevents a duplicate purchase")
local tree = model.gearTree
frame:Close()
check(model.Entity.removals[#model.Entity.removals] == tree, "Closing removes the exact preview tree")
check(not model.valid, "Closing disposes of the preview panel")
ix.gearAppearance.OpenMenu(vendor)
frame = frames[#frames]
currentCharacter = {}
frame:Think()
check(not frame.valid, "Character switches close the old customization window")
currentCharacter = character
ix.gearAppearance.OpenMenu(vendor)
frame = frames[#frames]
position.distance = 192 ^ 2 + 1
frame:Think()
check(not frame.valid, "Leaving the vendor closes the window")
position.distance = 0
item.data.equip = false
ix.gearAppearance.OpenMenu(vendor)
frame = frames[#frames]
frame:Think()
check(not find("DButton", "Apply — 100 rubles").enabled and not frame.item,
	"An empty eligible list cannot submit a purchase")
frame:Close()
item.data.equip = true
local suit = {id = 3, uniqueID = "suit", isBodyArmor = true, newModel = "suit.mdl", newSkin = 0,
	data = {equip = true}, skincustom = {{name = "Skin 0", skingroup = 0},
		{name = "Skin 2", skingroup = 2, modelOverride = "suit_other.mdl"}},
	GetData = item.GetData, GetID = item.GetID, GetName = function() return "Suit" end}
inventory.GetItems = function() return {[2] = item, [3] = suit} end
local paintAllowed = false
ix.townNPCs = {HasService = function() return paintAllowed end}
ix.gearAppearance.OpenMenu(vendor)
frame = frames[#frames]
check(frame.item == item,
	"ordinary gear remains available before the painting unlock")
frame:Close()
paintAllowed = true
ix.gearAppearance.OpenMenu(vendor)
frame = frames[#frames]
frame.SelectItem(suit)
model = find("DModelPanel")
check(model.model == "suit.mdl" and not model.gearTree, "a suit previews on the character model without a PAC part")
local finish = find("DComboBox")
finish.OnSelect(finish, 2, "Finish 2", "2")
check(model.model == "suit_other.mdl" and suit:GetData("setSkin") == nil,
	"suit finish/model previews leave saved appearance unchanged")
frame.SelectItem(item)
check(model.model == "player.mdl" and model.gearTree, "switching back to gear restores the worn character preview")
frame:Close()
print("Gear menu: " .. checks .. " checks passed")
