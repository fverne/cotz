PLUGIN.name = "Override Thirdperson"
PLUGIN.description = "Override Thirdperson."
PLUGIN.author = "ZeMysticalTaco / TFA"

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("ThirdOTSPacket")
	util.AddNetworkString("ThirdOTSReq")

	net.Receive("ThirdOTSReq", function(len, ply)
		local t = net.ReadBool()
		local state = net.ReadBool()
		if t then
			ply:SetNW2Bool("ThirtOTS",  state)
		else
			ply:SetNW2Bool("ThirtOTS_SStatus", state)
		end
	end)

	hook.Add("PlayerSay", "thirdperson_ots", function(ply, text, public)
		local ltext = string.lower(text) -- Make the chat message entirely lowercase

		if (ltext == "!tp_ots") then
			ply:ConCommand("thirdperson_ots")

			return ""
		end
	end)
end

concommand.Add("thirdperson_ots", function(fply, cmd, args, argstr)
	if CLIENT then
		net.Start("ThirdOTSReq")
		net.WriteBool(true)
		net.WriteBool(not ix.option.Get("thirdpersonEnabled", false))
		net.SendToServer()
	end
	fply:SetNW2Bool("ThirtOTS", not ix.option.Get("thirdpersonEnabled", false))
end, nil, nil, FCVAR_NONE)

concommand.Add("thirdperson_ots_swap", function(fply, cmd, args, argstr)
	if CLIENT then
		net.Start("ThirdOTSReq")
		net.WriteBool(false)
		net.WriteBool(not fply:GetNW2Bool("ThirtOTS_SStatus", false))
		net.SendToServer()
	end
	fply:SetNW2Bool("ThirtOTS_SStatus", not fply:GetNW2Bool("ThirtOTS_SStatus", false))
end, nil, nil, FCVAR_NONE)


function PointDir(from, to)
	local ang = to - from

	return ang:Angle()
end

local minvec = Vector(-6, -6, -6)
local maxvec = Vector(6, 6, 6)
local crouchfac = 0
local rightconvar = CreateClientConVar("thirdperson_ots_right", 20, true, false)
local upconvar = CreateClientConVar("thirdperson_ots_up", 0, true, false)
local upcrouchedconvar = CreateClientConVar("thirdperson_ots_crouched_up", 15, true, false)
local forwardconvar = CreateClientConVar("thirdperson_ots_forward", -35, true, false)
local crosscv = CreateClientConVar("thirdperson_ots_crosshair", 1, true, false)
local fovcv = CreateClientConVar("thirdperson_ots_fov", 100, true, false)
local lply

local function chkfunc(ent)
	if not lply and IsValid(LocalPlayer()) then
		lply = LocalPlayer()
	end

	if ent == lply or (IsValid(ply) and ent == ply:GetActiveWeapon()) then return false end
	if ent:IsRagdoll() then return false end

	return true
end

local angleclamp = 85
local oldeyeangles
local neweyeangles
local tr = {}
local traceres
local swapfac = 1
local swaptarget = 1

hook.Add("CalcView", "ThirdOTSCalcView", function(fply, pos, angles, fov)
	if not ix.option.Get("thirdpersonEnabled", false) then return end
	if not fply:Alive() then return end
	swaptarget = fply:GetNW2Bool("ThirtOTS_SStatus", false) and -1 or 1
	swapfac = math.Approach(swapfac, swaptarget, (swaptarget - swapfac) * FrameTime() * 10)
	oldeyeangles = fply:EyeAngles() --angles * 1

	if not fply.thirdotscameraangle then
		angles.p = math.Clamp(angles.p, -angleclamp, angleclamp)
		fply.thirdotscameraangle = angles
	end

	angles = fply.thirdotscameraangle

	if fply.oldeyeangles then
		local dif = fply:EyeAngles() - fply.oldeyeangles
		fply.thirdotscameraangle = fply.thirdotscameraangle + dif
	end

	fply.thirdotscameraangle:Normalize()
	fply.thirdotscameraangle.p = math.Clamp(fply.thirdotscameraangle.p, -angleclamp, angleclamp)
	angles:Normalize()
	local tmpang = Angle(angles.p, angles.y, angles.r)
	tr.start = pos
	tr.endpos = pos + (tmpang:Forward() * forwardconvar:GetFloat()) + (tmpang:Right() * rightconvar:GetFloat() * swapfac) + (tmpang:Up() * upconvar:GetFloat())
	local newnum = fply:Crouching() and 1 or 0
	crouchfac = math.Approach(crouchfac, newnum, (newnum - crouchfac) * FrameTime() * 10)

	if crouchfac > 0 then
		tr.endpos = tr.endpos + (tmpang:Up() * upcrouchedconvar:GetFloat()) * crouchfac
	end

	tr.filter = chkfunc
	tr.mask = MASK_SOLID
	tr.mins = minvec
	tr.maxs = maxvec
	local htra = util.TraceHull(tr)
	local tmppos = htra.HitPos
	tr.start = tmppos - tmpang:Forward() * forwardconvar:GetFloat() * 2
	tr.endpos = tmpang:Forward() * 2147483647
	tr.mask = MASK_SHOT
	tr.filter = chkfunc
	--tmppos,tmpang:Forward()*2147483647,filtertable
	traceres = util.TraceLine(tr)
	neweyeangles = PointDir(fply:GetShootPos(), traceres.HitPos)
	neweyeangles:Normalize()
	local vpan = fply:GetViewPunchAngles()
	vpan:Normalize()
	fply:SetEyeAngles(LerpAngle(FrameTime() * 10, oldeyeangles, neweyeangles))
	fply.oldeyeangles = fply:EyeAngles()
	fply.campos = tmppos
	fply.camang = tmpang
	tmpang = tmpang + vpan * 1
	tmpang.r = 0
	if fovcv then
		fov = fov * math.Clamp( fovcv:GetFloat(), 50, 150) / 90
	end

	if LeanCalcView then
		return LeanCalcView(fply, tmppos, tmpang, fov)
	else
		return {
			origin = tmppos,
			angles = tmpang,
			fov = fov
		}
	end
end)

hook.Add("ShouldDrawLocalPlayer", "ThirdOTSShouldDrawLocalPlayer", function(fply)
	if not ix.option.Get("thirdpersonEnabled", false) then return end

	return true
end)

hook.Add("HUDPaint", "ThirdOTSHudPaint", function()
	local fply = LocalPlayer()
	if not IsValid(fply) then return end
	if not ix.option.Get("thirdpersonEnabled", false) then return end

	if not fply.interpposx then
		fply.interpposx = ScrW() / 2
	end

	if not fply.interpposy then
		fply.interpposy = ScrH() / 2
	end

	local pos = (fply:GetEyeTrace().HitPos):ToScreen()
	pos.x = math.Clamp(pos.x, 0, ScrW())
	pos.y = math.Clamp(pos.y, 0, ScrH())
	fply.interpposx = math.Approach(fply.interpposx, pos.x, (fply.interpposx - pos.x) * FrameTime() * 25)
	fply.interpposy = math.Approach(fply.interpposy, pos.y, (fply.interpposy - pos.y) * FrameTime() * 25)
	draw.NoTexture()
	local s_cone
	s_cone = 0.015
	local wep = fply:GetActiveWeapon()
	if wep.DrawCrosshairDefault ~= nil and wep.DrawCrosshairDefault == false then return end

	if IsValid(wep) and wep.CalculateConeRecoil then
		s_cone = wep:CalculateConeRecoil()
	end

	local gap = (s_cone * 90) / fply:GetFOV() * ScrH() / 1.44

	--surface.DrawCircle( fply.interpposx, fply.interpposy, math.Clamp(gap,6,ScrH()/2), col )
	--if Vector(fply.interpposx, fply.interpposy, 0):Distance(Vector(ScrW() / 2, ScrH() / 2, 0)) < ScrH() / 60 then
	--	surface.DrawCircle(ScrW() / 2, ScrH() / 2, math.Clamp(gap, 6, ScrH() / 2), greencol)
	--else
	--	surface.DrawCircle(ScrW() / 2, ScrH() / 2, math.Clamp(gap, 6, ScrH() / 2), redcol)
	--end

	if ( not crosscv ) or crosscv:GetBool() then
		surface.DrawCircle(ScrW() / 2, ScrH() / 2, math.Clamp(gap, 6, ScrH() / 2), color_white)
	end
end)

local DisabledMoveTypes = {
	[MOVETYPE_FLY] = true,
	[MOVETYPE_FLYGRAVITY] = true,
	[MOVETYPE_OBSERVER] = true,
	[MOVETYPE_NOCLIP] = true
}

hook.Add("CreateMove", "ThirdOTSCreateMove", function(cmd)
	local fply = LocalPlayer()
	if not IsValid(fply) then return end
	if not ix.option.Get("thirdpersonEnabled", false) then return end
	if DisabledMoveTypes[fply:GetMoveType()] then return end
	local tang = fply.camang and fply.camang or fply:EyeAngles()
	vel = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), cmd:GetUpMove())
	vel:Rotate(fply:EyeAngles() - tang)
	cmd:SetSideMove(vel.y)
	cmd:SetForwardMove(vel.x)
	cmd:SetUpMove(vel.z)
end)	