

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
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
    end

    if class == "npc_mutant_rodent" then
      CalculateCredit(entity, attacker, "rodentKilled")
    end

    if class == "npc_mutant_karlik" then
      CalculateCredit(entity, attacker, "karlikKilled")
      CalculateCredit(entity, attacker, "groupPsyKilled")
    end

    if class == "npc_mutant_snork" then
      CalculateCredit(entity, attacker, "snorkKilled")
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
    end

    if class == "npc_mutant_cat" then
      CalculateCredit(entity, attacker, "catKilled")
      CalculateCredit(entity, attacker, "groupPredatorKilled")
    end

    if class == "npc_mutant_bloodsucker" then
      CalculateCredit(entity, attacker, "bloodsuckerKilled")
      CalculateCredit(entity, attacker, "groupPredatorKilled")
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
    end

    if class == "npc_mutant_boar" then
      CalculateCredit(entity, attacker, "boarKilled")
      CalculateCredit(entity, attacker, "groupMeatKilled")
    end  

    if class == "npc_mutant_burer" then
      CalculateCredit(entity, attacker, "burerKilled")
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
      CalculateCredit(entity, attacker, "groupPsyKilled")
    end

    if class == "npc_mutant_chimera" then
      CalculateCredit(entity, attacker, "chimeraKilled")
    end

    if class == "npc_mutant_chimera_electro" then
      CalculateCredit(entity, attacker, "electrochimeraKilled")
    end

    if class == "npc_mutant_controller" or class == "npc_mutant_controller_swamp" or class == "npc_mutant_controller_electro" or class == "npc_mutant_controller_fast" then
      CalculateCredit(entity, attacker, "controllerKilled")
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
      CalculateCredit(entity, attacker, "groupPsyKilled")
    end

    if class == "npc_mutant_dog" then
      CalculateCredit(entity, attacker, "blinddogKilled")
      CalculateCredit(entity, attacker, "groupCanineKilled")
    end

    if class == "npc_mutant_hellhound" then
      CalculateCredit(entity, attacker, "hellhoundKilled")
      CalculateCredit(entity, attacker, "groupCanineKilled")
    end

    if class == "npc_mutant_flesh" then
      CalculateCredit(entity, attacker, "fleshKilled")
      CalculateCredit(entity, attacker, "groupMeatKilled")
    end

    if class == "npc_mutant_pseudodog" then
      CalculateCredit(entity, attacker, "pseudodogKilled")
      CalculateCredit(entity, attacker, "groupCanineKilled")
    end

    if class == "npc_mutant_psydog" then
      CalculateCredit(entity, attacker, "psydogKilled")
      CalculateCredit(entity, attacker, "groupCanineKilled")
      CalculateCredit(entity, attacker, "groupPsyKilled")
    end 

    if class == "npc_mutant_pseudogiant_fast" or class == "npc_mutant_pseudogiant_slow" then
      CalculateCredit(entity, attacker, "pseudogiantKilled")
    end

    if class == "npc_mutant_izlom" then
      CalculateCredit(entity, attacker, "izlomKilled")
      CalculateCredit(entity, attacker, "groupHumanoidKilled")
    end

    if class == "npc_mutant_spider" then
      CalculateCredit(entity, attacker, "spiderKilled")
      CalculateCredit(entity, attacker, "groupPredatorKilled")
    end

    if class == "npc_mutant_sprig" then
      CalculateCredit(entity, attacker, "sprigKilled")
      CalculateCredit(entity, attacker, "groupPredatorKilled")
    end

    if class == "npc_mutant_tark" then
      CalculateCredit(entity, attacker, "tarkKilled")
      CalculateCredit(entity, attacker, "groupMeatKilled")
    end

    if class == "npc_mutant_bear" then
      CalculateCredit(entity, attacker, "bearKilled")
      CalculateCredit(entity, attacker, "groupPredatorKilled")
    end

    if class == "npc_mutant_vareshka" then
      CalculateCredit(entity, attacker, "vareshkaKilled")
    end

    if class == "npc_mutant_skeleton" then
      CalculateCredit(entity, attacker, "skeletonKilled")
    end
  end
end

function PLUGIN:PlayerSay(sender, text, teamchat)
  if(string.find(text, "sneed")) then
    hook.Run("ix_JobTrigger", sender, "chatSayTest")
  end
end