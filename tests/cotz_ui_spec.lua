-- Run from the addon root: luatex --luaonly tests/cotz_ui_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local screenWidth, screenHeight = 1920, 1080
local fonts, fontCount, currentFont = {}, 0, nil
local rectangles = {}
local methods = {}
local function panel(class)
	return setmetatable({class = class, children = {}, width = 100, height = 24,
		margin = {0, 0, 0, 0}, text = ""}, {__index = methods})
end
function methods:Add(class)
	local child = panel(class)
	self.children[#self.children + 1] = child

	return child
end
function methods:GetChildren() return self.children end
function methods:GetClassName() return self.class end
function methods:SetText(text) self.text = text end
function methods:GetText() return self.text end
function methods:GetValue()
	assert(not self.closed, "Read entry values before removing their frame")

	return self.text
end
function methods:SetFont(font) self.font = font end
function methods:SetTall(height) self.height = height end
function methods:GetTall() return self.height end
function methods:SetWide(width) self.width = width end
function methods:GetWide() return self.width end
function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:SetPos(x, y) self.x, self.y = x, y end
function methods:DockMargin(...) self.margin = {...} end
function methods:GetDockMargin() return table.unpack(self.margin) end
function methods:DockPadding(...) self.padding = {...} end
function methods:SetZPos(value) self.z = value end
function methods:Center() self.x, self.y = (screenWidth - self.width) / 2, (screenHeight - self.height) / 2 end
function methods:GetVBar()
	if not self.bar then
		self.bar = self:Add("DVScrollBar")
		self.bar.btnGrip = self.bar:Add("DButton")
	end

	return self.bar
end
function methods:SizeToContentsX(padding)
	surface.SetFont(self.font)
	self.width = surface.GetTextSize(self.text) + padding
end
function methods:Close()
	self.closed = true
	for _, child in ipairs(self.children) do child:Close() end
end
for _, name in ipairs({"Dock", "SetTitle", "SetTextColor", "SetWrap", "SetContentAlignment",
	"SetAutoStretchVertical", "SetHideButtons", "InvalidateLayout", "InvalidateChildren", "PerformLayout",
	"Think", "MakePopup", "SetBackgroundBlur", "SetDrawOnTop", "DoModal", "RequestFocus", "SelectAllText"}) do
	methods[name] = function() end
end
ScrW = function() return screenWidth end
ScrH = function() return screenHeight end
Color = function(r, g, b, a) return {r = r, g = g, b = b, a = a} end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
TOP, BOTTOM, FILL, LEFT = 1, 2, 3, 4
TEXT_ALIGN_CENTER = 1
surface = {
	CreateFont = function(name, definition) fonts[name] = definition fontCount = fontCount + 1 end,
	SetFont = function(name) currentFont = name end,
	GetTextSize = function(text) return #text * fonts[currentFont].size / 2, fonts[currentFont].size end,
	SetDrawColor = function() end,
	DrawRect = function(x, y, width, height) rectangles[#rectangles + 1] = {x, y, width, height} end,
	DrawOutlinedRect = function() end,
}
draw = {SimpleText = function() end}
vgui = {Create = function(class)
	local frame = panel(class)
	frame.lblTitle = frame:Add("DLabel")
	frame.btnClose = frame:Add("DButton")

	return frame
end}
ix = {util = {WrapText = function(text, width, font)
	surface.SetFont(font)
	local textWidth = surface.GetTextSize(text)
	local lines = {}
	for _ = 1, math.max(1, math.ceil(textWidth / width)) do lines[#lines + 1] = text end

	return lines
end}}
dofile("gamemodes/ix_cotz/schema/libs/cl_cotzui.lua")
local frame, scroll = ix.cotzUI.Frame("Management", 0.8, 0.75, 900)
check(fontCount == 3, "Shared fonts are created once for a screen scale")
ix.cotzUI.Scale(1)
check(fontCount == 3, "Repeated drawing reuses fonts")
local field = ix.cotzUI.StyleEntry(scroll:Add("DTextEntry"))
ix.cotzUI.SetHeight(field, 34)
local button = ix.cotzUI.Button(scroll, string.rep("Long item name ", 12), function() end)
button:PerformLayout(800, 34)
local wideHeight = button:GetTall()
button:PerformLayout(240, 34)
check(button:GetTall() > wideHeight, "Long action text gains height when a menu narrows")
button:PerformLayout(800, 34)
check(button:GetTall() == wideHeight, "Wrapped actions shrink after gaining space")
check(scroll.z == 1, "Fill content docks after fixed footer actions")
for _, resolution in ipairs({{1024, 768}, {1280, 720}, {1920, 1080}, {3440, 1440}, {3840, 2160}}) do
	screenWidth, screenHeight = table.unpack(resolution)
	frame:Think()
	frame:PerformLayout(frame:GetWide(), frame:GetTall())
	check(frame.x >= 0 and frame.y >= 0 and frame.x + frame.width <= screenWidth
		and frame.y + frame.height <= screenHeight, "Frame stays within the resized viewport")
	check(field:GetTall() == ix.cotzUI.Scale(34), "Existing inputs resize with refreshed fonts")
	check(scroll:GetVBar():GetWide() == ix.cotzUI.Scale(6), "Existing scrollbars resize with the frame")
	check(frame.btnClose.x + frame.btnClose.width <= frame.width, "Close control remains inside its frame")
	for _, position in ipairs({{-30, -30}, {screenWidth + 20, screenHeight + 20}}) do
		rectangles = {}
		ix.cotzUI.DrawMarker("Field assignment", position[1], position[2])
		local rect = rectangles[1]
		check(rect[1] >= 0 and rect[2] >= 0 and rect[1] + rect[3] <= screenWidth
			and rect[2] + rect[4] <= screenHeight, "Off-edge marker labels stay on screen")
	end
end
local function find(parent, text, class)
	if (not text or parent.text == text) and (not class or parent.class == class) then return parent end
	for _, child in ipairs(parent.children) do
		local result = find(child, text, class)
		if result then return result end
	end
end
DermaMenu = function()
	local menu = panel("DMenu")
	menu.AddOption = function(control, text, callback)
		local option = control:Add("DMenuOption")
		option:SetText(text)
		option.DoClick = callback

		return option
	end
	menu.GetCanvas = function(control) return control end

	return menu
end
local selected
local menu = ix.cotzUI.Menu()
local option = menu:AddOption("Read signal", function() selected = "read" end)
option:DoClick()
check(selected == "read", "Menu styling preserves option callbacks")
local combo = ix.cotzUI.StyleCombo(panel("DComboBox"))
combo:OnMenuOpened(menu)
option:DoClick()
check(selected == "read" and option.font == "cotzUISmall", "Opened dropdown options retain their actions")
local submissions = 0
local query = ix.cotzUI.Query("Donate this item?", "Donation", "Donate", function() submissions = submissions + 1 end,
	"Cancel")
find(query, "Cancel", "DButton"):DoClick()
check(query.closed and submissions == 0, "Cancel closes a confirmation without submitting its action")
query = ix.cotzUI.Query("Buy this item?", "Purchase", "Buy", function() submissions = submissions + 1 end, "Cancel")
find(query, "Buy", "DButton"):DoClick()
check(query.closed and submissions == 1, "Confirmation runs its existing callback")
local received
local entryFrame = ix.cotzUI.StringRequest("Treasury", "Roubles", "0", function(value) received = value end)
local entry = find(entryFrame, nil, "DTextEntry")
entry:SetText("1250")
entry:OnEnter()
check(entryFrame.closed and received == "1250", "Enter captures the value before destroying the entry")
received = nil
entryFrame = ix.cotzUI.StringRequest("Listing", "Price", "100", function(value) received = value end)
find(entryFrame, "Cancel", "DButton"):DoClick()
check(entryFrame.closed and received == nil, "Cancel does not publish an edited price")
local message = ix.cotzUI.Message("Invalid slot", "Marker", "OK")
find(message, "OK", "DButton"):DoClick()
check(message.closed, "Validation messages remain dismissible")
print("PASS: " .. checks .. " COTZ UI layout and callback checks")
