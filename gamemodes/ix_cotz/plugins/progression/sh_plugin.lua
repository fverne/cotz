PLUGIN.name = "Progression"
PLUGIN.author = "gumlefar"
PLUGIN.desc = ("Persistent character progression with shared world unlocks " .. "and personal NPC services.")

ix.progression = ix.progression or {}
ix.progression.definitions = ix.progression.definitions or {}

PLUGIN.checktime = 0

function ix.progression.Register(progressionID, data)
	data.id = progressionID
	ix.progression.definitions[progressionID] = data
end

ix.util.Include("sh_requirementpools.lua")
ix.util.Include("sh_definitions.lua")

ix.util.Include("sh_technutprog.lua")
ix.util.Include("sh_cleanerprog.lua")
ix.util.Include("sh_hagglerprog.lua")
ix.util.Include("sh_muteprog.lua")
ix.util.Include("sh_oldtimerprog.lua")
ix.util.Include("sh_quarterprog.lua")
ix.util.Include("sh_spicylemonprog.lua")
ix.util.Include("sh_jittersprog.lua")
ix.util.Include("sh_eggheadprog.lua")
ix.util.Include("sh_bossprog.lua")

function PLUGIN:LoadData()
	local saved = self:GetData() or {}
	self.worldUnlocks = saved.worldUnlocks or {}
end

function PLUGIN:SaveData()
	self:SetData({ version = 3, worldUnlocks = self.worldUnlocks or {} })
end

if SERVER then
	function PLUGIN:PlayerLoadedCharacter(client, character, previousCharacter)
		ix.progression.InitializeCharacterProgression(character)
	end

	function PLUGIN:PostLoadData()
		ix.progression.ValidateRequirementPools()
		self.worldDataLoaded = true
		self:SetupProgressionWorld()
	end

	function PLUGIN:Think()
		if not self.worldDataLoaded or (self.checktime or 0) > CurTime() then
			return
		end
		self.checktime = CurTime() + 15
		self:SetupProgressionWorld()
	end
end

function PLUGIN:PopulateHelpMenu(tabs)
	tabs["progression"] = function(container)
		local title = container:Add("DLabel")
		title:SetText("Your Progression")
		title:SetFont("stalkerregularbigfont")
		title:Dock(TOP)
		title:InvalidateLayout(true)
		title:SetAutoStretchVertical(true)

		local intro = container:Add("DLabel")
		intro:SetWrap(true)
		intro:SetFont("stalkerregularfont")
		intro:SetText(
			(
				"Below is a list of known NPCs and what they need for various "
				.. "progressions. Progress and unlocks belong to your current "
				.. "character. Finish every item requirement in a task to receive "
				.. "reputation, 30% of the handed-in value, and one item from a requested group. "
				.. "Groups with only one item give extra money instead."
			)
		)
		intro:Dock(TOP)
		intro:DockMargin(0, 16, 0, 0)
		intro:SetAutoStretchVertical(true)

		local npcIdentifiers = {}
		local initialNpcs = {
			"'Old Timer'",
			"'Technut'",
			"'Jitters'",
			"'Cleaner'",
			"'Quartermaster'",
			"'Boss'",
			"'Smartass'",
		}

		table.Add(npcIdentifiers, initialNpcs)

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerKillIntro") then
			local tradeNPC = {
				"'Haggler'",
			}
			table.Add(npcIdentifiers, tradeNPC)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerItemDelivery_mainMeat") then
			local cookNPC = {
				"'Spicy Lemon'",
			}
			table.Add(npcIdentifiers, cookNPC)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerItemDelivery_mainStatue") then
			local muteNPC = {
				"'Mute'",
			}
			table.Add(npcIdentifiers, muteNPC)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "smartass_rfTasks") then
			local ecologistNpcs = {
				"'Egghead'",
				"'Beanstalk'",
				"'Intern'",
			}
			table.Add(npcIdentifiers, ecologistNpcs)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "intern_gasAnalyzerReadings") then
			local pripyatNpcs = {
				"'Computer'",
			}
			table.Add(npcIdentifiers, pripyatNpcs)
		end

		for _, npcIdentifier in pairs(npcIdentifiers) do
			local npcTitle = container:Add("DLabel")
			npcTitle:SetWrap(true)
			npcTitle:SetFont("stalkerregularbigfont")
			npcTitle:SetText(npcIdentifier)
			npcTitle:Dock(TOP)
			npcTitle:DockMargin(0, 16, 0, 0)
			npcTitle:SetAutoStretchVertical(true)

			local activeProgressions = 0
			for _, v in
				pairs(ix.progression.GetActiveProgressions(LocalPlayer():GetCharacter(), npcIdentifier))
			do
				local definition = ix.progression.definitions[v]
				local character = LocalPlayer():GetCharacter()
				local progressionStatus = definition.requirementSlots
						and ix.progression.GetComplexProgressionValue(character, v)
					or ix.progression.GetLine(character, v)

				activeProgressions = activeProgressions + 1

				local progressionTitle = container:Add("DLabel")
				progressionTitle:SetWrap(true)
				progressionTitle:SetFont("stalkerregularfont")
				progressionTitle:SetText(definition.name)
				progressionTitle:Dock(TOP)
				progressionTitle:DockMargin(0, 16, 0, 0)
				progressionTitle:SetAutoStretchVertical(true)

				if definition.BuildResponse then
					local descriptionText =
						definition:BuildResponse(definition.keyNpc, progressionStatus, character)
					local progressionDescription = container:Add("DLabel")
					progressionDescription:SetWrap(true)
					progressionDescription:SetFont("stalkerregularsmallfont")
					progressionDescription:SetText(descriptionText)
					progressionDescription:Dock(TOP)
					progressionDescription:DockMargin(0, 16, 0, 0)
					progressionDescription:SetAutoStretchVertical(true)
				end
			end

			if activeProgressions == 0 then
				npcTitle:Remove()
			end
		end
	end
end
