
local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local GetAimVector = reg.Player.GetAimVector

local SP = game.SinglePlayer()

local mins, maxs = Vector(-8, -8, -1), Vector(8, 8, 1)

local td = {}
td.mins = mins
td.maxs = maxs

function SWEP:CanRestWeapon(height)
	height = height or -1
	local vel = Length(GetVelocity(self.Owner))
	local pitch = self.Owner:EyeAngles().p

	if vel == 0 and pitch <= 60 and pitch >= -20 then
		local sp = self.Owner:GetShootPos()
		local aim = self.Owner:GetAimVector()

		if not self.dt.BipodDeployed then
			td.start = sp
			td.endpos = td.start + aim * 35
			td.filter = self.Owner

			local tr = util.TraceHull(td)

			//fire first trace to check whether there is anything IN FRONT OF US
			if tr.Hit then
				//if there is, don't allow us to deploy
				return false
			end
		end

		aim.z = height

		td.start = sp
		td.endpos = td.start + aim * 25
		td.filter = self.Owner

		tr = util.TraceHull(td)

		if tr.Hit then
			local ent = tr.Entity

			-- if the second trace passes, we can deploy
			if not ent:IsPlayer() and not ent:IsNPC() then
				return true
			end
		end

		return false
	end

	return false
end
