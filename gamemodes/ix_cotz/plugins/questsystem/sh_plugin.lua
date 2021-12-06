local PLUGIN = PLUGIN

PLUGIN.name = "Quest System"
PLUGIN.author = "some faggot"
PLUGIN.desc = "System to keep track of quest state on characters."

local charMeta = ix.meta.character or {}

IX_QUEST_NEW	   = 10
IX_QUEST_COMPLETED = 65536

ix.util.Include("sh_definitions.lua")

ix.char.RegisterVar("quests", {
	field = "quests",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = true,
})

function charMeta:HasQuest(questid)
	local quests = self:GetQuests()

	if (quests[questid]) then
		return true
	end

	return false
end

function charMeta:HasQuestWithStageAbove(questid, stage)
	local quests = self:GetQuests()

	if (quests[questid] >= stage) then
		return true
	end

	return false
end

function charMeta:HasQuestWithSpecificStage(questid, stage)
	local quests = self:GetQuests()

	if (quests[questid] == stage) then
		return true
	end

	return false
end

function charMeta:CompleteQuest(questid)
	local quests = self:GetQuests()

	quests[questid] = IX_QUEST_COMPLETED

	self:SetQuests(quests)
end

function charMeta:CompleteQuestWithSpecificStage(questid, stage)
	local quests = self:GetQuests()
	
	if (quests[questid] == stage) then
		quests[questid] = IX_QUEST_COMPLETED
	end

	self:SetQuests(quests)
end

function charMeta:StartQuest(questid)
	self:StartQuestWithStage(questid, IX_QUEST_NEW)
end

function charMeta:StartQuestWithStage(questid, stage)
	if(self:CanStartQuest(questid)) then
		local quests = self:GetQuests()

		quests[questid] = stage

		self:SetQuests(quests)
	end
end

function charMeta:CanStartQuest(questid)
	local quests = self:GetQuests()

	if (quests[questid] == nil) then
		return true
	end

	return false
end

function charMeta:AdvanceQuestToStage(questid, stage)
	local quests = self:GetQuests()

	if( self:HasQuest(questid) ) then
		quests[questid] = stage
	end
end