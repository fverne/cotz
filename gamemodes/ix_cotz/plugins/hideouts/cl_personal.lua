local PLUGIN = PLUGIN
local nextPurchase = 0

function PLUGIN:RequestPersonalBarter(id, entrance)
	if (self.nextPersonalRequest or 0) > CurTime() then return end
	self.nextPersonalRequest = CurTime() + 0.5
	net.Start("cotz/hideouts/personal-open")
	net.WriteString(id or "")
	net.WriteString(entrance or "")
	net.SendToServer()
end

local function submit(panel, revision, index)
	if nextPurchase > CurTime() then return end
	nextPurchase = CurTime() + 0.5
	net.Start("cotz/hideouts/personal-buy")
	net.WriteUInt(revision, 32)
	net.WriteUInt(index, 9)
	net.SendToServer()
	panel:Remove()
end

net.Receive("cotz/hideouts/personal-barter", function()
	if IsValid(ix.gui.personalHideoutBarter) then ix.gui.personalHideoutBarter:Remove() end
	local panel, scroll = ix.cotzUI.Frame("Hideout improvements", 0.8, 0.75, 900)
	ix.gui.personalHideoutBarter = panel
	local revision = net.ReadUInt(32)
	local count = net.ReadUInt(9)
	if count == 0 then
		ix.cotzUI.Label(scroll, "No improvements are available here. Enter your room once to resolve its container locations; use installed containers for their upgrades.")
	end
	for index = 1, count do
		local offerIndex = index
		local label, detail, allowed = net.ReadString(), net.ReadString(), net.ReadBool()
		local page = net.ReadBool()
		ix.cotzUI.Label(scroll, label, true)
		ix.cotzUI.Label(scroll, detail)
		if page then
			ix.cotzUI.Button(scroll, "Open page", function() submit(panel, revision, offerIndex) end)
		elseif allowed then
			ix.cotzUI.Button(scroll, "Purchase", function()
				ix.cotzUI.Query(label .. "\n\n" .. detail, "Confirm hideout purchase", "Purchase", function()
					submit(panel, revision, offerIndex)
				end, "Cancel")
			end)
		end
	end
end)
