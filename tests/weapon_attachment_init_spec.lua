-- Run from the repository root: luatex --luaonly tests/weapon_attachment_init_spec.lua
local checks = 0
local pendingCallback

local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

function IsValid(value)
	return type(value) == "table" and not value.removed
end

timer = {
	Simple = function(_, callback)
		pendingCallback = callback
	end,
}

local cases = {
	{class = "cw_m1911chic", attachments = {"md_foregrip"}},
	{class = "cw_toz34special", attachments = {"md_nightforce_nxs"}},
	{class = "cw_obrezmalfunction", attachments = {"md_nightforce_nxs", "md_pbs1", "md_saker"}},
}

for _, case in ipairs(cases) do
	local path = "lua/weapons/" .. case.class .. "/shared.lua"
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	SWEP = {}
	local initialize = assert(source:match("(function SWEP:IndividualInitialize%(%)\n.-\nend)"))
	assert(load(initialize, "@" .. path))()

	for _, server in ipairs({true, false}) do
		SERVER = server
		CLIENT = not server

		for _, removed in ipairs({false, true}) do
			local attached = {}
			local weapon = {
				StockBGs = {main = 0, obrez = 3},
				BoltBGs = {main = 1, bent = 1},
				setBodygroup = function() end,
				WMEnt = {SetBodygroup = function() end},
				attachSpecificAttachment = function(_, attachment)
					attached[#attached + 1] = attachment
				end,
			}
			pendingCallback = nil
			SWEP.IndividualInitialize(weapon)

			if server then
				check(type(pendingCallback) == "function", case.class .. ": server schedules attachments")
				weapon.removed = removed

				if removed then
					-- Removed GMod entities no longer expose their scripted weapon methods.
					weapon.attachSpecificAttachment = nil
				end

				pendingCallback()
				check(#attached == (removed and 0 or #case.attachments),
					case.class .. ": only surviving weapons receive attachments")

				for index, attachment in ipairs(attached) do
					check(attachment == case.attachments[index], case.class .. ": preserves attachment order")
				end
			else
				check(pendingCallback == nil, case.class .. ": client does not schedule server attachments")
			end
		end
	end
end

print("PASS: " .. checks .. " weapon attachment initialization checks")
