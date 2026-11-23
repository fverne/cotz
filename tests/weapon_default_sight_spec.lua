local file = assert(io.open("lua/weapons/cw_base/cl_model.lua", "r"))
local source = file:read("*a")
file:close()

local calls = {}
local sight = {
	SetNoDraw = function(_, hidden) calls.hidden = hidden end,
	SetParent = function(_, parent) calls.parent = parent end,
	AddEffects = function(_, effect) calls.effect = effect end,
	SetupBones = function() calls.bones = (calls.bones or 0) + 1 end,
	DrawModel = function() calls.draws = (calls.draws or 0) + 1 end,
}
local weapon = {
	DefaultSightModel = "stock_sight.mdl",
	CW_VM = {},
	createManagedCModel = function(_, model, group)
		assert(model == "stock_sight.mdl" and group == 1)
		return sight
	end,
}
local environment = {SWEP = weapon, IsValid = function(value) return value == sight end,
	RENDERGROUP_BOTH = 1, EF_BONEMERGE = 2}

for _, method in ipairs({"setupAttachmentModels", "drawAttachments"}) do
	local definition = assert(source:match("(function SWEP:" .. method .. "%(%)\n.-\nend)"))
	assert(load(definition, nil, "t", environment))()
end

weapon:setupAttachmentModels()
assert(calls.hidden and calls.parent == weapon.CW_VM and calls.effect == 2)

weapon.CurIronsightPos = {}
weapon.AimPos = weapon.CurIronsightPos
weapon:drawAttachments()
assert(calls.draws == 1 and calls.bones == 1)

weapon.AimPos = {}
weapon:drawAttachments()
assert(calls.draws == 1)

weapon.AimPos = weapon.CurIronsightPos
weapon:drawAttachments()
assert(calls.draws == 2 and calls.bones == 2)
