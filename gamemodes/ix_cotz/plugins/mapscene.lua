-- Extends the bundled Helix "mapscene" plugin (gamemodes/helix/plugins/mapscene.lua). Sharing its unique ID makes
-- this file load into the same PLUGIN table after the bundled one, so Helix itself stays unmodified.
-- The server adds the character-menu camera position to the client's PVS, so scenery away from the
-- player's body is networked. Clients report the position and the server accepts only points on a scene path.
local PLUGIN = PLUGIN

local VISIBILITY_UPDATE_INTERVAL = 0.25
local VISIBILITY_TIMEOUT = 2
local VISIBILITY_TOLERANCE_SQUARED = 16 * 16

if CLIENT then
	local nextVisibilityUpdate = 0
	local visibilityActive = false

	local function updateVisibility(origin)
		local curTime = CurTime()

		if curTime < nextVisibilityUpdate or (not origin and not visibilityActive) then
			return
		end

		nextVisibilityUpdate = curTime + VISIBILITY_UPDATE_INTERVAL
		visibilityActive = origin ~= nil

		net.Start("cotz/mapscene/visibility")
			net.WriteBool(visibilityActive)

			if visibilityActive then
				net.WriteVector(origin)
			end
		net.SendToServer()
	end

	-- Kept in a table rather than as a function field so the plugin loader does not cache it as a hook.
	-- Re-capture the bundled method only when it is not already this wrapper, so Lua refresh does not stack wrappers.
	PLUGIN.cotzDetours = PLUGIN.cotzDetours or {}

	if PLUGIN.CalcView ~= PLUGIN.cotzDetours.calcViewWrapper then
		PLUGIN.cotzDetours.calcView = PLUGIN.CalcView
	end

	function PLUGIN:CalcView(client, origin, angles, fov)
		local view = PLUGIN.cotzDetours.calcView(self, client, origin, angles, fov)

		updateVisibility(view and view.origin)

		return view
	end

	PLUGIN.cotzDetours.calcViewWrapper = PLUGIN.CalcView
else
	util.AddNetworkString("cotz/mapscene/visibility")

	local function isSceneOrigin(origin)
		for key, scene in pairs(PLUGIN.scenes) do
			local start = scene.origin or (isvector(key) and key)
			local nearest = scene[1]

			if start then
				local offset = scene[1] - start
				local lengthSquared = offset:LengthSqr()
				local fraction = 0

				if lengthSquared > 0 then
					fraction = math.Clamp((origin - start):Dot(offset) / lengthSquared, 0, 1)
				end

				nearest = start + offset * fraction
			end

			-- Include mouse parallax and network vector rounding, but reject arbitrary viewing positions.
			if origin:DistToSqr(nearest) <= VISIBILITY_TOLERANCE_SQUARED then
				return true
			end
		end

		return false
	end

	net.Receive("cotz/mapscene/visibility", function(_, client)
		local curTime = CurTime()

		if curTime < (client.ixMapSceneNextUpdate or 0) then
			return
		end

		client.ixMapSceneNextUpdate = curTime + VISIBILITY_UPDATE_INTERVAL * 0.5
		client.ixMapSceneOrigin = nil

		if not net.ReadBool() then
			return
		end

		local origin = net.ReadVector()

		if isSceneOrigin(origin) then
			client.ixMapSceneOrigin = origin
			client.ixMapSceneExpires = curTime + VISIBILITY_TIMEOUT
		end
	end)

	function PLUGIN:SetupPlayerVisibility(client)
		if client.ixMapSceneOrigin and CurTime() < client.ixMapSceneExpires then
			AddOriginToPVS(client.ixMapSceneOrigin)
		end
	end
end
