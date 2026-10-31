PLUGIN.name = "Dialogue"
PLUGIN.author = "Pilot - expanded by gumlefar"
PLUGIN.desc = "System for communication between all NPCs."

if SERVER then
	util.AddNetworkString("ixDialogue")
	util.AddNetworkString("cotz/dialogue/progression-response")
	util.AddNetworkString("ixDialogueNotify")
	util.AddNetworkString("ixDialogueFreeze")
	util.AddNetworkString("ixPreCallback")
	util.AddNetworkString("ixPostCallback")
	util.AddNetworkString("ixDialogueResolveDynamic")
	util.AddNetworkString("ixPreDynamicCallback")

	net.Receive("ixDialogueFreeze", function(len, client)
		freeze = net.ReadBool()

		client:Freeze(freeze)
	end)

	local function accessibleTopic(client, treeID, topicID, target)
		local character = client:GetCharacter()
		if
			not character
			or not IsValid(target)
			or target:GetClass() ~= "ix_vendor_adv"
			or target.dialogueid ~= treeID
			or client:GetPos():DistToSqr(target:GetPos()) > 192 * 192
			or not target:CanAccess(client)
		then
			return
		end
		local tree = ix.dialogue.list[treeID]
		local topic = tree and tree.tree[topicID]
		if not topic then
			return
		end
		if
			treeID == "owlnpc"
			and string.find(topicID, "Storage", 1, true)
			and not ix.progression.IsCompleted(character, "cotz/town/cleaner/CL01")
		then
			return
		end
		if
			treeID == "technpc"
			and string.find(topicID, "Paint", 1, true)
			and not ix.progression.IsCompleted(character, "cotz/town/technut/TN13")
		then
			return
		end

		return topic
	end

	for network, callback in pairs({
		ixPreCallback = "preCallback",
		ixPostCallback = "postCallback",
		ixDialogueResolveDynamic = "ResolveDynamicOption",
		ixPreDynamicCallback = "DynamicPreCallback",
	}) do
		-- Capture each callback separately for Lua 5.1 closures.
		local callbackName = callback
		net.Receive(network, function(length, client)
			local treeID = net.ReadString()
			local topicID = net.ReadString()
			local target = net.ReadEntity()
			local data
			if callbackName == "ResolveDynamicOption" or callbackName == "DynamicPreCallback" then
				data = net.ReadTable()
			end
			local topic = accessibleTopic(client, treeID, topicID, target)
			if topic and isfunction(topic[callbackName]) then
				topic[callbackName](topic, client, target, data)
			end
		end)
	end

	netstream.Hook("ix_requestNicknameChange", function(client, requestedNickname)
		if client and client:getReputation() >= 4100 then -- Professional
			if string.len(requestedNickname) == 0 then
				client:GetCharacter():SetNickname(nil)
				client:Notify("Nickname removed.")
			elseif string.len(requestedNickname) <= 16 and string.len(requestedNickname) >= 4 then
				client:GetCharacter():SetNickname(nil)
				client:GetCharacter():SetNickname(requestedNickname)
				client:Notify("Nickname changed to " .. requestedNickname)
			else
				client:Notify("Invalid nickname length.")
			end
		end
	end)
end

local playerMeta = FindMetaTable("Player")

function playerMeta:dialogue(id, target)
	if not isentity(target) then
		return
	end
	if
		target:GetClass() == "ix_vendor_adv"
		and not ix.progression.CanUseNPC(self:GetCharacter(), target:GetDisplayName())
	then
		id = "progressionlocked"
	end

	if CLIENT then
		ix.gui.dialogue = vgui.Create("ixDialogue")
		ix.gui.dialogue.target = target
		ix.gui.dialogue.id = id

		net.Start("ixDialogueFreeze")
		net.WriteBool(true)
		net.SendToServer()
	else
		net.Start("ixDialogue")
		net.WriteEntity(target)
		net.WriteString(id)
		net.Send(self)

		self:Freeze(true)
	end
end

if CLIENT then
	hook.Add("ShouldSuppressMenu", "cotz/dialogue/suppress-menu", function(client)
		if ix.gui.dialogue then
			if IsValid(ix.gui.openedStorage) then -- needs to have contianer open time set to 0
				return false
			end

			return true
		end
	end)
end

ix.config.Add(
	"specialSaleCooldown",
	21600,
	"The cooldown for various specialsales to refresh their stocks.",
	nil,
	{
		data = { min = 0, max = 604800 },
		category = "Town NPCs",
	}
)
