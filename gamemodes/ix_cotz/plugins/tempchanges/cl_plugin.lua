function ix.util.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness)
	local quadarc = {}

	startang = startang or 0
	endang = endang or 0

	local diff = math.abs(startang - endang)

	-- Nothing to draw for a (near) zero-length arc.
	if (diff < 0.5) then
		return quadarc
	end

	local smoothness = math.log(diff, 2) / 2
	local step = diff / (math.pow(2, smoothness))

	-- Guard against NaN / zero steps, which would make no points or loop forever.
	if (step ~= step or step < 0.5) then
		step = 0.5
	end

	if (startang > endang) then
		step = -step
	end

	local inner = {}
	local outer = {}
	local count = 0
	local r = radius - thickness

	for deg = startang, endang, step do
		local rad = math.rad(deg)
		local cosrad, sinrad = math.cos(rad), math.sin(rad)

		count = count + 1

		local ox, oy = cx + (cosrad * r), cy + (-sinrad * r)
		inner[count] = {x = ox, y = oy, u = (ox - cx) / radius + .5, v = (oy - cy) / radius + .5}

		local ox2, oy2 = cx + (cosrad * radius), cy + (-sinrad * radius)
		outer[count] = {x = ox2, y = oy2, u = (ox2 - cx) / radius + .5, v = (oy2 - cy) / radius + .5}
	end

	-- N points make N - 1 quads. The original looped one (or two) too many.
	for tri = 1, count - 1 do
		quadarc[#quadarc + 1] = {outer[tri], outer[tri + 1], inner[tri + 1], inner[tri]}
	end

	return quadarc
end

function ix.util.DrawPrecachedArc(arc)
	for _, v in ipairs(arc) do
		if (#v >= 3) then
			surface.DrawPoly(v)
		end
	end
end