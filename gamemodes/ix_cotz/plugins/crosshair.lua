
local PLUGIN = PLUGIN

PLUGIN.name = "Crosshair"
PLUGIN.author = "Black Tea"
PLUGIN.description = "A Crosshair."

ix.option.Add("disableCrosshair", ix.type.bool, false, {
	category = "_stalkersettings"
})

if (CLIENT) then
	local crosshairmat = Material("stalker/crosshair.vtf")

	local function drawdot( pos, size )
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial( crosshairmat )
		surface.DrawTexturedRect(pos[1] - size/2, pos[2] - size/2, size, size)
	end

	local aimVector, punchAngle, ft, screen, scaleFraction, distance
	local math_round = math.Round
	local curAlpha = 0
	local maxDistance = 1000 ^ 2
	local crossSize = 4
	local colors = {color_black}
	local filter = {}

	function PLUGIN:DrawCrosshair(x, y, trace)
		local entity = trace.Entity
		distance = trace.StartPos:DistToSqr(trace.HitPos)
		scaleFraction = 1 - math.Clamp(distance / maxDistance, 0, .5)
		crossSize = math.Clamp( 35 * scaleFraction, 25, 65)

		drawdot( {math_round(screen.x), math_round(screen.y)}, crossSize)
	end

	-- luacheck: globals g_ContextMenu
	function PLUGIN:PostDrawHUD()
		ix.hud.DrawAll(true)

		local client = LocalPlayer()
		if (!client:GetCharacter() or !client:Alive()) then
			return
		end

		if (ix.option.Get("disableCrosshair", false)) then
			return
		end

		local entity = Entity(client:GetLocalVar("ragdoll", 0))

		if (entity:IsValid()) then
			return
		end

		local wep = client:GetActiveWeapon()
		local bShouldDraw = hook.Run("ShouldDrawCrosshair", client, wep)

		if (client:KeyDown(IN_ATTACK2) and IsValid(wep) and wep:GetClass() ~= "ix_hands") then
			return
		end

		if (bShouldDraw == false or !IsValid(wep) /*or wep.DrawCrosshair == false ALWAYS DISPLAY CROSSHAIR*/) then
			return
		end

		if (bShouldDraw == false or g_ContextMenu:IsVisible() or
			(IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing())) then
			return
		end

		aimVector = client:EyeAngles()
		punchAngle = client:GetViewPunchAngles()
		ft = FrameTime()
		filter = {client}

		local vehicle = client:GetVehicle()
		if (vehicle and IsValid(vehicle)) then
			aimVector = aimVector + vehicle:GetAngles()
			table.insert(filter, vehicle)
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + (aimVector + punchAngle):Forward() * 65535
			data.filter = filter
		local trace = util.TraceLine(data)

		local drawTarget = self
		local drawFunction = self.DrawCrosshair

		-- we'll manually call this since CHudCrosshair is never drawn; checks are already performed
		--if (wep.DoDrawCrosshair) then
		--	drawTarget = wep
		--	drawFunction = wep.DoDrawCrosshair
		--end

		screen = trace.HitPos:ToScreen()
		drawFunction(drawTarget, screen.x, screen.y, trace)
	end
end
