local originalSync = ix.meta.character.Sync

-- SetData's noReplication argument only suppresses updates, not Helix's initial character sync.
-- Vendor history and admin economy counters stay server-side; their UIs receive filtered snapshots.
function ix.meta.character:Sync(receiver)
	if receiver ~= self.player then
		return originalSync(self, receiver)
	end

	local data = {}

	for key, value in pairs(self.vars) do
		local definition = ix.char.vars[key]

		if definition and not definition.bNoNetworking then
			data[key] = value
		end
	end

	if data.data then
		local characterData = {}

		for key, value in pairs(data.data) do
			if key ~= "vendorStock" and key ~= "vendorRestockClaims" and key ~= "economyStats" then
				characterData[key] = value
			end
		end

		data.data = characterData
	end

	ix.characterNetwork.SendInfo(self, data, receiver)
end
