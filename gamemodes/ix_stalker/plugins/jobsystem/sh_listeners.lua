

local function CalculateCredit(entity, attacker, trigger)
  hook.Run("ix_JobTrigger", attacker, trigger)

  local players = {}

  for k,v in pairs(ents.FindInSphere( attacker:GetPos(), 1024 )) do
    if (v:IsPlayer() and v != attacker) then
      players[v:EntIndex()] = true
      hook.Run("ix_JobTrigger", v, trigger)
    end
  end
  for k,v in pairs(ents.FindInSphere( entity:GetPos(), 1024 )) do
    if (v:IsPlayer() and v != attacker and !players[v:EntIndex()]) then
      hook.Run("ix_JobTrigger", v, trigger)
    end
  end
end

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local class = string.lower(entity:GetClass())
  if attacker:IsPlayer() then
    if(string.find( class, "npc_mutant" )) then
      CalculateCredit(entity, attacker, "mutantKilled")
    end

    if class == "npc_mutant_classiczombie" or class == "npc_mutant_classiczombie_babka" or class == "npc_mutant_classiczombie_radio" or class == "npc_mutant_classiczombie_volatile" then
      CalculateCredit(entity, attacker, "zombieKilled")
    end

    if class == "npc_mutant_rodent" then
      CalculateCredit(entity, attacker, "rodentKilled")
    end

    if class == "npc_mutant_snork" then
      CalculateCredit(entity, attacker, "snorkKilled")
    end

    if class == "npc_mutant_cat" then
      CalculateCredit(entity, attacker, "catKilled")
    end

    if class == "npc_mutant_bloodsucker" then
      CalculateCredit(entity, attacker, "bloodsuckerKilled")
    end

    if class == "npc_mutant_boar" then
      CalculateCredit(entity, attacker, "boarKilled")
    end  

    if class == "npc_mutant_burer" then
      CalculateCredit(entity, attacker, "burerKilled")
    end

    if class == "npc_mutant_chimera" then
      CalculateCredit(entity, attacker, "chimeraKilled")
    end

    if class == "npc_mutant_controller" or class == "npc_mutant_controller_swamp" then
      CalculateCredit(entity, attacker, "controllerKilled")
    end

    if class == "npc_mutant_dog" or class == "npc_mutant_hellhound" or class == "npc_mutant_pseudodog" or class == "npc_mutant_psydog" then
      CalculateCredit(entity, attacker, "dogKilled")
    end

    if class == "npc_mutant_flesh" then
      CalculateCredit(entity, attacker, "fleshKilled")
    end

    if class == "npc_mutant_pseudodog" then
      CalculateCredit(entity, attacker, "pseudodogKilled")
    end

    if class == "npc_mutant_psydog" then
      CalculateCredit(entity, attacker, "psydogKilled")
    end 

    if class == "npc_mutant_pseudogiant" then
      CalculateCredit(entity, attacker, "pseudogiantKilled")
    end

    if class == "npc_mutant_izlom" then
      CalculateCredit(entity, attacker, "izlomKilled")
    end

    if class == "npc_mutant_spider" then
      CalculateCredit(entity, attacker, "spiderKilled")
    end

    if class == "npc_mutant_sprig" then
      CalculateCredit(entity, attacker, "sprigKilled")
    end

    if class == "npc_mutant_tark" then
      CalculateCredit(entity, attacker, "tarkKilled")
    end
  end
end

function PLUGIN:PlayerSay(sender, text, teamchat)
  if(string.find(text, "sneed")) then
    hook.Run("ix_JobTrigger", sender, "chatSayTest")
  end
end