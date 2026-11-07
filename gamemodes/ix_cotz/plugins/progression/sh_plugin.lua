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

ix.util.Include("definitions/sh_computer_story.lua")
ix.util.Include("definitions/sh_computerprog.lua")
ix.util.Include("definitions/sh_hoarderprog.lua")
ix.util.Include("definitions/sh_noosphereprog.lua")
ix.util.Include("definitions/sh_communityprog.lua")

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

function PLUGIN:CreateMenuButtons(tabs)
	tabs["progression"] = function(container)
		ix.cotzUI.Scale(1)
		local title = container:Add("DLabel")
		title:SetText("Your Progression")
		title:SetFont("cotzUITitle")
		title:SetTextColor(ix.cotzUI.colors.text)
		title:Dock(TOP)
		title:InvalidateLayout(true)
		title:SetAutoStretchVertical(true)

		local intro = container:Add("DLabel")
		intro:SetWrap(true)
		intro:SetFont("cotzUISmall")
		intro:SetTextColor(ix.cotzUI.colors.muted)
		intro:SetText(
			(
				"Discuss progression with a contact to add their current requests here. "
				.. "Below is a list of known NPCs and what they need for various "
				.. "progressions. Progress and unlocks belong to your current "
				.. "character. "
				.. "Stock rewards increase your personal stock capacity without faster refills. "
				.. "Finish every item requirement in a task to receive "
				.. "the listed town completion payment. Non-town hand-ins retain their existing payout rules. "
				.. "Commissions may also grant service credit or purchase access. "
				.. "Progression does not grant item gifts."
			)
		)
		intro:Dock(TOP)
		intro:DockMargin(0, 16, 0, 0)
		intro:SetAutoStretchVertical(true)

		local npcIdentifiers = {}
		for name in pairs(ix.townNPCs and ix.townNPCs.byName or {}) do
			local character = LocalPlayer():GetCharacter()
			local known = character:GetData("knownProgressionTopics", {})
			local discovered = false
			for id in pairs(known) do
				local definition = ix.progression.definitions[id]
				if definition and definition.keyNpc == name then discovered = true break end
			end
			if discovered and ix.progression.CanUseNPC(character, name) then
				npcIdentifiers[#npcIdentifiers + 1] = name
			end
		end
		table.sort(npcIdentifiers)

		for _, npcIdentifier in pairs(npcIdentifiers) do
			local card = ix.cotzUI.Card(container)
			local npcTitle = card:Add("DLabel")
			npcTitle:SetWrap(true)
			npcTitle:SetFont("cotzUILabel")
			npcTitle:SetTextColor(ix.cotzUI.colors.teal)
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
				local label = card:Add("DLabel")
				label:SetFont("cotzUISmall")
				label:SetTextColor(ix.cotzUI.colors.muted)
				label:SetWrap(true)
				label:SetText("Personal maximum-stock bonuses from base catalogue: "
					.. table.concat(capacityText, "; ") .. ". Passive refill speed unchanged.")
				label:Dock(TOP)
				label:SetAutoStretchVertical(true)
			end

			local earned = ix.progression.GetEarnedServiceText(LocalPlayer():GetCharacter(), npcIdentifier)
			if earned ~= "" then
				local label = card:Add("DLabel")
				label:SetFont("cotzUISmall")
				label:SetTextColor(ix.cotzUI.colors.muted)
				label:SetWrap(true)
				label:SetText(earned)
				label:Dock(TOP)
				label:SetAutoStretchVertical(true)
			end

			local activeProgressions = 0
			for _, v in
				pairs(ix.progression.GetKnownActiveProgressions(LocalPlayer():GetCharacter(), npcIdentifier))
			do
				local definition = ix.progression.definitions[v]
				local character = LocalPlayer():GetCharacter()
				local progressionStatus = definition.requirementSlots
						and ix.progression.GetComplexProgressionValue(character, v)
					or ix.progression.GetLine(character, v)

				activeProgressions = activeProgressions + 1

				local progressionTitle = card:Add("DLabel")
				progressionTitle:SetWrap(true)
				progressionTitle:SetFont("cotzUILabel")
				progressionTitle:SetTextColor(ix.cotzUI.colors.text)
				progressionTitle:SetText(definition.name)
				progressionTitle:Dock(TOP)
				progressionTitle:DockMargin(0, 16, 0, 0)
				progressionTitle:SetAutoStretchVertical(true)

				if definition.BuildResponse then
					local descriptionText =
						ix.progression.DescribeTask(definition, definition.keyNpc, progressionStatus, character)
					local heading = definition.name .. "\n"
					if descriptionText:sub(1, #heading) == heading then
						descriptionText = descriptionText:sub(#heading + 1):gsub("^\n+", "")
					end
					local progressionDescription = card:Add("DLabel")
					progressionDescription:SetWrap(true)
					progressionDescription:SetFont("cotzUISmall")
					progressionDescription:SetTextColor(ix.cotzUI.colors.text)
					progressionDescription:SetText(descriptionText)
					progressionDescription:Dock(TOP)
					progressionDescription:DockMargin(0, 16, 0, 0)
					progressionDescription:SetAutoStretchVertical(true)
				end
			end

			if activeProgressions == 0 and #capacityText == 0 and earned == "" then
				card:Remove()
			end
		end
	end
end
