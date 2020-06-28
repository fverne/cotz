local PLUGIN = PLUGIN

PLUGIN.name = "Quest System"
PLUGIN.author = "some faggot"
PLUGIN.desc = "System to keep track of quest state on characters."

local charMeta = ix.meta.character or {}

IX_QUEST_NEW	   = 10
IX_QUEST_COMPLETED = 65536

ix.util.Include("sh_definitions.lua")


--GetData("quests") here should probably be replaced with registerVar(quests) and GetQuests
function charMeta:HasQuest(questid)
	local quests = self:GetData("quests", {})

	if (quests[questid]) then
		return true
	end

	return false
end

function charMeta:HasQuestWithStageAbove(questid, stage)
	local quests = self:GetData("quests", {})

	if (quests[questid] >= stage) then
		return true
	end

	return false
end

function charMeta:HasQuestWithSpecificStage(questid, stage)
	local quests = self:GetData("quests", {})

	if (quests[questid] == stage) then
		return true
	end

	return false
end

function charMeta:CompleteQuest(questid)
	local quests = self:GetData("quests", {})

	quests[questid] = IX_QUEST_COMPLETED

	self:SetData("quests", quests)
end

function charMeta:CompleteQuestWithSpecificStage(questid)
	local quests = self:GetData("quests", {})
	
	if (quests[questid] == stage) then
		quests[questid] = IX_QUEST_COMPLETED
	end

	self:SetData("quests", quests)
end

function charMeta:CompleteQuest(questid)
	local quests = self:GetData("quests", {})

	quests[questid] = nil

	self:SetData("quests", quests)
end

function charMeta:StartQuest(questid)
	self:StartQuestWithStage(questid, IX_QUEST_NEW)
end

function charMeta:StartQuestWithStage(questid, stage)
	if(self:CanStartQuest(questid)) then
		local quests = self:GetData("quests", {})

		quests[questid] = stage

		self:SetData("quests", quests)
	end
end

function charMeta:CanStartQuest(questid)
	local quests = self:GetData("quests", {})

	if (quests[questid] == nil) then
		return true
	end

	return false
end

function charMeta:AdvanceQuestToStage(questid, stage)
	local quests = self:GetData("quests", {})

	if( self:HasQuest(questid) ) then
		quests[questid] = stage
	end
end