-- Run from the addon root: luatex --luaonly tests/squads_menu_scoreboard_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local function loadGLua(path)
	local source = read(path):gsub("!=", "~="):gsub("!", "not ")
	return assert(load(source, "@" .. path))()
end
local classes = {}
local vars = {}
local methods = {}
local clock = 1
local clients = {}
local localClient
local function panel(class)
	return setmetatable({class = class, children = {}}, {__index = function(_, key)
		return classes[class] and classes[class][key] or methods[key]
	end})
end
function methods:Add(class)
	local child = panel(class)
	child.parent = self
	self.children[#self.children + 1] = child
	if (child.Init) then child:Init() end

	return child
end
function methods:Remove()
	self.removed = true
	for _, child in ipairs(self.children) do child:Remove() end
	if (self.OnRemove) then self:OnRemove() end
end
function methods:Clear()
	for _, child in ipairs(self:GetChildren()) do child:Remove() end
	self.children = {}
end
function methods:GetParent() return self.parent end
function methods:SetText(value) self.text = value end
function methods:SetPlayer(client) self.player = client self.character = client:GetCharacter() end
function methods:SetRecord(record)
	self.record = record
	self.player = record.player
	self.character = self.player and self.player:GetCharacter()
end
function methods:Update() end
function methods:SizeToContents() end
function methods:GetChildren()
	local children = {}
	for _, child in ipairs(self.children) do
		if (not child.removed) then children[#children + 1] = child end
	end
	return children
end
function methods:SetTall(value) self.height = value end
function methods:GetTall() return self.height or 20 end
function methods:SetColor(value) self.color = value end
function methods:SetWide(value) self.width = value end
function methods:GetWide() return self.width or 800 end
function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:SetPos(x, y) self.x, self.y = x, y end
function methods:SetKeepAspect(value) self.keepAspect = value end
function methods:SetImage(value) self.image = value end
function methods:GetValue() return self.text or "" end
function methods:SetFont(value) self.font = value end
function methods:GetText() return self.text or "" end
function methods:DockMargin(...) self.margin = {...} end
function methods:GetDockMargin() return table.unpack(self.margin or {0, 0, 0, 0}) end
function methods:GetVBar()
	self.bar = self.bar or panel("VBar")
	self.bar.btnGrip = self.bar.btnGrip or panel("Grip")
	return self.bar
end
for _, name in ipairs({"Dock", "DockPadding", "SetZPos", "SetBackgroundPaintFunction",
	"SetPaintBackground", "SetWrap", "SetAutoStretchVertical", "SetTextColor", "SetHideButtons", "SetMaterial",
	"SetMultiline", "SetUpdateOnType", "SetPlaceholderText", "SetCursor", "SetModel", "SetTooltip",
	"SetMouseInputEnabled", "SetEnabled", "InvalidateLayout", "SetHelixTooltip", "SetVisible"}) do methods[name] = function() end end
function methods:SetVisible(value) self.visible = value end
function methods:SetEnabled(value) self.enabled = value end
function IsValid(value) return type(value) == "table" and not value.removed end
function CurTime() return clock end
function LocalPlayer() return localClient end
function Color(r, g, b) return {r = r, g = g, b = b} end
function AccessorFunc() end
TOP, FILL, LEFT = 1, 2, 3
local screenWidth, screenHeight = 1920, 1080
function ScrW() return screenWidth end
function ScrH() return screenHeight end
function Material(path) return path end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
string.Trim = function(value) return value:match("^%s*(.-)%s*$") end
string.utf8len = string.len
string.utf8sub = string.sub
table.IsEmpty = function(value) return next(value) == nil end
surface = {CreateFont = function() end}
function L(value) return value end
local menuOptions, openedURL
function DermaMenu()
	menuOptions = {}

	return {AddOption = function(_, label, callback) menuOptions[label] = callback end, Open = function() end}
end
gui = {OpenURL = function(url) openedURL = url end}
local timers, sentSettings = {}, {}
timer = {Simple = function(delay, callback) timers[#timers + 1] = callback end}
local function flushTimers()
	local pending = timers
	timers = {}
	for _, callback in ipairs(pending) do callback() end
end
SERVER, CLIENT = false, true
PLUGIN = {}
vgui = {Register = function(name, definition) classes[name] = definition end}
player = {GetAll = function() return clients end, GetHumans = function() return clients end}
hook = {Add = function() end, Run = function(name, client)
	if (name == "ShouldShowPlayerOnScoreboard" and client.hidden) then return false end
end}
net = {Receive = function() end}
ix = {
	gui = {}, option = {Add = function() end}, type = {},
	cotzUI = {GetScale = function()
		return math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2) * 1.3
	end},
	char = {loaded = {}, RegisterVar = function(name, data) vars[name] = data end},
	util = {Include = function() end, GetMaterial = function(path) return path end}, command = {Add = function() end},
	config = {Get = function() return {} end},
}
game = {GetMap = function() return "map_a" end}
table.Copy = function(value)
	local result = {}
	for key, item in pairs(value) do result[key] = item end
	return result
end
ix.plugin = ix.plugin or {Get = function() end}
dofile("gamemodes/ix_cotz/plugins/simplecrossserverdata/sh_presence.lua")
local root = "gamemodes/ix_cotz/plugins/squads/"
loadGLua(root .. "sh_plugin.lua")
check(not vars.squadID.isLocal, "squad identity is visible to other players")
check(not vars.squadName.field, "display names add no database column")
check(not PLUGIN.PlayerBindPress, "squads no longer captures F4")
check(not read(root .. "derma/cl_squad.lua"):find("gm_showspare2", 1, true), "no F4 close binding remains")
local tabs = {}
PLUGIN:CreateMenuButtons(tabs)
local container = panel("container")
tabs.squads(container)
check(container.children[1].class == "ixSquadMenu", "squads tab embeds the menu")
local nextCharacterID = 0
local function client(id, name, reputation)
	nextCharacterID = nextCharacterID + 1
	local character = {id = id, name = name, characterID = nextCharacterID}
	function character:GetData()
		assert(self == localClient.character, "other characters' private data is unavailable on this client")
		return {leaderboardStats = {tasksCompleted = 3, taskEarnings = 100}}
	end
	function character:GetProgression()
		assert(self == localClient.character, "other characters' progression is unavailable on this client")
		return {}
	end
	function character:GetID() return self.characterID end
	function character:GetName() return "Name " .. self.characterID end
	function character:GetPdaavatar() return "vgui/icons/face_31.png" end
	function character:GetSquadColor() return self.color or {} end
	function character:SetSquadColor(color) self.color = color end
	function character:GetModel() return "models/error.mdl" end
	function character:GetSquadID() return self.id end
	function character:GetSquadName() return self.name end
	local value = {character = character}
	function value:GetLocalVar(key) return self[key] end
	function value:GetCharacter() return self.character end
	function value:SteamID64() return "7656119800000000" .. self.entityIndex end
	function value:EntIndex() return self.entityIndex end
	function value:Nick() return "Connecting player" end
	value.entityIndex = nextCharacterID
	function value:getReputation() return reputation end
	function value:getCurrentRankName() return "Tourist" end

	return value
end
localClient = client("NULL", "", 0)
local first = client("owner-a", "Alpha", 20)
first.character.color = Color(120, 80, 40)
local second = client("owner-a", "Alpha", 10)
local hidden = client("owner-b", "Hidden", 0)
hidden.hidden = true
clients = {localClient, first, second, hidden}
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_leaderboard.lua")
loadGLua("gamemodes/ix_cotz/schema/derma/cl_scoreboard.lua")
-- Remote presentation must run without any player entity methods or local-only action menu.
local remotePresentation = panel("ixScoreboardRow")
remotePresentation:Init()
remotePresentation:SetRecord({characterID = 900, name = "Remote medic", pdaavatar = "medic.png",
	state = "travelling", destination = "map_c", fresh = true})
check(remotePresentation.name.text == "Remote medic" and remotePresentation.avatarPath == "medic.png",
	"real remote row renders saved character identity without an entity")
check(remotePresentation.status.text == "TRAVELLING: MAP_C", "real remote row renders shared travel status")
remotePresentation.icon:DoRightClick()
remotePresentation.record.fresh = false
remotePresentation:Update()
check(remotePresentation.status.text == "STATUS UNAVAILABLE", "real row loses its online claim when stale")
-- Current character leaderboard replaces the old grouped scoreboard.
local scoreboard = panel("ixScoreboard")
scoreboard:Init()
scoreboard:Think()
check(scoreboard.selected == localClient.character:GetID(), "the dossier initially selects its owner")
check(scoreboard.rows[first.character:GetID()] and scoreboard.rows[second.character:GetID()],
	"visible local characters enter the leaderboard")
check(not scoreboard.rows[hidden.character:GetID()], "hidden characters do not enter the leaderboard")
local previousRow = scoreboard.rows[second.character:GetID()]
second.hidden = true
clock = clock + 1
scoreboard:Think()
check(previousRow.removed, "hidden players lose existing rows")
-- Shared records need no player entities, remain grouped, and are deduplicated by character ID.
ix.crossserver.rosterFresh = clock
ix.crossserver.roster = {
	[100] = {characterID = 100, name = "Remote scout", state = "online", map = "map_b",
		steamID64 = "76561198000000100",
		squadID = "owner-r", squadName = "Remote squad", squadColor = Color(90, 100, 110)},
	[101] = {characterID = 101, name = "Traveller", state = "travelling", map = "map_a", destination = "map_b"},
	[first.character:GetID()] = {characterID = first.character:GetID(), name = "Old name", map = "map_a"},
	[hidden.character:GetID()] = {characterID = hidden.character:GetID(), name = "Hidden", map = "map_b"},
}
clock = clock + 1
scoreboard:Think()
check(scoreboard.rows[100], "remote characters appear without a player entity")
scoreboard.rows[100]:DoRightClick()
check(menuOptions.viewProfile and not menuOptions["Mute / unmute"],
	"remote rows offer Steam profiles without voice actions")
menuOptions.viewProfile()
check(openedURL == "https://steamcommunity.com/profiles/76561198000000100", "remote profiles use the saved account ID")
local remoteRow = scoreboard.rows[100]
scoreboard.area:DoClick()
clock = clock + 1
scoreboard:Think()
check(not scoreboard.rows[100] and remoteRow.removed, "local-area filtering removes remote rows")
check(scoreboard.rows[101], "travellers remain associated with their source map")
scoreboard.area:DoClick()
clock = clock + 1
scoreboard:Think()
check(scoreboard.rows[100], "all-maps restores remote characters")
check(ix.crossserver.GetPresenceText(ix.crossserver.roster[101], true, false) == "TRAVELLING: MAP_B",
	"scoreboard and squad share travelling destination labels")
clock = clock + 16
local records = ix.crossserver.GetScoreboardRoster(false)
check(ix.crossserver.GetPresenceText(records[100], records[100].fresh, false) == "STATUS UNAVAILABLE",
	"stale snapshots cannot claim a remote character is online")
check(not ix.crossserver.GetScoreboardRoster(true)[100], "stale remote maps cannot pass the local filter")
ix.crossserver.roster = {}
clock = clock + 1
scoreboard:Think()
check(not scoreboard.rows[100], "remote disconnect removes the row")

local connecting = client("NULL", "", 0)
local connectingCharacter = connecting.character
connecting.character = nil
clients[#clients + 1] = connecting
ix.crossserver.roster = {
	[900] = {characterID = 900, name = "Old character", steamID64 = connecting:SteamID64()},
}
clock = clock + 1
scoreboard:Think()
local connectingID = -connecting:EntIndex()
records = ix.crossserver.GetScoreboardRoster(false)
check(scoreboard.rows[connectingID] and records[connectingID].awaitingCharacter,
	"connected players enter the scoreboard before selecting a character")
check(not records[900], "character-menu rows replace stale character snapshots for the same account")
check(ix.crossserver.GetPresenceText(records[connectingID], true, true) == "TRAVELLING: MAP_A",
	"connected players awaiting a character show travelling")
connecting.hidden = true
records = ix.crossserver.GetScoreboardRoster(false)
check(not records[connectingID] and not records[900], "hidden connection rows and their cached characters stay hidden")
connecting.hidden = false
scoreboard.rows[connectingID]:DoClick()
check(scoreboard.dossierFields.location.card.visible and not scoreboard.dossierFields.rank.card.visible,
	"connection rows show travel status without inventing character statistics")
connecting.character = connectingCharacter
clock = clock + 1
scoreboard:Think()
check(not scoreboard.rows[connectingID] and scoreboard.rows[connectingCharacter:GetID()],
	"loading a character replaces the temporary connection row")
clients[#clients] = nil
ix.crossserver.roster = {}

-- Owner access is independent of the viewer's unlocks and the list filters.
local squadPlugin = PLUGIN
PLUGIN = {HasService = function() return false end}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_networkservices.lua")
ix.townNPCs = PLUGIN
PLUGIN = squadPlugin
clock = clock + 1
scoreboard:Think()
check(scoreboard.selected == localClient.character:GetID(), "the owner remains selected without network unlocks")
for _, field in pairs(scoreboard.dossierFields) do
	check(field.card.visible == true, "every owner dossier field bypasses progression gates")
end
check(scoreboard.search.enabled == true and scoreboard.area.enabled == true,
	"search and area filters are always available")
check(ix.townNPCs:GetNetworkAccess(localClient.character).remote,
	"fresh characters can see the cross-map roster")
local filtered = ix.townNPCs:FilterNetworkRecord(localClient.character, {
	characterID = 900, map = "remote_map", profile = {reputation = 500, leaderboardStats = {tasksCompleted = 8}},
}, {remote = false})
check(filtered and filtered.profile.reputation == 500 and filtered.profile.leaderboardStats.tasksCompleted == 8,
	"remote identities, rank and activity are available without progression")
ix.crossserver.roster[first.character:GetID()] = {
	characterID = first.character:GetID(), name = "Old name", map = "map_a",
	profile = {reputation = 20, leaderboardStats = {
		tasksCompleted = 8, taskEarnings = 750, mutantsPoached = 4, favoriteContact = "Tester",
	}},
}
local otherRecord = ix.crossserver.GetScoreboardRoster(false)[first.character:GetID()]
scoreboard:SelectRecord(otherRecord)
check(scoreboard.dossierFields.taskEarnings.card.visible
	and scoreboard.dossierFields.reputation.card.visible, "other characters have fully available dossiers")
check(scoreboard.dossierFields.tasksCompleted.value.text == "8"
	and scoreboard.dossierFields.taskEarnings.value.text == "750 RU"
	and scoreboard.dossierFields.mutantsPoached.value.text == "4"
	and scoreboard.dossierFields.favoriteContact.value.text == "Tester",
	"local player dossiers retain the public server counters and favorite contact")
check(otherRecord.player == first and otherRecord.name == first.character:GetName(),
	"public statistics merge with the current local identity and actions")
ix.crossserver.roster[first.character:GetID()].profile.leaderboardStats.tasksCompleted = 9
clock = clock + 1
scoreboard:Think()
check(scoreboard.dossierFields.tasksCompleted.value.text == "9", "selected dossiers refresh with public snapshots")
scoreboard:SelectRecord(ix.crossserver.GetScoreboardRoster(false)[localClient.character:GetID()])
local lockedRoster = ix.crossserver.GetScoreboardRoster(false)
check(lockedRoster[localClient.character:GetID()].profile.reputation == 0
	and lockedRoster[localClient.character:GetID()].profile.leaderboardStats.tasksCompleted == 3,
	"server-compatible filtering preserves all personal counters")
check(next(lockedRoster[first.character:GetID()].profile.leaderboardStats) ~= nil,
	"other characters' counters remain available in roster data")
ix.townNPCs.HasService = function() return true end
scoreboard.search:SetText("does not match any character")
clock = clock + 1
scoreboard:Think()
check(not scoreboard.rows[localClient.character:GetID()]
	and scoreboard.selected == localClient.character:GetID(), "a list filter cannot clear the personal dossier")
local previousCharacter = localClient.character
localClient.character = client("NULL", "", 0).character
clock = clock + 1
scoreboard:Think()
check(scoreboard.selected == localClient.character:GetID(), "character switching selects the new owner's dossier")
localClient.character = nil
clock = clock + 1
scoreboard:Think()
check(scoreboard.selected == nil and next(scoreboard.rows) == nil
	and scoreboard.details.text == "Select a stalker", "unloading a character clears its personal dossier")
localClient.character, ix.townNPCs = previousCharacter, nil

-- Load the real UI helpers and exercise the wrapper's state transitions.
dofile(root .. "derma/cl_squad.lua")
local squadView = classes.ixSquadView
classes.ixSquadView = {SetMembers = function(self, squad) self.data = squad end}
local menu = panel("ixSquadMenu")
menu:Init()
menu:Think()
check(menu.state == "loners", "unaffiliated menu offers creation")
localClient.character.id = "owner-c"
clock = clock + 1
menu:Think()
check(menu.state == "loading", "pending roster synchronization shows a loading state")
ix.squad.list["owner-c"] = {members = {[localClient.character:GetID()] = 0}}
clock = clock + 1
menu:Think()
check(menu.content.class == "ixSquadView", "receiving membership embeds the management panel")
check(ix.gui.squad == menu.content, "network updates target the embedded panel")
localClient.character.id = "NULL"
clock = clock + 1
menu:Think()
check(menu.state == "loners", "leaving replaces management with creation")
-- Exercise the styled management panel, layout and draft saving with real UI methods.
classes.ixSquadView = squadView
localClient.character.id = "owner-c"
local data = {owner = "owner-c", name = "Test squad", description = "Meet at camp.", memberInfo = {
	[localClient.character:GetID()] = {name = "Leader"}, [100] = {name = "Scout"}, [101] = {name = "Medic"},
}, members = {[localClient.character:GetID()] = 2, [100] = 0, [101] = 1}}
local view = panel("ixSquadView")
view:Init()
view:SetMembers(data)
check(view.name.font == "cotzSquadsTitle", "squad heading uses the shared alsina font family")
check(view.entryMessage.font == "cotzSquadsSmall", "inline message editor matches the COTZ UI")
check(view.memberTags[localClient.character:GetID()].icon == "vgui/icons/face_31.png",
	"member cards use character PDA portraits")
local portrait = view.memberTags[localClient.character:GetID()]
portrait:PerformLayout(400)
check(portrait.avatar.width / portrait.avatar.height == 1.5, "PDA portraits match the scoreboard ratio")
check(not view.logo, "squad header has no icon")
check(view.memberCount == 3, "styled roster keeps every character")
check(view.count.text == "3 stalkers  /  1 on this server", "summary reports local presence without claiming remote status")
local remoteRow = view.memberTags[100]
remoteRow.info.state, remoteRow.info.map = "online", "another_map"
ix.squad.presenceFresh = {id = "owner-c", time = clock}
remoteRow:UpdateCharacter()
check(remoteRow.status.text == "ONLINE: ANOTHER_MAP", "fresh shared presence displays the remote map")
clock = clock + 16
remoteRow:UpdateCharacter()
check(remoteRow.status.text == "STATUS UNAVAILABLE", "stale shared presence becomes unavailable")
view.body:PerformLayout(1000, 600)
local paneGap = math.ceil(12 * ix.cotzUI.GetScale())
check(view.overview.width + view.roster.width + paneGap == 1000 and view.roster.y == 0,
	"wide layout has separate overview and roster columns")
view.body:PerformLayout(500, 600)
check(view.roster.x == 0 and view.roster.y == view.overview.height + paneGap,
	"narrow layout stacks both scrolling panes without overlap")
view.entryName.OnValueChange(view.entryName, "Draft name")
view:SetMembers(data)
check(view.netData.name == "Draft name" and view.name.text == "Draft name", "roster updates preserve an unsaved name")
local pendingData
net.Start = function() end
net.WriteTable = function(value) pendingData = value end
net.SendToServer = function() sentSettings[#sentSettings + 1] = pendingData end
view:SaveSettings()
check(#sentSettings == 1 and sentSettings[1].name == "Draft name", "save submits staged settings")
view.entryMessage.OnValueChange(view.entryMessage, "Latest message")
view:SaveSettings()
view.entryName.OnValueChange(view.entryName, "Final name")
view:OnRemove()
clock = clock + 2
flushTimers()
check(#sentSettings == 2 and sentSettings[2].name == "Final name"
	and sentSettings[2].description == "Latest message", "closing edits merge into the pending rate-limited save")
view.entryName.OnValueChange(view.entryName, "Stale edit")
view:SaveSettings()
localClient.character.id = "another-squad"
clock = clock + 2
flushTimers()
check(#sentSettings == 2, "delayed settings cannot change a different squad after membership changes")
localClient.character.id = "NULL"
localClient.squadInvite = {targetID = localClient.character:GetID(), name = "Inviting squad",
	inviter = "Scout", expires = clock + 30}
clock = clock + 1
menu:Think()
check(IsValid(menu.acceptInvite), "a live invitation adds an acceptance button to the open menu")
local acceptEvent
net.Start = function(event) acceptEvent = event end
menu.acceptInvite:DoClick()
check(acceptEvent == "cotz/squads/accept-invite", "acceptance uses the dedicated network request")
clock = clock + 31
menu:Think()
check(not IsValid(menu.acceptInvite), "expired invitations disappear from the menu")
-- Server synchronization publishes only the display name; full data still goes to members.
SERVER, CLIENT = true, false
ix.squad.meta = {}
loadGLua(root .. "meta/sh_squad.lua")
local member = client("owner-c", "", 0)
local otherCharacter = client("another-squad", "Other", 0)
local outsider = client("NULL", "", 0)
function member:SteamID64() return "member" end
function otherCharacter:SteamID64() return "owner-c" end
function outsider:SteamID64() return "outsider" end
local writes = 0
function member.character:SetSquadName(name) self.name = name writes = writes + 1 end
function otherCharacter.character:SetSquadName() error("must not overwrite another character's squad") end
clients = {member, otherCharacter, outsider}
local sentTo
net.Start = function() end
net.WriteTable = function() end
net.Send = function(receivers) sentTo = receivers end
local squad = setmetatable({owner = "owner-c", name = "Charlie", memberInfo = {},
	members = {[member.character:GetID()] = 0}},
	{__index = ix.squad.meta})
squad:Sync(member)
check(member.character.name == "Charlie", "restoring a squad publishes its display name")
check(#sentTo == 1 and sentTo[1] == member, "targeted roster synchronization stays private")
squad:Sync(member)
check(writes == 1, "unchanged public metadata is not retransmitted")
squad.name = "Delta"
squad:Sync()
check(member.character.name == "Delta", "renames update public metadata")
check(#sentTo == 1 and sentTo[1] == member, "full roster excludes other active characters")
print("squads menu/scoreboard: " .. checks .. " checks passed")
