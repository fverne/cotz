netstream.Hook("ixHideoutMenu", function(entrance, records)
	if IsValid(ix.gui.hideouts) then
		ix.gui.hideouts:Remove()
	end
	local frame, list = ix.cotzUI.Frame("Hideout entrance", 0.6, 0.55, 520)
	ix.gui.hideouts = frame
	if #records == 0 then
		ix.cotzUI.Label(list, "No accessible hideouts at this entrance.")
	end
	ix.cotzUI.Button(list, "Arrange a personal hideout", function()
		ix.plugin.Get("hideouts"):RequestPersonalBarter(nil, entrance)
	end)
	for _, record in ipairs(records) do
		ix.cotzUI.Button(list, "Enter " .. record.name, function()
			netstream.Start("ixHideoutEnter", record.id)
			frame:Remove()
		end)
		if record.manage then
			ix.cotzUI.Button(list, "Manage " .. record.name, function()
				ix.plugin.Get("hideouts"):RequestManagement(record.id, "entrance")
				frame:Remove()
			end)
		end
	end
end)
