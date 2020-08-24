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
			frame:SetSize(ScrW()*0.3, ScrH()*0.4)
			frame:SetPos((ScrW()/2)-ScrW()*0.15,(ScrH()/2)-ScrH()*0.2)
			
			local sentence = frame:Add("DLabel")
			sentence:Dock(TOP)
			sentence:SetContentAlignment(8)
			sentence:SetFont("stalkerregularfont")
			sentence:SetText("Select what you want to poach. Using your "..ix.item.instances[tool].name)
			sentence:DockMargin(5, frame:GetTall()*0.02, 5, 0)

			local meme = frame:Add("DLabel")
			meme:Dock(TOP)
			meme:SetContentAlignment(8)
			meme:SetTall(ScrH()*0.05)
			meme:SetText("Select poaching option:")
			meme:DockMargin(5, 5, 5, 0)
			meme:SetFont("stalkerregulartitlefont")
				
			local btnmeat = frame:Add("ixStalkerButton")
			btnmeat:Dock(TOP)
			btnmeat:SetText("Mostly Meat")
			btnmeat:DockMargin(btnmeat:GetParent():GetWide()*0.3, 20, btnmeat:GetParent():GetWide()*0.3, 0)
			btnmeat:SetTall(ScrH()*0.05)
			btnmeat:SetFont("stalkerregularfont")

			function btnmeat.DoClick()
				if (CLIENT) and (IsValid(ix.gui.menu)) then
					ix.gui.menu:Remove()
				end
				netstream.Start("doPoach", "meat", tool, entity)
				frame:Close()
			end

			local btnmix = frame:Add("ixStalkerButton")
			btnmix:Dock(TOP)
			btnmix:SetText("Mix of Parts and Meat")
			btnmix:DockMargin(btnmix:GetParent():GetWide()*0.3, 20, btnmix:GetParent():GetWide()*0.3, 0)
			btnmix:SetTall(ScrH()*0.05)
			btnmix:SetFont("stalkerregularfont")

			function btnmix.DoClick()
				if (CLIENT) and (IsValid(ix.gui.menu)) then
					ix.gui.menu:Remove()
				end
				netstream.Start("doPoach", "mix", tool, entity)
				frame:Close()
			end

			local btnparts = frame:Add("ixStalkerButton")
			btnparts:Dock(TOP)
			btnparts:SetText("Mostly Parts")
			btnparts:DockMargin(btnparts:GetParent():GetWide()*0.3, 20, btnparts:GetParent():GetWide()*0.3, 0)
			btnparts:SetTall(ScrH()*0.05)
			btnparts:SetFont("stalkerregularfont")

			function btnparts.DoClick()
				if (CLIENT) and (IsValid(ix.gui.menu)) then
					ix.gui.menu:Remove()
				end
				netstream.Start("doPoach", "part", tool, entity)
				frame:Close()
			end

			frame:PostLayoutUpdate()
		--end
	end)
else

end