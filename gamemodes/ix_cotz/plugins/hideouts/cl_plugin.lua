local UI = ix.cotzUI

netstream.Hook("ixHideoutMenu", function(entrance, records)
	if IsValid(ix.gui.hideouts) then
		ix.gui.hideouts:Remove()
	end
	local frame, list = UI.Frame("Hideout entrance", 0.6, 0.55, 520)
	ix.gui.hideouts = frame
	if #records == 0 then
		UI.Label(list, "No accessible hideouts at this entrance.")
	end
	for _, record in ipairs(records) do
		UI.Button(list, "Enter " .. record.name, function()
			netstream.Start("ixHideoutEnter", record.id)
			frame:Remove()
		end)
		if record.manage then
			UI.Button(list, "Manage " .. record.name, function()
				ix.plugin.Get("hideouts"):RequestManagement(record.id, "entrance")
				frame:Remove()
			end)
		end
	end
end)
