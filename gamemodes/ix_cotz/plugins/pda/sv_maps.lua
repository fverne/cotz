local INSTALL_COOLDOWN = 0.5

function PLUGIN:InstallMapUSB(item)
	local character = self:GetMapInstallTarget(item)
	if not character then return false end
	local client = item.player
	if (client.cotzNextMapInstall or 0) > CurTime() then return false end
	client.cotzNextMapInstall = CurTime() + INSTALL_COOLDOWN
	local installed = table.Copy(character:GetData("cotzMaps", {}))
	installed[item.mapID] = true
	character:SetData("cotzMaps", installed)
	client:Notify(self.maps[item.mapID].name .. " map added. Open Maps in the main menu.")

	-- Helix removes the USB only after a successful install; failed actions return false above.
	return true
end

-- Preserve maps on legacy PDAs as character unlocks when their owner next loads.
function PLUGIN:PlayerLoadedCharacter(client, character)
	local inventory = character:GetInventory()
	if not inventory then return end
	local installed = table.Copy(character:GetData("cotzMaps", {}))
	local changed = false
	for _, item in pairs(inventory:GetItems(true)) do
		if item.isPDA then
			for id, unlocked in pairs(item:GetData("cotzMaps", {})) do
				if unlocked == true and installed[id] ~= true then
					installed[id] = true
					changed = true
				end
			end
		end
	end
	if changed then character:SetData("cotzMaps", installed) end
end
