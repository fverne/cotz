PLUGIN.name = "Dialogue"
PLUGIN.author = "Pilot"
PLUGIN.desc = "System for communication between all NPCs."

if (SERVER) then
	util.AddNetworkString("ixDialogue")
	util.AddNetworkString("ixDialogueFreeze")
	util.AddNetworkString("ixPreCallback")
	util.AddNetworkString("ixPostCallback")

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
end

local playerMeta = FindMetaTable("Player")

function playerMeta:dialogue(id, target)
	if not isentity(target) then return end

	if (CLIENT) then
		local panel = vgui.Create("ixDialogue")
		panel.target = target
		panel.id = id

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

--EXAMPLE USAGE

ix.command.Add("forwardconvo", {
	OnRun = function(self, client, arguments)
		local target = client:GetEyeTrace().Entity
		client:dialogue("universalunion", target)
	end
})
