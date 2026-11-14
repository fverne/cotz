local PLUGIN = PLUGIN
local COLORS = {
	background = Color(19, 18, 20, 235),
	card = Color(12, 13, 12, 215),
	border = Color(93, 94, 86, 180),
	text = Color(216, 215, 201),
	muted = Color(116, 119, 107),
	green = Color(105, 139, 87),
	teal = Color(73, 140, 143),
	track = Color(41, 43, 38),
}

function PLUGIN:CreateMenuButtons(tabs)
	tabs["tasks"] = function(container)
		local tasks = container:Add("ixCharacterJournalPanel")
		tasks:Dock(FILL)
	end
end

local function addLabel(parent, text, font, color)
	local label = parent:Add("DLabel")
	label:Dock(TOP)
	label:DockMargin(0, 0, 0, 8)
	label:SetFont(font)
	label:SetTextColor(color or COLORS.text)
	label:SetText(text)
	label:SetWrap(true)
	label:SetAutoStretchVertical(true)

	return label
end

local function addButton(parent, text, callback)
	local button = parent:Add("DButton")
	button:Dock(RIGHT)
	button:DockMargin(8, 0, 0, 0)
	surface.SetFont("cotzTasksSmall")
	local textWidth = surface.GetTextSize(text)
	button:SetWide(math.ceil(textWidth + 24))
	button:SetText(text)
	button:SetFont("cotzTasksSmall")
	button:SetTextColor(COLORS.text)
	button.Paint = function(this, width, height)
		surface.SetDrawColor(this:IsHovered() and COLORS.teal or COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
	end
	button.DoClick = callback

	return button
end

local function isCompleted(job)
	return job.isCompleted or job.progress >= job.numberRec
end

local function taskIcon(job, definition)
	local species = job.targetSpecies or definition.targetSpecies
	if species then
		local trigger = species .. "Killed"
		for _, candidate in SortedPairs(ix.jobs.list) do
			if candidate.listenTrigger == trigger and candidate.icon then return candidate.icon end
		end
	end

	return definition.icon or "propic/event/area"
end

local function taskMap(npc, job)
	local definition = ix.jobs.list[job.identifier]
	local contact = ix.townNPCs and ix.townNPCs.byName[npc]
	local issuerMap = contact and contact.map
	local state = job.fieldTask
	if isCompleted(job) then return issuerMap end
	if state then
		if state.stage == "delivered" or state.stage == "issue" then return issuerMap or state.map end
		if state.stage == "carrying" then
			if state.recipient then return ix.jobs.field.GetRecipientMap(state) end
			if state.kind == "deadDrop" then return state.destinationMap or state.map end

			return issuerMap
		end

		return state.map
	end

	local map = job.targetMap or definition.targetMap or definition.fieldMap
	if map then return map end
	if job.photoKind or definition.photoKind or definition.listenTrigger then return nil end

	return issuerMap
end

local function jobSignature(jobs)
	local parts = {}
	for npc, job in SortedPairs(jobs) do
		if ix.jobs.list[job.identifier] then
			parts[#parts + 1] = npc .. "\n" .. ix.jobs.getFormattedName(job) .. "\n"
				.. ix.jobs.getFormattedDesc(job, true, LocalPlayer():GetCharacter()) .. "\n"
				.. tostring(job.progress) .. "/" .. job.numberRec
				.. tostring(job.isCompleted) .. tostring(job.fieldTask and job.fieldTask.kind)
				.. tostring(job.fieldTask and job.fieldTask.stage) .. tostring(taskMap(npc, job))
		end
	end

	return table.concat(parts, "\n")
end

local PANEL = {}

function PANEL:Init()
	self:DockPadding(16, 16, 16, 16)
	self.title = addLabel(self, "TASKS", "ixMediumFont")
	self.query = ""
	self.statusFilter = "all"
	self.zoneFilter = "all"
	self.search = ix.cotzUI.StyleEntry(self:Add("DTextEntry"))
	self.search:Dock(TOP)
	self.search:SetPlaceholderText("Search tasks, contacts, objectives or zones")
	self.search:SetUpdateOnType(true)
	local paintEntry = self.search.Paint
	self.search.Paint = function(control, width, height)
		paintEntry(control, width, height)
		if control:GetText() == "" and not control:HasFocus() then
			draw.SimpleText(control:GetPlaceholderText(), "cotzUISmall", 8 * self.fontScale, height / 2,
				COLORS.muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
	self.search.OnValueChange = function(_, value)
		self.query = string.lower(string.Trim(value))
		self:Rebuild()
	end
	self.status = ix.cotzUI.StyleCombo(self:Add("DComboBox"))
	self.status:Dock(TOP)
	self.status:SetSortItems(false)
	self.status:AddChoice("All tasks", "all", true)
	self.status:AddChoice("In progress", "progress")
	self.status:AddChoice("Completed", "completed")
	self.status:SetTooltip("Completed tasks are ready to return to the contact. Handed-in tasks leave this list.")
	self.status.OnSelect = function(_, _, _, value)
		self.statusFilter = value
		self:Rebuild()
	end
	self.zone = ix.cotzUI.StyleCombo(self:Add("DComboBox"))
	self.zone:Dock(TOP)
	self.zone:SetSortItems(false)
	self.zone:AddChoice("All zones", "all", true)
	self.zone:AddChoice("Current zone", "current")
	self.zone:SetTooltip("Filter by the current objective, delivery destination or return contact. Tasks without a known zone remain visible.")
	self.zone.OnSelect = function(_, _, _, value)
		self.zoneFilter = value
		self:Rebuild()
	end
	self.journal = self:Add("DScrollPanel")
	self.journal:Dock(FILL)
	local bar = self.journal:GetVBar()
	bar:SetWide(6)
	bar:SetHideButtons(true)
	bar.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.track)
		surface.DrawRect(0, 0, width, height)
	end
	bar.btnGrip.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawRect(0, 0, width, height)
	end
	self:RefreshFonts()
	self:Rebuild()
end

function PANEL:RefreshFonts()
	local scale = ix.cotzUI.GetScale()
	if self.fontScale == scale then return end
	self.fontScale = scale
	for name, size in pairs({Title = 25, Label = 19, Small = 17}) do
		surface.CreateFont("cotzTasks" .. name, {
			font = "alsina", size = math.floor(size * scale + 0.5), weight = 500, extended = true,
		})
	end
	self.title:SetFont("cotzTasksTitle")
	for _, control in ipairs({self.search, self.status, self.zone}) do
		control:SetTall(math.ceil(34 * scale))
		control:DockMargin(0, 0, 0, math.ceil(8 * scale))
	end
end

function PANEL:AddTask(npc, job)
	local definition = ix.jobs.list[job.identifier]
	if not definition then return end
	local card = self.journal:Add("DPanel")
	card:Dock(TOP)
	card:DockMargin(0, 0, 10, 12)
	local iconSize = math.ceil(96 * self.fontScale)
	local iconWidth = math.ceil(96 * self.fontScale * 1.1)
	local iconGap = math.ceil(16 * self.fontScale)
	card:DockPadding(16, 12, 16, 12)
	card.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.card)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
	end
	addLabel(card, ix.jobs.getFormattedName(job), "cotzTasksLabel")
	addLabel(card, npc, "cotzTasksSmall", COLORS.muted)
	addLabel(card, ix.jobs.getFormattedDesc(job, true, LocalPlayer():GetCharacter()), "cotzTasksSmall")
	local completed = isCompleted(job)
	local progressText = job.targetWeights and string.format("Progress: %.2f / %d packs", job.progress, job.numberRec)
		or string.format("Progress: %d / %d", job.progress, job.numberRec)
	local status = completed and "Complete — return to " .. npc
		or progressText
	addLabel(card, status, "cotzTasksSmall", completed and COLORS.green or COLORS.text)
	local progress = card:Add("DPanel")
	progress:Dock(TOP)
	progress:SetTall(4)
	progress:DockMargin(0, 0, 0, 12)
	progress.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.track)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(completed and COLORS.green or COLORS.teal)
		surface.DrawRect(0, 0, width * math.Clamp(job.progress / math.max(1, job.numberRec), 0, 1), height)
	end
	local actions = card:Add("DPanel")
	actions:Dock(TOP)
	actions:SetTall(math.ceil(30 * self.fontScale))
	actions.Paint = function() end
	addButton(actions, "Abandon", function()
		local character = LocalPlayer():GetCharacter()
		if not character or not character:GetJobs()[npc] then return end
		local remaining = character:GetData("lastTaskAbandon", 0) - os.time()
		if remaining >= 0 then
			LocalPlayer():Notify("You can abandon another task in " .. remaining .. " seconds.")
			return
		end
		local current = character:GetJobs()[npc]
		ix.cotzUI.Query("Abandon " .. ix.jobs.getFormattedName(current) .. "? Your task progress will be lost.",
			"Abandon task", "Cancel", function() end, "Abandon", function()
				if LocalPlayer():GetCharacter() ~= character then return end
				local active = character:GetJobs()[npc]
				if not active or active.rewardKey ~= current.rewardKey or active.identifier ~= current.identifier then return end
				local remaining = character:GetData("lastTaskAbandon", 0) - os.time()
				if remaining >= 0 then
					LocalPlayer():Notify("You can abandon another task in " .. remaining .. " seconds.")
					return
				end
				netstream.Start("job_removeplayerjob", npc)
			end)
	end)
	if job.fieldTask then
		for _, option in ipairs(ix.jobs.field.GetActions(job)) do
			addButton(actions, option.label, function() ix.jobs.field.RequestAction(npc, option.action) end)
		end
	end
	local icon = card:Add("DImage")
	icon:SetImage(taskIcon(job, definition))
	icon:SetKeepAspect(true)
	icon:SetSize(iconWidth, iconSize)
	card.PerformLayout = function(this)
		icon:SetPos(this:GetWide() - 16 - iconWidth, 12)
		local textHeight = 0
		for _, child in ipairs(this:GetChildren()) do
			if child == progress then break end
			local _, top, _, bottom = child:GetDockMargin()
			child:DockMargin(0, top, iconWidth + iconGap, bottom)
			textHeight = textHeight + child:GetTall() + top + bottom
		end
		progress:DockMargin(0, math.max(0, iconSize + iconGap - textHeight), 0, 12)
		local height = 24
		for _, child in ipairs(this:GetChildren()) do
			if child ~= icon then
				local _, top, _, bottom = child:GetDockMargin()
				height = height + child:GetTall() + top + bottom
			end
		end
		height = math.max(height, iconSize + 24)
		if this:GetTall() ~= height then this:SetTall(height) end
	end
end

function PANEL:MatchesTask(npc, job)
	local completed = isCompleted(job)
	if self.statusFilter == "completed" and not completed then return false end
	if self.statusFilter == "progress" and completed then return false end
	local map = taskMap(npc, job)
	if self.zoneFilter == "current" and map and map ~= game.GetMap() then return false end
	if self.query == "" then return true end
	local text = table.concat({npc, ix.jobs.getFormattedName(job),
		ix.jobs.getFormattedDesc(job, true, self.character), map and ix.jobs.GetMapName(map) or ""}, "\n")

	return string.find(string.lower(text), self.query, 1, true) ~= nil
end

function PANEL:Rebuild()
	self.journal:Clear()
	local character = LocalPlayer():GetCharacter()
	local jobs = character and character:GetJobs() or {}
	self.snapshot = jobSignature(jobs)
	self.character = character
	self.map = game.GetMap()
	local count, total = 0, 0
	local tasks = {}
	for npc, job in SortedPairs(jobs) do
		if ix.jobs.list[job.identifier] then
			total = total + 1
			if self:MatchesTask(npc, job) then
				tasks[#tasks + 1] = {npc = npc, job = job,
					field = (job.fieldTask or ix.jobs.list[job.identifier].fieldType) and 1 or 0}
				count = count + 1
			end
		end
	end
	table.sort(tasks, function(a, b)
		if a.field ~= b.field then return a.field > b.field end

		return a.npc < b.npc
	end)
	for _, task in ipairs(tasks) do
		self:AddTask(task.npc, task.job)
	end
	local filtered = self.query ~= "" or self.statusFilter ~= "all" or self.zoneFilter ~= "all"
	self.title:SetText("TASKS · " .. count .. (filtered and " / " .. total or ""))
	if count == 0 then
		local text = total == 0 and "No active tasks. Speak to a contact to find work."
			or "No matching tasks. Clear the search or change the filters."
		addLabel(self.journal, text, "cotzTasksLabel", COLORS.muted)
	end
end

function PANEL:Think()
	if (self.nextRefresh or 0) > RealTime() then return end
	self.nextRefresh = RealTime() + 0.5
	local character = LocalPlayer():GetCharacter()
	local jobs = character and character:GetJobs() or {}
	local oldScale = self.fontScale
	self:RefreshFonts()
	if oldScale ~= self.fontScale or character ~= self.character or self.map ~= game.GetMap()
		or jobSignature(jobs) ~= self.snapshot then
		self:Rebuild()
	end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(COLORS.background)
	surface.DrawRect(0, 0, width, height)
end

vgui.Register("ixCharacterJournalPanel", PANEL, "DPanel")

netstream.Hook("ix_COTZPlayPDASound", function(data)
	if data == 1 then
		surface.PlaySound("stalkersound/pda/pda.wav")
	elseif data == 2 then
		surface.PlaySound("stalkersound/pda/pda_update.wav")
	end
end)
