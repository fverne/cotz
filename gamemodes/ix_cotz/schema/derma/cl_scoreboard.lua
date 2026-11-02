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

-- Squad grouping; the squad plugin supplies public identity without exposing its roster.
PANEL = {}

function PANEL:Init()
	self:DockMargin(0, 0, 0, 16)
	self:SetTall(32)
end

function PANEL:UpdateGroup(name, records, color)
	self:SetColor(color or ix.config.Get("color"))
	self:SetText(name .. " (" .. #records .. ")")
	self.rows = self.rows or {}
	local present = {}
	table.sort(records, function(first, second)
		local firstRep = IsValid(first.player) and first.player:getReputation() or 0
		local secondRep = IsValid(second.player) and second.player:getReputation() or 0
		if (firstRep == secondRep) then return first.characterID < second.characterID end

		return firstRep < secondRep
	end)
	for index, record in ipairs(records) do
		local id = record.characterID
		present[id] = true
		local row = self.rows[id]
		if (not IsValid(row)) then
			row = self:Add("ixScoreboardRow")
			row:Dock(TOP)
			self.rows[id] = row
		end
		row:SetRecord(record)
		if (IsValid(record.player)) then record.player.ixScoreboardSlot = row end
		row:SetZPos(index)
		row:SetBackgroundPaintFunction(rowPaintFunctions[index % 2 == 0 and 1 or 2])
	end
	for id, row in pairs(self.rows) do
		if (not present[id]) then
			row:Remove()
			self.rows[id] = nil
		end
	end
	self:SizeToContents()
end

vgui.Register("ixScoreboardGroup", PANEL, "ixCategoryPanel")

PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.scoreboard)) then
		ix.gui.scoreboard:Remove()
	end

	self:Dock(FILL)
	self.groups = {}
	self.localArea = self:Add("DButton")
	self.localArea:Dock(TOP)
	self.localArea:SetZPos(-1)
	self.localArea:SetTall(28)
	self.localArea:SetText("Local area: OFF")
	self.localArea.DoClick = function(button)
		self.localOnly = not self.localOnly
		button:SetText(self.localOnly and "Local area: ON" or "Local area: OFF")
		self.nextThink = 0
	end
	self.nextThink = 0
	ix.gui.scoreboard = self
end

function PANEL:Think()
	if (CurTime() < self.nextThink) then return end
	self.nextThink = CurTime() + 0.5

	local groups = {}

	local records = ix.crossserver and ix.crossserver.GetScoreboardRoster(self.localOnly) or {}
	for _, record in pairs(records) do
		local id = record.squadID
		if (not id or id == "" or id == "NULL" or not record.squadName or record.squadName == "") then
			id = "loners"
		end
		local color = id ~= "loners" and record.squadColor
		groups[id] = groups[id] or {
			name = id == "loners" and "loners" or record.squadName,
			color = color and color.r and color or nil, records = {},
		}
		table.insert(groups[id].records, record)
	end

	for id, group in pairs(groups) do
		local panel = self.groups[id]

		if (not IsValid(panel)) then
			panel = self:Add("ixScoreboardGroup")
			panel:Dock(TOP)
			self.groups[id] = panel
		end

		panel:UpdateGroup(group.name, group.records, group.color)
	end

	for id, panel in pairs(self.groups) do
		if (not groups[id]) then
			panel:Remove()
			self.groups[id] = nil
		end
	end
end

vgui.Register("ixScoreboard", PANEL, "DScrollPanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["STALKERnet"] = function(container)
		container:Add("ixScoreboard")
	end
end)
