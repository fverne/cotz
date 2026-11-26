-- Extends the bundled Helix "typing" plugin (gamemodes/helix/plugins/typing.lua). Sharing its unique ID makes this
-- file load into the same PLUGIN table after the bundled one, so Helix itself stays unmodified.
-- Upstream rate-limits every typing update, so a message sent or cancelled within 0.2 seconds of starting dropped the
-- "stopped typing" update and left the indicator stuck. Stop updates now bypass the limit when typing is active.
local PLUGIN = PLUGIN

if CLIENT then return end

local TYPE_CLASS_INTERVAL = 0.2

function PLUGIN:PlayerSpawn(client)
	client.ixTypingActive = nil

	net.Start("ixTypeClass")
		net.WriteEntity(client)
		net.WriteString("")
	net.Broadcast()
end

-- Replaces the bundled receiver registered under the same message name.
net.Receive("ixTypeClass", function(length, client)
	local newClass = net.ReadString()
	local now = RealTime()

	if newClass == "" then
		if not client.ixTypingActive then
			return
		end
	elseif (client.ixNextTypeClass or 0) > now then
		return
	end

	client.ixTypingActive = newClass ~= "" or nil

	-- Starts go only to players in the PVS, who can see the indicator. Stops are broadcast because
	-- listeners may have left the PVS before the stop is sent.
	net.Start("ixTypeClass")
	net.WriteEntity(client)
	net.WriteString(newClass)

	if newClass == "" then
		net.Broadcast()
	else
		net.SendPVS(client:GetPos())
	end

	client.ixNextTypeClass = now + TYPE_CLASS_INTERVAL
end)
