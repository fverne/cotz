-- Screen distortion for players standing inside psy fields. Each awake field reports how deep the local
-- player stands in it; the strongest one drives the effect.
local MAX_BLUR = 0.6
local MAX_TINT = 0.08

local psy = {}
local depths = setmetatable({}, {__mode = "k"})

function psy.SetDepth(field, depth)
	depths[field] = depth > 0 and depth or nil
end

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

-- These resource entities also run outside Helix, so use the engine hook dispatcher.
hook.Add("RenderScreenspaceEffects", "cotz/anomalies/psy-field", function()
	if next(depths) == nil then return end

	local depth = 0
	for field, value in pairs(depths) do
		if IsValid(field) then
			depth = math.max(depth, value)
		else
			depths[field] = nil
		end
	end
	if depth <= 0 then return end

	DrawMotionBlur(0.15, MAX_BLUR * depth, 0.01)
	colorModify["$pp_colour_addr"] = MAX_TINT * depth
	colorModify["$pp_colour_addb"] = MAX_TINT * 1.5 * depth
	colorModify["$pp_colour_colour"] = 1 - 0.5 * depth
	DrawColorModify(colorModify)
end)

return psy
