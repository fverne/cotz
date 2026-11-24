local function detector(name, server)
	local now = 10
	local sequences = {
		anm_throw_s = 1,
		anm_throw_e = 2,
		anm_idle = 3,
		anm_hide = 4,
	}
	local viewModel = {
		LookupSequence = function(_, name) return sequences[name] or -1 end,
		SequenceDuration = function(_, sequence) return sequence == 2 and 2.5 or 1 end,
		SendViewModelMatchingSequence = function(self, sequence) self.sequence = sequence end,
		GetSequence = function(self) return self.sequence end,
	}
	local character = {
		GetInventory = function()
			return {HasItem = function(_, id) return id == "value_bolts" end}
		end,
	}
	local owner = {
		GetCharacter = function() return character end,
		GetViewModel = function() return viewModel end,
		GetPos = function() return {} end,
	}
	local base = {Primary = {}, Secondary = {}}
	local environment = setmetatable({
		SWEP = base,
		SERVER = server,
		CLIENT = not server,
		AddCSLuaFile = function() end,
		Angle = function() return {} end,
		Vector = function() return {} end,
		Color = function() return {} end,
		CurTime = function() return now end,
		IsValid = function(entity) return entity ~= nil end,
		sound = {GetProperties = function() return true end},
		hook = {Add = function() end},
		file = {Exists = function() return true end},
	}, {__index = _G})
	assert(loadfile("lua/weapons/cotz_detector_base/shared.lua", "t", environment))()
	local weapon = setmetatable({releases = {}}, {__index = base})
	environment.SWEP = weapon
	assert(loadfile("lua/weapons/detector_" .. name .. "/shared.lua", "t", environment))()

	function weapon:NetworkVar(_, _, name)
		self["Get" .. name] = function() return self[name] or 0 end
		self["Set" .. name] = function(_, value) self[name] = value end
	end

	weapon:SetupDataTables()
	weapon:NetworkVar("Float", 0, "NextPrimaryFire")
	weapon:NetworkVar("Float", 0, "NextSecondaryFire")
	weapon.GetOwner = function() return owner end
	weapon.GetIdleSequence = function() return "anm_idle" end
	weapon.ScanArtifacts = function() end
	weapon.FindNearestArtifact = function() end
	weapon.UpdateClientState = function() end
	weapon.ReleaseBolt = function(self, thrower, throwCharacter, force)
		assert(thrower == owner and throwCharacter == character, "release uses the character who started the throw")
		self.releases[#self.releases + 1] = force
	end

	local function tick(time)
		now = time
		weapon:Think()
	end

	return weapon, viewModel, tick
end

for _, name in ipairs({"echo", "bear", "veles"}) do
	for _, server in ipairs({true, false}) do
		for attack, force in pairs({PrimaryAttack = 5000, SecondaryAttack = 2500}) do
			local weapon, viewModel, tick = detector(name, server)
			weapon[attack](weapon)
			assert(viewModel.sequence == 1, "both throws play the detector windup")
			tick(10.99)
			assert(viewModel.sequence == 1 and #weapon.releases == 0, "windup completes before release")
			tick(11)
			assert(viewModel.sequence == 2, "the detector follow-through starts after the windup")
			local releaseTime = 11 + 2.5 * weapon.BoltReleaseCycle
			tick(releaseTime - 0.01)
			assert(#weapon.releases == 0, "the projectile waits for the release frame")
			tick(releaseTime)
			assert(weapon.releases[1] == (server and force or nil), "release is server-only and uses the input force")
			tick(13.25)
			weapon[attack](weapon)
			assert(viewModel.sequence == 2, "the cooldown covers the full follow-through")
			tick(13.5)
			assert(viewModel.sequence == 3, "idle resumes after follow-through")
			assert(#weapon.releases == (server and 1 or 0), "the release happens exactly once")
		end
	end
end

for _, switchTime in ipairs({10.5, 11}) do
	local weapon, viewModel, tick = detector("echo", true)
	weapon:PrimaryAttack()
	tick(switchTime)
	assert(weapon:Holster({}) == false and viewModel.sequence == 4, "switch starts the hide animation")
	tick(11.25)
	assert(viewModel.sequence == 4 and #weapon.releases == 0, "holstering cancels a pending throw")
end

print("PASS: detector throw sequences, release timing, cooldown and holster cancellation")
