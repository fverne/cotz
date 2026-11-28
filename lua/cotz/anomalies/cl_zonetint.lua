-- Slight colour tint for players standing inside anomaly zones. The tint fades in from the zone's edge and
-- reaches full strength halfway towards its centre. Each awake zone is tracked with its colour and radius, and
-- the strongest one drives the effect every frame.
local MAX_TINT = 0.1
local FULL_STRENGTH_RATIO = 0.5

local zoneTint = {}
local zones = setmetatable({}, {__mode = "k"})

local colorModify = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

-- tint is a Vector of 0-1 channel weights: x = red, y = green, z = blue.
function zoneTint.Track(zone, tint, radius)
	local entry = zones[zone] or {}
	entry.tint = tint
	entry.radius = radius
	zones[zone] = entry
end

function zoneTint.Untrack(zone)
	zones[zone] = nil
end

local function depthAt(player, zone, radius)
	local distance = (player:GetPos() - zone:GetPos()):Length2D()

	return math.Clamp((1 - distance / radius) / FULL_STRENGTH_RATIO, 0, 1)
end

-- Resource entities also run outside Helix, so use the engine hook dispatcher.
hook.Add("RenderScreenspaceEffects", "cotz/anomalies/zone-tint", function()
	local player = LocalPlayer()
	if next(zones) == nil or not IsValid(player) then return end

	local best, bestDepth = nil, 0
	for zone, entry in pairs(zones) do
		if IsValid(zone) then
			local depth = depthAt(player, zone, entry.radius)
			if depth > bestDepth then
				best, bestDepth = entry, depth
			end
		else
			zones[zone] = nil
		end
	end
	if not best then return end

	local strength = MAX_TINT * bestDepth
	colorModify["$pp_colour_addr"] = best.tint.x * strength
	colorModify["$pp_colour_addg"] = best.tint.y * strength
	colorModify["$pp_colour_addb"] = best.tint.z * strength
	DrawColorModify(colorModify)
end)

return zoneTint
