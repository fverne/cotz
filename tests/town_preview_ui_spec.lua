-- Run from the addon root: luatex --luaonly tests/town_preview_ui_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
IsValid = function(value) return type(value) == "table" and not value.removed end
TOP, BOTTOM = 1, 2
local now, width, height = 0, 1920, 1080
CurTime = function() return now end
ScrW = function() return width end
ScrH = function() return height end
local animation = "zero"
local npc = {
	GetClass = function() return "ix_townnpc_preview" end,
	GetSequenceList = function() return {[0] = "zero", [1] = "sit", [2] = "walk"} end,
	GetTownSpawnAnim = function() return animation end,
}
local receiver, packet, sends = nil, nil, 0
net = {
	Receive = function(_, callback) receiver = callback end,
	ReadEntity = function() return npc end,
	Start = function(name) packet = {name = name} end,
	WriteEntity = function(entity) packet.entity = entity end,
	WriteUInt = function(index, bits) packet.index, packet.bits = index, bits end,
	SendToServer = function() sends = sends + 1 end,
}
local function panel(kind, parent)
	local value = {kind = kind, children = {}, parent = parent}
	if parent then parent.children[#parent.children + 1] = value end
	function value:Add(childKind) return panel(childKind, self) end
	function value:Dock(dock) self.dock = dock end
	function value:SetPlaceholderText(text) self.placeholder = text end
	function value:SetUpdateOnType(enabled) self.updateOnType = enabled end
	function value:SetText(text) self.text = text end
	function value:GetValue() return self.text or "" end
	function value:Clear() self.children = {} end
	function value:Close() self.removed = true end
	function value:Remove() self.removed = true end
	function value:SetPos(x, y) self.x, self.y = x, y end
	function value:GetWide() return width * 0.38 end
	function value:GetTall() return height * 0.7 end

	return value
end
local frame, body
ix = {cotzUI = {
	Frame = function()
		frame, body = panel("frame"), panel("body")
		frame.screenWidth, frame.screenHeight = width, height
		function frame:Think() self.screenWidth, self.screenHeight = width, height end

		return frame, body
	end,
	Scale = function(value) return value end,
	StyleEntry = function(value) return value end,
	SetHeight = function(value, tall) value.tall = tall end,
	Label = function(parent, text)
		local label = panel("label", parent)
		label.text = text

		return label
	end,
	Button = function(parent, text, callback)
		local button = panel("button", parent)
		button.text, button.DoClick = text, callback

		return button
	end,
}}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/cl_preview.lua")
receiver()
check(#body.children == 3, "all model sequences are listed, including sequence index zero")
check(body.children[1].text == "sit" and body.children[3].text == "zero", "sequences sort by name")
body.children[3]:DoClick()
check(packet.entity == npc and packet.index == 0 and packet.bits == 16, "index zero sends a typed selection")
body.children[1]:DoClick()
check(sends == 1, "rapid repeated clicks are debounced")
now = 1
local search, nextButton, previousButton
for _, child in ipairs(frame.children) do
	if child.kind == "DTextEntry" then search = child end
	if child.text == "Next sequence" then nextButton = child end
	if child.text == "Previous sequence" then previousButton = child end
end
check(search.updateOnType and previousButton.dock == BOTTOM and nextButton.dock == BOTTOM,
	"search updates while typing and navigation stays outside the scrolling list")
nextButton:DoClick()
check(packet.index == 1, "next wraps from the last alphabetic entry to the first")
now = 2
animation = "sit"
previousButton:DoClick()
check(packet.index == 0, "previous wraps to the final entry")
search:SetText("WAL")
search:OnValueChange()
check(#body.children == 1 and body.children[1].text == "walk", "search matches case-insensitively")
now = 3
nextButton:DoClick()
check(packet.index == 2, "navigation uses the filtered list")
search:SetText("[")
search:OnValueChange()
check(#body.children == 1 and body.children[1].kind == "label", "search is literal and empty results are explained")
now = 4
nextButton:DoClick()
check(sends == 4, "empty filtered lists cannot send selections")
frame:Think()
check(frame.children[1].text == "Playing: sit", "current label reflects the networked animation")
width, height = 1024, 768
frame:Think()
check(frame.x + frame:GetWide() == width - 12, "picker stays beside the preview after a resolution change")
local previousFrame = frame
receiver()
check(previousFrame.removed and frame ~= previousFrame, "opening another picker replaces the previous window")
npc.removed = true
frame:Think()
check(frame.removed, "deleting or replacing the preview closes its picker")
print("PASS: " .. checks .. " preview UI checks")
