netstream.Hook("ixHideoutMenu", function(entrance, records)
	if IsValid(ix.gui.hideouts) then
		ix.gui.hideouts:Remove()
	end
	local frame = vgui.Create("DFrame")
	ix.gui.hideouts = frame
	frame:SetTitle("Hideout entrance")
	frame:SetSize(math.min(ScrW() * 0.6, 520), ScrH() * 0.55)
	frame:Center()
	frame:MakePopup()
	local list = frame:Add("DScrollPanel")
	list:Dock(FILL)
	if #records == 0 then
		local label = list:Add("DLabel")
		label:Dock(TOP)
		label:SetTall(40)
		label:SetText("No accessible hideouts at this entrance.")
	end
	for _, record in ipairs(records) do
		local button = list:Add("DButton")
		button:Dock(TOP)
		button:DockMargin(4, 4, 4, 0)
		button:SetTall(40)
		button:SetText("Enter " .. record.name)
		button.DoClick = function()
			netstream.Start("ixHideoutEnter", record.id)
			frame:Remove()
		end
		if record.manage then
			local manage = list:Add("DButton")
			manage:Dock(TOP)
			manage:DockMargin(4, 4, 4, 8)
			manage:SetTall(32)
			manage:SetText("Manage " .. record.name)
			manage.DoClick = function()
				ix.plugin.Get("hideouts"):RequestManagement(record.id, "entrance")
				frame:Remove()
			end
		end
	end
end)
