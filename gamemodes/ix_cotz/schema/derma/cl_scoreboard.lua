local rowPaintFunctions = {
	function(width, height)
	end,

	function(width, height)
		surface.SetDrawColor(30, 30, 30, 25)
		surface.DrawRect(0, 0, width, height)
	end
}

-- character icon
-- we can't customize the rendering of ModelImage so we have to do it ourselves
local PANEL = {}
local BODYGROUPS_EMPTY = "000000000"

AccessorFunc(PANEL, "model", "Model", FORCE_STRING)
AccessorFunc(PANEL, "bHidden", "Hidden", FORCE_BOOL)

function PANEL:Init()
	self:SetSize(96, 64)
	self.bodygroups = BODYGROUPS_EMPTY
end

function PANEL:SetModel(model, skin, bodygroups)
	model = model:gsub("\\", "/")

	if (isstring(bodygroups)) then
		if (bodygroups:len() == 9) then
			for i = 1, bodygroups:len() do
				self:SetBodygroup(i, tonumber(bodygroups[i]) or 0)
			end
		else
			self.bodygroups = BODYGROUPS_EMPTY
		end
	end

	self.model = model
	self.skin = skin
	self.path = "materials/spawnicons/" ..
		model:sub(1, #model - 4) .. -- remove extension
		((isnumber(skin) and skin > 0) and ("_skin" .. tostring(skin)) or "") .. -- skin number
		(self.bodygroups != BODYGROUPS_EMPTY and ("_" .. self.bodygroups) or "") .. -- bodygroups
		".png"

	local material = Material(self.path, "smooth")

	-- we don't have a cached spawnicon texture, so we need to forcefully generate one
	if (material:IsError()) then
		self.id = "ixScoreboardIcon" .. self.path
		self.renderer = self:Add("ModelImage")
		self.renderer:SetVisible(false)
		self.renderer:SetModel(model, skin, self.bodygroups)
		self.renderer:RebuildSpawnIcon()

		-- this is the only way to get a callback for generated spawn icons, it's bad but it's only done once
		hook.Add("SpawniconGenerated", self.id, function(lastModel, filePath, modelsLeft)
			filePath = filePath:gsub("\\", "/"):lower()

			if (filePath == self.path) then
				hook.Remove("SpawniconGenerated", self.id)

				self.material = Material(filePath, "smooth")
				self.renderer:Remove()
			end
		end)
	else
		self.material = material
	end
end

function PANEL:SetBodygroup(k, v)
	if (k < 0 or k > 8 or v < 0 or v > 9) then
		return
	end

	self.bodygroups = self.bodygroups:SetChar(k + 1, v)
end

function PANEL:GetModel()
	return self.model or "models/error.mdl"
end

function PANEL:GetSkin()
	return self.skin or 1
end

function PANEL:DoClick()
end

function PANEL:DoRightClick()
end

function PANEL:OnMouseReleased(key)
	if (key == MOUSE_LEFT) then
		self:DoClick()
	elseif (key == MOUSE_RIGHT) then
		self:DoRightClick()
	end
end

function PANEL:Paint(width, height)
	if (!self.material) then
		return
	end

	surface.SetMaterial(self.material)
	surface.SetDrawColor(self.bHidden and color_black or color_white)
	surface.DrawTexturedRect(0, 0, width, height)
end

function PANEL:Remove()
	if (self.id) then
		hook.Remove("SpawniconGenerated", self.id)
	end
end

vgui.Register("ixScoreboardIcon", PANEL, "Panel")

-- player row
PANEL = {}

AccessorFunc(PANEL, "paintFunction", "BackgroundPaintFunction")

function PANEL:Init()
	self:SetTall(80)

	self.icon = self:Add("ixScoreboardIcon")
	self.icon:SetWide(120)
	self.icon:Dock(LEFT)
	self.icon.DoRightClick = function()
		local client = self.player

		if (!IsValid(client)) then
			return
		end

		local menu = DermaMenu()

		menu:AddOption(L("viewProfile"), function()
			client:ShowProfile()
		end)

		menu:AddOption(L("copySteamID"), function()
			SetClipboardText(client:IsBot() and client:EntIndex() or client:SteamID())
		end)

		hook.Run("PopulateScoreboardPlayerMenu", client, menu)
		menu:Open()
	end

	self.icon:SetHelixTooltip(function(tooltip)
		local client = self.player

		if (IsValid(self) and IsValid(client)) then
			ix.hud.PopulatePlayerTooltip(tooltip, client)
		end
	end)

	self.icon.Paint = function(this, w, h)
		if (not self.avatar) then return end
		surface.SetMaterial(self.avatar)
		surface.SetDrawColor(255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.name = self:Add("DLabel")
	self.name:DockMargin(4, 1, 0, 0)
	self.name:Dock(TOP)
	self.name:SetTextColor(color_white)
	self.name:SetFont("stalkerregularfont2")

if ix.config.Get("allowVoice") then
	self.mute = self:Add("DImageButton")
	self.mute:DockMargin(5, 0, 0, 0)
	self.mute:Dock(RIGHT)
end

	self.rep = self:Add("DLabel")
	self.rep:DockMargin(5, 0, 0, 0)
	self.rep:Dock(TOP)
	self.rep:SetTextColor(Color(138, 43, 226))
	self.rep:SetFont("stalkerregularinvfont")

	self.description = self:Add("DLabel")
	self.description:DockMargin(5, 0, 0, 0)
	self.description:Dock(TOP)
	self.description:SetTextColor(color_white)
	self.description:SetFont("stalkerregularinvfont")

	self.status = self:Add("DLabel")
	self.status:DockMargin(5, 0, 0, 0)
	self.status:Dock(TOP)
	self.status:SetTextColor(color_white)
	self.status:SetFont("stalkerregularinvfont")

	self.paintFunction = rowPaintFunctions[1]
	self.nextThink = CurTime() + 1
end

function PANEL:Update()
	local record = self.record
	if (record) then
		local avatar = record.pdaavatar or "vgui/icons/face_31.png"
		if (self.avatarPath ~= avatar) then
			self.avatarPath = avatar
			self.avatar = Material(avatar, "smooth")
		end
		self.status:SetText(ix.crossserver.GetPresenceText(record, record.fresh, IsValid(self.player)))
		self.status:SetTextColor(ix.crossserver.GetPresenceColor(record, record.fresh, IsValid(self.player)))
		self.status:SizeToContents()
		if (IsValid(self.mute)) then self.mute:SetVisible(IsValid(self.player) and self.player ~= LocalPlayer()) end
		if (not IsValid(self.player)) then
			self.name:SetText(record.name)
			self.name:SizeToContents()
			self.rep:SetText("")
			self.rep:SizeToContents()
			self.description:SetText("")
			self.description:SizeToContents()
			return
		end
	end
	local client = self.player
	local model = client:GetModel()
	local skin = client:GetSkin()
	local name = client:GetName()
	local rep = client:getCurrentRankName()
	local description = hook.Run("GetCharacterDescription", client) or
		(client:GetCharacter() and client:GetCharacter():GetDescription()) or ""

	local reputation = client:getReputation()

	local bRecognize = false
	local localCharacter = LocalPlayer():GetCharacter()
	local character = IsValid(self.player) and self.player:GetCharacter()

	if (localCharacter and character) then
		bRecognize = hook.Run("IsCharacterRecognized", localCharacter, character:GetID())
			or hook.Run("IsPlayerRecognized", self.player)
	end

	self.icon:SetHidden(!bRecognize)

	-- no easy way to check bodygroups so we'll just set them anyway
	for _, v in pairs(client:GetBodyGroups()) do
		self.icon:SetBodygroup(v.id, client:GetBodygroup(v.id))
	end

	if (self.icon:GetModel() != model or self.icon:GetSkin() != skin) then
		self.icon:SetModel(model, skin)
		self.icon:SetTooltip(nil)
	end

	if (self.name:GetText() != name) then
		self.name:SetText(name)
		self.name:SizeToContents()
	end

    if (client != LocalPlayer() and IsValid(self.mute)) then
        if (client:IsMuted()) then
            self.mute:SetImage("icon32/muted.png")
            --  self.mute:SizeToContents()
            self.mute:SetSize(30, 1)

            self.mute.DoClick = function()
                client:SetMuted(false)
            end
        else
            self.mute:SetImage("icon32/unmuted.png")
            self.mute:SetSize(30, 1)

            self.mute.DoClick = function()
                client:SetMuted(true)
            end
        end
    end

	if (self.rep:GetText() != rep) then
		self.rep:SetText(rep)
		self.rep:SizeToContents()
	end

	--if (self.description:GetText() != description) then
	--	self.description:SetText(description)
	--	self.description:SizeToContents()
	--end

	if (self.description:GetText() != "Reputation: "..reputation) then
		self.description:SetText("Reputation: "..reputation)
		self.description:SizeToContents()
	end
end

function PANEL:SetRecord(record)
	self.record = record
	self.player = record.player
	self.character = IsValid(self.player) and self.player:GetCharacter() or nil
	self:Update()
end

function PANEL:SetPlayer(client)
	self.player = client
	self.team = client:Team()
	self.character = client:GetCharacter()

	self:Update()
end

function PANEL:Paint(width, height)
	self.paintFunction(width, height)
end

vgui.Register("ixScoreboardRow", PANEL, "EditablePanel")

local COLORS = {
	card = Color(12, 13, 12, 215), border = Color(93, 94, 86, 180),
	text = Color(216, 215, 201), muted = Color(116, 119, 107), teal = Color(73, 140, 143),
	rank = Color(138, 43, 226), green = Color(105, 139, 87),
	amber = Color(167, 143, 81), red = Color(184, 108, 92),
}
local FIELD_COLORS = {
	rank = COLORS.rank, reputation = COLORS.rank, location = COLORS.teal,
	favoriteContact = COLORS.amber, taskEarnings = COLORS.amber,
	mutantsKilled = COLORS.red, humansKilled = COLORS.red, rareMutantsKilled = COLORS.red,
	speciesKilled = COLORS.amber, tasksCompleted = COLORS.green, hardTasks = COLORS.green,
	researchOperations = COLORS.teal, recoveryOperations = COLORS.teal,
}
local PANEL = {}

local function rankName(record)
	if record.networkRanking == false then return "RANK LOCKED" end
	if IsValid(record.player) then return record.player:getCurrentRankName() end
	local plugin = ix.plugin.Get("karmarep")
	local name = "Tourist"
	for _, rank in ipairs(plugin and plugin.repDefs or {}) do
		if (record.profile.reputation or 0) >= rank[2] then name = rank[1] end
	end

	return name
end

local function paintCard(panel, width, height)
	surface.SetDrawColor(COLORS.card)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(panel.leaderboardInteractive and panel:IsHovered() and COLORS.teal or COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
end

local DOSSIER_FIELDS = {
	{"rank", "STALKER RANK"}, {"reputation", "REPUTATION"}, {"squad", "SQUAD"},
	{"location", "LOCATION"}, {"favoriteContact", "FAVORITE CONTACT"},
	{"mutantsPoached", "MUTANTS POACHED"}, {"mutantsKilled", "MUTANTS KILLED"}, {"humansKilled", "HUMANS KILLED"},
	{"rareMutantsKilled", "RARE MUTANTS KILLED"}, {"speciesKilled", "SPECIES KILLED"},
	{"tasksCompleted", "TASKS COMPLETED"}, {"hardTasks", "HARD TASKS"},
	{"researchOperations", "RESEARCH OPERATIONS"}, {"recoveryOperations", "RECOVERY OPERATIONS"},
	{"taskEarnings", "TASK EARNINGS"},
}

local function dossierLabel(parent, text, font, color)
	local label = parent:Add("DLabel")
	label:Dock(TOP)
	label:SetFont(font)
	label:SetTextColor(color)
	label:SetText(text)
	label:SetWrap(true)
	label:SetAutoStretchVertical(true)

	return label
end

function PANEL:Init()
	if IsValid(ix.gui.scoreboard) then ix.gui.scoreboard:Remove() end
	ix.gui.scoreboard = self
	self:Dock(FILL)
	self.controls = self:Add("DPanel")
	self.controls:Dock(TOP)
	self.controls:SetTall(36)
	self.controls.Paint = paintCard
	self.search = self.controls:Add("DTextEntry")
	self.search:Dock(FILL)
	self.search:SetPlaceholderText("Search stalker or squad")
	self.search:DockMargin(0, 0, 8, 0)
	self.search.Paint = function(entry, width, height)
		paintCard(entry, width, height)
		if entry:HasFocus() then
			surface.SetDrawColor(COLORS.teal)
			surface.DrawOutlinedRect(0, 0, width, height)
		end
		if entry:GetText() == "" and not entry:HasFocus() then
			draw.SimpleText(entry:GetPlaceholderText(), "cotzLeaderboard", 10, height / 2,
				COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		else
			entry:DrawTextEntryText(COLORS.text, COLORS.teal, COLORS.text)
		end
	end
	self.localOnly = false
	self.area = self.controls:Add("DButton")
	self.area:Dock(RIGHT)
	self.area:SetWide(140)
	self.area:SetText("All maps")
	self.area.DoClick = function(button)
		self.localOnly = not self.localOnly
		button:SetText(self.localOnly and "Local area" or "All maps")
	end
	self.squad = self.controls:Add("DButton")
	self.squad:Dock(RIGHT)
	self.squad:SetWide(140)
	self.squad:SetText("My squad: OFF")
	self.squad.DoClick = function(button)
		self.squadOnly = not self.squadOnly
		button:SetText(self.squadOnly and "My squad: ON" or "My squad: OFF")
	end
	for _, button in ipairs({self.area, self.squad}) do
		button.leaderboardInteractive = true
		button:DockMargin(4, 0, 0, 0)
		button:SetTextColor(COLORS.text)
		button.Paint = function(control, width, height)
			paintCard(control, width, height)
			local active = control == self.area and self.localOnly or control == self.squad and self.squadOnly
			if active then
				surface.SetDrawColor(COLORS.teal)
				surface.DrawRect(0, height - 2, width, 2)
			end
		end
	end
	self.dossier = self:Add("DPanel")
	self.dossier:Dock(RIGHT)
	self.dossier:DockMargin(12, 12, 0, 0)
	self.dossier.Paint = paintCard
	self.detailScroll = self.dossier:Add("DScrollPanel")
	self.detailScroll:Dock(FILL)
	self.detailScroll:DockMargin(16, 16, 16, 16)
	self.portrait = self.detailScroll:Add("DImage")
	self.portrait:Dock(TOP)
	self.portrait:DockMargin(0, 0, 0, 12)
	self.portrait:SetTall(96)
	self.portrait:SetKeepAspect(true)
	self.details = dossierLabel(self.detailScroll, "Select a stalker", "ixMediumFont", COLORS.text)
	self.details:DockMargin(0, 0, 0, 16)
	self.dossierFields = {}
	for _, definition in ipairs(DOSSIER_FIELDS) do
		local card = self.detailScroll:Add("DPanel")
		card:Dock(TOP)
		card:DockMargin(0, 0, 0, 8)
		card:DockPadding(10, 8, 10, 8)
		card.Paint = paintCard
		local caption = dossierLabel(card, definition[2], "ixSmallFont", COLORS.muted)
		caption:DockMargin(0, 0, 0, 4)
		local value = dossierLabel(card, "—", "ixMediumFont", COLORS.text)
		card.PerformLayout = function(panel)
			panel:SetTall(caption:GetTall() + value:GetTall() + 20)
		end
		self.dossierFields[definition[1]] = {caption = caption, value = value, card = card}
	end
	self.dossierNote = dossierLabel(self.detailScroll,
		"Recorded encounters and completed work.",
		"ixSmallFont", COLORS.muted)
	self.list = self:Add("DScrollPanel")
	self.list:Dock(FILL)
	self.list:DockMargin(0, 12, 0, 0)
	self.rows = {}
end

function PANEL:SelectRecord(record)
	self.selected = record.characterID
	self.portrait:SetImage(record.pdaavatar or "vgui/icons/face_31.png")
	local stats = record.profile.leaderboardStats or {}
	local access = table.Copy(self.networkAccess or {})
	local character = LocalPlayer():GetCharacter()
	local ownRecord = character and record.characterID == character:GetID()
	if ownRecord then
		access.dossier, access.activity, access.ranking, access.location = true, true, true, true
	end
	self.dossierNote:SetText(access.dossier and "Recorded encounters and completed work."
		or "Ask Mute about the remaining STALKERnet tools.")
	local location = access.location
		and ix.crossserver.GetPresenceText(record, record.fresh, IsValid(record.player)) or "LOCATION LOCKED"
	self.details:SetText(record.name)
	local values = table.Copy(stats)
	values.rank = rankName(record)
	values.reputation = math.floor(record.profile.reputation or 0)
	values.squad = record.squadName and record.squadName ~= "" and record.squadName or "Loner"
	values.location = location
	values.favoriteContact = stats.favoriteContact or "None"
	values.taskEarnings = (stats.taskEarnings or 0) .. " RU"
	for key, field in pairs(self.dossierFields) do
		local basic = key == "tasksCompleted" or key == "mutantsKilled" or key == "humansKilled"
		local visible = key == "squad" or access.dossier or (basic and access.activity)
			or ((key == "rank" or key == "reputation") and access.ranking) or (key == "location" and access.location)
		field.card:SetVisible(visible == true)
		field.value:SetText(tostring(values[key] or 0))
		local color = FIELD_COLORS[key] or COLORS.text
		if key == "squad" then color = record.squadColor or COLORS.muted end
		if key == "location" then
			color = ix.crossserver.GetPresenceColor(record, record.fresh, IsValid(record.player))
		end
		field.value:SetTextColor(color)
		field.card:InvalidateLayout(true)
	end
end

function PANEL:PerformLayout(width, height)
	local scale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2)
	if self.fontScale ~= scale then
		self.fontScale = scale
		surface.CreateFont("cotzLeaderboard", {
			font = "alsina", size = math.floor(19 * scale), weight = 500, extended = true,
		})
		surface.CreateFont("cotzDossierTitle", {
			font = "alsina", size = math.floor(28 * scale), weight = 600, extended = true,
		})
		surface.CreateFont("cotzDossierValue", {
			font = "alsina", size = math.floor(23 * scale), weight = 500, extended = true,
		})
		surface.CreateFont("cotzDossierCaption", {
			font = "alsina", size = math.floor(16 * scale), weight = 500, extended = true,
		})
		self.details:SetFont("cotzDossierTitle")
		self.portrait:SetTall(math.floor(96 * scale))
		self.dossierNote:SetFont("cotzDossierCaption")
		for _, field in pairs(self.dossierFields) do
			field.caption:SetFont("cotzDossierCaption")
			field.value:SetFont("cotzDossierValue")
			field.card:InvalidateLayout(true)
		end
		self.search:SetFont("cotzLeaderboard")
		self.area:SetFont("cotzLeaderboard")
		self.squad:SetFont("cotzLeaderboard")
	end
	local compact = width < 850
	self.dossier:Dock(compact and BOTTOM or RIGHT)
	self.dossier:SetWide(math.floor(width * 0.3))
	self.dossier:SetTall(math.floor(height * 0.45))
end

function PANEL:Think()
	if (self.nextRefresh or 0) > CurTime() then return end
	self.nextRefresh = CurTime() + 0.5
	local character = LocalPlayer():GetCharacter()
	if self.selectionCharacter ~= character then
		self.selectionCharacter = character
		self.selected = character and character:GetID()
	end
	if not character then
		for id, row in pairs(self.rows) do row:Remove() self.rows[id] = nil end
		self.portrait:SetImage("vgui/icons/face_31.png")
		self.details:SetText("Select a stalker")
		for _, field in pairs(self.dossierFields) do field.value:SetText("—") field.card:SetVisible(false) end
		return
	end
	local access = ix.townNPCs and ix.townNPCs:GetNetworkAccess(character)
		or {search = true, squads = true, ranking = true, activity = true, location = true, remote = true, dossier = true}
	self.networkAccess = access
	self.search:SetEnabled(access.search)
	self.squad:SetEnabled(access.squads)
	if not access.squads then self.squadOnly = false end
	self.squad:SetText(not access.squads and "Squad filter: LOCKED"
		or self.squadOnly and "My squad: ON" or "My squad: OFF")
	self.area:SetEnabled(true)
	self.area:SetText(self.localOnly and "Local area" or "All maps")
	self.dossierNote:SetText(access.dossier and "Recorded encounters and completed work."
		or "Ask Mute about the remaining STALKERnet tools.")
	local records = ix.crossserver and ix.crossserver.GetScoreboardRoster(false) or {}
	local ordered = {}
	for _, record in pairs(records) do
		record.profile = record.profile or {}
		ordered[#ordered + 1] = record
	end
	table.sort(ordered, function(a, b)
		if not access.ranking then
			if a.name == b.name then return a.characterID < b.characterID end

			return a.name < b.name
		end
		local first, second = a.profile.reputation or 0, b.profile.reputation or 0
		if first == second then return a.characterID < b.characterID end

		return first > second
	end)
	local present = {}
	local query = access.search and self.search:GetValue():lower() or ""
	for position, record in ipairs(ordered) do
		local squad = record.squadName or ""
		local matches = (record.name .. " " .. squad):lower():find(query, 1, true)
		local area = not self.localOnly or (record.fresh and record.map == game.GetMap())
		local member = not access.squads or not self.squadOnly or (character and record.squadID ~= "NULL"
			and record.squadID == character:GetSquadID())
		if matches and area and member then
			local id = record.characterID
			present[id] = true
			local row = self.rows[id]
			if not IsValid(row) then
				row = self.list:Add("DButton")
				row:Dock(TOP)
				row:DockMargin(0, 0, 0, 6)
				row:SetTall(76)
				row.leaderboardInteractive = true
				row:SetText("")
				row.avatar = row:Add("DImage")
				row.avatar:SetPos(44, 8)
				row.avatar:SetSize(90, 60)
				row.avatar:SetKeepAspect(true)
				row.avatar:SetMouseInputEnabled(false)
				self.rows[id] = row
			end
			row:SetZPos(position)
			row.avatar:SetImage(record.pdaavatar or "vgui/icons/face_31.png")
			row.Paint = function(button, width, height)
				paintCard(button, width, height)
				if access.ranking then draw.SimpleText("#" .. position, "ixSmallFont", 6, 28, COLORS.muted) end
				draw.SimpleText(record.name, "cotzLeaderboard", 146, 8, COLORS.text)
				local rankWidth = draw.SimpleText(rankName(record), "cotzLeaderboard", 146, 34, COLORS.rank)
				draw.SimpleText(" · " .. (squad ~= "" and squad or "Loner"),
					"cotzLeaderboard", 146 + rankWidth, 34, record.squadColor or COLORS.muted)
				local presence = (access.location or (character and record.characterID == character:GetID()))
					and ix.crossserver.GetPresenceText(record, record.fresh, IsValid(record.player)) or "LOCATION LOCKED"
				draw.SimpleText(presence,
					"cotzLeaderboard", 146, 54,
					ix.crossserver.GetPresenceColor(record, record.fresh, IsValid(record.player)))
			end
			row.DoClick = function() self:SelectRecord(record) end
			row.DoRightClick = function()
				if not IsValid(record.player) then return end
				local menu = DermaMenu()
				menu:AddOption(L("viewProfile"), function()
					if IsValid(record.player) then record.player:ShowProfile() end
				end)
				menu:AddOption("Mute / unmute", function()
					record.player:SetMuted(not record.player:IsMuted())
				end)
				hook.Run("PopulateScoreboardPlayerMenu", record.player, menu)
				menu:Open()
			end
			if self.selected == id then self:SelectRecord(record) end
		end
	end
	for id, row in pairs(self.rows) do
		if not present[id] then row:Remove() self.rows[id] = nil end
	end
	local ownRecord = character and records[character:GetID()]
	if ownRecord and (self.selected == character:GetID() or not present[self.selected]) then
		self:SelectRecord(ownRecord)
	elseif self.selected and not present[self.selected] then
		self.selected = nil
		self.portrait:SetImage("vgui/icons/face_31.png")
		self.details:SetText("Select a stalker")
		for _, field in pairs(self.dossierFields) do field.value:SetText("—") end
	end
end

vgui.Register("ixScoreboard", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["STALKERnet"] = function(container) container:Add("ixScoreboard") end
end)
