local INSTALL_COOLDOWN = 0.5

function PLUGIN:InstallMapUSB(item)
	local pda = self:GetMapInstallTarget(item)
	if not pda then return false end
	local client = item.player
	if (client.cotzNextMapInstall or 0) > CurTime() then return false end
	client.cotzNextMapInstall = CurTime() + INSTALL_COOLDOWN
	local installed = table.Copy(pda:GetData("cotzMaps", {}))
	installed[item.mapID] = true
	pda:SetData("cotzMaps", installed)
	client:Notify(self.maps[item.mapID].name .. " map installed. Open Maps in your PDA.")

	-- Helix removes the USB only after a successful install; failed actions return false above.
	return true
end
