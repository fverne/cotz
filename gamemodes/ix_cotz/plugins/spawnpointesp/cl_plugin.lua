local PLUGIN = PLUGIN
local REFRESH_INTERVAL = 5
local CACHE_LIFETIME = REFRESH_INTERVAL * 2
local DIM_DISTANCE = 1024
local MARKER_SIZE = 8
local LABEL_OFFSET = 12
local categoryPoints = {}
local nextRefresh = 0

local function canSeePoints()
	local client = LocalPlayer()

	return IsValid(client) and client:IsAdmin() and client:GetMoveType() == MOVETYPE_NOCLIP
		and not client:InVehicle() and ix.option.Get("observerESP", true)
		and CAMI.PlayerHasAccess(client, "Helix - Observer", nil)
end

for categoryID, category in ipairs(PLUGIN.spawnCategories) do
	category.option = "observerSpawnESP_" .. category.key
	category.color = HSVToColor((categoryID - 1) / #PLUGIN.spawnCategories * 360, 0.65, 1)

	ix.option.Add(category.option, ix.type.bool, false, {
		category = "observer",
		phrase = "Spawn Points - " .. category.name,
		description = "Show " .. category.name .. " spawn points while observing (admins only).",
		hidden = function()
			local client = LocalPlayer()

			return not IsValid(client) or not client:IsAdmin()
				or not CAMI.PlayerHasAccess(client, "Helix - Observer", nil)
		end,
		OnChanged = function()
			nextRefresh = 0
		end,
	})
end

timer.Create("cotz/spawnpoint-esp/refresh", 1, 0, function()
	if not canSeePoints() then
		categoryPoints = {}
		nextRefresh = 0

		return
	end
	if nextRefresh > CurTime() then return end

	nextRefresh = CurTime() + REFRESH_INTERVAL
	local enabled = {}
	local anyEnabled = false

	for categoryID, category in ipairs(PLUGIN.spawnCategories) do
		enabled[categoryID] = ix.option.Get(category.option, false)
		anyEnabled = anyEnabled or enabled[categoryID]
	end

	if not anyEnabled then
		categoryPoints = {}

		return
	end

	net.Start("cotz/spawnpoint-esp/request")
	for categoryID in ipairs(PLUGIN.spawnCategories) do
		net.WriteBool(enabled[categoryID])
	end
	net.SendToServer()
end)

net.Receive("cotz/spawnpoint-esp/points", function()
	local categoryID = net.ReadUInt(4)
	local reset = net.ReadBool()
	local count = net.ReadUInt(8)
	local category = PLUGIN.spawnCategories[categoryID]

	if not category or not canSeePoints() or not ix.option.Get(category.option, false) then return end

	local data = not reset and categoryPoints[categoryID] or {points = {}}
	data = data or {points = {}}
	data.expires = CurTime() + CACHE_LIFETIME

	for _ = 1, count do
		local position = net.ReadVector()
		local label = category.name .. " [" .. net.ReadString() .. "]"
		data.points[#data.points + 1] = {position = position, label = label}
	end

	categoryPoints[categoryID] = data
end)

local function drawPoint(point, color, position)
	local screen = point.position:ToScreen()
	if not screen.visible then return end
	if screen.x < 0 or screen.x > ScrW() or screen.y < 0 or screen.y > ScrH() then return end

	local distance = position:Distance(point.position)
	local alpha = math.max(255 * (1 - math.Clamp(distance / DIM_DISTANCE, 0, 1)), 80)
	color.a = alpha
	surface.SetDrawColor(color.r, color.g, color.b, alpha)
	surface.DrawOutlinedRect(screen.x - MARKER_SIZE / 2, screen.y - MARKER_SIZE / 2, MARKER_SIZE, MARKER_SIZE)
	ix.util.DrawText(point.label, screen.x, screen.y - LABEL_OFFSET, color,
		TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, "ixGenericFont", alpha)
end

function PLUGIN:HUDPaint()
	if not canSeePoints() then return end

	local position = LocalPlayer():GetPos()

	for categoryID, data in pairs(categoryPoints) do
		local category = self.spawnCategories[categoryID]

		if data.expires > CurTime() and ix.option.Get(category.option, false) then
			for _, point in ipairs(data.points) do
				drawPoint(point, category.color, position)
			end
		end
	end
end
