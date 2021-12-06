
local function CW20_DEPLOYANGLE()
	local ang = net.ReadAngle()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep.DeployAngle = ang
	end
end

net.Receive("CW20_DEPLOYANGLE", CW20_DEPLOYANGLE)

local function CW20_DEPLOY()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:Deploy()
	end
end

net.Receive("CW20_DEPLOY", CW20_DEPLOY)

local function CW20_THROWGRENADE()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		CustomizableWeaponry.quickGrenade.throw(wep)
	end
end

net.Receive("CW20_THROWGRENADE", CW20_THROWGRENADE)

local function CW20_GLOBALDELAY()
	local delay = net.ReadFloat()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:delayEverything(delay)
		wep:setGlobalDelay(delay)
	end
end

net.Receive("CW20_GLOBALDELAY", CW20_GLOBALDELAY)

local function CW20_FORCESTATE()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:forceState(net.ReadInt(16), net.ReadFloat())
	end
end

net.Receive("CW20_FORCESTATE", CW20_FORCESTATE)

local function CW20_M203ON()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:enableM203()
	end
end

net.Receive("CW20_M203ON", CW20_M203ON)

local function CW20_M203OFF()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableM203(true)
	end
end

net.Receive("CW20_M203OFF", CW20_M203OFF)

local function CW20_M203OFF_RELOAD()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:disableM203(false)
	end
end

net.Receive("CW20_M203OFF_RELOAD", CW20_M203OFF_RELOAD)

local function CW20_FIREM203()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:fireM203()
	end
end

net.Receive("CW20_FIREM203", CW20_FIREM203)

local function CW20_RELOADM203()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep:reloadM203()
	end
end

net.Receive("CW20_RELOADM203", CW20_RELOADM203)

local function CW20_GRENADETYPE()
	local grenType = net.ReadInt(16)
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.CW20Weapon then
		wep.Grenade40MM = grenType

		if CustomizableWeaponry.playSoundsOnInteract then
			wep:EmitSound("CW_M203_OPEN")
		end
	end
end

net.Receive("CW20_GRENADETYPE", CW20_GRENADETYPE)

local function CW20_M203CHAMBER()
	local wep = net.ReadEntity()
	local state = net.ReadBool()

	if IsValid(wep) and wep.CW20Weapon then
		wep.M203Chamber = state
	end
end

net.Receive("CW20_M203CHAMBER", CW20_M203CHAMBER)
