
-- Here is where all of your clientside hooks should go.

netstream.Hook("qurReq", function(time, title, subTitle)
	if (title:sub(1, 1) == "@") then
		title = L(title:sub(2))
	end

	if (subTitle:sub(1, 1) == "@") then
		subTitle = L(subTitle:sub(2))
	end

	Derma_Query(subTitle, title, "Yes", function()
		netstream.Start("qurReq", time, true)
	end, "No", function()
		netstream.Start("qurReq", time, false)
	end)
end)

function Schema:BuildBusinessMenu(panel)
	local bHasItems = false

	for k, _ in pairs(ix.item.list) do
		if (hook.Run("CanPlayerUseBusiness", LocalPlayer(), k) != false) then
			bHasItems = true

			break
		end
	end

	return bHasItems
end