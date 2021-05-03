if (CLIENT) then
	netstream.Hook("mutantPoachOpen", function(client, entity, tool)

		--if IsValid(entity) then

			local frame = vgui.Create("ixStalkerFrame")
			frame:SetTitle( "" )
			frame:SetVisible( true )
			--frame:SetDrawOnTop(true)
			frame:SetDraggable( true )
			frame:Center()
			frame:MakePopup()
			frame:SetSize(ScrW()*0.2, ScrH()*0.3)
			frame:SetPos((ScrW()/2)-ScrW()*0.15,(ScrH()/2)-ScrH()*0.2)
			
			local sentence = frame:Add("DLabel")
			sentence:Dock(TOP)
			sentence:SetContentAlignment(8)
			sentence:SetFont("stalkerregularfont")
			sentence:SetText("Poaching using your "..ix.item.instances[tool].name)
			sentence:DockMargin(5, frame:GetTall()*0.02, 5, 0)

			local meme = frame:Add("DLabel")
			meme:Dock(TOP)
			meme:SetContentAlignment(8)
			meme:SetTall(ScrH()*0.05)
			meme:SetText("Select poaching option:")
			meme:DockMargin(5, 5, 5, 0)
			meme:SetFont("stalkerregulartitlefont")
				
			local btn = frame:Add("ixStalkerButton")
			btn:Dock(TOP)
			btn:SetText("Poach")
			btn:DockMargin(btn:GetParent():GetWide()*0.2, 20, btn:GetParent():GetWide()*0.2, 0)
			btn:SetTall(ScrH()*0.05)
			btn:SetFont("stalkerregularfont")

			function btn.DoClick()
				if (CLIENT) and (IsValid(ix.gui.menu)) then
					ix.gui.menu:Remove()
				end
				netstream.Start("doPoach", tool, entity)
				frame:Close()
			end

			frame:PostLayoutUpdate()
		--end
	end)
else

end
