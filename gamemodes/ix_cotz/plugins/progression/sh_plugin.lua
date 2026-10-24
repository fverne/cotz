PLUGIN.name = "Progression"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Persistent character progression with shared world unlocks and personal NPC services."

ix.progression = ix.progression or {}
ix.progression.definitions = ix.progression.definitions or {}

PLUGIN.checktime = 0

function ix.progression.Register(progid, data)
	ix.progression.definitions[progid] = data
end

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

-- Legacy completion restores world changes without seeding personal progress.
function PLUGIN:LoadData()
	local saved = self:GetData() or {}
	self.legacyProgression = saved.version == 2 and saved.legacy or saved
	self.worldUnlocks = saved.worldUnlocks or {}
	for progid, definition in pairs(ix.progression.definitions) do
		local legacy = self.legacyProgression and self.legacyProgression[progid]
		if definition.worldNPC and istable(legacy) and legacy.completed then
			self.worldUnlocks[progid] = true
		end
	end
end

function PLUGIN:SaveData()
	self:SetData({version = 2, legacy = self.legacyProgression or {}, worldUnlocks = self.worldUnlocks or {}})
end

if (SERVER) then
	function PLUGIN:PlayerLoadedCharacter(client, character, previousCharacter)
		ix.progression.InitializeCharacterProgression(character)
	end

	function PLUGIN:PostLoadData()
		self.worldDataLoaded = true
		self:SetupProgressionWorld()
	end

	function PLUGIN:Think()
		if (not self.worldDataLoaded or (self.checktime or 0) > CurTime()) then return end
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
        intro:SetText("Below is a list of known NPCs and what they need for various progressions. Progress and unlocks belong to your current character.")
        intro:Dock(TOP)
        intro:DockMargin(0, 16, 0, 0)
        intro:SetAutoStretchVertical(true)

		local npcidentifiers = {}
		local initialNpcs = {
			"'Old Timer'",
			"'Technut'",
			"'Jitters'",
			"'Cleaner'",
			"'Quartermaster'",
			"'Boss'",
			"'Smartass'",
		}

		table.Add(npcidentifiers, initialNpcs)

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerKillIntro") then
			local tradenpc = {
				"'Haggler'",
			}
			table.Add(npcidentifiers, tradenpc)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerItemDelivery_mainMeat") then
			local cooknpc = {
				"'Spicy Lemon'",
			}
			table.Add(npcidentifiers, cooknpc)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "oldTimerItemDelivery_mainStatue") then
			local mutenpc = {
				"'Mute'",
			}
			table.Add(npcidentifiers, mutenpc)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "smartass_rfTasks") then
			local ecologistNpcs = {
				"'Egghead'",
				"'Beanstalk'",
				"'Intern'",
			}
			table.Add(npcidentifiers, ecologistNpcs)
		end

		if ix.progression.IsCompleted(LocalPlayer():GetCharacter(), "intern_gasAnalyzerReadings") then
			local pripyatNpcs = {
				"'Computer'",
			}
			table.Add(npcidentifiers, pripyatNpcs)
		end

		for _, npcidentifier in pairs(npcidentifiers) do
			local npctitle = container:Add("DLabel")
			npctitle:SetWrap(true)
			npctitle:SetFont("stalkerregularbigfont")
			npctitle:SetText(npcidentifier)
			npctitle:Dock(TOP)
			npctitle:DockMargin(0, 16, 0, 0)
			npctitle:SetAutoStretchVertical(true)

			local activeProgressions = 0
			for k, v in pairs(ix.progression.GetActiveProgressions(LocalPlayer():GetCharacter(), npcidentifier)) do
				local progdef = ix.progression.definitions[v]
				local character = LocalPlayer():GetCharacter()
				local progstatus = progdef.GetItemIds and ix.progression.GetComplexProgressionValue(character, v)
					or ix.progression.GetLine(character, v)
				
				activeProgressions = activeProgressions + 1
	
				local progressiontitle = container:Add("DLabel")
				progressiontitle:SetWrap(true)
				progressiontitle:SetFont("stalkerregularfont")
				progressiontitle:SetText(progdef.name)
				progressiontitle:Dock(TOP)
				progressiontitle:DockMargin(0, 16, 0, 0)
				progressiontitle:SetAutoStretchVertical(true)

	
				if (progdef.BuildResponse) then
					local descriptiontext = progdef:BuildResponse(progdef.keyNpc, progstatus)
					local progressiondescription = container:Add("DLabel")
					progressiondescription:SetWrap(true)
					progressiondescription:SetFont("stalkerregularsmallfont")
					progressiondescription:SetText(descriptiontext)
					progressiondescription:Dock(TOP)
					progressiondescription:DockMargin(0, 16, 0, 0)
					progressiondescription:SetAutoStretchVertical(true)
				end
			end

			if activeProgressions == 0 then
				npctitle:Remove()
			end
		end
	end
end
