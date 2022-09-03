PLUGIN.name = "Dialogue"
PLUGIN.author = "Pilot - expanded by gumlefar"
PLUGIN.desc = "System for communication between all NPCs."

if (SERVER) then
	util.AddNetworkString("ixDialogue")
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

	net.Receive("ixPreCallback", function(len, client)
		treeID = net.ReadString()
		topicID = net.ReadString()
		target = net.ReadEntity()

		topic = ix.dialogue.list[treeID].tree[topicID]

		topic.preCallback(topic, client, target)
	end)

	net.Receive("ixPostCallback", function(len, client)
		treeID = net.ReadString()
		topicID = net.ReadString()
		target = net.ReadEntity()

		topic = ix.dialogue.list[treeID].tree[topicID]

		topic.postCallback(topic, client, target)
	end)

	net.Receive("ixDialogueResolveDynamic", function(len, client)
		local treeID 	= net.ReadString()
		local topicID = net.ReadString()
		local target 	= net.ReadEntity()
		local dyndata = net.ReadTable()
		local topic = ix.dialogue.list[treeID].tree[topicID]

		topic.ResolveDynamicOption(topic, client, target, dyndata)
	end)

	net.Receive("ixPreDynamicCallback", function(len, client)
		local treeID 	= net.ReadString()
		local topicID = net.ReadString()
		local target 	= net.ReadEntity()
		local dyndata = net.ReadTable()
		local topic = ix.dialogue.list[treeID].tree[topicID]

		topic.DynamicPreCallback(topic, client, target, dyndata)
	end)

	netstream.Hook("ix_requestNicknameChange", function(client, requestedNickname)
		if client and client:getReputation() >= 1943 then
			if string.len(requestedNickname) == 0 then
				client:GetCharacter():SetNickname(nil)
				client:Notify("Nickname removed.")
			elseif string.len(requestedNickname) <= 16 and string.len(requestedNickname) >= 4 then
				client:GetCharacter():SetNickname(nil)
				client:GetCharacter():SetNickname(requestedNickname)
				client:Notify("Nickname changed to "..requestedNickname)
			else 
				client:Notify("Invalid nickname length.")
			end
		end
	end)
end

local playerMeta = FindMetaTable("Player")

function playerMeta:dialogue(id, target)
	if not isentity(target) then return end

	if (CLIENT) then
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

if(CLIENT) then
	hook.Add("ShouldSuppressMenu", "DialogMenuSuppress", function(client) 
		if(ix.gui.dialogue) then
			return true
		end
	end)
end

ix.config.Add("specialSaleCooldown", 21600, "The cooldown for various specialsales to refresh their stocks.", nil, {
	data = {min = 0, max = 604800},
	category = "Town NPCs",
})