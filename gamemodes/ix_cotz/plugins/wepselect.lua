
PLUGIN.name = "Weapon Select"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A reworked nutscript-style weapon select."

if (CLIENT) then
	PLUGIN.index = PLUGIN.index or 1
	PLUGIN.deltaIndex = PLUGIN.deltaIndex or PLUGIN.index
	PLUGIN.infoAlpha = PLUGIN.infoAlpha or 0
	PLUGIN.alpha = PLUGIN.alpha or 0
	PLUGIN.alphaDelta = PLUGIN.alphaDelta or PLUGIN.alpha
	PLUGIN.fadeTime = PLUGIN.fadeTime or 0

	local matrixScale = Vector(1, 1, 0)

	function PLUGIN:LoadFonts(font, genericFont)
		surface.CreateFont("ixWeaponSelectFont", {
			font = font,
			size = ScreenScale(8),
			extended = true,
			weight = 500
		})
	end

	function PLUGIN:HUDShouldDraw(name)
		if (name == "CHudWeaponSelection") then
			return false
		end
	end

	function PLUGIN:HUDPaint()
		local frameTime = FrameTime()

		self.alphaDelta = Lerp(frameTime * 100, self.alphaDelta, self.alpha)

		local fraction = self.alphaDelta

		if (fraction > 0.01) then
			local x, y = ScrW() * 0.5, ScrH() * 0.5
			local spacing = math.pi * 0.85
			local radius = 240 * self.alphaDelta
			local shiftX = ScrW() * .02

			self.deltaIndex = Lerp(frameTime * 12, self.deltaIndex, self.index)

			local weapons, weptbllen = self:GetWeaponTable(LocalPlayer():GetWeapons())
			local index = self.deltaIndex

			if self.index > weptbllen then
				self.index = 1
			end

			for i = 1, weptbllen do
				local theta = (i - index) * 0.1
				local color = ColorAlpha(
					i == self.index and ix.config.Get("color") or color_white,
					255
				)

				local lastY = 0

				if (self.markup and (i < self.index or i == 1)) then
					if (self.index != 1) then
						local _, h = self.markup:Size()
						lastY = h * fraction
					end

					if (i == 1 or i == self.index - 1) then
						self.infoAlpha = Lerp(frameTime * 3, self.infoAlpha, 255)
						self.markup:Draw(x + 6 + shiftX, y + 30, 0, 0, self.infoAlpha * fraction)
					end
				end

				surface.SetFont("stalkerregulartitlefont")
				local weaponName = weapons[i] and weapons[i]:GetPrintName():utf8upper() or "NONE"
				if (weaponName[1] == "#") then weaponName = string.upper(language.GetPhrase(weaponName)) end
				weaponName = "["..i.."] "..weaponName
				local tx, ty = surface.GetTextSize(weaponName)
				local scale = 1 - math.abs(theta * 2)

				local selectedOffset = i == self.index and 15 or 5

				ix.util.DrawText(weaponName, /*ScrW() - (tx) - 10 - +*/ selectedOffset, ScrH()/3 + (ty * 1.5 * i), color, 0, 1, "ixWeaponSelectFont")

			end

			if (self.fadeTime < CurTime() and self.alpha > 0) then
				self.alpha = 0
			end
		end
	end

	function PLUGIN:OnIndexChanged(weapon)
		self.alpha = 1
		self.fadeTime = CurTime() + 5
		self.markup = nil

		local source, pitch = hook.Run("WeaponCycleSound")
		LocalPlayer():EmitSound(source or "common/talk.wav", 50, pitch or 180)
	end


	function PLUGIN:PlayerBindPress(client, bind, pressed)
		bind = bind:lower()

		if (!pressed or !bind:find("invprev") and !bind:find("invnext")
			and !bind:find("slot") and !bind:find("attack")) then
			return
		end

		local currentWeapon = client:GetActiveWeapon()
		local bValid = IsValid(currentWeapon)
		local bTool

		if (client:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and client:KeyDown(IN_ATTACK))) then
			return
		end

		if (bValid and currentWeapon:GetClass() == "gmod_tool") then
			local tool = client:GetTool()
			bTool = tool and (tool.Scroll != nil)
		end

		local weapons, weptbllen = self:GetWeaponTable(client:GetWeapons())

		if (bind:find("invnext") and !bTool) then
			local oldIndex = self.index
			self.index = math.min(self.index + 1, weptbllen)

			if (self.alpha == 0 or oldIndex != self.index) then
				self:OnIndexChanged(weapons[self.index])
			end

			return true
		elseif (bind:find("invprev") and !bTool) then
			local oldIndex = self.index
			self.index = math.max(self.index - 1, 1)

			if (self.alpha == 0 or oldIndex != self.index) then
				self:OnIndexChanged(weapons[self.index])
			end

			return true
		elseif (bind:find("slot")) then
			self.index = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, weptbllen)
			self:OnIndexChanged(weapons[self.index])

			return true
		elseif (bind:find("attack") and self.alpha > 0) then
			local weapon = weapons[self.index]

			if (IsValid(weapon)) then
				LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", weapon) or "stalkersound/inv_ruck.mp3", 75, 100, 0.5)
				input.SelectWeapon(weapon)
			else
				if(IsValid(weapons[3])) then
					LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", weapon) or "stalkersound/inv_ruck.mp3", 75, 100, 0.5)
					input.SelectWeapon(weapons[3])
				end
			end

			self.alpha = 0

			return true
		elseif (bind:find("attack") and !(self.alpha > 0)) then --If M1/M2 is pressed but wepselection isn't active; then we want to raise our weapon!
			if (client:Alive() and !client:IsWepRaised() and client:GetActiveWeapon():GetClass() != "ix_hands") then
				net.Start("ixRequestWeaponRaise")
				net.SendToServer()
			end
		end
	end


	function PLUGIN:Think()
		local client = LocalPlayer()
		if (!IsValid(client) or !client:Alive()) then
			self.alpha = 0
		end
	end

	function PLUGIN:ScoreboardShow()
		self.alpha = 0
	end

	function PLUGIN:ShouldPopulateEntityInfo(entity)
		if (self.alpha > 0) then
			return false
		end
	end

	function PLUGIN:GetWeaponTable(weapontable)
		local weapons = {}

		local KNIFESLOT = 1
		local SECONDARYSLOT = 2
		local PRIMARYSLOT = 3
		local MISCSLOT = 4

		local extraslot = 5

		for i = 1, #weapontable do
			if (weapontable[i].Slot == PRIMARYSLOT) then
				weapons[1] = weapontable[i]
			elseif (weapontable[i].Slot == SECONDARYSLOT) then
				weapons[2] = weapontable[i]
			elseif (weapontable[i].Slot == KNIFESLOT or weapontable[i]:GetClass() == "ix_hands") then
				weapons[3] = weapontable[i]
			elseif (weapontable[i].Slot == MISCSLOT) then
				weapons[4] = weapontable[i]
			else
				weapons[extraslot] = weapontable[i]
				extraslot = extraslot + 1
			end
		end

		return weapons, extraslot-1
	end
end

if(SERVER)then
	util.AddNetworkString("ixRequestWeaponRaise")
	net.Receive("ixRequestWeaponRaise", function(len, client)
		if (!client:IsRestricted()) then
			client:SetWepRaised(true)
			timer.Simple(0.25, function()
				if (IsValid(client)) then
					client:SetNetVar("canShoot", true)
				end
			end)
		end
	end)
end
