local PANEL = {}

function PANEL:Init(uniqueID)
	local name

	self:SetSize(ScrW() * 0.165, ScrH() * 0.47)
	self:MakePopup()
	self:Center()
	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetDraggable(false)

	self.cincar = self:Add("DButton")
	self.cincar:SetSize( ScrW() * 0.145, ScrH() * 0.04)
	self.cincar:SetPos(ScrW() * 0.01, ScrH() * 0.107)
	self.cincar:SetText("")
	self.cincar:SetFont("Roh20")
	self.cincar:SetTextColor(Color(255, 255, 255, 210)) 
	self.cincar.DoClick = function(client)
		netstream.Start("StopCarRadioPlz")
	end

	self.cincar.icon = self.cincar:Add("SpawnIcon")
	self.cincar.icon:SetPos(2, 2)
	self.cincar.icon:SetSize(32, 32)
	self.cincar.icon:SetModel("models/kek1ch/cassette_red1.mdl")

	--[[if LocalPlayer():GetVehicle().CurCassette then
		name = nut.item.list[LocalPlayer():GetVehicle().CurCassette].name
		self.cincar.icon:SetModel(nut.item.list[LocalPlayer():GetVehicle().CurCassette].model, nut.item.list[LocalPlayer():GetVehicle().CurCassette].skin or 0)
	end]]

	function self.cincar:Paint(w,h)
		if self:IsDown() then 
			if not name then
				surface.SetDrawColor( Color(255, 255, 255, 220) )
				surface.SetMaterial( Material("daui/locked_button.png") )
				surface.DrawTexturedRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 176, 46, 40))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 178, 34, 34, 45))
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(Color( 255, 176, 46, 40))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 178, 34, 34, 45))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		elseif self:IsHovered() then 
			if not name then
				surface.SetDrawColor( Color(255, 255, 255, 220) )
				surface.SetMaterial( Material("daui/locked_button.png") )
				surface.DrawTexturedRect(0, 0, w, h)

				surface.SetDrawColor(Color( 178, 34, 34, 20))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 176, 46, 25))
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(Color( 178, 34, 34, 20))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 255, 176, 46, 25))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		else
			if not name then
				surface.SetDrawColor( Color(255, 255, 255, 220) )
				surface.SetMaterial( Material("daui/locked_button.png") )
				surface.DrawTexturedRect(0, 0, w, h)

				surface.SetDrawColor(Color( 30, 30, 30, 200))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(Color( 30, 30, 30, 200))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color( 0, 0, 0, 235))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		draw.DrawText(name or "Ничего не вставлено", "Dma6", ScrW() * 0.03, ScrH() * 0.011, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
	end

	self.cscroll = self:Add("DScrollPanel")
	self.cscroll:SetPos(ScrW() * 0.01, ScrH() * 0.178)
	self.cscroll:SetSize(ScrW() * 0.145, ScrH() * 0.24)
	self.cscroll:SetDrawBackground(false)

	local sbar = self.cscroll:GetVBar()
	function sbar:Paint( w, h )
		surface.SetDrawColor(Color( 30, 30, 30, 200))
		surface.DrawRect(0, 0, w, h)
		end
	function sbar.btnUp:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetDrawColor(Color( 0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	function sbar.btnGrip:Paint( w, h )
		surface.SetDrawColor(Color( 60, 60, 60, 200))
		surface.DrawRect(0, 0, w, h)
	end

	for k,v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		if v.category == "Кассета" then 
			local item = self.cscroll:Add("DButton")
			item:Dock(TOP)
			item:SetTall(ScrH() * 0.04)
			item:DockMargin(3, 3, 3, 0)
			item:SetText("")
			item:SetFont("Roh20")
			item:SetTextColor(Color(255, 255, 255, 210)) 
			item:SetZPos(999)
			item.DoClick = function(client)
				netstream.Start("StartPlayMusicCar", v.uniqueID)

				self.cincar.icon:SetModel(v.model, v.skin or 0)
				name = v.name
			end

			item.icon = item:Add("SpawnIcon")
			item.icon:SetPos(2, 2)
			item.icon:SetSize(32, 32)
			item.icon:SetModel(v.model, v.skin or 0)

			function item:Paint(w,h)
				if item:IsDown() then 
					surface.SetDrawColor(Color( 255, 176, 46, 40))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color( 255, 176, 46, 45))
					surface.DrawOutlinedRect(0, 0, w, h)
				elseif item:IsHovered() then 
					surface.SetDrawColor(Color( 255, 176, 46, 20))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color( 255, 176, 46, 25))
					surface.DrawOutlinedRect(0, 0, w, h)
				else
					surface.SetDrawColor(Color( 30, 30, 30, 200))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(Color( 0, 0, 0, 235))
					surface.DrawOutlinedRect(0, 0, w, h)
				end
				draw.DrawText(v.name, "Dma6", ScrW() * 0.03, ScrH() * 0.011, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT )
			end
		end
	end

	self.exit = self:Add("DButton")
	self.exit:SetPos(ScrW() * 0.027, ScrH() * 0.432)
	self.exit:SetSize(ScrW() * 0.11, ScrH() * 0.0335)
	self.exit:SetText("Выход")
	self.exit:SetFont("Roh20")
	self.exit:SetTextColor(Color(211, 211, 211)) 

	function self.exit:Paint( w, h )
		if self:IsDown() then 
			surface.SetDrawColor(Color( 255, 176, 46, 40))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 45))
			surface.DrawOutlinedRect(0, 0, w, h)
		elseif self:IsHovered() then 
			surface.SetDrawColor(Color( 255, 176, 46, 20))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color( 255, 176, 46, 25))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end

	self.exit.DoClick = function(client)
		self:Close()
		name = nil
		collectgarbage()
	end
end

function PANEL:Paint( w, h )
	ix.util.DrawBlur(self, 10)
	surface.SetDrawColor(Color( 30, 30, 30, 205))
	surface.DrawRect( 0, 0, w, h )
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 14, 150)
	surface.DrawRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033)

	surface.SetDrawColor(Color( 30, 30, 30, 50))
	surface.DrawOutlinedRect(ScrW() * 0, ScrH() * 0, ScrW() * 0.41, ScrH() * 0.033) --шапка

	draw.DrawText("Радио", "Roh20", ScrW() * 0.005, ScrH() * 0.003, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

	surface.SetDrawColor(Color( 138, 149, 151, 60))
	surface.DrawLine(ScrW() * 0.02, ScrH() * 0.0325, ScrW() * 0.14, ScrH() * 0.0325)

	surface.SetDrawColor(Color( 0, 33, 55, 160))
	surface.DrawRect(ScrW() * 0.009, ScrH() * 0.057, ScrW() * 0.148, ScrH() * 0.024) --верхняя панель крафта

	surface.SetDrawColor(Color( 0, 0, 0, 200))
	surface.DrawRect(ScrW() * 0.009, ScrH() * 0.08, ScrW() * 0.148, ScrH() * 0.345) --основная панель крафта 145

	draw.DrawText("Список кассет", "Roh20", ScrW() * 0.015, ScrH() * 0.055, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

	surface.SetDrawColor(Color( 0, 0, 0, 235))
	surface.DrawOutlinedRect(ScrW() * 0.009, ScrH() * 0.057, ScrW() * 0.148, ScrH() * 0.369) --основная обводка крафта

	surface.SetDrawColor(Color( 75, 75, 75, 95))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.082, ScrW() * 0.145, ScrH() * 0.025) --сортировка списка (слот кассеты в машине)

	draw.DrawText("Кассета в плеере", "Roh20", ScrW() * 0.015, ScrH() * 0.081, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

	surface.SetDrawColor(Color( 75, 75, 75, 95))
	surface.DrawRect(ScrW() * 0.01, ScrH() * 0.1485, ScrW() * 0.145, ScrH() * 0.025) --сортировка списка (у игрока)

	draw.DrawText("Кассеты игрока", "Roh20", ScrW() * 0.015, ScrH() * 0.146, Color(255, 255, 255, 210), TEXT_ALIGN_LEFT ) --надпись шапки

	surface.SetDrawColor( Color(125, 105, 0, 100) )
	surface.SetMaterial( Material("lgh/circle_gradient.png") )
	surface.DrawTexturedRectUV( -ScrW() * 0.05, ScrH() * 0.45, ScrW() * 0.3, ScrH() * 0.032, 1, 0.9, 0, 0.3 )
end


vgui.Register("RadioCar", PANEL, "DFrame")
netstream.Hook("RadioCar", function()
	RadioCar = vgui.Create("RadioCar")
end)
