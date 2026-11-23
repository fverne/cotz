-- Offline runner for the CW attachment placement tool: loads weapon files with stubs and samples
-- viewmodel animations through mdl_pose.py, so placements and aim fits run without the game.
-- Run from the repository root with luatex --luaonly; see docs/attachment-placement.md.
--
--   validate CLASS...                 Fit measured-lens scopes against their authored aims.
--   export OUT_DIR SPEC.lua           Write placement exports described by a spec file.
local POLICY = dofile("lua/cotz/attachment_policy.lua")
local MODEL_ROOTS = {"..", "../../.."}
local sourceMath = dofile("tests/helpers/source_math.lua")

local stub
stub = setmetatable({}, {__call = function() return stub end, __index = function() return stub end})

function isstring(value) return type(value) == "string" end
function IsValid(value) return value ~= nil and value ~= false end
RENDERGROUP_OTHER, RENDERGROUP_BOTH = 0, 1

table.HasValue = function(tbl, value)
	for _, item in pairs(tbl) do
		if item == value then return true end
	end

	return false
end

function SortedPairs(tbl)
	local keys = {}
	for key in pairs(tbl) do keys[#keys + 1] = key end
	table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
	local index = 0

	return function()
		index = index + 1
		return keys[index], tbl[keys[index]]
	end
end

function include(path)
	if path:find("^cotz/") then return dofile("lua/" .. path) end
end

concommand = {Add = function() end}

local attachments = {}
for path in io.popen("ls lua/cw/shared/attachments/md_*.lua"):lines() do
	local source = io.open(path):read("*a")
	local name = source:match('att%.name%s*=%s*"([^"]+)"')
	local first, second = source:match('att%.aimPos%s*=%s*{%s*"([^"]+)"%s*,%s*"([^"]+)"')
	if name then
		attachments[name] = {
			isSight = source:find("att%.isSight%s*=%s*true") ~= nil,
			withoutRail = source:find("att%.withoutRail%s*=%s*true") ~= nil,
			aimPos = first and {first, second} or nil,
		}
	end
end
CustomizableWeaponry = setmetatable({registeredAttachmentsSKey = attachments}, {__index = function() return stub end})

local paths = {}
local registry = {}

-- Rewrites GMod-only syntax (// and /* */ comments, !=, !, &&, ||) into standard Lua.
local function standardLua(source)
	local out, index, length = {}, 1, #source
	while index <= length do
		local char, pair = source:sub(index, index), source:sub(index, index + 1)
		if char == '"' or char == "'" then
			local close = index + 1
			while close <= length and source:sub(close, close) ~= char do
				close = close + (source:sub(close, close) == "\\" and 2 or 1)
			end
			out[#out + 1] = source:sub(index, close)
			index = close + 1
		elseif pair == "--" then
			local long = source:match("^%-%-%[(=*)%[", index)
			local close = long and select(2, source:find("]" .. long .. "]", index, true)) or source:find("\n", index) or length
			out[#out + 1] = source:sub(index, close)
			index = close + 1
		elseif pair == "//" then
			local close = source:find("\n", index) or length + 1
			out[#out + 1] = "--" .. source:sub(index + 2, close - 1)
			index = close
		elseif pair == "/*" then
			local close = select(2, source:find("*/", index, true)) or length
			out[#out + 1] = "--[==[" .. source:sub(index + 2, close - 2) .. "]==]"
			index = close + 1
		elseif pair == "!=" then
			out[#out + 1], index = "~=", index + 2
		elseif pair == "&&" then
			out[#out + 1], index = " and ", index + 2
		elseif pair == "||" then
			out[#out + 1], index = " or ", index + 2
		elseif char == "!" then
			out[#out + 1], index = " not ", index + 1
		elseif char == "[" and source:match("^%[=*%[", index) then
			local level = source:match("^%[(=*)%[", index)
			local close = select(2, source:find("]" .. level .. "]", index, true)) or length
			out[#out + 1] = source:sub(index, close)
			index = close + 1
		else
			out[#out + 1], index = char, index + 1
		end
	end

	return table.concat(out)
end

local function loadWeapon(path)
	-- Inherited fields read while loading resolve to stubs; the metatable is removed afterwards.
	local swep = setmetatable({Primary = {}, Secondary = {}}, {__index = function() return stub end})
	local env = setmetatable({
		SWEP = swep, CLIENT = true, SERVER = false, Vector = Vector, Angle = Angle,
		AddCSLuaFile = function() end, include = function() end,
	}, {__index = function(_, key)
		-- Optional addon flags stay unset so their branches do not run.
		if key:find("^CustomizableWeaponry_") then return nil end
		return rawget(_G, key) or stub
	end})
	local handle = assert(io.open(path))
	local source = handle:read("*a")
	handle:close()
	local chunk, err = load(standardLua(source), "@" .. path, "t", env)
	if not chunk then error("cannot load " .. path .. ": " .. err) end
	chunk()

	return setmetatable(swep, nil)
end

weapons = {Get = function(class)
	if registry[class] == nil then
		local path = paths[class] or ("lua/weapons/" .. class .. "/shared.lua")
		local handle = io.open(path)
		registry[class] = false
		if handle then
			handle:close()
			registry[class] = loadWeapon(path)
		end
	end

	return registry[class] or nil
end}

local function locateModel(model)
	for _, root in ipairs(MODEL_ROOTS) do
		local handle = io.popen("ls " .. root .. "/*/" .. model .. " 2>/dev/null")
		local found = handle:read("*l")
		handle:close()
		if found then return found end
	end

	-- Model paths are case-insensitive in the game but not on Linux.
	local handle = io.popen(string.format("find %s -maxdepth 1 -mindepth 1 -type d | while read d; do "
		.. "find \"$d/models\" -ipath %q 2>/dev/null; done | head -1", MODEL_ROOTS[1], "*/" .. model))
	local found = handle:read("*l")
	handle:close()

	return found
end

local modelPaths = {}
local function findModel(model)
	if modelPaths[model] == nil then
		modelPaths[model] = locateModel(model) or false
	end

	return modelPaths[model] or nil
end

local sampleCache = {}
local function modelSamples(model, sequence, bone)
	local key = model .. "|" .. sequence .. "|" .. bone
	if sampleCache[key] == nil then
		local path = findModel(model)
		local output
		if path then
			local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q %q %q --format lua 2>/dev/null",
				path, sequence, bone))
			output = handle:read("*a")
			handle:close()
		end
		sampleCache[key] = output and output ~= "" and load("return " .. output)() or false
	end

	return sampleCache[key] or nil
end

local function toMatrix(sample)
	local axes = {Vector(unpack(sample.forward)), Vector(unpack(sample.left)), Vector(unpack(sample.up))}
	local pos, angle = Vector(unpack(sample.pos)), sourceMath.toAngle(axes)

	return {GetTranslation = function() return pos end, GetAngles = function() return angle end}
end

unpack = unpack or table.unpack

function ClientsideModel(model)
	local probe = {}
	local sequence, cycle = nil, 0
	function probe.SetNoDraw() end
	function probe.SetPos() end
	function probe.SetAngles() end
	function probe.InvalidateBoneCache() end
	function probe.SetupBones() end
	function probe.Remove() end
	-- The tool treats sequence and bone IDs as numbers; map them back to names here.
	local names = {}
	local function id(name)
		names[#names + 1] = name
		return #names
	end
	function probe.LookupSequence(_, name) return id(name) end
	function probe.LookupBone(_, name) return id(name) end
	function probe.ResetSequence(_, number) sequence = names[number] end
	function probe.SetCycle(_, value) cycle = value end
	function probe.GetBoneMatrix(_, number)
		local samples = modelSamples(model, sequence, names[number])
		local sample = samples and samples[math.floor(cycle * #samples + 0.5) + 1]

		return sample and toMatrix(sample) or nil
	end

	return probe
end

local tool = dofile("lua/autorun/client/cotz_attachment_placement.lua")

local function encode(value)
	if type(value) == "table" then
		local parts = {}
		if #value > 0 or next(value) == nil then
			for _, item in ipairs(value) do parts[#parts + 1] = encode(item) end
			return "[" .. table.concat(parts, ", ") .. "]"
		end
		for key, item in SortedPairs(value) do parts[#parts + 1] = string.format("%q: %s", tostring(key), encode(item)) end
		return "{" .. table.concat(parts, ", ") .. "}"
	elseif type(value) == "string" then
		return string.format("%q", value)
	end

	return tostring(value)
end

local function validate(classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		for id, data in pairs(swep and swep.AttachmentModelsVM or {}) do
			local attachment = attachments[id]
			local keys = attachment and attachment.aimPos
			if keys and swep[keys[1]] and type(data) == "table" and data.pos then
				local samples = tool.sampleIdleBone(swep, data.bone)
				local placement = {id = id, model = data.model, angle = data.angle, size = data.size or Vector(1, 1, 1)}
				local fit = samples and tool.fitScopeAim(swep, placement, data.pos, samples)
				local authored = swep[keys[1]]
				print(string.format("%-16s %-20s authored (%.3f, %.3f, %.3f)  fitted %s", class, id, authored.x, authored.y,
					authored.z, fit and string.format("(%.3f, %.3f, %.3f)", fit.aimPos.x, fit.aimPos.y, fit.aimPos.z)
					or (samples and "-" or "no samples")))
			end
		end
	end
end

--[[
	Spec file: return {
		donors = {cw_ak74 = "path/to/old/shared.lua", ...}, -- optional path overrides, also for targets
		donorOrder = {"cw_ak74", ...},                      -- defaults to the policy donors
		targets = {
			{class = "cw_x", anchor = "md_kobra"},          -- existing anchor
			{class = "cw_y", seed = {id, model, bone, pos, angle, size, from}}, -- seed placement
		},
	}
]]
local function export(outDir, specPath)
	local spec = dofile(specPath)
	for class, path in pairs(spec.paths or {}) do
		paths[class] = path
	end
	local policy = include("cotz/attachment_policy.lua")
	local donors = spec.donorOrder or policy.donors

	for _, entry in ipairs(spec.targets) do
		local class = entry.class
		local target = weapons.Get(class)
		local anchorID, anchor, seedSource
		if entry.seed then
			anchorID = entry.seed.id
			anchor = entry.seed
			local donor = entry.seed.from and weapons.Get(entry.seed.from)
			seedSource = donor and {swep = donor, placement = donor.AttachmentModelsVM[anchorID]}
		else
			anchorID = entry.anchor
			anchor = target.AttachmentModelsVM[anchorID]
		end

		local allowed, family, mount = tool.allowedSights(class, target, entry.category or "primary")
		local setup = tool.buildSetup({
			class = class, target = target, anchorID = anchorID, anchor = anchor,
			authored = not entry.seed and anchor or nil, seedSource = seedSource, header = "Sight",
			donors = entry.donors or donors, allowed = allowed, mount = mount,
		})
		local positions = tool.computePositions(setup, anchor.pos)
		local samples = tool.sampleIdleBone(target, anchor.bone)
		local fits = {}
		if samples then
			for _, id in ipairs(setup.ids) do
				local data = setup.placements[id]
				fits[id] = tool.fitScopeAim(target, data, positions[id], samples)
			end
		end
		local result = tool.buildExport(class, target, setup, positions, fits)
		local out = io.open(outDir .. "/" .. class .. ".json", "w")
		out:write(encode(result))
		out:close()
		print(string.format("%s (%s): %d models, %d fields, skipped [%s]%s", class, family, #result.models,
			#result.fields, table.concat(result.skipped, ", "), samples and "" or " (no animation samples)"))
	end
end

-- Prints each weapon's line of sight for one sight in that sight's model space, from its authored aim.
local function axes(id, classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		local data = swep and swep.AttachmentModelsVM and swep.AttachmentModelsVM[id]
		local samples = data and data.pos and tool.sampleIdleBone(swep, data.bone)
		local axis = samples and tool.deriveSightAxis(swep, id, data, samples)
		if axis then
			print(string.format("%-18s lens (%.4f, %.4f, %.4f) forward (%.4f, %.4f, %.4f)", class, axis.lens.x, axis.lens.y,
				axis.lens.z, axis.forward.x, axis.forward.y, axis.forward.z))
		end
	end
end


-- Anomaly reskins: every Anomaly viewmodel shares the wpn_body bone orientation, so a placement on the
-- reference gun moves to another gun by a viewmodel-space translation, and the pack's own tuned sight lines
-- give that translation. See docs/anomaly-reskin.md.
local VM_FORWARD, VM_UP = Vector(1, 0, 0), Vector(0, 0, 1)

local function sp(vector) return Vector(vector.x, -vector.y, vector.z) end
local function cwAngle(angle) return Angle(-angle.p, angle.y, angle.r) end

local function toViewmodel(pos, sample)
	return (LocalToWorld(sp(pos), Angle(), sample:GetTranslation(), sample:GetAngles()))
end

local function toBone(point, sample)
	return sp((WorldToLocal(point, Angle(), sample:GetTranslation(), sample:GetAngles())))
end

local function cross(a, b)
	return Vector(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
end

local function normalized(vector)
	local copy = Vector(vector.x, vector.y, vector.z)
	copy:Normalize()

	return copy
end

-- CW angle on the bone that turns the model's line of sight to the view forward and its +Z to view up.
local function uprightAngle(forward, sample, upHint)
	local a1 = normalized(forward)
	local hint = upHint or Vector(0, 0, 1)
	local a3 = normalized(hint - a1 * a1:Dot(hint))
	local a2 = cross(a3, a1)
	local bone = sourceMath.toMatrix(sample:GetAngles())
	local columns = {}
	for index, axis in ipairs({Vector(1, 0, 0), Vector(0, 1, 0), Vector(0, 0, 1)}) do
		-- Model axis e_j maps to sum_k B_k * A_k[j] in the viewmodel, then into bone space.
		local component = function(vector) return index == 1 and vector.x or index == 2 and vector.y or vector.z end
		local vm = VM_FORWARD * component(a1) + Vector(0, 1, 0) * component(a2) + VM_UP * component(a3)
		columns[index] = Vector(bone[1]:Dot(vm), bone[2]:Dot(vm), bone[3]:Dot(vm))
	end

	return cwAngle(sourceMath.toAngle(columns))
end

-- Point on the eye line of an aim position, `distance` in front of the eye along the view.
local function eyeLinePoint(aimPos, aimAng, x)
	local origin = Vector(-aimPos.y, aimPos.x, -aimPos.z)
	local ray = tool.aimRay(aimAng)

	return origin + ray * ((x - origin.x) / ray.x)
end

local function boneSample(swep, bone)
	local samples = tool.sampleIdleBone(swep, bone)

	return samples and samples[1]
end

local function packAim(anomaly, sight)
	local source = anomaly.AnomalySource or {}

	return source["IronSightsPos_" .. sight], source["IronSightsAng_" .. sight] or source.IronSightsAng or Vector()
end

local boundsCache = {}
local function meshBounds(model)
	if boundsCache[model] == nil then
		local path = findModel(model)
		local output = ""
		if path then
			local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q x x --bounds --format lua 2>/dev/null",
				path))
			output = handle:read("*a")
			handle:close()
		end
		local bounds = output ~= "" and load("return " .. output)()
		boundsCache[model] = bounds and {min = Vector(unpack(bounds.min)), max = Vector(unpack(bounds.max))} or false
	end

	return boundsCache[model] or nil
end

local function component(vector, index)
	return index == 1 and vector.x or index == 2 and vector.y or vector.z
end

local function muzzleSample(swep)
	local path = isstring(swep.ViewModel) and findModel(swep.ViewModel)
	local idle = swep.Animations and swep.Animations.idle
	if not path or not isstring(idle) or swep.ViewModelFlip then return end

	local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q %q %q --attachment --samples 1 "
		.. "--format lua 2>/dev/null", path, idle, swep.MuzzleAttachmentName or "1"))
	local output = handle:read("*a")
	handle:close()
	local samples = output ~= "" and load("return " .. output)()

	return samples and toMatrix(samples[1])
end

local seatOnSurface

-- Seeds keyed by method; each returns the anchor placement and the swep/placement its aim derives from.
local seeds = {}

-- Moves the reference gun's hand-placed sight by the difference between the pack's sight lines.
function seeds.translate(entry, target, anomaly)
	local reference = weapons.Get(entry.reference)
	local referenceAnomaly = weapons.Get(entry.referenceAnomaly)
	local placement = reference.AttachmentModelsVM[entry.anchor]
	local referenceBody, targetBody = boneSample(reference, "wpn_body"), boneSample(target, "wpn_body")
	local fromAim, toAim = packAim(referenceAnomaly, entry.sight), packAim(anomaly, entry.sight)
	if not (referenceBody and targetBody and fromAim and toAim) then return end

	local referenceScope, targetScope = boneSample(reference, "wpn_scope"), boneSample(target, "wpn_scope")
	local forward = referenceScope and targetScope
		and targetScope:GetTranslation().x - referenceScope:GetTranslation().x or 0
	local shift = Vector(forward, toAim.x - fromAim.x, fromAim.z - toAim.z)
	local point = toViewmodel(placement.pos, referenceBody) + shift

	return {model = placement.model, bone = "wpn_body", pos = toBone(point, targetBody), angle = placement.angle,
		size = placement.size}, {swep = reference, placement = placement}
end

-- Distance from the eye to a placed sight's lens along the view, from its authored aim.
local function eyeDistance(swep, id)
	local placement = swep.AttachmentModelsVM[id]
	local source = {swep = swep, placement = placement}
	local geometry = tool.sightGeometry({id = id, model = placement.model, aimSource = source})
	local body = boneSample(swep, placement.bone)
	local lens = LocalToWorld(tool.modelPoint(geometry.lens, placement.size, placement.pos, placement.angle), Angle(),
		body:GetTranslation(), body:GetAngles())

	return lens.x + swep[attachments[id].aimPos[1]].y
end

-- Puts a sight's line of sight on the pack's tuned line for the matching pack sight.
function seeds.line(entry, target, anomaly)
	local body = boneSample(target, "wpn_body")
	local aimPos, aimAng = packAim(anomaly, entry.sight)
	local donor = weapons.Get(entry.geometryFrom)
	local donorPlacement = donor and donor.AttachmentModelsVM[entry.anchor]
	if not (body and aimPos and donorPlacement) then return end

	local source = {swep = donor, placement = donorPlacement}
	local geometry = tool.sightGeometry({id = entry.anchor, model = donorPlacement.model, aimSource = source})
	if not geometry then return end

	local size = Vector(entry.size, entry.size, entry.size)
	local angle = uprightAngle(geometry.forward, body)
	-- The pack pushes some optics far forward (an ACOG eye relief of 15), so keep the reference gun's relief
	-- relative to the ironsights and use only the height and side of the pack's line.
	local reference = weapons.Get(entry.eyeDistanceFrom)
	local keys = attachments[entry.anchor].aimPos
	local relief = target.IronsightPos.y + reference[keys[1]].y - reference.IronsightPos.y
	local distance = eyeDistance(reference, entry.eyeDistanceID)
	local lens = eyeLinePoint(aimPos, aimAng, distance - relief)
	local lensOffset = tool.modelPoint(geometry.lens, size, Vector(), angle)
	local pos = toBone(lens, body) - sp(lensOffset)

	return {model = donorPlacement.model, bone = "wpn_body", pos = pos, angle = angle, size = size}, source
end

-- Uses the old COTZ version of the same gun: its hand-tuned sight height and side offset from the
-- ironsights carry over to the new model's ironsights. Eye distances do not carry over between viewmodel
-- fields of view, so the sight's mesh center goes to a point on the gun instead: the reference gun's offset
-- from wpn_scope, or a fraction of the way from wpn_body to the muzzle.
function seeds.ironsights(entry, target)
	local body = boneSample(target, "wpn_body")
	local old = weapons.Get(entry.old)
	local placement = old and old.AttachmentModelsVM and old.AttachmentModelsVM[entry.anchor]
	local keys = attachments[entry.anchor].aimPos
	local oldAim = old and old[keys[1]]
	if not (body and oldAim and old.IronsightPos and target.IronsightPos) then return end

	-- Mirrored old viewmodels cannot be sampled, and some old guns only kept the aim; take the line of sight
	-- from another gun and keep only the old height offset.
	local offset = oldAim - old.IronsightPos
	local geometrySwep, geometryPlacement = old, placement
	if old.ViewModelFlip or not placement then
		geometrySwep = weapons.Get(entry.geometryFrom)
		geometryPlacement = geometrySwep and geometrySwep.AttachmentModelsVM[entry.anchor]
		offset = Vector(0, offset.y, offset.z)
		if not geometryPlacement then return end
	end

	local source = {swep = geometrySwep, placement = geometryPlacement}
	local geometry = tool.sightGeometry({id = entry.anchor, model = geometryPlacement.model, aimSource = source})
	local bounds = meshBounds(geometryPlacement.model)
	if not (geometry and bounds) then return end

	local targetX
	local scope = boneSample(target, "wpn_scope")
	local reference = entry.scopeFrom and weapons.Get(entry.scopeFrom)
	local referencePlacement = reference and reference.AttachmentModelsVM[entry.anchor]
	if scope and referencePlacement then
		local referenceBody, referenceScope = boneSample(reference, referencePlacement.bone), boneSample(reference, "wpn_scope")
		local referenceBounds = meshBounds(referencePlacement.model)
		local middle = (referenceBounds.min + referenceBounds.max) / 2
		local referenceCenter = LocalToWorld(tool.modelPoint(middle, referencePlacement.size, referencePlacement.pos,
			referencePlacement.angle), Angle(), referenceBody:GetTranslation(), referenceBody:GetAngles())
		targetX = scope:GetTranslation().x + referenceCenter.x - referenceScope:GetTranslation().x
	else
		local muzzle = muzzleSample(target)
		if not muzzle then return end
		targetX = body:GetTranslation().x + (entry.alongBore or 0.1) * (muzzle:GetTranslation().x - body:GetTranslation().x)
	end

	local aim = target.IronsightPos + Vector(offset.x, 0, offset.z)
	local angle = uprightAngle(geometry.forward, body)
	local size = (placement or geometryPlacement).size or Vector(1, 1, 1)
	local middle = (bounds.min + bounds.max) / 2
	local lensX = targetX
	local pos
	for _ = 1, 3 do
		local lens = eyeLinePoint(aim, target.IronsightAng or Vector(), lensX)
		pos = toBone(lens, body) - sp(tool.modelPoint(geometry.lens, size, Vector(), angle))
		local center = toViewmodel(pos, body) + LocalToWorld(tool.modelPoint(middle, size, Vector(), angle), Angle(),
			Vector(), body:GetAngles())
		lensX = lensX - (center.x - targetX)
	end

	return {model = geometryPlacement.model, bone = "wpn_body", pos = pos, angle = angle, size = size}, source
end

-- Seats the sight where the pack hand-placed its own model of the same sight: the mesh centers coincide,
-- the sight stands upright facing the view, and its size matches the pack model's mesh extents.
function seeds.element(entry, target, anomaly)
	local body = boneSample(target, "wpn_body")
	local element = anomaly.AnomalySource and anomaly.AnomalySource.VElements
		and anomaly.AnomalySource.VElements[entry.element]
	local donor = weapons.Get(entry.geometryFrom)
	local donorPlacement = donor and donor.AttachmentModelsVM[entry.anchor]
	if not (body and element and donorPlacement) or element.bonemerge then return end

	local sample = boneSample(target, element.bone)
	local packBounds, sightBounds = meshBounds(element.model), meshBounds(donorPlacement.model)
	local source = {swep = donor, placement = donorPlacement}
	local geometry = tool.sightGeometry({id = entry.anchor, model = donorPlacement.model, aimSource = source})
	if not (sample and packBounds and sightBounds and geometry) then return end

	-- The pack offsets elements along the bone's forward, right and up like COTZ placements. Its element angles
	-- do not reproduce its own sight lines under either CW or Source conventions, so the pack model is taken as
	-- mounted upright facing forward in its posed mesh frame (+X forward, +Y left, +Z up). This reproduces the
	-- pack's tuned EOTech aim positions.
	local origin = toViewmodel(element.pos, sample)
	local packSize = element.size or Vector(1, 1, 1)
	local packCenter = (packBounds.min + packBounds.max) / 2
	local center = origin + Vector(packCenter.x * packSize.x, packCenter.y * packSize.y, packCenter.z * packSize.z)
	local packExtents = {
		(packBounds.max.x - packBounds.min.x) * packSize.x,
		(packBounds.max.y - packBounds.min.y) * packSize.y,
		(packBounds.max.z - packBounds.min.z) * packSize.z,
	}

	local ratios = {}
	local sightForward = normalized(geometry.forward)
	local sightAxes = {sightForward, cross(Vector(0, 0, 1), sightForward), Vector(0, 0, 1)}
	local extent = Vector(sightBounds.max.x - sightBounds.min.x, sightBounds.max.y - sightBounds.min.y,
		sightBounds.max.z - sightBounds.min.z)
	for index, axis in ipairs(sightAxes) do
		local sightExtent = math.abs(axis.x) * extent.x + math.abs(axis.y) * extent.y + math.abs(axis.z) * extent.z
		ratios[#ratios + 1] = packExtents[index] / sightExtent
	end
	local scale = (ratios[1] + ratios[2] + ratios[3]) / 3
	local size = Vector(scale, scale, scale)
	local angle = uprightAngle(geometry.forward, body)
	local sightCenter = (sightBounds.min + sightBounds.max) / 2
	local pos = toBone(center, body) - sp(tool.modelPoint(sightCenter, size, Vector(), angle))

	return {model = donorPlacement.model, bone = "wpn_body", pos = pos, angle = angle, size = size}, source
end

-- Sight seating: each sight moves straight down (or up, if it cuts into the gun) until its underside first
-- touches the gun's mesh. Rays on a grid under the sight find its lowest surface and the gun's highest at
-- the same points, so a rail clamp's channel rests on the rail top while its jaws hang beside the rail.
-- Placed mounts (the AK rail adapter, the pack's claw mounts, pistol rails and spacers) count as part of the
-- gun's surface.
local SEAT_TOLERANCE = 0.02

local function placedMesh(item)
	local modelPath = findModel(item.model)
	if not modelPath then return end

	local size = item.size or Vector(1, 1, 1)
	local origin = toViewmodel(item.pos, item.sample)
	local axes = {}
	for index, axis in ipairs({Vector(1, 0, 0), Vector(0, 1, 0), Vector(0, 0, 1)}) do
		local direction = LocalToWorld(tool.modelPoint(axis, size, Vector(), item.angle), Angle(), Vector(),
			item.sample:GetAngles())
		axes[index] = string.format("[%f, %f, %f]", direction.x, direction.y, direction.z)
	end

	local floor = item.minModelZ and string.format(', "min_model_z": %f', item.minModelZ) or ""

	return string.format('{"model": %q, "origin": [%f, %f, %f], "axes": [%s]%s}', modelPath, origin.x, origin.y, origin.z,
		table.concat(axes, ", "), floor)
end

-- items: {id, model, size, pos, angle, sample}; extras: placed mounts that count as the gun's surface.
-- Returns the clearance per id (nil without overlap).
local function contactClearances(swep, items, extras)
	local path = isstring(swep.ViewModel) and findModel(swep.ViewModel)
	if not path or swep.ViewModelFlip then return {} end

	local entries, sights, surfaces = {}, {}, {}
	for _, item in ipairs(items) do
		local mesh = placedMesh(item)
		if mesh then
			entries[#entries + 1] = item.id
			sights[#sights + 1] = mesh
		end
	end
	for _, item in ipairs(extras or {}) do
		surfaces[#surfaces + 1] = placedMesh(item)
	end
	if #sights == 0 then return {} end

	local idle = swep.Animations and swep.Animations.idle
	local request = string.format('{"sights": [%s], "extras": [%s]}', table.concat(sights, ", "), table.concat(surfaces, ", "))
	local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q %q x --contact %q --format lua 2>/dev/null",
		path, isstring(idle) and idle or "", request))
	local output = handle:read("*a")
	handle:close()
	local clearances = output ~= "" and load("return " .. output)() or {}
	local result = {}
	for index, id in ipairs(entries) do
		result[id] = clearances[index] or nil
	end

	return result
end

local function railItem(target, setup, positions)
	local rail = setup.placements.md_rail
	local sample = rail and boneSample(target, rail.bone)

	return sample and {id = "md_rail", model = rail.model, size = rail.size, pos = positions.md_rail, angle = rail.angle,
		sample = sample, minModelZ = rail.minModelZ}
end

local function lower(positions, id, clearance, sample)
	positions[id] = toBone(toViewmodel(positions[id], sample) - Vector(0, 0, clearance), sample)
end

seatOnSurface = function(target, setup, positions, body, keep)
	-- A pistol rail is seated on the slide first; pack mounts already sit as the pack places them.
	local rail = railItem(target, setup, positions)
	if rail and setup.placements.md_rail.seat then
		local clearance = contactClearances(target, {rail}).md_rail
		if clearance then lower(positions, "md_rail", clearance, rail.sample) end
		rail = railItem(target, setup, positions)
	end

	local items = {}
	for _, id in ipairs(setup.ids) do
		local data = setup.placements[id]
		if attachments[id] and attachments[id].isSight and not (keep or {})[id] then
			items[#items + 1] = {id = id, model = data.model, size = data.size, pos = positions[id], angle = data.angle,
				sample = body}
		end
	end

	for id, clearance in pairs(contactClearances(target, items, {rail})) do
		if math.abs(clearance) > SEAT_TOLERANCE then
			lower(positions, id, clearance, body)
			setup.seated = (setup.seated or "") .. string.format(" %s %+.2f", id:sub(4), -clearance)
		end
	end
end

local function vectorList(vector)
	return {tonumber(string.format("%.6f", vector.x)), tonumber(string.format("%.6f", vector.y)),
		tonumber(string.format("%.6f", vector.z))}
end

-- Pistol sights ride on the slide: the vm-recoil variant's bolt bone moves the slide when firing, so the
-- sight models move from wpn_body to that bone, keeping their pose at rest.
local function moveToSlide(target, result, body)
	local hold = target.NormalHoldType or target.HoldType
	local slide = isstring(target.BoltBone) and boneSample(target, target.BoltBone)
	if not (body and slide and (hold == "pistol" or hold == "revolver")) then return end

	local slideAxes = sourceMath.toMatrix(slide:GetAngles())
	for _, model in ipairs(result.models) do
		if model.id == "md_rail" or attachments[model.id] and attachments[model.id].isSight then
			local pos, angle = Vector(unpack(model.pos)), Angle(unpack(model.angle))
			local origin = toViewmodel(pos, body)
			local columns = {}
			for index, axis in ipairs({Vector(1, 0, 0), Vector(0, 1, 0), Vector(0, 0, 1)}) do
				local direction = LocalToWorld(tool.modelPoint(axis, Vector(1, 1, 1), Vector(), angle), Angle(), Vector(),
					body:GetAngles())
				columns[index] = Vector(slideAxes[1]:Dot(direction), slideAxes[2]:Dot(direction), slideAxes[3]:Dot(direction))
			end
			local slideAngle = cwAngle(sourceMath.toAngle(columns))
			model.bone = target.BoltBone
			model.pos = vectorList(toBone(origin, slide))
			model.angle = vectorList(Vector(slideAngle.p, slideAngle.y, slideAngle.r))
		end
	end
end

-- Rail mounts under the sights: the pack's own claw mount or rail adapter where it has one, placed as the
-- pack bonemerges it (the mount's vertices follow one bone, so the inverse of that bone's pose in the mount
-- model places it), or a pistol rail centred under the anchor sight for slides without a rail.
local function skinBone(model)
	local path = findModel(model)
	if not path then return end

	local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q x x --skin-bone 2>/dev/null", path))
	local bone = handle:read("*l")
	handle:close()

	return bone ~= "" and bone or nil
end

local function addMount(entry, target, anomaly, setup, positions, body)
	local mount
	if entry.mountElement then
		local element = anomaly.AnomalySource.VElements[entry.mountElement]
		local bone = element and skinBone(element.model)
		local pose = bone and modelSamples(element.model, "idle", bone)
		if not (pose and boneSample(target, bone)) then return end

		local forward, left, up = pose[1].forward, pose[1].left, pose[1].up
		local columns = {Vector(forward[1], left[1], up[1]), Vector(forward[2], left[2], up[2]),
			Vector(forward[3], left[3], up[3])}
		local origin = pose[1].pos
		local inverse = -(columns[1] * origin[1] + columns[2] * origin[2] + columns[3] * origin[3])
		mount = {model = element.model, bone = bone, angle = cwAngle(sourceMath.toAngle(columns)), size = Vector(1, 1, 1)}
		positions.md_rail = sp(inverse)
	elseif entry.railModel then
		local anchor = setup.placements[entry.anchor]
		local anchorBounds, railBounds = meshBounds(anchor.model), meshBounds(entry.railModel)
		if not (anchorBounds and railBounds) then return end

		local size = Vector(entry.railSize, entry.railSize, entry.railSize)
		local angle = uprightAngle(Vector(1, 0, 0), body)
		local anchorMiddle = (anchorBounds.min + anchorBounds.max) / 2
		local center = LocalToWorld(tool.modelPoint(anchorMiddle, anchor.size, positions[entry.anchor], anchor.angle),
			Angle(), body:GetTranslation(), body:GetAngles())
		local railMiddle = (railBounds.min + railBounds.max) / 2
		mount = {model = entry.railModel, bone = "wpn_body", angle = angle, size = size, seat = true,
			minModelZ = entry.railTop}
		positions.md_rail = toBone(center, body) - sp(tool.modelPoint(railMiddle, size, Vector(), angle))
	end
	if not mount then return end

	mount.id, mount.isNew, mount.isRail = "md_rail", true, true
	setup.placements.md_rail = mount
	setup.ids[#setup.ids + 1] = "md_rail"
	setup.flags.SightWithRail = true
end

-- Smallest height of a line of sight above the gun between the sight and the muzzle (front posts, beads).
local function postMargin(target, sightX, aimPos, aimAng)
	local path = isstring(target.ViewModel) and findModel(target.ViewModel)
	local muzzle = path and muzzleSample(target)
	if not muzzle then return end

	local windows, points = {}, {}
	for x = sightX, muzzle:GetTranslation().x, 0.3 do
		local point = eyeLinePoint(aimPos, aimAng, x)
		points[#points + 1] = point
		windows[#windows + 1] = string.format("[%f, %f, %f, 0.08]", x, x + 0.3, point.y)
	end
	if #windows == 0 then return end

	local idle = target.Animations and target.Animations.idle
	local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q %q x --surface %q --format lua 2>/dev/null",
		path, isstring(idle) and idle or "", "[" .. table.concat(windows, ", ") .. "]"))
	local output = handle:read("*a")
	handle:close()
	local heights = output ~= "" and load("return " .. output)() or {}
	local margin
	for index, point in ipairs(points) do
		if heights[index] then
			margin = math.min(margin or math.huge, point.z - heights[index])
		end
	end

	return margin
end

-- Lifts every sight on a gun whose sight lines pass too close over its front post: a spacer (a rail segment
-- stretched to the needed height) is seated on the gun under the anchor sight and the sights seat on it.
local SPACER_MODEL = "models/wystan/attachments/rail.mdl"
local SPACER_WIDTH = 1.0
local MAX_SPACER_LENGTH = 6
local POST_CLEARANCE = 0.4
local SPACER_MINIMUM = 0.05

local function addSpacer(entry, target, setup, positions, fits, body)
	if setup.placements.md_rail then return end

	local deficit = 0
	for _, id in ipairs(setup.ids) do
		local fit = fits[id]
		if fit then
			local margin = postMargin(target, toViewmodel(positions[id], body).x, fit.aimPos, fit.aimAng)
			if margin then deficit = math.max(deficit, POST_CLEARANCE - margin) end
		end
	end
	if deficit <= SPACER_MINIMUM then return end

	local anchor = setup.placements[entry.anchor]
	local anchorBounds, spacerBounds = meshBounds(anchor.model), meshBounds(SPACER_MODEL)
	if not (anchorBounds and spacerBounds) then return end

	-- The sights' combined footprint (along the bore) sets the spacer's length; the deficit sets its height.
	local low, high = math.huge, -math.huge
	for _, id in ipairs(setup.ids) do
		local data = setup.placements[id]
		local bounds = fits[id] and meshBounds(data.model)
		if bounds then
			local middle = (bounds.min + bounds.max) / 2
			for _, x in ipairs({bounds.min.x, bounds.max.x}) do
				local vm = LocalToWorld(tool.modelPoint(Vector(x, middle.y, middle.z), data.size, positions[id], data.angle),
					Angle(), body:GetTranslation(), body:GetAngles())
				low, high = math.min(low, vm.x), math.max(high, vm.x)
			end
		end
	end
	if low > high then return end
	local extent = spacerBounds.max - spacerBounds.min
	local length = math.min(MAX_SPACER_LENGTH, math.max(high - low, 1))
	local size = Vector(length / extent.x, SPACER_WIDTH / extent.y, deficit / extent.z)
	local angle = uprightAngle(Vector(1, 0, 0), body)
	local anchorMiddle = (anchorBounds.min + anchorBounds.max) / 2
	local center = LocalToWorld(tool.modelPoint(anchorMiddle, anchor.size, positions[entry.anchor], anchor.angle), Angle(),
		body:GetTranslation(), body:GetAngles())
	center.x = (low + high) / 2
	local spacerMiddle = (spacerBounds.min + spacerBounds.max) / 2
	setup.placements.md_rail = {id = "md_rail", model = SPACER_MODEL, bone = "wpn_body", angle = angle, size = size,
		seat = true, isNew = true, isRail = true}
	setup.ids[#setup.ids + 1] = "md_rail"
	setup.flags.SightWithRail = true
	positions.md_rail = toBone(center, body) - sp(tool.modelPoint(spacerMiddle, size, Vector(), angle))
	setup.spacer = deficit

	return true
end

local function sightUniverse()
	local ids = {}
	for id, attachment in SortedPairs(attachments) do
		if attachment.isSight then ids[#ids + 1] = id end
	end

	return ids
end

--[[
	Spec file: return {
		paths = {class = "path/to/shared.lua", ...},
		targets = {
			{class, category, mount, anomaly = "cw_anomaly_x", method = "translate"|"line"|"ironsights"|"none",
				anchor, sight, reference, referenceAnomaly, geometryFrom, size, eyeDistance, old, donors},
		},
	}
]]
local function anomalyExport(outDir, specPath)
	local spec = dofile(specPath)
	for class, path in pairs(spec.paths or {}) do
		paths[class] = path
	end

	for _, entry in ipairs(spec.targets) do
		local class = entry.class
		local target = weapons.Get(class)
		local anomaly = entry.anomaly and weapons.Get(entry.anomaly)
		-- The full sight set is regenerated, so earlier exports already applied to the file must not count
		-- as hand placements or tuned aims.
		local barrel = {}
		for id, data in pairs(target.AttachmentModelsVM or {}) do
			if not (attachments[id] and attachments[id].isSight) and id ~= "md_rail" then barrel[id] = data end
		end
		target.AttachmentModelsVM = barrel
		for _, attachment in pairs(attachments) do
			for _, key in ipairs(attachment.aimPos or {}) do target[key] = nil end
		end
		local seed, source
		if entry.method ~= "none" then
			seed, source = seeds[entry.method](entry, target, anomaly)
		end

		local result, seatedLog, spacerLog
		if seed then
			local allowed = tool.allowedSights(class, target, entry.category)
			if entry.mount == "dovetail" then
				allowed = tool.allowedSights(class, {HasDovetailMount = true}, entry.category)
			else
				-- The Kobra clamps to an AK side dovetail; without one it would float beside the gun.
				allowed.md_kobra = nil
			end
			seed.id = entry.anchor
			local setup = tool.buildSetup({
				class = class, target = target, anchorID = entry.anchor, anchor = seed, seedSource = source,
				header = "Sight", donors = entry.donors, allowed = allowed, mount = entry.mount,
			})
			local positions = tool.computePositions(setup, seed.pos)
			local samples = tool.sampleIdleBone(target, "wpn_body")
			-- Donor hand placements carry small tilts; every Anomaly bone frame is the same, so stand each
			-- new sight upright facing the view instead.
			for _, id in ipairs(setup.ids) do
				local data = setup.placements[id]
				local geometry = samples and attachments[id] and attachments[id].isSight and tool.sightGeometry(data)
				if geometry then data.angle = uprightAngle(geometry.forward, samples[1]) end
			end
			if samples then
				if not setup.placements.md_rail then
					addMount(entry, target, anomaly, setup, positions, samples[1])
				end
				-- The 9A-91's hand-placed side-mount Kobra and PSO-1 keep their place on dovetail guns.
				local keep = entry.method == "translate" and {md_kobra = true, md_pso1 = true} or {}
				seatOnSurface(target, setup, positions, samples[1], keep)
			end
			local fits = {}
			for _, id in ipairs(setup.ids) do
				fits[id] = samples and tool.fitScopeAim(target, setup.placements[id], positions[id], samples)
			end
			if samples and addSpacer(entry, target, setup, positions, fits, samples[1]) then
				seatOnSurface(target, setup, positions, samples[1])
				for _, id in ipairs(setup.ids) do
					fits[id] = tool.fitScopeAim(target, setup.placements[id], positions[id], samples)
				end
			end
			result = tool.buildExport(class, target, setup, positions, fits)
			seatedLog, spacerLog = setup.seated, setup.spacer
			moveToSlide(target, result, samples and samples[1])
			if entry.mount == "dovetail" then
				result.fields[#result.fields + 1] = {name = "HasDovetailMount", kind = "bool", value = true}
			end
		else
			result = {version = 1, class = class, models = {}, fields = {}, attachments = {}, skipped = {},
				slot = {key = 1, header = "Sight", create = false, offset = {800, -300}}}
		end

		-- The sight list is rebuilt from what was placed; other known sights leave the slot and items.
		local placed = {}
		for _, id in ipairs(result.attachments) do placed[id] = true end
		result.slot.replace = true
		result.removeAttachments = {}
		for _, id in ipairs(sightUniverse()) do
			if not placed[id] then result.removeAttachments[#result.removeAttachments + 1] = id end
		end

		local out = io.open(outDir .. "/" .. class .. ".json", "w")
		out:write(encode(result))
		out:close()
		if seatedLog then print(string.format("%-18s seated:%s", class, seatedLog)) end
		if spacerLog then print(string.format("%-18s spacer %.2f high", class, spacerLog)) end
		print(string.format("%-18s %-10s %d sights [%s] skipped [%s]%s", class, entry.method, #result.attachments,
			table.concat(result.attachments, ", "), table.concat(result.skipped, ", "),
			entry.method ~= "none" and not seed and " (no seed)" or ""))
	end
end

-- Suppressors: the old hand placements fix where each suppressor model meets the old muzzle attachment;
-- the median of that mount point moves onto the Anomaly muzzle attachment.
local SUPPRESSORS = {"md_pbs1", "md_tundra9mm", "md_saker", "md_cobram2"}



local function median(values)
	table.sort(values)

	return values[math.ceil(#values / 2)]
end

local function suppressorMounts(classes)
	local mounts = {}
	for _, id in ipairs(SUPPRESSORS) do
		local points, axes, sizes, models = {x = {}, y = {}, z = {}}, {x = {}, y = {}, z = {}}, {}, {}
		for _, class in ipairs(classes) do
			local swep = weapons.Get(class)
			local data = swep and swep.AttachmentModelsVM and swep.AttachmentModelsVM[id]
			local muzzle = data and data.pos and muzzleSample(swep)
			local body = muzzle and boneSample(swep, data.bone)
			if body then
				local size = data.size or Vector(1, 1, 1)
				local modelAngle = Angle(-data.angle.p, data.angle.y, data.angle.r)
				local onBone = WorldToLocal(muzzle:GetTranslation(), Angle(), body:GetTranslation(), body:GetAngles())
				local point = WorldToLocal(onBone, Angle(), sp(data.pos), modelAngle)
				local axis = WorldToLocal(WorldToLocal(VM_FORWARD, Angle(), Vector(), body:GetAngles()), Angle(), Vector(),
					modelAngle)
				for _, key in ipairs({"x", "y", "z"}) do
					points[key][#points[key] + 1] = point[key] / (key == "x" and size.x or key == "y" and size.y or size.z)
					axes[key][#axes[key] + 1] = axis[key]
				end
				sizes[class] = size
				models[data.model] = (models[data.model] or 0) + 1
			end
		end
		if #points.x > 0 then
			local model, best = nil, 0
			for name, count in pairs(models) do
				if count > best then model, best = name, count end
			end
			mounts[id] = {
				point = Vector(median(points.x), median(points.y), median(points.z)),
				axis = normalized(Vector(median(axes.x), median(axes.y), median(axes.z))),
				sizes = sizes, model = model, count = #points.x,
			}
		end
	end

	return mounts
end

local function suppressorExport(outDir, specPath)
	local spec = dofile(specPath)
	for class, path in pairs(spec.paths or {}) do
		paths[class] = path
	end

	local oldClasses = {}
	for class in pairs(spec.paths) do
		if class:find("^old_") then oldClasses[#oldClasses + 1] = class end
	end
	table.sort(oldClasses)
	local mounts = suppressorMounts(oldClasses)
	for _, id in ipairs(SUPPRESSORS) do
		local mount = mounts[id]
		if mount then
			print(string.format("%s: %d guns, mount (%.2f, %.2f, %.2f) axis (%.2f, %.2f, %.2f)", id, mount.count, mount.point.x,
				mount.point.y, mount.point.z, mount.axis.x, mount.axis.y, mount.axis.z))
		end
	end

	for _, entry in ipairs(spec.targets) do
		local class = entry.class
		local target = weapons.Get(class)
		local body, muzzle = boneSample(target, "wpn_body"), muzzleSample(target)
		local listed = {}
		for _, category in pairs(target.Attachments or {}) do
			for _, id in ipairs(category.atts or {}) do listed[id] = category end
		end

		local result = {version = 1, class = class, models = {}, fields = {}, attachments = {}, skipped = {},
			slot = {key = 1, header = "Barrel", create = false, offset = {0, 0}}, removeAttachments = {}}
		for _, id in ipairs(SUPPRESSORS) do
			local mount = mounts[id]
			if listed[id] and mount and body and muzzle then
				local size = mount.sizes["old_" .. class] or Vector(1, 1, 1)
				local up = math.abs(mount.axis.z) > 0.9 and Vector(1, 0, 0) or Vector(0, 0, 1)
				local angle = uprightAngle(mount.axis, body, up)
				local offset = tool.modelPoint(mount.point, size, Vector(), angle)
				result.models[#result.models + 1] = {
					id = id, model = mount.model, bone = "wpn_body", new = true,
					pos = vectorList(toBone(muzzle:GetTranslation(), body) - sp(offset)),
					angle = vectorList(Vector(angle.p, angle.y, angle.r)), size = vectorList(size),
				}
			elseif listed[id] then
				result.skipped[#result.skipped + 1] = id
			end
		end
		-- Foregrip placements have no reference on the new models.
		for _, id in ipairs({"md_foregrip"}) do
			if listed[id] then result.removeAttachments[#result.removeAttachments + 1] = id end
		end
		for _, id in ipairs(result.skipped) do
			result.removeAttachments[#result.removeAttachments + 1] = id
		end

		local out = io.open(outDir .. "/" .. class .. ".json", "w")
		out:write(encode(result))
		out:close()
		print(string.format("%-18s placed %d, removed [%s]", class, #result.models, table.concat(result.removeAttachments, ", ")))
	end
end

-- Prints where a sight model's axes point in the viewmodel on hand-placed guns.
local function modelAxes(id, classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		local data = swep and swep.AttachmentModelsVM and swep.AttachmentModelsVM[id]
		local samples = data and data.pos and not swep.ViewModelFlip and tool.sampleIdleBone(swep, data.bone)
		if samples then
			local out = {}
			for _, axis in ipairs({Vector(1, 0, 0), Vector(0, 1, 0), Vector(0, 0, 1)}) do
				local local_ = tool.modelPoint(axis, Vector(1, 1, 1), Vector(), data.angle)
				local vm = LocalToWorld(local_, Angle(), Vector(), samples[1]:GetAngles())
				out[#out + 1] = string.format("(%.2f, %.2f, %.2f)", vm.x, vm.y, vm.z)
			end
			print(string.format("%-18s x->%s y->%s z->%s", class, out[1], out[2], out[3]))
		end
	end
end

-- Prints viewmodel-space positions of a weapon's mount bones, muzzle and attachment model origins.
local function inspect(classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		local body = boneSample(swep, "wpn_body")
		local function show(label, point)
			print(string.format("  %-22s (%.2f, %.2f, %.2f)", label, point.x, point.y, point.z))
		end
		print(class, swep.ViewModel)
		if body then show("wpn_body", body:GetTranslation()) end
		local scope = boneSample(swep, "wpn_scope")
		if scope then show("wpn_scope", scope:GetTranslation()) end
		local muzzle = muzzleSample(swep)
		if muzzle then show("muzzle", muzzle:GetTranslation()) end
		-- Mesh centers show where each model actually sits, unlike model origins.
		for id, data in SortedPairs(swep.AttachmentModelsVM or {}) do
			local sample = boneSample(swep, data.bone)
			local bounds = data.pos and meshBounds(data.model)
			if sample and bounds then
				local middle = (bounds.min + bounds.max) / 2
				show(id, LocalToWorld(tool.modelPoint(middle, data.size or Vector(1, 1, 1), data.pos, data.angle), Angle(),
					sample:GetTranslation(), sample:GetAngles()))
			end
		end
	end
end

-- Prints each sight's clearance above the gun mesh for the weapon file as it stands (0 means touching).
local function seats(classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		local items = {}
		for id, data in SortedPairs(swep and swep.AttachmentModelsVM or {}) do
			local sample = attachments[id] and attachments[id].isSight and data.pos and boneSample(swep, data.bone)
			if sample then
				items[#items + 1] = {id = id, model = data.model, size = data.size, pos = data.pos, angle = data.angle,
					sample = sample}
			end
		end
		local rail = swep and swep.AttachmentModelsVM and swep.AttachmentModelsVM.md_rail
		local railSample = rail and rail.pos and boneSample(swep, rail.bone)
		local extras = railSample and {{id = "md_rail", model = rail.model, size = rail.size, pos = rail.pos,
			angle = rail.angle, sample = railSample}} or {}
		for id, clearance in SortedPairs(contactClearances(swep, items, extras)) do
			print(string.format("%-18s %-20s clearance %+.2f", class, id, clearance))
		end
	end
end

-- Prints how far each sight's line of sight passes above the gun between the sight and the muzzle; a small
-- or negative margin means the front post shows in (or blocks) the sight.
local function posts(classes)
	for _, class in ipairs(classes) do
		local swep = weapons.Get(class)
		for id, data in SortedPairs(swep and swep.AttachmentModelsVM or {}) do
			local keys = attachments[id] and attachments[id].aimPos
			local aimPos = keys and swep[keys[1]]
			local sample = aimPos and data.pos and boneSample(swep, data.bone)
			local margin = sample and postMargin(swep, toViewmodel(data.pos, sample).x, aimPos,
				swep[keys[2]] or swep.IronsightAng or Vector())
			if margin then print(string.format("%-18s %-20s clears the gun by %+.2f", class, id, margin)) end
		end
	end
end

-- One visual scale per asset family, calibrated in model units from the rail, optic, and muzzle meshes.
-- Slide-mounted optics use a compact envelope. Side-mount and pack-specific models retain their fit.
local STANDARD_SIZES = {
	md_microt1 = 0.40,
	md_eotech = 0.95,
	md_aimpoint = 0.83,
	md_cmore = 0.90,
	md_reflex = 0.84,
	md_rmr = 0.85,
	md_schmidt_shortdot = 0.82,
	md_acog = 0.92,
	md_nightforce_nxs = 1.00,
	md_pbs1 = 0.80,
	md_cobram2 = 0.95,
	md_saker = 0.72,
	md_tundra9mm = 0.70,
}
local SIDE_MOUNTS = {md_kobra = true, md_pso1 = true, cw_anomaly_1p29 = true, cw_anomaly_mosin = true}
local TRANSFERRED_9A91 = {md_rail = true, md_schmidt_shortdot = true, md_acog = true, md_nightforce_nxs = true}
local PISTOL_RAIL = "models/cw2/attachments/pistolrail.mdl"
local COMPACT_SCALE = 0.75
local MIN_EYE_RELIEF = 1.5
local STOCK_PISTOL_RAIL_SCALE = 0.145
local MAX_RESEAT_DISTANCE = 0.4

local function refitScale(id, data, bounds, compact, receiverWidth)
	local scale = STANDARD_SIZES[id]
	if id == "md_rail" and data.model == SPACER_MODEL then
		local extent = bounds.max - bounds.min
		-- The scope housing can overhang its mount. The spacer only needs to span the clamp.
		return Vector(math.min(data.size.x, MAX_SPACER_LENGTH / extent.x), SPACER_WIDTH / extent.y, data.size.z)
	elseif id == "md_rail" and data.model == PISTOL_RAIL then
		local extent = bounds.max - bounds.min
		local widthScale = receiverWidth and math.min(0.185, math.max(0.105, receiverWidth * 1.2 / extent.y))
			or STOCK_PISTOL_RAIL_SCALE

		local lengthFactor = math.min(1.08, math.max(0.9, widthScale / 0.12))
		return Vector(STOCK_PISTOL_RAIL_SCALE * lengthFactor, widthScale, STOCK_PISTOL_RAIL_SCALE)
	elseif scale and compact and not data.isMuzzle then
		scale = scale * COMPACT_SCALE
	end

	return scale and Vector(scale, scale, scale) or data.size
end

local function pointInViewmodel(point, data, sample)
	return (LocalToWorld(tool.modelPoint(point, data.size, data.pos, data.angle), Angle(),
		sample:GetTranslation(), sample:GetAngles()))
end

local function modelExtents(data, bounds, sample)
	local min, max = bounds.min, bounds.max
	local low = Vector(math.huge, math.huge, math.huge)
	local high = -low
	for _, x in ipairs({min.x, max.x}) do
		for _, y in ipairs({min.y, max.y}) do
			for _, z in ipairs({min.z, max.z}) do
				local point = pointInViewmodel(Vector(x, y, z), data, sample)
				low = Vector(math.min(low.x, point.x), math.min(low.y, point.y), math.min(low.z, point.z))
				high = Vector(math.max(high.x, point.x), math.max(high.y, point.y), math.max(high.z, point.z))
			end
		end
	end

	return low, high
end

local function refitModel(swep, id, data, compact, receiverWidth, clearance)
	local attachment = attachments[id]
	local keys = attachment and attachment.aimPos
	local aimPos = keys and swep[keys[1]]
	local aimAng = keys and swep[keys[2]] or swep.IronsightAng or Vector()
	local bounds = meshBounds(data.model)
	if not bounds then return nil, "missing attachment mesh" end

	local samples = tool.sampleIdleBone(swep, data.bone)
	if not samples then return nil, "missing idle bone" end

	local sample = samples[1]
	local low, high = modelExtents(data, bounds, sample)
	local pos = (low + high) / 2
	local aimSource = aimPos and {swep = swep, placement = data}
	local geometry = aimSource and tool.sightGeometry({id = id, model = data.model, aimSource = aimSource})
	if geometry then
		pos.y = pointInViewmodel(geometry.lens, data, sample).y
	end
	if data.isMuzzle then
		local muzzle = muzzleSample(swep)
		if muzzle then pos = muzzle:GetTranslation() end
	end
	local bonePoint = WorldToLocal(pos, Angle(), sample:GetTranslation(), sample:GetAngles())
	local scaledPoint = WorldToLocal(bonePoint, Angle(), sp(data.pos), cwAngle(data.angle))
	local pivot = Vector(scaledPoint.x / data.size.x, scaledPoint.y / data.size.y, scaledPoint.z / data.size.z)
	local size = refitScale(id, data, bounds, compact, receiverWidth)
	local changed = (size - data.size):Length() > 0.001
	local result = {model = data.model, bone = data.bone, angle = data.angle, size = size, pos = data.pos}

	if changed then
		result.pos = toBone(pos, sample) - sp(tool.modelPoint(pivot, size, Vector(), data.angle))
		if not data.isMuzzle then
			local newLow, newHigh = modelExtents(result, bounds, sample)
			-- Keep rails' seating surface and sights' clamp bottoms at their previous height.
			local height = id == "md_rail" and data.model == PISTOL_RAIL and high.z - newHigh.z or low.z - newLow.z
			result.pos = toBone(toViewmodel(result.pos, sample) + Vector(0, 0, height), sample)
		end
	end

	if clearance then
		result.pos = toBone(toViewmodel(result.pos, sample) - Vector(0, 0, clearance), sample)
		changed = true
	end

	local fitted
	if geometry then
		result.id, result.aimSource = id, aimSource
		local relief = aimPos.y
		if not geometry.derived then
			for _, idle in ipairs(samples) do
				local center = pointInViewmodel(geometry.lens, result, idle)
				relief = math.max(relief, MIN_EYE_RELIEF - center.x)
			end
		end

		-- fitScopeAim takes the eye relief from the current SWEP aim.
		swep[keys[1]] = Vector(aimPos.x, relief, aimPos.z)
		fitted = tool.fitScopeAim(swep, result, result.pos, samples)
		swep[keys[1]] = aimPos

		if not fitted then return nil, "could not fit optical axis" end
		-- A derived axis comes from the stored aim and is only needed when the geometry moves.
		changed = changed or not geometry.derived and (aimPos - fitted.aimPos):Length() > 0.002
	end

	local newLow, newHigh = modelExtents(result, bounds, sample)
	local apertureError
	if fitted then
		apertureError = 0
		for _, idle in ipairs(samples) do
			local center = pointInViewmodel(geometry.lens, result, idle)
			local error = (center - eyeLinePoint(fitted.aimPos, aimAng, center.x)):Length()
			apertureError = math.max(apertureError, error)
		end
	end

	return {
		pose = result, aim = fitted, changed = changed, extent = newHigh - newLow, before = high - low,
		low = newLow, high = newHigh, apertureError = apertureError, sample = sample,
	}
end

local function readProfileWeapon(class)
	local swep = weapons.Get(class)
	if swep then return swep end

	local base = class:match("^(cw_anomaly_.*)_vmrecoil$")
	local dir = "lua/weapons/"
	local source = base and io.open(dir .. base .. ".lua")
	if not source then return end

	source:close()
	return loadWeapon(dir .. base .. ".lua")
end

local function addFallbackModels(swep, layout, models)
	for id, values in pairs(layout) do
		if id ~= "bone" then
			local data = {
				model = models[id], bone = layout.bone,
				pos = Vector(unpack(values, 1, 3)), angle = Angle(unpack(values, 4, 6)),
				size = Vector(unpack(values, 7, 9)), fallback = true,
			}
			swep.AttachmentModelsVM[id] = data
			local keys = attachments[id] and attachments[id].aimPos
			if keys then
				swep[keys[1]] = Vector(unpack(values, 10, 12))
				swep[keys[2]] = Vector()
			end
		end
	end
end

local function receiverWidths(swep, sites)
	local idle = swep.Animations and swep.Animations.idle
	local path = isstring(swep.ViewModel) and findModel(swep.ViewModel)
	if not (path and isstring(idle)) or #sites == 0 then return {} end

	local handle = io.popen(string.format("python3 docs/attachments/mdl_pose.py %q %q x --mount-widths %q --format lua",
		path, idle, encode(sites)))
	local output = handle:read("*a")
	handle:close()

	return output ~= "" and load("return " .. output)() or {}
end

local function contactItem(id, pose, sample)
	return {
		id = id, model = pose.model, pos = pose.pos, angle = pose.angle, size = pose.size, sample = sample,
	}
end

local function auditClearances(swep, fits, rail)
	local items = {}
	for id, fit in SortedPairs(fits) do
		local optic = attachments[id]
		if fit.result and optic and optic.isSight and not SIDE_MOUNTS[id] then
			items[#items + 1] = contactItem(id, fit.result.pose, fit.result.sample)
		end
	end

	local mountFit = fits.md_rail and fits.md_rail.result
	local mount = mountFit and mountFit.pose or rail
	local mountSample = mountFit and mountFit.sample or mount and mount.pos and mount.bone and boneSample(swep, mount.bone)
	local extras = swep.SightWithRail and mountSample and {contactItem("md_rail", mount, mountSample)} or {}

	return contactClearances(swep, items, extras)
end

local function writeWeaponSizeAudit(out, class, profile, poses)
	local swep = readProfileWeapon(class)
	if not swep then
		out:write(encode({class = class, reason = "missing SWEP definition"}), "\n")
		return
	end

	swep.AttachmentModelsVM = swep.AttachmentModelsVM or {}
	addFallbackModels(swep, poses.weapons[class], poses.models)
	-- CW's stored aim and model offsets use the unreflected viewmodel frame.
	local flipped = swep.ViewModelFlip
	swep.ViewModelFlip = false
	local rail = swep.AttachmentModelsVM.md_rail
	local family = POLICY.weapons[class] or profile.family
	local compact = family == "pistol" or family == "revolver" or rail and rail.model == PISTOL_RAIL
	local reskin = isstring(swep.ViewModel) and swep.ViewModel:find("^models/flaymi/anomaly/")
		and class ~= "cw_9a91" and not class:find("^cw_anomaly_")
	local fits, sites, siteIds = {}, {}, {}
	for id, data in SortedPairs(swep.AttachmentModelsVM) do
		local att = attachments[id]
		data.isMuzzle = id == profile.suppressor or table.HasValue(SUPPRESSORS, id)
		local generated = data.fallback or class == "cw_9a91" and TRANSFERRED_9A91[id]
			or reskin and (id == "md_rail" or data.isMuzzle or att and att.isSight)
		if generated and data.pos and data.angle then
			data.size = data.size or Vector(1, 1, 1)
			local result, reason = refitModel(swep, id, data, compact)
			fits[id] = {result = result, data = data, reason = reason}
			if result and not data.isMuzzle and not SIDE_MOUNTS[id] then
				local site = (result.low + result.high) / 2
				site.z = id == "md_rail" and data.model == PISTOL_RAIL and result.high.z or result.low.z
				sites[#sites + 1], siteIds[id] = vectorList(site), #sites + 1
			end
		end
	end

	local widths = receiverWidths(swep, sites)
	local mount = fits.md_rail
	local railWidth = widths[siteIds.md_rail]
	if mount and mount.result and mount.data.model == PISTOL_RAIL and railWidth then
		mount.result = refitModel(swep, "md_rail", mount.data, compact, railWidth)
	end

	local clearances = auditClearances(swep, fits, rail)
	for id, fit in SortedPairs(fits) do
		local result, data = fit.result, fit.data
		if result then
			local clearance = clearances[id]
			-- Large gaps can come from a ray hitting a stock or hand below the mount.
			if clearance and math.abs(clearance) > SEAT_TOLERANCE and math.abs(clearance) <= MAX_RESEAT_DISTANCE then
				result = refitModel(swep, id, data, compact, nil, clearance) or result
			end
			local pose, aim = result.pose, result.aim
			out:write(encode({
				class = class, id = id, fallback = data.fallback or false, changed = result.changed,
				extent = vectorList(result.extent), before = vectorList(result.before),
				model = data.model, bone = data.bone, pos = vectorList(pose.pos),
				size = vectorList(pose.size), angle = vectorList(Vector(pose.angle.p, pose.angle.y, pose.angle.r)),
				aim = aim and vectorList(aim.aimPos), aimField = aim and aim.aimKeys[1],
				receiverWidth = widths[siteIds[id]] or nil, apertureError = result.apertureError,
				clearance = clearance, flipped = flipped or false,
			}), "\n")
		else
			out:write(encode({class = class, id = id, reason = fit.reason}), "\n")
		end
	end
	swep.ViewModelFlip = flipped
end

local function writeSizeAudit(out, classes)
	local poses = dofile("lua/cotz/weapon_attachment_poses.lua")
	local profiles = dofile("lua/cotz/weapon_attachment_profiles.lua")
	for id in pairs(SIDE_MOUNTS) do
		attachments[id] = attachments[id] or {isSight = true, aimPos = {id .. "Pos", id .. "Ang"}}
	end

	for class, profile in SortedPairs(profiles.weapons) do
		if #classes == 0 or table.HasValue(classes, class) then
			writeWeaponSizeAudit(out, class, profile, poses)
		end
	end
end

local mode = arg[1]
-- Optional spec file before the class list supplies path overrides, for example the old donors.
if arg[2] and arg[2]:find("%.lua$") then
	for class, path in pairs(dofile(arg[2]).paths or {}) do paths[class] = path end
	table.remove(arg, 2)
end

if mode == "sizes" then
	local out = assert(io.open(arg[2], "w"))
	writeSizeAudit(out, {select(3, unpack(arg))})
	out:close()
elseif mode == "posts" then
	posts({select(2, unpack(arg))})
elseif mode == "seats" then
	seats({select(2, unpack(arg))})
elseif mode == "inspect" then
	inspect({select(2, unpack(arg))})
elseif mode == "suppressors" then
	suppressorExport(arg[2], arg[3])
elseif mode == "modelaxes" then
	modelAxes(arg[2], {select(3, unpack(arg))})
elseif mode == "anomaly" then
	anomalyExport(arg[2], arg[3])
elseif mode == "axes" then
	axes(arg[2], {select(3, unpack(arg))})
elseif mode == "validate" then
	validate({select(2, unpack(arg))})
elseif mode == "export" then
	export(arg[2], arg[3])
else
	print("usage: offline_placement.lua validate CLASS... | export OUT_DIR SPEC.lua")
end
