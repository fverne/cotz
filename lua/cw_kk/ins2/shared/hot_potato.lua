
local SP = game.SinglePlayer()
local MP = !SP

CustomizableWeaponry_KK.ins2.hotPotato = CustomizableWeaponry_KK.ins2.hotPotato or {}
function CustomizableWeaponry_KK.ins2.hotPotato:IsValid() return true end

function CustomizableWeaponry_KK.ins2.hotPotato:attemptPickUp(ply, nade)
	self.restrictedStates = self.restrictedStates or {
		[CW_ACTION] = true,
		[CW_CUSTOMIZE] = true,
		[CW_KK_ACTION] = true,
		[CW_KK_QNADE] = true,
		[CW_KK_QKNIFE] = true,
	}

	local wep = ply:GetActiveWeapon()

	if !IsValid(wep) or !wep.KKINS2Wep then
		return
	end

	if IsValid(wep.dt.Potato) then
		return
	end

	if wep.GlobalDelay > CurTime() then
		return
	end

	if self.restrictedStates[wep.dt.State] then
		return
	end

	nade:SetNoDraw(true)
	nade:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	nade:SetOwner(ply)

	wep.dt.Potato = nade
	nade.heldBy = wep
end

function CustomizableWeaponry_KK.ins2.hotPotato:DoPlayerDeath(victim, attacker, dmginfo)
	local wep = victim:GetActiveWeapon()

	if IsValid(wep) and wep.KKINS2Wep then
		local nade = wep.dt.Potato

		if IsValid(nade) then
			nade:SetCollisionGroup(COLLISION_GROUP_NONE)
			nade:SetNoDraw(false)
		end
	end
end

hook.Add("DoPlayerDeath", CustomizableWeaponry_KK.ins2.hotPotato, CustomizableWeaponry_KK.ins2.hotPotato.DoPlayerDeath)
