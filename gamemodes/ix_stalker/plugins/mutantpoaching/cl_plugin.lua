if (CLIENT) then
	netstream.Hook("mutantPoachOpen", function(client, entity, mutantparts, tool)

		--if IsValid(entity) then

			local frame = vgui.Create("DFrame")
			frame:SetTitle( "Mutant Poaching" )
			frame:SetVisible( true )
			--frame:SetDrawOnTop(true)
			frame:SetDraggable( true )
			frame:ShowCloseButton( true )
			frame:Center()
			frame:MakePopup()
			frame:SetSize(600, 400)
			frame:SetPos((ScrW()/2)-300,(ScrH()/2)-200)
			
			local sentence = frame:Add("DLabel")
			sentence:Dock(TOP)
			sentence:SetContentAlignment(8)
			sentence:SetFont("stalkerregularfont")
			sentence:SetText("Select what you want to poach. Using your "..ix.item.list[tool].name)
			sentence:SetTall(100)
			sentence:DockMargin(5, 5, 5, 0)

			local meme = frame:Add("DLabel")
			meme:Dock(TOP)
			meme:SetContentAlignment(8)
			meme:SetText("Meat")
			meme:DockMargin(5, 5, 5, 0)
			
			for k, v in pairs(mutantparts) do
				PrintTable(mutantparts)
				
				local btn = frame:Add("DButton")
				btn:Dock(TOP)
				btn:SetText(mutantparts[k])
				btn:DockMargin(5, 5, 5, 0)
				btn:SetTall(20)

				function btn.DoClick()
					--local arti = k
				
					--netstream.Start("saleSpecial", arti, true)
					frame:Close()
				end
			end

		--end
	end)
else
	netstream.Hook("doPoach", function(client, parts)
		ix.plugin.list["specialsale"]:sellArtifact(client, artID, isDaily)
	end)
end