local field = ix.jobs.field
local modelBounds = {}
local settings = field.runtimeSettings
local GROUND_OFFSETS = {Vector(0, 0, 0), Vector(settings.groundOffset, 0, 0),
	Vector(-settings.groundOffset, 0, 0), Vector(0, settings.groundOffset, 0),
	Vector(0, -settings.groundOffset, 0)}
local GROUND_UP = Vector(0, 0, settings.groundUp)
local GROUND_DOWN = Vector(0, 0, settings.groundDown)
local GROUND_CLEARANCE = Vector(0, 0, settings.groundClearance)

function field.GroundPoint(position, cargo, filter)
	local model = ix.item.list[cargo].model
	if not modelBounds[model] then
		local probe = ents.Create("prop_dynamic")
		if not IsValid(probe) then return end
		probe:SetModel(model)
		modelBounds[model] = {probe:GetModelBounds()}
		probe:Remove()
	end
	local bounds = modelBounds[model]
	for _, offset in ipairs(GROUND_OFFSETS) do
		local trace = util.TraceHull({start = position + offset + GROUND_UP,
			endpos = position + offset - GROUND_DOWN, mins = bounds[1], maxs = bounds[2],
			mask = MASK_SOLID, filter = filter})
		if trace.Hit and not trace.StartSolid and trace.HitNormal.z >= settings.minimumGroundNormal then
			local point = trace.HitPos + GROUND_CLEARANCE
			if util.IsInWorld(point) then return point end
		end
	end
end

