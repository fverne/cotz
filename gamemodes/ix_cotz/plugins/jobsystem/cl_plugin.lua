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

local function jobSignature(jobs)
	local parts = {}
	for npc, job in SortedPairs(jobs) do
		if ix.jobs.list[job.identifier] then
			parts[#parts + 1] = npc .. "\n" .. ix.jobs.getFormattedName(job) .. "\n"
				.. ix.jobs.getFormattedDesc(job) .. "\n" .. tostring(job.progress) .. "/" .. job.numberRec
				.. tostring(job.isCompleted) .. tostring(job.fieldTask and job.fieldTask.kind)
		end
	end

	return table.concat(parts, "\n")
end

local PANEL = {}

function PANEL:Init()
	self:DockPadding(16, 16, 16, 16)
	self.title = addLabel(self, "TASKS", "ixMediumFont")
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
	local scale = math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.75, 2)
	if self.fontScale == scale then return end
	self.fontScale = scale
	for name, size in pairs({Title = 25, Label = 19, Small = 17}) do
		surface.CreateFont("cotzTasks" .. name, {
			font = "alsina", size = math.floor(size * scale), weight = 500, extended = true,
		})
	end
	self.title:SetFont("cotzTasksTitle")
end

function PANEL:AddTask(npc, job)
	local definition = ix.jobs.list[job.identifier]
	if not definition then return end
	local card = self.journal:Add("DPanel")
	card:Dock(TOP)
	card:DockMargin(0, 0, 10, 12)
	card:DockPadding(16, 12, 16, 12)
	card.Paint = function(_, width, height)
		surface.SetDrawColor(COLORS.card)
		surface.DrawRect(0, 0, width, height)
		surface.SetDrawColor(COLORS.border)
		surface.DrawOutlinedRect(0, 0, width, height)
	end
	addLabel(card, ix.jobs.getFormattedName(job), "cotzTasksLabel")
	addLabel(card, npc, "cotzTasksSmall", COLORS.muted)
	addLabel(card, ix.jobs.getFormattedDesc(job), "cotzTasksSmall")
	local completed = job.isCompleted or job.progress >= job.numberRec
	local status = completed and "Complete — return to " .. npc
		or string.format("Progress: %d / %d", job.progress, job.numberRec)
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
		netstream.Start("job_removeplayerjob", npc)
	end)
	if job.fieldTask then
		addButton(actions, "Field work", function() ix.jobs.field.OpenMenu(npc, job.fieldTask.kind) end)
	end
	card.PerformLayout = function(this)
		local height = 24
		for _, child in ipairs(this:GetChildren()) do
			local _, top, _, bottom = child:GetDockMargin()
			height = height + child:GetTall() + top + bottom
		end
		if this:GetTall() ~= height then this:SetTall(height) end
	end
end

function PANEL:Rebuild()
	self.journal:Clear()
	local character = LocalPlayer():GetCharacter()
	local jobs = character and character:GetJobs() or {}
	self.snapshot = jobSignature(jobs)
	self.character = character
	local count = 0
	for npc, job in SortedPairs(jobs) do
		if ix.jobs.list[job.identifier] then
			self:AddTask(npc, job)
			count = count + 1
		end
	end
	self.title:SetText("TASKS · " .. count)
	if count == 0 then
		addLabel(self.journal, "No active tasks. Speak to a contact to find work.", "cotzTasksLabel", COLORS.muted)
	end
end

function PANEL:Think()
	if (self.nextRefresh or 0) > RealTime() then return end
	self.nextRefresh = RealTime() + 0.5
	local character = LocalPlayer():GetCharacter()
	local jobs = character and character:GetJobs() or {}
	local oldScale = self.fontScale
	self:RefreshFonts()
	if oldScale ~= self.fontScale or character ~= self.character or jobSignature(jobs) ~= self.snapshot then
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
