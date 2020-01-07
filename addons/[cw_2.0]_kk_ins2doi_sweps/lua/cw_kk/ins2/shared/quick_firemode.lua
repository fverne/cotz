
local SP = game.SinglePlayer()

// copy-pasta

function doStuff(self)
	local CT = CurTime()

	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end

	if CT < self.GlobalDelay then
		return
	end

	if self.dt.INS2GLActive or self.dt.M203Active then
		return
	end

	if self.dt.State == CW_RUNNING then
		return
	end

	self:CycleFiremodes()
end

// concommand

if SERVER then
	local wep

	concommand.Add("cw_kk_firemode", function(ply)
		if !IsValid(ply) then return end

		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end

		doStuff(wep)
	end)
end
