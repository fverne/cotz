
CustomizableWeaponry_KK.ins2.bulletBgs = CustomizableWeaponry_KK.ins2.bulletBgs or {}

local mathClamp = math.Clamp

if SERVER then
	return
end

CustomizableWeaponry_KK.ins2.bulletBgs._getReserve = function(wep)
	local out
	local clip = wep:Clip1()

	if wep.getFullestMag and wep:usesMagazines() then
		out = math.max(clip, wep:getFullestMag(), -1)
	else
		out = wep.Owner:GetAmmoCount(wep.Primary.Ammo) + clip
	end

	if wep.ActiveAttachments.kk_ins2_ww2_stripper then
		out = mathClamp(out, 0, wep.Primary.ClipSize) // srsly, get teh dam mag system
		out = mathClamp(out - clip, 0, wep.Primary.ClipSize)
	end

	return out
end

local getAmmoReserve = CustomizableWeaponry_KK.ins2.bulletBgs._getReserve

// _beltBGID, _beltBGMax, _shellsBGID, _shellsBGMax

// big guns
CustomizableWeaponry_KK.ins2.bulletBgs.pauseBelt = function(wep)
	wep._pauseBeltUpdates = wep.Sequence
end

CustomizableWeaponry_KK.ins2.bulletBgs.beltToReserve = function(wep)
	wep:setBodygroup(wep._beltBGID, mathClamp(getAmmoReserve(wep), 0, wep._beltBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.beltToClip = function(wep)
	wep:setBodygroup(wep._beltBGID, mathClamp(wep:Clip1(), 0, wep._beltBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.beltToClipM1 = function(wep)
	wep:setBodygroup(wep._beltBGID, mathClamp(wep:Clip1() - 1, 0, wep._beltBGMax))
end

// revolvers
CustomizableWeaponry_KK.ins2.bulletBgs.shellsToReserve = function(wep)
	wep:setBodygroup(wep._shellsBGID, mathClamp(getAmmoReserve(wep), 0, wep._shellsBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip = function(wep)
	wep:setBodygroup(wep._shellsBGID, mathClamp(wep:Clip1(), 0, wep._shellsBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClipP1 = function(wep)
	wep:setBodygroup(wep._shellsBGID, mathClamp(wep:Clip1() + 1, 0, wep._shellsBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.bothToReserve = function(wep)
	local r = getAmmoReserve(wep)
	wep:setBodygroup(wep._beltBGID, mathClamp(r, 0, wep._beltBGMax))
	wep:setBodygroup(wep._shellsBGID, mathClamp(r, 0, wep._shellsBGMax))
end

CustomizableWeaponry_KK.ins2.bulletBgs.bothToClipP1 = function(wep)
	local r = wep:Clip1() + 1
	wep:setBodygroup(wep._beltBGID, mathClamp(r, 0, wep._beltBGMax))
	wep:setBodygroup(wep._shellsBGID, mathClamp(r, 0, wep._shellsBGMax))
end

// main think
CustomizableWeaponry_KK.ins2.bulletBgs.think = function(wep)
	local cycle = wep.CW_VM:GetCycle()

	// kek I dont have to make new table for this
	if wep.reloadProgressAnims and wep.reloadProgressAnims[wep.Sequence] and cycle < 1 then
		return
	end

	if wep.Sequence == wep.Animations.base_insert then
		return
	end

	// shotgun reload start/insert/end transition problem
	if wep._pauseBeltUpdates != wep.Sequence or cycle >= 1 or (wep.Owner:ShouldDrawLocalPlayer() and cycle <= 0) then
		wep._pauseBeltUpdates = false
	end

	if !wep._pauseBeltUpdates then
		CustomizableWeaponry_KK.ins2.bulletBgs.beltToClip(wep)
	end
end

// enfield
CustomizableWeaponry_KK.ins2.bulletBgs.beltToClipPS = function(wep)
	wep:setBodygroup(wep._beltBGID, mathClamp(wep:Clip1() + wep.stripperCapacity, 0, wep._beltBGMax))
end

// 1917
CustomizableWeaponry_KK.ins2.bulletBgs.bothToClip = function(wep)
	local r = wep:Clip1()
	wep:setBodygroup(wep._beltBGID, mathClamp(r, 0, wep._beltBGMax))
	wep:setBodygroup(wep._shellsBGID, mathClamp(r, 0, wep._shellsBGMax))
end
