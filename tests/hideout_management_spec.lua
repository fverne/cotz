local callbacks, buttons, options = {}, {}, {}
local reads, readIndex, sent = {}, 0, {}
local function read()
	readIndex = readIndex + 1

	return reads[readIndex]
end

PLUGIN = {}
net = {
	Receive = function(name, callback) callbacks[name] = callback end,
	ReadString = read, ReadUInt = read, ReadBool = read,
	Start = function() sent = {} end,
	WriteString = function(value) sent[#sent + 1] = value end,
	WriteUInt = function(value) sent[#sent + 1] = value end,
	SendToServer = function() end,
}
local panel = {Remove = function() end}
ix = {gui = {}, currency = {Get = function(value) return value .. " roubles" end}, cotzUI = {
	Frame = function() return panel, {} end,
	Label = function() end,
	Button = function(parent, label, callback) buttons[label] = callback end,
	Menu = function()
		options = {}

		return {
			AddOption = function(self, label, callback) options[#options + 1] = {label, callback} end,
			Open = function() end,
		}
	end,
}}
CurTime = function() return 100 end
IsValid = function() return false end
local function client(id, name)
	return {GetCharacter = function()
		return {GetID = function() return id end, GetName = function() return name end}
	end}
end
local owner, invited, stranger = client(1, "Owner"), client(2, "Invited"), client(3, "Stranger")
LocalPlayer = function() return owner end
player = {GetHumans = function() return {owner, invited, stranger} end}
dofile("gamemodes/ix_cotz/plugins/hideouts/cl_management.lua")

reads = {"entrance", 1, "1", "Home", false, "invite", true, false, 30, false, false,
	2, 2, "Invited", 4, "Character #4"}
reads[#reads + 1] = ""
callbacks["cotz/hideouts/manage"]()
assert(readIndex == #reads)
buttons["Revoke invitation"]()
assert(#options == 2 and options[1][1] == "Invited" and options[2][1] == "Character #4")
options[2][2]()
assert(sent[1] == "1" and sent[2] == 7 and sent[3] == "4")
buttons["Invite character"]()
assert(#options == 2 and options[1][1] == "Invited" and options[2][1] == "Stranger")

readIndex, reads = 0, {"entrance", 1, "1", "Home", false, "invite", true, false, 30, false, false, 0}
reads[#reads + 1] = ""
callbacks["cotz/hideouts/manage"]()
buttons["Revoke invitation"]()
assert(#options == 0)
print("PASS: invitation menus show saved invitees, including offline characters, and exclude strangers")

local confirmation
ix.cotzUI.Query = function(message, title, label, callback) confirmation = callback end
panel.nextRequest = nil
readIndex, reads = 0, {"exit", 1, "1", "Home", false, "invite", true, true, 30, false, false, 0}
reads[#reads + 1] = ""
callbacks["cotz/hideouts/manage"]()
buttons["Reset hideout layout"]()
assert(confirmation and sent[2] ~= 15)
confirmation()
assert(sent[1] == "1" and sent[2] == 15)
print("PASS: layout reset requires confirmation before sending its management action")

panel.nextRequest = nil
confirmation = nil
buttons["Delete personal hideout"]()
assert(confirmation and sent[2] ~= 17)
confirmation()
assert(sent[1] == "1" and sent[2] == 17)
print("PASS: personal hideout deletion requires confirmation")

dofile("gamemodes/ix_cotz/plugins/hideouts/cl_personal.lua")
readIndex, reads = 0, {"entrance", 1, "1", "Home", false, "invite", true, false, 30, false, false, 0}
reads[#reads + 1] = ""
callbacks["cotz/hideouts/manage"]()
assert(not buttons["Hideout improvements"] and not buttons["Upgrade prop capacity to 40 (5000 roubles)"])
buttons = {}
readIndex, reads = 0, {"1", "general", "General crate", 1, false, false, 0, 0, 2, 3, "'Ballast'", 0}
callbacks["cotz/hideouts/container"]()
assert(readIndex == #reads and not buttons["Upgrade this container"])
PLUGIN.nextPersonalRequest = 0
PLUGIN:RequestPersonalBarter("gate")
assert(sent[1] == "gate" and #sent == 1)
print("PASS: door and container menus leave upgrades to the contact; the entrance still requests claims")

panel.nextRequest = nil
readIndex, reads = 0, {"squad", 1, "1", "Squad home", true, "squad", true, false,
	30, true, false, 0}
reads[#reads + 1] = ""
callbacks["cotz/hideouts/manage"]()
buttons["Use squad vendor funds for hideout upgrades: off"]()
assert(sent[1] == "1" and sent[2] == 16 and sent[3] == "1")
local paymentText
ix.cotzUI.Query = function(message, title, label, callback) paymentText, confirmation = message, callback end
print("PASS: leader funding controls send the setting action")

buttons, confirmation = {}, nil
panel.nextRequest = nil
readIndex, reads = 0, {"entrance", 1, "1", "Home", false, "invite", true, false,
	30, false, false, 0, "new_room"}
callbacks["cotz/hideouts/manage"]()
buttons["Migrate hideout to new_room"]()
assert(confirmation and sent[2] ~= 18)
assert(paymentText:find("props are discarded", 1, true))
confirmation()
assert(sent[1] == "1" and sent[2] == 18 and readIndex == #reads)
print("PASS: migration offers require confirmation and explain prop loss")

for _, state in ipairs({{false, false, "new_room"}, {true, true, "new_room"}, {false, true, ""}}) do
	buttons = {}
	readIndex, reads = 0, {"entrance", 1, "1", "Home", state[1], "invite", state[2], false,
		30, false, false, 0, state[3]}
	callbacks["cotz/hideouts/manage"]()
	assert(not buttons["Migrate hideout to new_room"])
end
print("PASS: migration is hidden for guests, squad rooms and rooms without an offer")
