local COLORS = {
	background = Color(19, 18, 20, 235),
	card = Color(12, 13, 12, 215),
	border = Color(93, 94, 86, 180),
	hover = Color(169, 171, 149),
	text = Color(216, 215, 201),
	muted = Color(116, 119, 107),
	green = Color(105, 139, 87),
	teal = Color(73, 140, 143),
	red = Color(154, 84, 70),
	track = Color(41, 43, 38),
}
local RANKS = {[0] = "MEMBERS", [1] = "OFFICERS", [2] = "LEADER"}
local fontScale

local function refreshFonts()
	local scale = ix.cotzUI.GetScale()
	if (fontScale == scale) then return false end
	fontScale = scale

	for name, size in pairs({Title = 25, Label = 19, Small = 17}) do
		surface.CreateFont("cotzSquads" .. name, {
			font = "alsina", size = math.floor(size * scale + 0.5), weight = 500, extended = true,
		})
	end

	return true
end

local function scaled(value)
	return math.ceil(value * (fontScale or 1))
end

local function paintCard(_, width, height)
	surface.SetDrawColor(COLORS.card)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
end

local function addLabel(parent, text, font, color)
	local label = parent:Add("DLabel")
	label:Dock(TOP)
	label:DockMargin(0, 0, 0, scaled(8))
	label:SetFont(font or "cotzSquadsSmall")
	label:SetTextColor(color or COLORS.text)
	label:SetText(text)
	label:SetWrap(true)
	label:SetAutoStretchVertical(true)

	return label
end

local function addButton(parent, text, callback, danger)
	local button = parent:Add("DButton")
	button:Dock(TOP)
	button:DockMargin(0, scaled(4), 0, scaled(4))
	button.squadHeight = 32
	button:SetTall(scaled(32))
	button:SetFont("cotzSquadsSmall")
	button:SetTextColor(danger and COLORS.red or COLORS.text)
	button:SetText(text)
	button.Paint = function(this, width, height)
		surface.SetDrawColor(this:IsHovered() and COLORS.track or COLORS.card)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(this:IsHovered() and (danger and COLORS.red or COLORS.teal) or COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
	end
	button.DoClick = callback

	return button
end

local function addEntry(parent, height, limit, multiline)
	local entry = parent:Add("DTextEntry")
	entry:Dock(TOP)
	entry:DockMargin(0, 0, 0, scaled(12))
	entry.squadHeight = height
	entry:SetTall(scaled(height))
	entry:SetFont("cotzSquadsSmall")
	entry:SetMultiline(multiline or false)
	entry:SetUpdateOnType(true)
	entry.AllowInput = function(this, character)
		return (this:GetText() .. character):utf8len() > limit
	end
	entry.Paint = function(this, width, entryHeight)
		surface.SetDrawColor(COLORS.background)
		surface.DrawRect(0, 0, width, entryHeight)
		surface.SetDrawColor(this:HasFocus() and COLORS.teal or COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, entryHeight)
		local placeholder = this:GetPlaceholderText()
		if (this:GetText() == "" and placeholder and not this:HasFocus()) then
			draw.SimpleText(placeholder, "cotzSquadsSmall", scaled(8), entryHeight / 2,
				COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		else
			this:DrawTextEntryText(COLORS.text, COLORS.teal, COLORS.text)
		end
	end

	return entry
end

local function addSection(parent, text)
	local label = addLabel(parent, text, "cotzSquadsSmall", COLORS.muted)
	label:DockMargin(0, scaled(12), 0, scaled(8))
	label.Paint = function(_, width)
		surface.SetDrawColor(COLORS.border)
		surface.DrawLine(0, 0, width, 0)
	end

	return label
end

local function fitCard(panel)
	local height = scaled(24)

	for _, child in ipairs(panel:GetChildren()) do
		local _, top, _, bottom = child:GetDockMargin()
		height = height + child:GetTall() + top + bottom
	end

	if (panel:GetTall() ~= height) then panel:SetTall(height) end
end

local function addCard(parent)
	local card = parent:Add("DPanel")
	card:Dock(TOP)
	card:DockMargin(0, 0, scaled(10), scaled(12))
	card:DockPadding(scaled(16), scaled(12), scaled(16), scaled(12))
	card.Paint = paintCard
	card.PerformLayout = fitCard

	return card
end

local function styleScroll(scroll)
	local bar = scroll:GetVBar()
	bar:SetWide(scaled(6))
	bar:SetHideButtons(true)
	bar.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.track)
		surface.DrawRect(0, 0, width, height)
	end
	bar.btnGrip.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawRect(0, 0, width, height)
	end
end

local queuedSettings
local nextSettingsSend = 0

local function queueSettings(character, squadID, data)
	if (LocalPlayer():GetCharacter() ~= character or character:GetSquadID() ~= squadID) then return end
	if (not queuedSettings or queuedSettings.character ~= character or queuedSettings.squadID ~= squadID) then
		queuedSettings = {character = character, squadID = squadID, data = {}}
	end
	local pending = queuedSettings

	for key, value in pairs(data) do pending.data[key] = value end
	if (pending.scheduled) then return end
	pending.scheduled = true
	local delay = math.max(0, nextSettingsSend - CurTime())
	local function send()
		if (queuedSettings ~= pending) then return end
		queuedSettings = nil
		if (LocalPlayer():GetCharacter() ~= character or character:GetSquadID() ~= squadID) then return end
		nextSettingsSend = CurTime() + 1.05
		net.Start("ixSquadSettings")
			net.WriteTable(pending.data)
		net.SendToServer()
	end
	if (delay > 0) then timer.Simple(delay, send) else send() end
end

local PANEL = {}

function PANEL:Init()
	refreshFonts()
	self.netData = {}
	self.memberTags = {}
	self.character = LocalPlayer():GetCharacter()
	self.header = self:Add("DPanel")
	self.header:Dock(TOP)
	self.header:DockMargin(0, 0, 0, scaled(12))
	self.header:DockPadding(scaled(16), scaled(12), scaled(16), scaled(12))
	self.header.squadHeight = 96
	self.header:SetTall(scaled(96))
	self.header.Paint = function(_, width, height)
		paintCard(nil, width, height)
		surface.SetDrawColor(self.netData.color or (self.data and self.data.color) or COLORS.green)
		surface.DrawRect(0, 0, scaled(3), height)
	end
	self.summary = self.header:Add("DPanel")
	self.summary:Dock(FILL)
	self.summary.Paint = function() end
	self.name = addLabel(self.summary, "", "cotzSquadsTitle")
	self.count = addLabel(self.summary, "", "cotzSquadsSmall", COLORS.muted)
	self.header.PerformLayout = function(this)
		local height = math.max(scaled(96), self.name:GetTall() + self.count:GetTall() + scaled(40))
		if (this:GetTall() ~= height) then this:SetTall(height) end
	end
	self.body = self:Add("DPanel")
	self.body:Dock(FILL)
	self.body.Paint = function() end
	self.overview = self.body:Add("DScrollPanel")
	self.roster = self.body:Add("DScrollPanel")
	styleScroll(self.overview)
	styleScroll(self.roster)
	self.body.PerformLayout = function(_, width, height)
		local gap = scaled(12)
		local narrow = width < scaled(640)
		local leftWidth = narrow and width or math.floor(width * 0.38)
		local leftHeight = narrow and math.floor((height - gap) * 0.48) or height
		self.overview:SetPos(0, 0)
		self.overview:SetSize(leftWidth, leftHeight)
		self.roster:SetPos(narrow and 0 or leftWidth + gap, narrow and leftHeight + gap or 0)
		self.roster:SetSize(narrow and width or width - leftWidth - gap,
			narrow and height - leftHeight - gap or height)
	end
end

function PANEL:IsLeader()
	return self.leader
end

function PANEL:IsOfficer()
	return self.officer
end

function PANEL:InvitePlayer()
	local menu = DermaMenu()
	local count = 0

	for _, client in ipairs(player.GetHumans()) do
		local character = client:GetCharacter()
		local nearby = LocalPlayer():GetPos():DistToSqr(client:GetPos()) < 160 * 160

		if (client ~= LocalPlayer() and character and character:GetSquadID() == "NULL" and nearby) then
			count = count + 1
			menu:AddOption(character:GetName(), function()
				net.Start("ixSquadInvite")
					net.WriteEntity(client)
					net.SendToServer()
			end)
		end
	end

	if (count == 0) then menu:AddOption("No unaffiliated stalkers nearby"):SetEnabled(false) end
	menu:Open()
end

function PANEL:BuildOverview()
	self.overview:Clear()
	local card = addCard(self.overview)
	addLabel(card, "SQUAD DETAILS", "cotzSquadsLabel")

	if (self.leader) then
		addSection(card, "NAME")
		self.entryName = addEntry(card, 34, 48)
		self.entryName:SetText(self.data.name)
		self.entryName.OnValueChange = function(_, value)
			self.netData.name = string.Trim(value):utf8sub(1, 48)
		end
	else
		addLabel(card, "Your rank: " .. (self.officer and "Officer" or "Member"), nil, COLORS.muted)
	end

	addSection(card, "MESSAGE OF THE DAY")
	if (self.leader) then
		self.entryMessage = addEntry(card, 140, 2048, true)
		self.entryMessage:SetText(self.data.description or "")
		self.entryMessage.OnValueChange = function(_, value)
			self.netData.description = value:utf8sub(1, 2048)
		end
	else
		local message = self.data.description
		self.message = addLabel(card, message and message ~= "" and message or "No message posted.")
	end

	if (self.leader) then
		addSection(card, "IDENTITY")
		addButton(card, L("squad_menu_btn_color"), function()
			local menu = DermaMenu()
			local color = vgui.Create("DColorCombo")
			color:SetupCloseButton(CloseDermaMenus)
			color:SetColor(self.netData.color or self.data.color or COLORS.green)
			color.OnValueChanged = function(_, value) self.netData.color = value end
			menu:AddPanel(color)
			menu:Open()
		end)
		self.save = addButton(card, "Save changes", function() self:SaveSettings() end)
		self.feedback = addLabel(card, "Changes also save when you close this menu.", nil, COLORS.muted)
	end

	addSection(card, "ACTIONS")
	if (self.leader or self.officer) then
		addButton(card, L("squad_menu_btn_invite"), function() self:InvitePlayer() end)
		local hideouts = ix.plugin.Get("hideouts")
		if hideouts and hideouts.RequestManagement then
			addButton(card, "Squad hideout", function() hideouts:RequestManagement("", "squad") end)
		end
	end
	local action = self.leader and "ixSquadDisband" or "ixSquadLeave"
	local title = L(self.leader and "squad_menu_btn_disband" or "squad_menu_btn_leave")
	addButton(card, title, function()
		local prompt = self.leader and L("squad_menu_btn_ask_disband") or "Leave this squad?"
		Derma_Query(prompt, title, L("text_yes"), function()
			net.Start(action)
			net.SendToServer()
		end, L("text_no"))
	end, true)
end

function PANEL:SetMembers(data)
	local character = LocalPlayer():GetCharacter()
	if (not character) then return end
	self.data = data
	self.leader = data.members[character:GetID()] == 2
	self.officer = data.members[character:GetID()] == 1
	self.name:SetText(self.netData.name or data.name)
	if (not self.detailsBuilt) then
		self:BuildOverview()
		self.detailsBuilt = true
	elseif (self.message) then
		self.message:SetText((data.description and data.description ~= "" and data.description) or "No message posted.")
	end
	self.roster:Clear()
	self.memberTags = {}
	local card = addCard(self.roster)
	addLabel(card, "PERSONNEL", "cotzSquadsLabel")
	addLabel(card, "Select a stalker for squad actions.", nil, COLORS.muted)
	local members = {}
	local count = 0

	for characterID, rank in pairs(data.members) do
		members[#members + 1] = {id = characterID, rank = rank, info = data.memberInfo[characterID] or {}}
		count = count + 1
	end

	table.sort(members, function(first, second)
		if (first.rank ~= second.rank) then return first.rank > second.rank end
		return (first.info.name or tostring(first.id)) < (second.info.name or tostring(second.id))
	end)
	local previousRank
	for _, member in ipairs(members) do
		if (previousRank ~= member.rank) then addSection(card, RANKS[member.rank]) end
		previousRank = member.rank
		local row = card:Add("ixSquadMemberTag")
		row:Dock(TOP)
		row:DockMargin(0, 0, 0, scaled(6))
		row:SetCharacter(member.id, member.info)
		self.memberTags[member.id] = row
	end

	self.memberCount = count
	self:UpdateCount()
end

function PANEL:UpdateCount()
	local here = 0
	for characterID in pairs(self.data.members) do
		if (ix.squad.GetPlayer(characterID)) then here = here + 1 end
	end

	self.count:SetText(self.memberCount .. " stalkers  /  " .. here .. " on this server")
end

function PANEL:SaveSettings()
	if (not self.data or table.IsEmpty(self.netData)) then return end
	-- Merge closing edits with pending saves so the server's settings cooldown cannot discard the final draft.
	queueSettings(self.character, self.data.owner, self.netData)
	self.netData = {}
	if (IsValid(self.feedback)) then self.feedback:SetText("Changes submitted.") end
end

function PANEL:OnRemove()
	self:SaveSettings()
end

function PANEL:Think()
	if (not self.data or (self.nextCount or 0) > CurTime()) then return end
	self.nextCount = CurTime() + 1
	self:UpdateCount()
end

vgui.Register("ixSquadView", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self.squadHeight = 66
	self:SetTall(scaled(66))
	self:SetCursor("hand")
	self.avatar = self:Add("DImage")
	self.avatar:SetMouseInputEnabled(false)
	self.name = self:Add("DLabel")
	self.name:SetFont("cotzSquadsLabel")
	self.name:SetTextColor(COLORS.text)
	self.status = self:Add("DLabel")
	self.status:SetFont("cotzSquadsSmall")
end

local function requestMemberAction(characterID, event, prompt, title, desiredRank)
	Derma_Query(prompt, title, L("text_yes"), function()
		net.Start(event)
			net.WriteUInt(characterID, 32)
			if (desiredRank ~= nil) then net.WriteUInt(desiredRank, 2) end
		net.SendToServer()
	end, L("text_no"))
end

function PANEL:OnMousePressed(code)
	if (code ~= MOUSE_RIGHT) then return end
	local character = LocalPlayer():GetCharacter()
	if (not character or character:GetID() == self.characterID) then return end
	local squad = ix.squad.list[character:GetSquadID()]
	if (not squad or squad.members[self.characterID] == nil) then return end

	local menu = DermaMenu()
	local target = ix.squad.GetPlayer(self.characterID)

	if (target) then
		menu:AddOption(L("squad_menu_opt_sendpm"), function()
			Derma_StringRequest(L("squad_menu_opt_sendpm"), L("squad_menu_opt_message"), "", function(text)
				local currentTarget = ix.squad.GetPlayer(self.characterID)
				if (currentTarget and text ~= "") then
					RunConsoleCommand("say", "/pm", currentTarget:GetCharacter():GetName(), text)
				end
			end)
		end):SetImage("icon16/user_comment.png")
	end

	local rank = squad:GetRank(LocalPlayer())
	local targetRank = squad.members[self.characterID]

	if (squad:IsLeader(LocalPlayer())) then
		local promote = targetRank == 0
		local title = L(promote and "squad_menu_btn_raiseofficer" or "squad_menu_btn_demote")
		local prompt = L(promote and "squad_menu_btn_ask_raiseofficer" or "squad_menu_btn_ask_demote")
		menu:AddOption(title, function()
			requestMemberAction(self.characterID, "ixSquadRankChange", prompt, title, promote and 1 or 0)
		end):SetImage("icon16/user_go.png")
	end

	if (rank and rank > targetRank and targetRank ~= 2) then
		menu:AddOption(L("squad_menu_btn_kickmember"), function()
			requestMemberAction(self.characterID, "ixSquadKickMember",
				L("squad_menu_text_kickmember", self.name:GetText(), squad.name), L("squad_menu_btn_kickmember"))
		end):SetImage("icon16/user_delete.png")
	end

	menu:Open()
end

function PANEL:OnMouseReleased(code)
	if (code == MOUSE_LEFT) then self:OnMousePressed(MOUSE_RIGHT) end
end

function PANEL:SetCharacter(characterID, info)
	self.characterID = characterID
	self.info = info or {}
	self:UpdateCharacter()
end

function PANEL:UpdateCharacter()
	local target = ix.squad.GetPlayer(self.characterID)
	local character = target and target:GetCharacter()
	local name = character and character:GetName() or self.info.name or ("Character #" .. self.characterID)
	local icon = character and character:GetPdaavatar() or self.info.pdaavatar or "vgui/icons/face_31.png"
	self.name:SetText(name)
	local status = ix.crossserver.GetPresenceText(self.info, false, target ~= nil)
	local fresh = ix.squad.presenceFresh
	local current = LocalPlayer():GetCharacter()
	local verified = fresh and current and fresh.id == current:GetSquadID() and CurTime() - fresh.time < 15
	if (self.info.state) then
		status = ix.crossserver.GetPresenceText(self.info, verified, target ~= nil)
	end
	self.status:SetText(status)
	self.status:SetTextColor(ix.crossserver.GetPresenceColor(self.info, verified, target ~= nil))
	self:SetTooltip(name .. " · " .. status)

	if (self.icon ~= icon) then
		self.icon = icon
		self.avatar:SetMaterial(ix.util.GetMaterial(icon))
	end
end

function PANEL:Think()
	if ((self.nextRefresh or 0) > CurTime()) then return end
	self.nextRefresh = CurTime() + 1
	self:UpdateCharacter()
end

function PANEL:PerformLayout(width)
	local portraitHeight = self:GetTall() - scaled(12)
	local portraitWidth = portraitHeight * 96 / 64
	self.avatar:SetPos(scaled(6), scaled(6))
	self.avatar:SetSize(portraitWidth, portraitHeight)
	local left = portraitWidth + scaled(16)
	self.name:SetPos(left, scaled(9))
	self.name:SetSize(math.max(0, width - left - scaled(12)), scaled(24))
	self.status:SetPos(left, scaled(35))
	self.status:SetSize(math.max(0, width - left - scaled(12)), scaled(20))
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(self:IsHovered() and COLORS.track or COLORS.background)
	surface.DrawRect(0, 0, width, height)
	surface.SetDrawColor(self:IsHovered() and COLORS.hover or COLORS.border)
	surface.DrawOutlinedRect(0, 0, width, height)
end

vgui.Register("ixSquadMemberTag", PANEL, "Panel")

local function resizeChildren(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if (child.squadHeight) then child:SetTall(scaled(child.squadHeight)) end
		resizeChildren(child)
		child:InvalidateLayout(true)
	end
end

PANEL = {}

function PANEL:Init()
	self.nextRefresh = 0
	refreshFonts()
	self:DockPadding(scaled(16), scaled(16), scaled(16), scaled(16))
	self.title = addLabel(self, "SQUADS", "cotzSquadsTitle")
	self.host = self:Add("DPanel")
	self.host:Dock(FILL)
	self.host.Paint = function() end
end

function PANEL:BuildEmpty(state, character)
	self.content = self.host:Add("DScrollPanel")
	self.content:Dock(FILL)
	styleScroll(self.content)
	local card = addCard(self.content)
	addLabel(card, state == "loading" and "CONTACTING YOUR SQUAD" or "TRAVEL WITH COMPANY", "cotzSquadsLabel")
	addLabel(card, state == "loading" and "Your squad roster is being retrieved."
		or "You are not in a squad. Create one or accept an invitation from another stalker.", nil, COLORS.muted)
	if (state ~= "loners" or not character) then return end

	local invite = LocalPlayer():GetLocalVar("squadInvite")
	if (invite and invite.targetID == character:GetID() and invite.expires > CurTime()) then
		addSection(card, "SQUAD INVITATION")
		addLabel(card, invite.inviter .. " invited you to " .. invite.name .. ".")
		local accept = addButton(card, "Accept invite", function(button)
			button:SetEnabled(false)
			net.Start("cotz/squads/accept-invite")
			net.SendToServer()
		end)
		self.acceptInvite = accept
	end

	addSection(card, "CREATE A SQUAD")
	local name = addEntry(card, 36, 48)
	name:SetPlaceholderText("Squad name")
	local nextCreate = 0
	local create = addButton(card, "Create squad", function()
		local text = string.Trim(name:GetText())
		if (text == "" or text:utf8len() > 48 or nextCreate > CurTime()) then return end
		if (LocalPlayer():GetCharacter() ~= character or character:GetSquadID() ~= "NULL") then return end
		nextCreate = CurTime() + 30
		net.Start("ixSquadCreate")
			net.WriteString(text)
		net.SendToServer()
	end)
	name.OnEnter = function() create:DoClick() end
end

function PANEL:Think()
	if (self.nextRefresh > CurTime()) then return end
	self.nextRefresh = CurTime() + 0.25
	if (refreshFonts()) then
		self:DockPadding(scaled(16), scaled(16), scaled(16), scaled(16))
		resizeChildren(self)
	end

	local character = LocalPlayer():GetCharacter()
	local id = character and character:GetSquadID()
	local squad = id and ix.squad.list[id]
	local hasSquad = squad and squad.members[character:GetID()] ~= nil
	local rank = hasSquad and squad.members[character:GetID()]
	local state = hasSquad and (id .. ":" .. rank) or (id and id ~= "NULL" and "loading" or "loners")
	local invite = LocalPlayer():GetLocalVar("squadInvite")
	local activeInvite = invite and character and invite.targetID == character:GetID()
		and invite.expires > CurTime() and invite or nil
	if (activeInvite ~= self.invite) then self.state = nil end
	self.invite = activeInvite
	if (state == self.state and character == self.character and IsValid(self.content)) then return end
	self.character = character
	self.state = state

	if (IsValid(self.content)) then self.content:Remove() end
	if (hasSquad) then
		self.content = self.host:Add("ixSquadView")
		self.content:Dock(FILL)
		ix.gui.squad = self.content
		self.content:SetMembers(squad)
	else
		self:BuildEmpty(state, character)
	end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(COLORS.background)
	surface.DrawRect(0, 0, width, height)
end

vgui.Register("ixSquadMenu", PANEL, "EditablePanel")
