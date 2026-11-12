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
ix = {gui = {}, cotzUI = {
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

reads = {"entrance", 1, "1", "Home", false, "invite", true, false, 2, 2, "Invited", 4, "Character #4"}
callbacks["cotz/hideouts/manage"]()
assert(readIndex == #reads)
buttons["Revoke invitation"]()
assert(#options == 2 and options[1][1] == "Invited" and options[2][1] == "Character #4")
options[2][2]()
assert(sent[1] == "1" and sent[2] == 7 and sent[3] == "4")
buttons["Invite character"]()
assert(#options == 2 and options[1][1] == "Invited" and options[2][1] == "Stranger")

readIndex, reads = 0, {"entrance", 1, "1", "Home", false, "invite", true, false, 0}
callbacks["cotz/hideouts/manage"]()
buttons["Revoke invitation"]()
assert(#options == 0)
print("PASS: invitation menus show saved invitees, including offline characters, and exclude strangers")

local confirmation
ix.cotzUI.Confirm = function(message, title, label, callback) confirmation = callback end
panel.nextRequest = nil
readIndex, reads = 0, {"exit", 1, "1", "Home", false, "invite", true, true, 0}
callbacks["cotz/hideouts/manage"]()
buttons["Reset hideout layout"]()
assert(confirmation and sent[2] ~= 15)
confirmation()
assert(sent[1] == "1" and sent[2] == 15)
print("PASS: layout reset requires confirmation before sending its management action")
