local PLUGIN = PLUGIN

local function describe(recipe)
	local lines = {"Assembly: " .. ix.currency.Get(recipe.price), "Common salvage: Swamps / Garbage."}
	for _, group in ipairs(recipe.groups) do
		local names = {}
		for _, itemID in ipairs(group.items) do
			local size = PLUGIN.crateBatchSizes[itemID] or 1
			names[#names + 1] = ix.item.list[itemID].name .. (size > 1 and " x" .. size or "")
		end
		lines[#lines + 1] = group.quantity .. " batches: " .. table.concat(names, " / ") .. " (" .. group.name .. ")"
	end
	lines[#lines + 1] = "Each batch accepts one listed alternative. Keep a free 2×2 space in your main inventory."

	return table.concat(lines, "\n")
end

net.Receive("cotz/hideouts/crates", function()
	local maximum, squadAllowed = net.ReadUInt(4), net.ReadBool()
	if IsValid(ix.gui.hideoutCrates) then ix.gui.hideoutCrates:Remove() end
	local panel, scroll = ix.cotzUI.Frame("Hideout crate barter", 0.8, 0.75, 900)
	ix.gui.hideoutCrates = panel
	ix.cotzUI.Label(scroll, "Choose a storage family. Squad crates require three times the cash and materials.")
	for _, squad in ipairs({false, true}) do
		if squad and not squadAllowed then continue end
		for family, definition in SortedPairs(PLUGIN.personalContainerRecipes) do
			ix.cotzUI.Button(scroll, (squad and "Squad: " or "Personal: ") .. definition.name, function()
				local _, list = ix.cotzUI.Frame(definition.name .. " crates", 0.8, 0.75, 900)
				for level = 1, 12 do
					local recipe = PLUGIN:GetCrateRecipe(family, level, squad)
					local allowed = level <= maximum
					ix.cotzUI.Label(list, "Level " .. level .. (allowed and "" or " — locked"), true)
					ix.cotzUI.Label(list, describe(recipe))
					if allowed then
						ix.cotzUI.Button(list, "Review payment for level " .. level, function()
							if (panel.nextCrateRequest or 0) > CurTime() then return end
							panel.nextCrateRequest = CurTime() + 0.5
							net.Start("cotz/hideouts/crate-quote")
							net.WriteString(family)
							net.WriteUInt(level, 4)
							net.WriteBool(squad)
							net.SendToServer()
						end)
					end
				end
			end)
		end
	end
end)

net.Receive("cotz/hideouts/crate-quote", function()
	local token, family = net.ReadString(), net.ReadString()
	local level, squad = net.ReadUInt(4), net.ReadBool()
	local treasury, playerShare = net.ReadUInt(32), net.ReadUInt(32)
	local recipe = PLUGIN:GetCrateRecipe(family, level, squad)
	if not recipe then return end
	local text = describe(recipe) .. "\n\nSquad treasury: " .. ix.currency.Get(treasury)
		.. "\nYour share: " .. ix.currency.Get(playerShare)
	ix.cotzUI.Query(text, "Assemble " .. (squad and "squad" or "personal") .. " crate — level " .. level,
		"Assemble", function()
			net.Start("cotz/hideouts/crate-buy")
			net.WriteString(token)
			net.SendToServer()
		end, "Cancel")
end)
