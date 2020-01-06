
function SWEP:getMagCapacity()
	local mag = self:Clip1()

	if self.KKINS2RCE then
		return mag
	end

	if mag > self.Primary.ClipSize_Orig then
		return self.Primary.ClipSize_Orig .. " + " .. mag - self.Primary.ClipSize_Orig
	end

	return mag
end

function SWEP:getReserveAmmoText()
	local shouldOverride, text, targetColor = CustomizableWeaponry.callbacks.processCategory(self, "overrideReserveAmmoText")

	if self.KKINS2RCE then
		return self.Owner:GetAmmoCount(self.Primary.Ammo), shouldOverride, self.HUDColors.white
	end

	if self.KKINS2Nade then
		return self.Owner:GetAmmoCount(self.Primary.Ammo), shouldOverride, targetColor
	end

	if shouldOverride then
		return text, shouldOverride, targetColor
	end

	return self.Owner:GetAmmoCount(self.Primary.Ammo), shouldOverride, targetColor
end

SWEP.HUD_3D2D_MagColor = Color(255, 255, 255, 255)
SWEP.HUD_3D2d_ReserveColor = Color(255, 255, 255, 255)

local bullet = surface.GetTextureID("cw2/gui/bullet")

function SWEP:draw3D2DHUD()
	local att = self:getMuzzlePosition()
	local ang = EyeAngles()
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -90)

	cam.Start3D2D(att.Pos + ang:Forward() * 4, ang, self.HUD_3D2DScale)
		cam.IgnoreZ(true)
			local FT = FrameTime()

			if self.dt.State == CW_AIMING or (self.InactiveWeaponStates[self.dt.State] and not (self.IsReloading and self.Cycle <= 0.98)) then
				self.HUD_3D2DAlpha = math.Approach(self.HUD_3D2DAlpha, 0, FT * 1000)
			else
				self.HUD_3D2DAlpha = math.Approach(self.HUD_3D2DAlpha, 255, FT * 1000)
			end

			self.HUDColors.red.a = self.HUD_3D2DAlpha
			self.HUDColors.white.a = self.HUD_3D2DAlpha
			self.HUDColors.black.a = self.HUD_3D2DAlpha

			if self.dt.INS2GLActive then
				local glName = self:getGLAttName()

				// display the text when we either have a round in, or have no rounds but aren't aiming
				if (not self.M203Chamber and self.dt.State ~= CW_AIMING) or self.M203Chamber then
					local reloadProgress = self:getReloadProgress()

					if reloadProgress then
						draw.ShadowText("RELOADING  " .. reloadProgress .. "%", "CW_HUD60", 90, 50, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					else
						if not self.M203Chamber then
							draw.ShadowText(glName .. " EMPTY", "CW_HUD60", 90, 50, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
						else
							draw.ShadowText(glName .. " READY", "CW_HUD60", 90, 50, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
						end
					end

					local curGrenade = CustomizableWeaponry.grenadeTypes.getGrenadeText(self)

					local nadeText

					local nadeSetup = CustomizableWeaponry_KK.ins2.quickGrenade:getAmmo(self)

					local nadeCount = nadeSetup.ammo and self.Owner:GetAmmoCount(nadeSetup.ammo) or 8

					if nadeCount > 0 then
						nadeText = nadeCount .. "x " .. nadeSetup.text .. ", "
					else
						nadeText = ""
					end

					draw.ShadowText(nadeText .. "RESERVE: " .. self.Owner:GetAmmoCount("40MM"), "CW_HUD48", 90, 100, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

					// draw.ShadowText(self.Owner:GetAmmoCount("40MM") .. "x RESERVE", "CW_HUD48", 90, 100, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					draw.ShadowText("TYPE" .. curGrenade, "CW_HUD40", 90, 140, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			else

				local mag = self:Clip1()
				local ammoCount, magCount, targetColor = self:getReserveAmmoText()

				self.HUDColors.black.a = self.HUD_3D2DAlpha

				local reloadProgress = self:getReloadProgress()

				// if our mag has not much ammo or we're reloading, make the text red
				if mag <= self.Primary.ClipSize * 0.25 or reloadProgress then
					self.HUD_3D2D_MagColor = LerpColor(FT * 10, self.HUD_3D2D_MagColor, self.HUDColors.red)
				else
					self.HUD_3D2D_MagColor = LerpColor(FT * 10, self.HUD_3D2D_MagColor, self.HUDColors.white)
				end

				self.HUD_3D2D_MagColor.a = self.HUD_3D2DAlpha

				// only show the reload progress if we're reloading
				if reloadProgress then
					draw.ShadowText("RELOADING " .. reloadProgress .. "%", "CW_HUD60", 90, 50, self.HUD_3D2D_MagColor, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				else
					local magCap = self.Primary.ClipSize

					if magCap > 0 or self.KKINS2RCE then
						draw.ShadowText(self:getMagCapacity() .. " / " .. ammoCount, "CW_HUD60", 90, 50, self.HUD_3D2D_MagColor, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					else
						draw.ShadowText(ammoCount, "CW_HUD60", 90, 50, self.HUD_3D2D_MagColor, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					end
				end

				// draw.ShadowText(self.FireModeDisplay, "CW_HUD40", 90, 100, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

				if self.BulletDisplay and self.BulletDisplay > 0 then
					local bulletDisplayAlpha = self.HUD_3D2DAlpha
					local bulletDisplayOffset = 0

					if #self.FireModes > 1 then -- if we have more than 1 firemode for the current weapon, we don't let the firemode display fade and instead reposition it a bit to let the player see what firemode he's using while aiming
						local aiming = self.dt.State == CW_AIMING

						bulletDisplayAlpha = aiming and 255 or self.HUD_3D2DAlpha
						bulletDisplayOffset = aiming and -255 or 0
					end

					surface.SetTexture(bullet)
					surface.SetDrawColor(0, 0, 0, bulletDisplayAlpha)

					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRectRotated(115 + bulletDisplayOffset, 38 + (i - 1) * 18, 30, 30, 180)
					end

					surface.SetTexture(bullet)
					surface.SetDrawColor(255, 255, 255, bulletDisplayAlpha)

					for i = 1, self.BulletDisplay do
						surface.DrawTexturedRectRotated(113 + bulletDisplayOffset, 38 + (i - 1) * 18 - 2, 30, 30, 180)
					end
				end

				draw.ShadowText(self.Primary.Ammo, "CW_HUD48", 90, 100, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

				local nadeSetup = CustomizableWeaponry_KK.ins2.quickGrenade:getAmmo(self)

				local nadeCount = nadeSetup.ammo and self.Owner:GetAmmoCount(nadeSetup.ammo) or 8

				if nadeCount > 0 then
					draw.ShadowText(nadeCount .. "x " .. nadeSetup.text, "CW_HUD40", 90, 140, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end

			self.HUDColors.white.a = 255
			self.HUDColors.black.a = 255

			CustomizableWeaponry.callbacks.processCategory(self, "drawTo3D2DHUD")
		cam.IgnoreZ(false)
	cam.End3D2D()
end

local Deploy, UnDeploy = surface.GetTextureID("cw2/gui/bipod_deploy"), surface.GetTextureID("cw2/gui/bipod_undeploy")
local deployedOnObject = surface.GetTextureID("cw2/gui/deployonobject")
local scopeTemplate = surface.GetTextureID("cw2/gui/scope_template")

local ClumpSpread = surface.GetTextureID("cw2/gui/clumpspread_ring")
local Bullet = surface.GetTextureID("cw2/gui/bullet")
local GLCrosshair = surface.GetTextureID("cw2/gui/crosshair_gl")
local Vignette = surface.GetTextureID("cw2/effects/vignette")

local White, Black = Color(255, 255, 255, 255), Color(0, 0, 0, 255)
local x, y, x2, y2, lp, size, FT, CT, tr, x3, x4, y3, y4, UCT, sc1, sc2
local td = {}

local surface = surface
local math = math
local draw = draw
local dst = draw.SimpleText

local cwhud24 = "CW_HUD24"
local cwhud22 = "CW_HUD22"
local cwhud20 = "CW_HUD20"
local cwhud16 =	"CW_HUD16"
local cwhud14 = "CW_HUD14"

local gradient = surface.GetTextureID("cw2/gui/gradient")

function SWEP:drawCustomHUD()
	local FT = FrameTime()

	local x, y = ScrW(), ScrH()

	self.HUDColors.white.a = 255
	self.HUDColors.black.a = 255
	local baseX, baseY = 100, y - 150

	surface.SetDrawColor(0, 0, 0, 200)
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(baseX - 5, baseY - 15, 300, 90)

	// draw the bottom-left part of the HUD; aka health and armor
	draw.ShadowText("HEALTH: ", cwhud24, baseX, baseY, self.HUD_HealthTextColor, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText("ARMOR: ", cwhud24, baseX, baseY + 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	local hp = self.Owner:Health()
	local arm = self.Owner:Armor()

	// approach the health and armor values rather than snapping, so that the pips fill up gradually
	self.HUD_LastHealth = math.Approach(self.HUD_LastHealth, hp, FT * 100)
	self.HUD_LastArmor = math.Approach(self.HUD_LastArmor, arm, FT * 100)

	// draw the health and armor text
	draw.ShadowText(hp .. "%", cwhud24, baseX + 100, baseY, self.HUD_HealthTextColor, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText(arm .. "%", cwhud24, baseX + 100, baseY + 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	local healthPips = math.Clamp(math.floor(self.HUD_LastHealth / 5), 1, 20)
	local armorPips = math.Clamp(math.floor(self.HUD_LastArmor / 5), 0, 20)

	// black health and armor pips (to avoid unnecessary SetDrawColor calls)
	surface.SetDrawColor(0, 0, 0, 255)

	for i = 1, healthPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 16, 5, 10)
	end

	for i = 1, armorPips do
		surface.DrawRect(baseX + (i - 1) * 12 + 2, baseY + 36, 5, 10)
	end

	// colored health pips
	for i = 1, healthPips do
		surface.SetDrawColor(240 - i * 10, i * 12.75, i * 4, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 15, 5, 10)
	end

	// colored armor pips
	for i = 1, armorPips do
		surface.SetDrawColor(0, 125 + i * 6.5, 200 + i * 2.75, 255)
		surface.DrawRect(baseX + (i - 1) * 12 + 1, baseY + 35, 5, 10)
	end

	// draw the 2D variant of the custom HUD in case the 3D variant was disabled by the user
	if GetConVarNumber("cw_customhud_ammo") <= 0 then
		local baseXAMMO, baseYAMMO = x - 117, y - 150
		local magCap = self.Primary.ClipSize

		surface.SetDrawColor(0, 0, 0, 200)
		surface.SetTexture(gradient)

		// display the M203 section if we're in M203 mode
		if self.dt.INS2GLActive and self.dt.State != CW_CUSTOMIZE then
			local baseY = baseY + 100
			local baseYAMMO = baseYAMMO + 100

			local glName = self:getGLAttName()

			surface.DrawTexturedRectRotated(baseXAMMO - 128, baseYAMMO - 60, 300, 70, 180)

			local reloadProgress = self:getReloadProgress()

			if reloadProgress then
				draw.ShadowText("RELOADING  " .. reloadProgress .. "%", cwhud24, baseXAMMO + 15, baseY - 80, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			else
				if not self.M203Chamber then
					draw.ShadowText(glName .. " EMPTY", cwhud24, baseXAMMO + 15, baseY - 80, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				else
					draw.ShadowText(glName .. " READY", cwhud24, baseXAMMO + 15, baseY - 80, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end

			local curGrenade = CustomizableWeaponry.grenadeTypes.getGrenadeText(self)

			local nadeText

			local nadeSetup = CustomizableWeaponry_KK.ins2.quickGrenade:getAmmo(self)

			local nadeCount = nadeSetup.ammo and self.Owner:GetAmmoCount(nadeSetup.ammo) or 8

			if nadeCount > 0 then
				nadeText = nadeCount .. "x " .. nadeSetup.text .. ", "
			else
				nadeText = ""
			end

			draw.ShadowText(nadeText .. "RESERVE: " .. self.Owner:GetAmmoCount("40MM"), cwhud22, baseXAMMO + 15, baseY - 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

			// draw.ShadowText(self.Owner:GetAmmoCount("40MM") .. "x RESERVE", cwhud22, baseXAMMO + 15, baseY - 60, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

			draw.ShadowText("TYPE" .. curGrenade, cwhud22, baseXAMMO + 15, baseY - 40, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

			return
		end

		surface.DrawTexturedRectRotated(baseXAMMO - 128, baseYAMMO + 30, 300, 90, 180)

		local mag = self:Clip1()
		local ammoCount, magCount, targetColor = self:getReserveAmmoText()

		if not targetColor then
			if ammoCount <= magCap then -- make the reserve text red if we only have 1 mag (or less) in reserve left
				self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, self.HUDColors.deepRed)
			else
				self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, White)
			end
		else
			self.HUD_ReserveTextColor = LerpColor(FT * 10, self.HUD_ReserveTextColor, targetColor)
		end

		local reloadProgress = self:getReloadProgress()

		// if we're reloading or are low on ammo, make the text red
		if reloadProgress or mag <= magCap * 0.25 then
			self.HUD_MagTextColor = LerpColor(FT * 10, self.HUD_MagTextColor, self.HUDColors.red)
		else
			self.HUD_MagTextColor = LerpColor(FT * 10, self.HUD_MagTextColor, White)
		end

		// display either the reload progress or the ammo in mag
		if self.Primary.Ammo != "none" then
			if reloadProgress then
				draw.ShadowText("RELOADING  " .. reloadProgress .. "%", "CW_HUD32", baseXAMMO + 15, baseYAMMO, self.HUD_MagTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			else
				if magCap > 0 or self.KKINS2RCE then
					draw.ShadowText(self.HUD_MagText .. self:getMagCapacity(), "CW_HUD32", baseXAMMO + 15, baseYAMMO, self.HUD_MagTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				else
					draw.ShadowText("Reserve: " .. ammoCount, "CW_HUD32", baseXAMMO + 15, baseYAMMO, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end
		end

		local grenades = self.Owner:GetAmmoCount("Frag Grenades")
		local ammoText = "RESERVE: " .. ammoCount

		local nadeText

		local nadeSetup = CustomizableWeaponry_KK.ins2.quickGrenade:getAmmo(self)

		local nadeCount = nadeSetup.ammo and self.Owner:GetAmmoCount(nadeSetup.ammo) or 8

		// display the amount of frag grenades only if we have some
		if nadeCount > 0 then
			nadeText = nadeCount .. "x " .. nadeSetup.text

			surface.SetFont(cwhud24)

			local textSize = surface.GetTextSize(ammoText)

			if magCap > 0 or self.KKINS2RCE then
				draw.ShadowText(nadeText .. ", ", cwhud20, baseXAMMO - textSize + 15, baseYAMMO + 25, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			else
				draw.ShadowText(nadeText, cwhud20, baseXAMMO + 15, baseYAMMO + 25, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end
		end

		if magCap > 0 or self.KKINS2RCE then
			draw.ShadowText(ammoText, cwhud24, baseXAMMO + 15, baseYAMMO + 25, self.HUD_ReserveTextColor, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			draw.ShadowText(self.FireModeDisplay, cwhud22, baseXAMMO + 15, baseYAMMO + 45, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		// display the firemode section
		if self.BulletDisplay and self.BulletDisplay > 0 and magCap > 0 then
			surface.SetDrawColor(0, 0, 0, 255)
			surface.SetTexture(Bullet)

			surface.SetFont(cwhud24)
			local xSize = surface.GetTextSize(self.FireModeDisplay)

			// draw the shadow of the bullets and the regular bullets in 2 separate loops, to do only (2 SetDrawColor) calls instead of (BulletDisplay * 2 SetDrawColor) calls
			for i = 1, self.BulletDisplay do
				surface.DrawTexturedRect(baseXAMMO - (i - 1) * 20 - xSize, baseYAMMO + 39, 16, 16)
			end

			surface.SetDrawColor(255, 255, 255, 255)

			for i = 1, self.BulletDisplay do
				surface.DrawTexturedRect(baseXAMMO - (i - 1) * 20 - 1 - xSize, baseYAMMO + 38, 16, 16)
			end
		end

		if self.Primary.Ammo != "none" then
			draw.ShadowText(self.Primary.Ammo, cwhud14, baseXAMMO + 15, baseYAMMO + 62, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			-- draw.ShadowText(self.Primary.Ammo .. " (" .. self.Shell .. ")", cwhud14, baseXAMMO + 15, baseYAMMO + 62, White, Black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end
end

local simpleTextColor = Color(255, 210, 0, 255)
local mod = 50

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	if self.SelectIcon then
		surface.SetTexture(self.SelectIcon)

		wide = wide - mod

		x = x + (mod / 2)
		y = y + (mod / 4) + (wide / 8)

		surface.SetDrawColor(255, 255, 255, alpha)

		surface.DrawTexturedRect(x, y, wide, (wide / 2))
	else
		simpleTextColor.a = alpha
		draw.SimpleText(self.IconLetter, self.SelectFont, x + wide / 2, y + tall * 0.2, simpleTextColor, TEXT_ALIGN_CENTER)
	end
end
