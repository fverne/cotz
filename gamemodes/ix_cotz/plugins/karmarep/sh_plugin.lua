local PLUGIN = PLUGIN
PLUGIN.name = "KarmaREp"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Karma & Reputation System"

PLUGIN.repDefs = {
	{"Tourist", 0},
	{"Rookie", 50},
	{"Regular", 282},
	{"Experienced", 765},
	{"Veteran", 1943},
	{"Expert", 4254},
	{"Master", 9338},
	{"Legendary", 20943},
}

PLUGIN.karmaDefs = {
	{"Instrument of Ruin", -100},
	{"Fiend", -75},
	{"Outlaw", -50},
	{"Opportunist", -25},
	{"Neutral", 0},
	{"Sentinel", 25},
	{"Vigilante", 50},
	{"Peacekeeper", 75},
	{"Symbol of Order", 100},
}

ix.char.RegisterVar("reputation", {
	field = "reputation",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
})

ix.char.RegisterVar("karma", {
	field = "karma",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
})

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

function playerMeta:getKarma()
	return (self:GetNetVar("karma")) or 0
end

function playerMeta:getReputation()
	return (self:GetNetVar("reputation")) or 0
end

function playerMeta:getRepName()
	return (self:GetNetVar("repOverride")) or 0
end

function playerMeta:addKarma(amount)
	local curKarma = self:getKarma()

	self:SetNetVar("karma", 
		math.Clamp(math.min(curKarma) + amount, -100, 100)
	)
end

function playerMeta:addReputation(amount)
	self:SetNetVar("reputation", self:getReputation() + amount)
end

function playerMeta:setReputation(amount)
	self:SetNetVar("reputation", amount)
end

function playerMeta:getCurrentRankName()
	local rep = self:GetNetVar("reputation") or 0

	if self:getRepName() != 0 then
		return self:getRepName()
	end
	
	for i = 1, #PLUGIN.repDefs do
		if PLUGIN.repDefs[i][2] > rep then
			return PLUGIN.repDefs[i-1][1]
		end
	end

	return PLUGIN.repDefs[#PLUGIN.repDefs][1]
end

function playerMeta:getCurrentKarmaName()
	local karma = self:GetNetVar("karma") or 0
	
	for i = 1, #PLUGIN.karmaDefs do
		if PLUGIN.karmaDefs[i][2] >= karma then
			return PLUGIN.karmaDefs[i-1][i]
		end
	end
end

function playerMeta:getArbitraryRankName(rep)
	for i = 1, #PLUGIN.repDefs do
		if PLUGIN.repDefs[i][2] > rep then
			return PLUGIN.repDefs[i-1][1]
		end
	end

	return PLUGIN.repDefs[#PLUGIN.repDefs][1]
end

function PLUGIN:PopulateCharacterInfo(client, character, container)
	local repnametext = container:AddRow("reputation")
	repnametext:SetText(client:getCurrentRankName())
	repnametext:SetTextColor(Color(138, 43, 226))
	repnametext:SizeToContents()

	return true
end

if (SERVER) then
	local PLUGIN = PLUGIN
	
	function PLUGIN:CharacterPreSave(character)
		local savedKarma = math.Clamp(character.player:getKarma(), -100, 100)
		character:SetKarma(savedKarma)
		character:SetReputation(character.player:getReputation())
		character:SetData("repOverride", character.player:getRepName())
	end

	function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
		if (character:GetKarma()) then
			client:SetNetVar("karma", character:GetKarma())
		else
			client:SetNetVar("karma", 0)
		end
		
		if (character:GetReputation()) then
			client:SetNetVar("reputation", character:GetReputation())
		else
			client:SetNetVar("reputation", 0)
		end

		if (character:GetData("repOverride")) then
			client:SetNetVar("repOverride", character:GetData("repOverride"))
		else
			client:SetNetVar("repOverride", 0)
		end
	end

	function PLUGIN:PlayerDeath(client)
	end

	function PLUGIN:PlayerSpawn(client)
	end
end



function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local class = string.lower(entity:GetClass())
	if attacker:IsPlayer() then
	  if class == "npc_mutant_classiczombie" then
	    attacker:addReputation(0.5)
	  end

	  if class == "npc_mutant_rodent" then
	    attacker:addReputation(0.5)
	  end

	  if class == "npc_mutant_snork" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_cat" then
	    attacker:addReputation(1)
	  end

	  if class == "npc_mutant_bloodsucker" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_boar" then
	    attacker:addReputation(1)
	  end  

	  if class == "npc_mutant_burer" then
	    attacker:addReputation(3)
	  end

	  if class == "npc_mutant_chimera" then
	    attacker:addReputation(4)
	  end

	  if class == "npc_mutant_controller" then
	    attacker:addReputation(3)
	  end

	  if class == "npc_mutant_dog" then
	    attacker:addReputation(1)
	  end

	  if class == "npc_mutant_flesh" then
	    attacker:addReputation(0.5)
	  end

	  if class == "npc_mutant_pseudodog" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_psydog" then
	    attacker:addReputation(3)
	  end 

	  if class == "npc_mutant_pseudogiant" then
	    attacker:addReputation(4)
	  end
	end
end

ix.command.Add("charsetreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, reputation)
		local target = ix.util.FindPlayer(target)
		local reputation = tonumber(reputation)

		target:setReputation(reputation)

		if client == target then
            client:Notify("You have set your reputation to "..reputation)
        else
            client:Notify("You have set "..target:Name().."'s reputation to "..reputation)
            target:Notify(client:Name().." has set your reputation to "..reputation)
        end
	end
})

ix.command.Add("charaddreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, target, reputation)
		local target = ix.util.FindPlayer(target)
		local reputation = tonumber(reputation)

		target:addReputation(reputation)

		if client == target then
            client:Notify("You have added "..reputation.." to your reputation.")
        else
            client:Notify("You have added "..reputation.." to "..target:Name().."'s reputation.")
            target:Notify(client:Name().." has added "..reputation.." to your reputation.")
        end
	end
})

ix.command.Add("charcheckreputation", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, target)
		local target = ix.util.FindPlayer(target)

		if target then 
        	client:Notify(target:Name() .. " has "..target:getReputation().." reputation.")
    	else
            client:Notify("Player not found")
        end
	end
})

ix.command.Add("charrepnameset", {
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string
	},
	OnRun = function(self, client, target, name)
		local target = ix.util.FindPlayer(target)
		local reputation = name

		target:SetNetVar("repOverride", reputation)

		if client == target then
            client:Notify("Custom rankname set.")
        else
            client:Notify("Custom rankname set.")
            target:Notify(client:Name().." has set your repname.")
        end
	end
})

ix.command.Add("charrepnameremove", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, target)
		local target = ix.util.FindPlayer(target)

		target:SetNetVar("repOverride", 0)

		if client == target then
            client:Notify("Custom rankname removed.")
        else
            client:Notify("Custom rankname removed.")
            target:Notify(client:Name().." has removed your repname.")
        end
	end
})