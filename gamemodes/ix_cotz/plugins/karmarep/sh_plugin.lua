local PLUGIN = PLUGIN
PLUGIN.name = "KarmaREp"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Karma & Reputation System"

PLUGIN.repDefs = {
	{"Tourist", 0},
	{"Rookie", 25},
	{"Novice", 250},
	{"Regular", 750},
	{"Experienced", 1600},
	{"Professional", 4100},
	{"Veteran", 8300},
	{"Expert", 16000},
	{"Master", 24000},
	{"Legend", 32000},
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

-- Character state is authoritative; player net vars are only its display mirror.
function playerMeta:getKarma()
	if SERVER then
		local character = self:GetCharacter()

		return character and character:GetKarma() or 0
	end

	return self:GetNetVar("karma", 0)
end

function playerMeta:getReputation()
	if SERVER then
		local character = self:GetCharacter()

		return character and character:GetReputation() or 0
	end

	return self:GetNetVar("reputation", 0)
end

function playerMeta:getRepName()
	if SERVER then
		local character = self:GetCharacter()

		return character and character:GetData("repOverride", 0) or 0
	end

	return self:GetNetVar("repOverride", 0)
end

function playerMeta:addKarma(amount)
	if not SERVER then return end
	local character = self:GetCharacter()
	if not character then return end
	local karma = math.Clamp(character:GetKarma() + amount, -100, 100)

	character:SetKarma(karma)
	self:SetNetVar("karma", karma)
end

function playerMeta:addReputation(amount)
	self:setReputation(self:getReputation() + amount)
end

function playerMeta:setReputation(amount)
	if not SERVER then return end
	local character = self:GetCharacter()
	if not character then return end

	character:SetReputation(amount)
	self:SetNetVar("reputation", amount)
end

function playerMeta:SetRepName(name)
	if not SERVER then return end
	local character = self:GetCharacter()
	if not character then return end

	character:SetData("repOverride", name)
	self:SetNetVar("repOverride", name)
end

function playerMeta:getCurrentRankName()
	local rep = self:getReputation()

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
	local karma = self:getKarma()
	
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

if SERVER then
	function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
		client:SetNetVar("karma", character:GetKarma())
		client:SetNetVar("reputation", character:GetReputation())
		client:SetNetVar("repOverride", character:GetData("repOverride", 0))
	end

	function PLUGIN:PlayerDeath(client)
	end

	function PLUGIN:PlayerSpawn(client)
	end
end



function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local class = string.lower(entity:GetClass())
	if attacker:IsPlayer() then
	  if string.find( class, "npc_human_z" ) then
		attacker:addReputation(0.5)
	  end

	  if string.find( class, "npc_human_bandit" ) then
		attacker:addReputation(1)
	  end

	  if string.find( class, "npc_human_merc" ) then
		attacker:addReputation(1.5)
	  end

	  if string.find( class, "npc_human_mili" ) then
		attacker:addReputation(2)
	  end

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

	  if class == "npc_mutant_hellhound" then
	    attacker:addReputation(3)
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

	  if class == "npc_mutant_sprig" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_karlik" then
	    attacker:addReputation(4)
	  end

	  if class == "npc_mutant_izlom" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_vareshka" then
	    attacker:addReputation(2.5)
	  end

	  if class == "npc_mutant_burer" then
	    attacker:addReputation(3.5)
	  end

	  if class == "npc_mutant_skeleton" then
	    attacker:addReputation(2)
	  end

	  if class == "npc_mutant_tark" then
	    attacker:addReputation(2)
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

		target:SetRepName(reputation)

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

		target:SetRepName(0)

		if client == target then
            client:Notify("Custom rankname removed.")
        else
            client:Notify("Custom rankname removed.")
            target:Notify(client:Name().." has removed your repname.")
        end
	end
})
