
local PLUGIN = PLUGIN

PLUGIN.name = "Map Scenes"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Adds areas of the map that are visible during character selection."
PLUGIN.scenes = PLUGIN.scenes or {}

local x3, y3 = 0, 0
local realOrigin = Vector(0, 0, 0)
local realAngles = Angle(0, 0, 0)
local view = {}
local VISIBILITY_UPDATE_INTERVAL = 0.25
local VISIBILITY_TIMEOUT = 2
local VISIBILITY_TOLERANCE_SQUARED = 16 * 16

if (CLIENT) then
	PLUGIN.ordered = PLUGIN.ordered or {}

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

	function PLUGIN:CalcView(client, origin, angles, fov)
		local scenes = self.scenes

		if (IsValid(ix.gui.characterMenu) and !IsValid(ix.gui.menu) and !ix.gui.characterMenu:IsClosing() and
			!table.IsEmpty(scenes)) then
			local key = self.index
			local value = scenes[self.index]

			if (!self.index or !value) then
				value, key = table.Random(scenes)
				self.index = key
			end

			if (self.orderedIndex or value.origin or isvector(key)) then
				local curTime = CurTime()

				self.orderedIndex = self.orderedIndex or 1

				local ordered = self.ordered[self.orderedIndex]

				if (ordered) then
					key = ordered[1]
					value = ordered[2]
				end

				if (!self.startTime) then
					self.startTime = curTime
					self.finishTime = curTime + 30
				end

				local fraction = math.min(math.TimeFraction(self.startTime, self.finishTime, CurTime()), 1)

				if (value) then
					realOrigin = LerpVector(fraction, key, value[1])
					realAngles = LerpAngle(fraction, value[2], value[3])
				end

				if (fraction >= 1) then
					self.startTime = curTime
					self.finishTime = curTime + 30

					if (ordered) then
						self.orderedIndex = self.orderedIndex + 1

						if (self.orderedIndex > #self.ordered) then
							self.orderedIndex = 1
						end
					else
						local keys = {}

						for k, _ in pairs(scenes) do
							if (isvector(k)) then
								keys[#keys + 1] = k
							end
						end

						self.index = keys[ math.random( #keys ) ]
					end
				end
			elseif (value) then
				realOrigin = value[1]
				realAngles = value[2]
			end

			local x, y = gui.MousePos()
			local x2, y2 = surface.ScreenWidth() * 0.5, surface.ScreenHeight() * 0.5
			local frameTime = FrameTime() * 0.5

			y3 = Lerp(frameTime, y3, math.Clamp((y - y2) / y2, -1, 1) * -6)
			x3 = Lerp(frameTime, x3, math.Clamp((x - x2) / x2, -1, 1) * 6)

			view.origin = realOrigin + realAngles:Up()*y3 + realAngles:Right()*x3
			view.angles = realAngles + Angle(y3 * -0.5, x3 * -0.5, 0)

			updateVisibility(view.origin)

			return view
		end

		updateVisibility()
	end

	function PLUGIN:PreDrawViewModel(viewModel, client, weapon)
		if (IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing()) then
			return true
		end
	end

	net.Receive("ixMapSceneAdd", function()
		local data = net.ReadTable()

		PLUGIN.scenes[#PLUGIN.scenes + 1] = data
	end)

	net.Receive("ixMapSceneRemove", function()
		local index = net.ReadUInt(16)

		PLUGIN.scenes[index] = nil
	end)

	net.Receive("ixMapSceneAddPair", function()
		local data = net.ReadTable()
		local origin = net.ReadVector()

		PLUGIN.scenes[origin] = data

		table.insert(PLUGIN.ordered, {origin, data})
	end)

	net.Receive("ixMapSceneRemovePair", function()
		local key = net.ReadVector()

		PLUGIN.scenes[key] = nil

		for k, v in ipairs(PLUGIN.ordered) do
			if (v[1] == key) then
				table.remove(PLUGIN.ordered, k)

				break
			end
		end
	end)

	net.Receive("ixMapSceneSync", function()
		local length = net.ReadUInt(32)
		local data = net.ReadData(length)
		local uncompressed = util.Decompress(data)

		if (!uncompressed) then
			ErrorNoHalt("[Helix] Unable to decompress map scene data!\n")
			return
		end

		-- Set the list of texts to the ones provided by the server.
		PLUGIN.scenes = util.JSONToTable(uncompressed)

		for k, v in pairs(PLUGIN.scenes) do
			if (v.origin or isvector(k)) then
				table.insert(PLUGIN.ordered, {v.origin and v.origin or k, v})
			end
		end
	end)
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

	util.AddNetworkString("ixMapSceneSync")
	util.AddNetworkString("ixMapSceneAdd")
	util.AddNetworkString("ixMapSceneRemove")

	util.AddNetworkString("ixMapSceneAddPair")
	util.AddNetworkString("ixMapSceneRemovePair")

	function PLUGIN:SaveScenes()
		self:SetData(self.scenes)
	end

	function PLUGIN:LoadData()
		self.scenes = self:GetData() or {}
	end

	function PLUGIN:PlayerInitialSpawn(client)
		local json = util.TableToJSON(self.scenes)
		local compressed = util.Compress(json)
		local length = compressed:len()

		net.Start("ixMapSceneSync")
			net.WriteUInt(length, 32)
			net.WriteData(compressed, length)
		net.Send(client)
	end

	function PLUGIN:AddScene(position, angles, position2, angles2)
		local data

		if (position2) then
			data = {origin=position, position2, angles, angles2}
			self.scenes[#self.scenes + 1] = data

			net.Start("ixMapSceneAddPair")
				net.WriteTable(data)
				net.WriteVector(position)
			net.Broadcast()
		else
			data = {position, angles}
			self.scenes[#self.scenes + 1] = data

			net.Start("ixMapSceneAdd")
				net.WriteTable(data)
			net.Broadcast()
		end

		self:SaveScenes()
	end
end

ix.command.Add("MapSceneAdd", {
	description = "@cmdMapSceneAdd",
	privilege = "Manage Map Scenes",
	adminOnly = true,
	arguments = bit.bor(ix.type.bool, ix.type.optional),
	OnRun = function(self, client, bIsPair)
		local position, angles = client:EyePos(), client:EyeAngles()

		-- This scene is in a pair for moving scenes.
		if (tobool(bIsPair) and !client.ixScnPair) then
			client.ixScnPair = {position, angles}

			return "@mapRepeat"
		else
			if (client.ixScnPair) then
				PLUGIN:AddScene(client.ixScnPair[1], client.ixScnPair[2], position, angles)
				client.ixScnPair = nil
			else
				PLUGIN:AddScene(position, angles)
			end

			return "@mapAdd"
		end
	end
})

ix.command.Add("MapSceneRemove", {
	description = "@cmdMapSceneRemove",
	privilege = "Manage Map Scenes",
	adminOnly = true,
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, radius)
		radius = radius or 280

		local position = client:GetPos()
		local i = 0

		for k, v in pairs(PLUGIN.scenes) do
			local delete = false

			if (isvector(k)) then
				if (k:Distance(position) <= radius or v[1]:Distance(position) <= radius) then
					delete = true
				end
			elseif (v[1]:Distance(position) <= radius) then
				delete = true
			end

			if (delete) then
				if (isvector(k)) then
					net.Start("ixMapSceneRemovePair")
						net.WriteVector(k)
					net.Broadcast()
				else
					net.Start("ixMapSceneRemove")
						net.WriteString(k)
					net.Broadcast()
				end

				PLUGIN.scenes[k] = nil

				i = i + 1
			end
		end

		if (i > 0) then
			PLUGIN:SaveScenes()
		end

		return "@mapDel", i
	end
})
