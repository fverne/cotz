-- The server owns hideout state; these snapshots feed the contact's dynamic upgrade dialogue.
local function refreshDialogue(target, topicID)
	local panel = ix.gui.dialogue
	if not IsValid(panel) or panel.exiting or panel.target ~= target or panel.currentTopicID ~= topicID then return end
	local topic = panel.tree and panel.tree[topicID]
	if not topic or not topic.GetDynamicOptions then return end
	panel.options:Clear()
	panel:prepareDynamicOptions(topic.GetDynamicOptions(topic, LocalPlayer(), target), topic.options)
end

net.Receive("cotz/hideouts/upgrade-hideouts", function()
	local target = net.ReadEntity()
	local hideouts = {}
	for index = 1, net.ReadUInt(6) do
		hideouts[index] = {id = net.ReadString(), name = net.ReadString(), squad = net.ReadBool()}
	end
	LocalPlayer().cotzHideoutUpgradeList = {target = target, hideouts = hideouts}
	refreshDialogue(target, "HideoutUpgrades")
end)

net.Receive("cotz/hideouts/upgrade-offers", function()
	local target, hideout, revision = net.ReadEntity(), net.ReadString(), net.ReadUInt(32)
	local offers = {}
	for index = 1, net.ReadUInt(6) do
		offers[index] = {
			label = net.ReadString(), summary = net.ReadString(), description = net.ReadString(),
			payable = net.ReadBool(), redeemable = net.ReadBool(),
		}
	end
	LocalPlayer().cotzHideoutUpgradeOffers = {target = target, hideout = hideout, revision = revision, offers = offers}
	refreshDialogue(target, "HideoutUpgradeList")
end)
