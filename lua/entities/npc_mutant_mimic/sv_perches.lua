-- Teleport destinations. Searches run only when an aerial attack is considered or performed.
local PERCH_ATTEMPTS = 16
local PERCH_RADIUS_MIN, PERCH_RADIUS_MAX = 240, 550
local PERCH_HEIGHT_MIN, PERCH_HEIGHT_MAX = 130, 260
-- The second half of the attempts flies lower, which still finds room under ceilings.
local PERCH_LOW_HEIGHT_MIN, PERCH_LOW_HEIGHT_MAX = 64, 130
local PERCH_SEPARATION_SQR = 220 ^ 2
local LAND_ATTEMPTS = 14
local LAND_RADIUS_MIN, LAND_RADIUS_MAX = 220, 450
local SIGHT_HEIGHT = Vector(0, 0, 40)
local SHOT_RADIUS = Vector(8, 8, 8)

local function clearShot(actor, enemy, position)
	local trace = util.TraceHull({
		start = position, endpos = enemy:WorldSpaceCenter(), mins = -SHOT_RADIUS, maxs = SHOT_RADIUS,
		mask = MASK_SHOT_HULL, filter = {actor, enemy},
	})

	return not trace.Hit and not trace.StartSolid
end

local function roomToHover(actor, position)
	local mins, maxs = actor:OBBMins(), actor:OBBMaxs()
	if not util.IsInWorld(position) or not util.IsInWorld(position + Vector(0, 0, maxs.z)) then return false end
	local trace = util.TraceHull({
		start = position, endpos = position, mins = mins, maxs = maxs, mask = MASK_NPCSOLID, filter = actor,
	})

	return not trace.Hit and not trace.StartSolid and not trace.AllSolid
end

local function ringPoint(center, minimum, maximum)
	local angle = math.Rand(0, math.pi * 2)
	local radius = math.Rand(minimum, maximum)

	return center + Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)
end

-- A point in the air with room for the mimic and a clear line for an orb to the enemy.
function ENT:MimicFindPerch(enemy, avoid)
	local center = enemy:GetPos()
	for attempt = 1, PERCH_ATTEMPTS do
		local low = attempt > PERCH_ATTEMPTS / 2
		local height = low and math.Rand(PERCH_LOW_HEIGHT_MIN, PERCH_LOW_HEIGHT_MAX)
			or math.Rand(PERCH_HEIGHT_MIN, PERCH_HEIGHT_MAX)
		local position = ringPoint(center, PERCH_RADIUS_MIN, PERCH_RADIUS_MAX) + Vector(0, 0, height)
		if (not avoid or position:DistToSqr(avoid) >= PERCH_SEPARATION_SQR) and roomToHover(self, position)
			and clearShot(self, enemy, position + self:OBBCenter()) then
			return position
		end
	end
end

-- Supported ground near the enemy with sight of it, so the mimic does not land in another room.
function ENT:MimicFindLanding(enemy)
	local center = enemy:GetPos()
	for _ = 1, LAND_ATTEMPTS do
		local ground = self:STALKERNPCNavigationGround(ringPoint(center, LAND_RADIUS_MIN, LAND_RADIUS_MAX))
		if ground and clearShot(self, enemy, ground + SIGHT_HEIGHT) then return ground end
	end
end
