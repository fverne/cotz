ix.progression = ix.progression or {}

ix.char.RegisterVar("progression", {
	field = "progression",
	fieldType = "cotzMediumText",
	default = {lines = {}},
	isLocal = true,
	bNoDisplay = true,
	OnSet = function(character, value)
		local oldValue = character.vars.progression
		character.vars.progression = value

		if IsValid(character.player) then
			ix.characterNetwork.SendVar(character, "progression", value, character.player)
		end

		hook.Run("CharacterVarChanged", character, "progression", oldValue, value)
	end,
})

local function validateCharacter(character)
	assert(
		getmetatable(character) == ix.meta.character,
		"Progression storage requires an explicit Helix character"
	)
end

local function newRecord()
	return {lines = {}}
end

local function validateRecord(record)
	assert(
		istable(record) and istable(record.lines),
		"Invalid character progression record"
	)
end

local function readRecord(character)
	validateCharacter(character)

	local record = character:GetProgression()

	if record == nil then
		return newRecord()
	end

	validateRecord(record)

	return record
end

-- Return snapshots: callers must explicitly commit changes through the setter.
function ix.progression.GetCharacterProgression(character)
	return table.Copy(readRecord(character))
end

-- Frequent eligibility checks only need to copy one line, not the whole record.
function ix.progression.GetCharacterProgressionLine(character, progressionID)
	return table.Copy(readRecord(character).lines[progressionID] or {})
end

if SERVER then
	function ix.progression.SetCharacterProgression(character, record)
		validateCharacter(character)
		validateRecord(record)
		character:SetProgression(table.Copy(record))
	end

	function ix.progression.InitializeCharacterProgression(character)
		validateCharacter(character)

		if character.vars.progression == nil then
			ix.progression.SetCharacterProgression(character, newRecord())
		else
			validateRecord(character:GetProgression())
		end
		local record = ix.progression.GetCharacterProgression(character)
		local changed = false
		for _, line in pairs(record.lines) do
			if line.claiming then
				line.claiming = nil
				changed = true
			end
		end
		if changed then
			ix.progression.SetCharacterProgression(character, record)
			character:Save()
		end
		ix.progression.AssignActiveRequirements(character)
	end
end
