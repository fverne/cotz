PLUGIN.name = "Progression"
PLUGIN.author = "gumlefar"
PLUGIN.desc = ("Persistent character progression with shared world unlocks " .. "and personal NPC services.")

ix.progression = ix.progression or {}
-- Rebuild the registry on reload so removed milestones cannot remain active.
ix.progression.definitions = {}

PLUGIN.checktime = 0

function ix.progression.Register(progressionID, data)
	data.id = progressionID
	ix.progression.definitions[progressionID] = data
end

ix.util.Include("libs/sh_expansion.lua")
ix.util.Include("libs/sh_services.lua")
ix.util.Include("definitions/sh_requirementpools.lua")
ix.util.Include("definitions/sh_definitions.lua")

ix.util.Include("definitions/sh_technutprog.lua")
ix.util.Include("definitions/sh_cleanerprog.lua")
ix.util.Include("definitions/sh_hagglerprog.lua")
ix.util.Include("definitions/sh_muteprog.lua")
ix.util.Include("definitions/sh_oldtimerprog.lua")
ix.util.Include("definitions/sh_quarterprog.lua")
ix.util.Include("definitions/sh_spicylemonprog.lua")
ix.util.Include("definitions/sh_jittersprog.lua")
ix.util.Include("definitions/sh_eggheadprog.lua")
ix.util.Include("definitions/sh_bossprog.lua")
ix.util.Include("definitions/sh_beanstalkprog.lua")
ix.util.Include("definitions/sh_computerprog.lua")
ix.util.Include("definitions/sh_originalprog.lua")
ix.util.Include("definitions/sh_hoarderprog.lua")
ix.util.Include("definitions/sh_noosphereprog.lua")
ix.util.Include("definitions/sh_communityprog.lua")
ix.util.Include("definitions/sh_smartassprog.lua")
ix.util.Include("definitions/sh_arenaprog.lua")

function PLUGIN:LoadData()
	local saved = self:GetData() or {}
	self.worldUnlocks = saved.worldUnlocks or {}
end

function PLUGIN:SaveData()
	self:SetData({worldUnlocks = self.worldUnlocks or {}})
end

if SERVER then
	function PLUGIN:PlayerLoadedCharacter(client, character, previousCharacter)
		ix.progression.InitializeCharacterProgression(character)
	end

	function PLUGIN:PostLoadData()
		ix.progression.AuditDefinitions()
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
				.. "character. "
				.. "Supply milestones can increase your personal stock capacity without faster refills. "
				.. "Finish every item requirement in a task to receive "
				.. "reputation and 30% of the handed-in value. Standard programmes offer a saved choice of supplies; "
				.. "specialist commissions list their fixed supplies, service credit or catalogue rewards. "
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
			"'The Original'",
			"'Quartermaster'",
			"'Boss'",
			"'Smartass'",
			-- "'Hoarder'",
			-- "'Arena Master'",
			-- "NPC",
			-- "'???'",
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

			local capacityItems = {}
			for _, definition in pairs(ix.progression.definitions) do
				for _, reward in ipairs(definition.stockUnlocks or {}) do
					if reward.npc == npcIdentifier then
						for _, itemID in ipairs(reward.items) do
							local bonus = ix.progression.GetStockBonus(LocalPlayer():GetCharacter(), npcIdentifier, itemID)
							if bonus > 0 then
								capacityItems[itemID] = bonus
							end
						end
					end
				end
			end
			local capacityText = {}
			for itemID, bonus in pairs(capacityItems) do
				capacityText[#capacityText + 1] = ix.item.list[itemID].name .. ": +" .. bonus
			end
			table.sort(capacityText)
			if #capacityText > 0 then
				local label = container:Add("DLabel")
				label:SetFont("stalkerregularfont")
				label:SetWrap(true)
				label:SetText("Personal maximum-stock bonuses from base catalogue: "
					.. table.concat(capacityText, "; ") .. ". Passive refill speed unchanged.")
				label:Dock(TOP)
				label:SetAutoStretchVertical(true)
			end

			local earned = ix.progression.GetEarnedServiceText(LocalPlayer():GetCharacter(), npcIdentifier)
			if earned ~= "" then
				local label = container:Add("DLabel")
				label:SetFont("stalkerregularfont")
				label:SetWrap(true)
				label:SetText(earned)
				label:Dock(TOP)
				label:SetAutoStretchVertical(true)
			end

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
						ix.progression.DescribeTask(definition, definition.keyNpc, progressionStatus, character)
					local progressionDescription = container:Add("DLabel")
					progressionDescription:SetWrap(true)
					progressionDescription:SetFont("stalkerregularsmallfont")
					progressionDescription:SetText(descriptionText)
					progressionDescription:Dock(TOP)
					progressionDescription:DockMargin(0, 16, 0, 0)
					progressionDescription:SetAutoStretchVertical(true)
				end
			end

			if activeProgressions == 0 and #capacityText == 0 and earned == "" then
				npcTitle:Remove()
			end
		end
	end
end
