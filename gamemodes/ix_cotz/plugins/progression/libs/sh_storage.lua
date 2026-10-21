ix.progression = ix.progression or {}

local DATA_KEY = "progression"
local DATA_VERSION = 2

local function ValidateCharacter(character)
	assert(getmetatable(character) == ix.meta.character,
		"Progression storage requires an explicit Helix character")
end

local function NewRecord()
	return {version = DATA_VERSION, lines = {}}
end

local function ValidateRecord(record)
	assert(istable(record) and record.version == DATA_VERSION and istable(record.lines),
		"Unsupported or invalid character progression record")
end

local function ReadRecord(character)
	ValidateCharacter(character)

	local record = character:GetData(DATA_KEY)

	if (record == nil) then
		return NewRecord()
	end

	ValidateRecord(record)

	return record
end

-- Return snapshots: callers must explicitly commit changes through the setter.
function ix.progression.GetCharacterProgression(character)
	return table.Copy(ReadRecord(character))
end

-- Frequent eligibility checks only need to copy one line, not the whole record.
function ix.progression.GetCharacterProgressionLine(character, progid)
	return table.Copy(ReadRecord(character).lines[progid] or {})
end

if (SERVER) then
	-- SetData replicates only to the owner; Helix's character save persists it.
	function ix.progression.SetCharacterProgression(character, record)
		ValidateCharacter(character)
		ValidateRecord(record)
		character:SetData(DATA_KEY, table.Copy(record))
	end

	-- Never seed personal progress from the legacy server-wide status table.
	function ix.progression.InitializeCharacterProgression(character)
		ValidateCharacter(character)

		if (character:GetData(DATA_KEY) == nil) then
			ix.progression.SetCharacterProgression(character, NewRecord())
		else
			ValidateRecord(character:GetData(DATA_KEY))
		end
	end
end
