netstream.Hook("ixHideoutMenu", function(entrance, records)
	if IsValid(ix.gui.hideouts) then
		ix.gui.hideouts:Remove()
	end
	local frame = vgui.Create("DFrame")
	ix.gui.hideouts = frame
	frame:SetTitle("Your hideouts")
	frame:SetSize(380, 360)
	frame:Center()
	frame:MakePopup()
	local list = frame:Add("DScrollPanel")
	list:Dock(FILL)
	if #records == 0 then
		local label = list:Add("DLabel")
		label:Dock(TOP)
		label:SetTall(40)
		label:SetText("You have no hideouts at this entrance.")
	end
	for _, record in ipairs(records) do
		local button = list:Add("DButton")
		button:Dock(TOP)
		button:DockMargin(4, 4, 4, 0)
		button:SetTall(40)
		button:SetText(record.name .. " (#" .. record.id .. ")")
		button.DoClick = function()
			netstream.Start("ixHideoutEnter", record.id)
			frame:Remove()
		end
	end
end)
