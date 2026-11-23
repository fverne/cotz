-- Run from the repository root: luatex --luaonly tests/attachment_placement_spec.lua
local sourceMath = dofile("tests/helpers/source_math.lua")
local checks = 0

local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function near(first, second, message)
	check(math.abs(first - second) < 0.0001, string.format("%s: %s ~= %s", message, first, second))
end

local function nearVector(first, second, message)
	near(first.x, second.x, message .. " x")
	near(first.y, second.y, message .. " y")
	near(first.z, second.z, message .. " z")
end

function isstring(value)
	return type(value) == "string"
end

function SortedPairs(tbl)
	local keys = {}
	for key in pairs(tbl) do
		keys[#keys + 1] = key
	end
	table.sort(keys)
	local index = 0

	return function()
		index = index + 1
		return keys[index], tbl[keys[index]]
	end
end

table.HasValue = function(tbl, value)
	for _, item in pairs(tbl) do
		if item == value then return true end
	end

	return false
end

function include(path)
	return dofile("lua/" .. path)
end

concommand = {Add = function() end}

CustomizableWeaponry = {registeredAttachmentsSKey = {
	md_microt1 = {isSight = true, aimPos = {"MicroT1Pos", "MicroT1Ang"}},
	md_eotech = {isSight = true, aimPos = {"EoTechPos", "EoTechAng"}},
	md_kobra = {isSight = true, withoutRail = true, aimPos = {"KobraPos", "KobraAng"}},
	md_pso1 = {isSight = true, withoutRail = true, aimPos = {"PSOPos", "PSOAng"}},
	md_pbs1 = {isSuppressor = true},
}}

local registry = {}
weapons = {Get = function(class) return registry[class] end}

local tool = dofile("lua/autorun/client/cotz_attachment_placement.lua")

local function placement(model, pos, angle, size)
	return {model = model, bone = "body", pos = pos, angle = angle, size = size or Vector(1, 1, 1)}
end

-- Rotation of `child` expressed in `parent`'s CW frame, as matrix columns.
local function relativeAxes(parent, child)
	local _, angle = WorldToLocal(Vector(), Angle(-child.p, child.y, child.r), Vector(),
		Angle(-parent.p, parent.y, parent.r))

	return sourceMath.toMatrix(angle)
end

-- Policy families.
do
	local allowed = tool.allowedSights("cw_glock17", {}, "secondary")
	check(allowed.md_microt1 and allowed.md_rmr and not allowed.md_kobra, "pistols take rail red dots")
	check(not allowed.md_schmidt_shortdot and not allowed.md_acog, "pistols take no magnified optics")

	allowed = tool.allowedSights("cw_mateba", {}, "secondary")
	check(allowed.md_schmidt_shortdot and allowed.md_eotech and not allowed.md_acog, "revolvers add the ShortDot")

	check(next((tool.allowedSights("cw_mossberg500", {}, "primary"))) == nil, "unmounted shotguns take no sights")
	check(next((tool.allowedSights("cw_mosin_unlisted", {HasDovetailMount = true}, "primary"))) ~= nil,
		"unlisted primaries default to rifles")
	allowed = tool.allowedSights("cw_toz34short", {}, "primary")
	check(allowed.md_acog and allowed.md_kobra and not allowed.md_pso1, "listed shotgun mounts take optics")
	check(next((tool.allowedSights("cw_mp40", {}, "primary"))) == nil, "period weapons take no sights")

	allowed = tool.allowedSights("cw_test", {HasDovetailMount = true}, "primary")
	check(allowed.md_pso1, "dovetail rifles take the PSO-1")
	check(not tool.allowedSights("cw_test", {}, "primary").md_pso1, "the PSO-1 needs a dovetail")
	check(tool.allowedSights("cw_test", {}, "primary").md_kobra, "rifles take the Kobra without a dovetail")
end

-- Donor transfer across differently oriented and scaled anchors.
local donor = {
	ViewModel = "donor.mdl",
	IronsightPos = Vector(-2, -3, 1),
	IronsightAng = Vector(0, 0, 0),
	MicroT1Pos = Vector(-2.1, -4, 0.4),
	MicroT1Ang = Vector(0.3, -0.2, 0),
	AttachmentModelsVM = {
		md_kobra = placement("kobra.mdl", Vector(0.5, 1, -2), Angle(0, 180, 90), Vector(0.8, 0.8, 0.8)),
		md_microt1 = placement("microt1.mdl", Vector(0.2, -3, 1.5), Angle(10, 170, 95), Vector(0.4, 0.4, 0.4)),
		md_eotech = placement("eotech.mdl", Vector(0.1, 4, -6), Angle(0, 90, 90)),
		md_pso1 = placement("pso.mdl", Vector(-0.2, -0.5, 3), Angle(0, 0, -90)),
		md_rail = placement("models/wystan/attachments/akrailmount.mdl", Vector(0, -2.7, -1.8), Angle(0, 180, 90)),
	},
	Attachments = {[1] = {header = "Sight", atts = {"md_kobra", "md_microt1", "md_eotech", "md_pso1"}}},
}
registry.cw_donor = donor

local targetAnchor = placement("kobra.mdl", Vector(1, 2, 3), Angle(90, -90, 0), Vector(0.4, 0.4, 0.4))
local target = {
	ViewModel = "target.mdl",
	IronsightPos = Vector(-3, -2, 2),
	IronsightAng = Vector(0, 0, 0),
	KobraPos = Vector(-3, -4, 1),
	AttachmentModelsVM = {
		md_kobra = targetAnchor,
		md_eotech = placement("eotech.mdl", Vector(4, 5, 6), Angle(0, 0, 0)),
		md_pbs1 = placement("pbs1.mdl", Vector(0, -12, 2), Angle(0, 90, -90)),
	},
	Attachments = {
		[1] = {header = "Sight", atts = {"md_kobra", "md_eotech"}},
		[2] = {header = "Barrel", atts = {"md_pbs1"}},
	},
}
registry.cw_target = target

local function setup(options)
	options = options or {}

	return tool.buildSetup({
		class = "cw_target", target = target, anchorID = "md_kobra", anchor = targetAnchor, authored = targetAnchor,
		header = "Sight", donors = {"cw_donor"}, mount = options.mount,
		allowed = options.allowed or {md_microt1 = true, md_eotech = true, md_kobra = true},
	})
end

do
	local result = setup()
	local positions = tool.computePositions(result, targetAnchor.pos)
	local microt1 = result.placements.md_microt1
	check(microt1 and microt1.isNew and microt1.donor == "cw_donor", "allowed donor sights are added")
	check(not result.placements.md_pso1, "policy filters donor sights")
	check(not result.placements.md_rail and next(result.flags) == nil, "rail adapters need a dovetail mount")
	nearVector(positions.md_kobra, targetAnchor.pos, "anchor stays put")
	nearVector(positions.md_eotech, target.AttachmentModelsVM.md_eotech.pos, "existing models keep their placement")
	check(result.placements.md_eotech.angle == target.AttachmentModelsVM.md_eotech.angle, "existing angles are kept")
	near(microt1.size.x, 0.2, "donor size follows the anchor scale")

	-- The new sight keeps the donor's pose relative to the anchor, scaled with it.
	local donorAnchor, donorSight = donor.AttachmentModelsVM.md_kobra, donor.AttachmentModelsVM.md_microt1
	local donorAxes = relativeAxes(donorAnchor.angle, donorSight.angle)
	local targetAxes = relativeAxes(targetAnchor.angle, microt1.angle)
	for column = 1, 3 do
		nearVector(targetAxes[column], donorAxes[column], "relative orientation " .. column)
	end

	local function localOffset(anchor, pos)
		local delta = pos - anchor.pos

		return WorldToLocal(Vector(delta.x, -delta.y, delta.z), Angle(), Vector(),
			Angle(-anchor.angle.p, anchor.angle.y, anchor.angle.r))
	end
	nearVector(localOffset(targetAnchor, positions.md_microt1), localOffset(donorAnchor, donorSight.pos) * 0.5,
		"relative offset")

	local fits = {md_microt1 = {aimKeys = {"MicroT1Pos", "MicroT1Ang"}, aimPos = Vector(1, 2, 3), aimAng = Vector()}}
	local export = tool.buildExport("cw_target", target, result, positions, fits)
	check(#export.models == 1 and export.models[1].id == "md_microt1", "only changed models are exported")
	check(export.attachments[1] == "md_microt1" and #export.skipped == 0, "fitted sights are registered")
	check(export.fields[1].name == "MicroT1Pos" and export.fields[2].name == "MicroT1Ang", "aim fields are exported")

	export = tool.buildExport("cw_target", target, result, positions, {})
	check(#export.models == 0 and export.skipped[1] == "md_microt1", "unfitted sights are skipped")
end

do
	local result = setup({mount = "dovetail", allowed = {md_microt1 = true, md_pso1 = true}})
	check(result.placements.md_rail and result.placements.md_rail.isRail, "dovetail mounts get the rail adapter")
	check(result.flags.SightWithRail, "rail adapters enable SightWithRail")

	local positions = tool.computePositions(result, targetAnchor.pos)
	local fits = {
		md_microt1 = {aimKeys = {"MicroT1Pos", "MicroT1Ang"}, aimPos = Vector(), aimAng = Vector()},
		md_pso1 = {aimKeys = {"PSOPos", "PSOAng"}, aimPos = Vector(), aimAng = Vector()},
	}
	local export = tool.buildExport("cw_target", target, result, positions, fits)
	local names = {}
	for _, field in ipairs(export.fields) do
		names[field.name] = field
	end
	check(names.PSO1AxisAlign and names.PSO1AxisAlign.kind == "align", "new scopes get alignment tables")
	check(names.SightWithRail and names.SightWithRail.value == true, "rail flag is exported")
	check(not table.HasValue(export.attachments, "md_rail"), "the rail adapter is not a slot attachment")
end

-- Seeds start from a donor placement and register in a new sight slot on bare weapons.
do
	local bare = {ViewModel = "bare.mdl", Attachments = {["+reload"] = {header = "Ammo", atts = {}}}}
	local seed = donor.AttachmentModelsVM.md_kobra
	local result = tool.buildSetup({
		class = "cw_bare", target = bare, anchorID = "md_kobra", anchor = seed, header = "Sight",
		seedSource = {swep = donor, placement = seed}, donors = {"cw_donor"}, allowed = {md_microt1 = true},
	})
	check(result.createSlot and result.slotKey == 1, "bare weapons get a new sight slot")
	check(result.placements.md_kobra.isNew and result.placements.md_microt1, "seed and derived sights are new")
	local positions = tool.computePositions(result, seed.pos)
	nearVector(positions.md_microt1, donor.AttachmentModelsVM.md_microt1.pos, "same-rig seeds copy the donor")
end

-- Deriving a sight axis from a hand-tuned aim and fitting it again reproduces that aim.
do
	local samples = {}
	for index = 1, 4 do
		samples[index] = SourceMathMatrix(Vector(12, -3, -4), Angle(-3, 7, 92))
	end
	local sight = donor.AttachmentModelsVM.md_microt1
	local axis = tool.deriveSightAxis(donor, "md_microt1", sight, samples)
	check(axis, "sight axis derived from the donor aim")

	local data = {id = "md_microt1", model = sight.model, angle = sight.angle, size = sight.size,
		aimSource = {swep = donor, placement = sight}}
	local copy = setmetatable({}, {__index = donor})
	local geometrySamples = {}
	for index = 1, 16 do
		geometrySamples[index] = samples[1]
	end
	-- fitScopeAim derives the axis itself, so stub the donor sampling through the tool's probe path.
	ClientsideModel = function()
		return {
			SetNoDraw = function() end, SetPos = function() end, SetAngles = function() end,
			LookupSequence = function() return 0 end, LookupBone = function() return 0 end,
			ResetSequence = function() end, SetCycle = function() end, InvalidateBoneCache = function() end,
			SetupBones = function() end, GetBoneMatrix = function() return samples[1] end, Remove = function() end,
		}
	end
	IsValid = function(value) return value ~= nil end
	RENDERGROUP_OTHER = 0
	copy.Animations = {idle = "idle"}
	donor.Animations = {idle = "idle"}

	local fit = tool.fitScopeAim(copy, data, sight.pos, geometrySamples)
	check(fit, "derived sight fits")
	nearVector(fit.aimPos, donor.MicroT1Pos, "round trip aim")

	-- A new sight without its own aim takes the donor's eye relief relative to the ironsights.
	local fresh = {IronsightPos = Vector(-3, -2, 2), IronsightAng = Vector(0.3, -0.2, 0)}
	fit = tool.fitScopeAim(fresh, data, sight.pos, geometrySamples)
	near(fit.aimPos.y, -3, "transferred eye relief")
end

print(string.format("attachment placement spec passed (%d checks)", checks))
