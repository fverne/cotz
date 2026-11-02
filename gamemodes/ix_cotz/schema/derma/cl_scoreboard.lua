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
}
local PANEL = {}

local function rankName(record)
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
	surface.SetDrawColor(panel:IsHovered() and COLORS.teal or COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
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
	self.dossier = self:Add("DPanel")
	self.dossier:Dock(RIGHT)
	self.dossier:DockMargin(12, 12, 0, 0)
	self.dossier.Paint = paintCard
	self.details = self.dossier:Add("DLabel")
	self.details:Dock(FILL)
	self.details:DockMargin(16, 110, 16, 16)
	self.details:SetWrap(true)
	self.details:SetContentAlignment(7)
	self.details:SetTextColor(COLORS.text)
	self.details:SetText("Select a stalker to view their dossier.")
	self.portrait = self.dossier:Add("DImage")
	self.portrait:SetPos(16, 16)
	self.portrait:SetSize(80, 80)
	self.list = self:Add("DScrollPanel")
	self.list:Dock(FILL)
	self.list:DockMargin(0, 12, 0, 0)
	self.rows = {}
end

function PANEL:SelectRecord(record)
	self.selected = record.characterID
	self.portrait:SetImage(record.pdaavatar or "vgui/icons/face_31.png")
	local stats = record.profile.leaderboardStats or {}
	local location = ix.crossserver.GetPresenceText(record, record.fresh, IsValid(record.player))
	self.details:SetText(record.name .. "\n" .. rankName(record)
		.. " · " .. math.floor(record.profile.reputation or 0) .. " reputation\n\n"
		.. (record.squadName and record.squadName ~= "" and record.squadName or "Loner") .. "\n"
		.. location .. "\n" .. (record.map or "") .. "\n\n"
		.. "MUTANTS KILLED     " .. (stats.mutantsKilled or 0) .. "\n\n"
		.. "HUMAN NPCS KILLED     " .. (stats.humansKilled or 0) .. "\n\n"
		.. "TASKS COMPLETED     " .. (stats.tasksCompleted or 0)
		.. "\n\nStatistics tracked since the leaderboard update.")
end

function PANEL:PerformLayout(width, height)
	local scale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2)
	if self.fontScale ~= scale then
		self.fontScale = scale
		surface.CreateFont("cotzLeaderboard", {
			font = "alsina", size = math.floor(19 * scale), weight = 500, extended = true,
		})
		self.details:SetFont("cotzLeaderboard")
	end
	local compact = width < 850
	self.dossier:Dock(compact and BOTTOM or RIGHT)
	self.dossier:SetWide(math.floor(width * 0.3))
	self.dossier:SetTall(math.floor(height * 0.45))
end

function PANEL:Think()
	if (self.nextRefresh or 0) > CurTime() then return end
	self.nextRefresh = CurTime() + 0.5
	local records = ix.crossserver and ix.crossserver.GetScoreboardRoster(false) or {}
	local ordered = {}
	for _, record in pairs(records) do
		record.profile = record.profile or {}
		ordered[#ordered + 1] = record
	end
	table.sort(ordered, function(a, b)
		local first, second = a.profile.reputation or 0, b.profile.reputation or 0
		if first == second then return a.characterID < b.characterID end

		return first > second
	end)
	local present = {}
	local query = self.search:GetValue():lower()
	local character = LocalPlayer():GetCharacter()
	for position, record in ipairs(ordered) do
		local squad = record.squadName or ""
		local matches = (record.name .. " " .. squad):lower():find(query, 1, true)
		local area = not self.localOnly or (record.fresh and record.map == game.GetMap())
		local member = not self.squadOnly or (character and record.squadID ~= "NULL"
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
				row:SetText("")
				row.avatar = row:Add("DImage")
				row.avatar:SetPos(44, 8)
				row.avatar:SetSize(60, 60)
				row.avatar:SetMouseInputEnabled(false)
				self.rows[id] = row
			end
			row:SetZPos(position)
			row.avatar:SetImage(record.pdaavatar or "vgui/icons/face_31.png")
			row.Paint = function(button, width, height)
				paintCard(button, width, height)
				draw.SimpleText("#" .. position, "ixSmallFont", 6, 28, COLORS.muted)
				draw.SimpleText(record.name, "cotzLeaderboard", 116, 8, COLORS.text)
				draw.SimpleText(rankName(record) .. " · " .. (squad ~= "" and squad or "Loner"),
					"cotzLeaderboard", 116, 34, COLORS.muted)
				draw.SimpleText(ix.crossserver.GetPresenceText(record, record.fresh, IsValid(record.player)),
					"cotzLeaderboard", 116, 54, COLORS.teal)
			end
			row.DoClick = function() self:SelectRecord(record) end
			row.DoRightClick = function()
				if not IsValid(record.player) then return end
				local menu = DermaMenu()
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
	if self.selected and not present[self.selected] then
		self.selected = nil
		self.portrait:SetImage("vgui/icons/face_31.png")
		self.details:SetText("Select a stalker to view their dossier.")
	end
end

vgui.Register("ixScoreboard", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["STALKERnet"] = function(container) container:Add("ixScoreboard") end
end)
