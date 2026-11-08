local openFrame

net.Receive("cotz/townnpcs/preview", function()
	local npc = net.ReadEntity()
	if not IsValid(npc) or npc:GetClass() ~= "ix_townnpc_preview" then return end
	if IsValid(openFrame) then openFrame:Remove() end
	local sequences = {}
	-- GetSequenceList is zero-indexed; ipairs would omit the first animation.
	for index, name in pairs(npc:GetSequenceList()) do
		sequences[#sequences + 1] = {index = index, name = name}
	end
	table.sort(sequences, function(first, second) return first.name < second.name end)
	local frame, body = ix.cotzUI.Frame("Town NPC animations", 0.38, 0.7, 640)
	openFrame = frame
	local function placeWindow()
		frame:SetPos(ScrW() - frame:GetWide() - ix.cotzUI.Scale(12), (ScrH() - frame:GetTall()) / 2)
	end
	placeWindow()
	local current = ix.cotzUI.Label(frame, "")
	local search = ix.cotzUI.StyleEntry(frame:Add("DTextEntry"))
	search:Dock(TOP)
	ix.cotzUI.SetHeight(search, 34)
	search:SetPlaceholderText("Search model sequences...")
	search:SetUpdateOnType(true)
	local filtered = {}
	local function selectSequence(entry)
		if not entry or not IsValid(npc) or (frame.nextChange or 0) > CurTime() then return end
		frame.nextChange = CurTime() + 0.15
		net.Start("cotz/townnpcs/preview-sequence")
		net.WriteEntity(npc)
		net.WriteString(entry.name)
		net.SendToServer()
	end
	local function step(direction)
		if not IsValid(npc) or #filtered == 0 then return end
		local selected = direction > 0 and 0 or 1
		for index, entry in ipairs(filtered) do
			if entry.name == npc:GetTownSpawnAnim() then selected = index break end
		end
		selectSequence(filtered[(selected - 1 + direction) % #filtered + 1])
	end
	local previous = ix.cotzUI.Button(frame, "Previous sequence", function() step(-1) end)
	previous:Dock(BOTTOM)
	local nextSequence = ix.cotzUI.Button(frame, "Next sequence", function() step(1) end)
	nextSequence:Dock(BOTTOM)
	local function refresh()
		body:Clear()
		filtered = {}
		local query = search:GetValue():lower()
		for _, entry in ipairs(sequences) do
			if entry.name:lower():find(query, 1, true) then filtered[#filtered + 1] = entry end
		end
		for _, entry in ipairs(filtered) do
			ix.cotzUI.Button(body, entry.name, function() selectSequence(entry) end)
		end
		if #filtered == 0 then ix.cotzUI.Label(body, "No matching sequences.") end
	end
	search.OnValueChange = refresh
	local think = frame.Think
	function frame:Think()
		local resized = self.screenWidth ~= ScrW() or self.screenHeight ~= ScrH()
		think(self)
		if not IsValid(npc) then self:Close() return end
		if resized then placeWindow() end
		local animation = npc:GetTownSpawnAnim()
		if self.animation ~= animation then
			self.animation = animation
			current:SetText("Playing: " .. animation)
		end
	end
	refresh()
end)
