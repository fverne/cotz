local function read(path)
	local file = assert(io.open(path, "r"))
	local source = file:read("*a")
	file:close()

	return source
end

local eyeAngles = {p = 0, y = 0, r = 0}
local weapon = {
	Owner = {EyeAngles = function() return eyeAngles end},
	getMuzzlePosition = function() error("The scope camera must not use the muzzle attachment.") end,
	ScopeAngleTransforms = {},
}

local base = read("lua/weapons/cw_base/sh_general.lua")
local getTelescopeAngles = assert(base:match("(function SWEP:getTelescopeAngles%(%)\n.-\n\tend)"))
assert(load(getTelescopeAngles, nil, "t", {SWEP = weapon}))()

local function checkMovement(getAngles)
	for _, pose in ipairs({{0, 0}, {32, 0}, {-27, 0}, {0, 48}, {19, -37}}) do
		eyeAngles.p, eyeAngles.y = pose[1], pose[2]
		local actual = getAngles()
		assert(actual.p == pose[1] and actual.y == pose[2], "The scope camera must follow pitch and yaw.")
	end
end

for _, freeAim in ipairs({false, true}) do
	weapon.freeAimOn = freeAim
	checkMovement(function() return weapon:getTelescopeAngles() end)
end

for _, class in ipairs({"tfa_3dscoped_base", "tfa_3dbash_base"}) do
	local source = read("lua/weapons/" .. class .. "/shared.lua")
	local camera = assert(source:match("(local ang = self.Owner:EyeAngles%(%)\n.-\n\tcd%.angles = ang)"))
	local scopeView = {}
	local calculate = assert(load(camera, nil, "t", {self = weapon, cd = scopeView, pairs = pairs}))
	checkMovement(function()
		calculate()

		return scopeView.angles
	end)
end
