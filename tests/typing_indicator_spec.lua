-- Run from the addon root: luatex --luaonly tests/typing_indicator_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local now = 10
local incomingClass
local receive
local outgoing
local messages = {}
local plugin = {}
local environment = {
	PLUGIN = plugin,
	RealTime = function() return now end,
	util = {AddNetworkString = function() end},
	net = {
		Receive = function(name, callback)
			check(name == "ixTypeClass", "keeps the existing message name")
			receive = callback
		end,
		ReadString = function() return incomingClass end,
		Start = function(name) outgoing = {name = name} end,
		WriteEntity = function(client) outgoing.client = client end,
		WriteString = function(class) outgoing.class = class end,
		Broadcast = function()
			outgoing.delivery = "broadcast"
			messages[#messages + 1] = outgoing
		end,
		SendPVS = function(position)
			outgoing.delivery = "pvs"
			outgoing.position = position
			messages[#messages + 1] = outgoing
		end,
	},
}

local path = "gamemodes/helix/plugins/typing.lua"
local file = assert(io.open(path))
local source = file:read("*a")
file:close()
-- Load the actual server branch without parsing the client renderer's GLua-only syntax.
local serverSource = assert(source:match("\nelse\n(.*)\nend%s*$"))
assert(load(serverSource, "@" .. path, "t", environment))()

local position = {}
local client = {GetPos = function() return position end}
local function send(class, time, sender)
	now = time
	incomingClass = class
	receive(0, sender or client)
end

send("ic", 10)
check(#messages == 1 and messages[1].class == "ic", "starting chat sends the indicator")
check(messages[1].client == client, "the indicator belongs to the sending player")
check(messages[1].delivery == "pvs" and messages[1].position == position, "starts go to nearby viewers")
send("", 10.1)
check(#messages == 2 and messages[2].class == "", "sending a short message clears inside the cooldown")
check(messages[2].delivery == "broadcast", "clears reach viewers who have left the PVS")

send("", 10.1)
send("", 10.15)
send("", 11)
check(#messages == 2, "duplicate clears do not generate broadcasts")
send("ic", 11)
check(#messages == 3, "typing can start again after the cooldown")
send("ooc", 11.05)
check(#messages == 3, "rapid nonempty changes remain rate limited")
send("", 11.05)
check(#messages == 4 and messages[4].class == "", "cancelling chat clears after a rejected class change")
send("ic", 11.1)
check(#messages == 4, "clearing does not bypass the start cooldown")

send("ic", 12)
send("ooc", 12.3)
check(#messages == 6 and messages[6].class == "ooc", "class changes work after the cooldown")
send("", 12.31)
check(#messages == 7 and messages[7].class == "", "class changes can also be cleared immediately")

local otherClient = {GetPos = function() return position end}
send("ic", 12.31, otherClient)
check(#messages == 8 and messages[8].client == otherClient, "cooldowns are independent for each player")
send("", 12.32, otherClient)
check(#messages == 9 and messages[9].client == otherClient, "each player can clear immediately")

send("ic", 13)
check(plugin:PlayerSpawn(client) == nil, "the spawn hook allows other handlers to continue")
check(#messages == 11 and messages[11].class == "", "spawning broadcasts a clear")
check(messages[11].delivery == "broadcast", "spawn clears reach all viewers")
send("", 13.01)
check(#messages == 11, "spawning resets active indicator tracking")
send("ic", 14)
send("", 14.1)
check(#messages == 13 and messages[13].class == "", "short-message clears still work after respawning")

print("typing_indicator_spec: " .. checks .. " checks passed")
