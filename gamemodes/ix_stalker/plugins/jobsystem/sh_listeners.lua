

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local class = string.lower(entity:GetClass())
  if attacker:IsPlayer() then
    if(string.find( class, "npc_mutant" )) then
      hook.Run("ix_JobTrigger", attacker, "mutantKilled")
    end

    if class == "npc_mutant_classiczombie" or class == "npc_mutant_classiczombie_babka" or class == "npc_mutant_classiczombie_radio" or class == "npc_mutant_classiczombie_volatile" then
      hook.Run("ix_JobTrigger", attacker, "zombieKilled")
    end

    if class == "npc_mutant_rodent" then
      hook.Run("ix_JobTrigger", attacker, "rodentKilled")
    end

    if class == "npc_mutant_snork" then
      hook.Run("ix_JobTrigger", attacker, "snorkKilled")
    end

    if class == "npc_mutant_cat" then
      hook.Run("ix_JobTrigger", attacker, "catKilled")
    end

    if class == "npc_mutant_bloodsucker" then
      hook.Run("ix_JobTrigger", attacker, "bloodsuckerKilled")
    end

    if class == "npc_mutant_boar" then
      hook.Run("ix_JobTrigger", attacker, "boarKilled")
    end  

    if class == "npc_mutant_burer" then
      hook.Run("ix_JobTrigger", attacker, "burerKilled")
    end

    if class == "npc_mutant_chimera" then
      hook.Run("ix_JobTrigger", attacker, "chimeraKilled")
    end

    if class == "npc_mutant_controller" or class == "npc_mutant_controller_swamp" then
      hook.Run("ix_JobTrigger", attacker, "controllerKilled")
    end

    if class == "npc_mutant_dog" or class == "npc_mutant_hellhound" or class == "npc_mutant_pseudodog" or class == "npc_mutant_psydog" then
      hook.Run("ix_JobTrigger", attacker, "dogKilled")
    end

    if class == "npc_mutant_flesh" then
      hook.Run("ix_JobTrigger", attacker, "fleshKilled")
    end

    if class == "npc_mutant_pseudodog" then
      hook.Run("ix_JobTrigger", attacker, "pseudodogKilled")
    end

    if class == "npc_mutant_psydog" then
      hook.Run("ix_JobTrigger", attacker, "psydogKilled")
    end 

    if class == "npc_mutant_pseudogiant" then
      hook.Run("ix_JobTrigger", attacker, "pseudogiantKilled")
    end

    if class == "npc_mutant_izlom" then
      hook.Run("ix_JobTrigger", attacker, "izlomKilled")
    end

    if class == "npc_mutant_spider" then
      hook.Run("ix_JobTrigger", attacker, "spiderKilled")
    end

    if class == "npc_mutant_sprig" then
      hook.Run("ix_JobTrigger", attacker, "sprigKilled")
    end

    if class == "npc_mutant_tark" then
      hook.Run("ix_JobTrigger", attacker, "tarkKilled")
    end
  end
end

function PLUGIN:PlayerSay(sender, text, teamchat)
  if(string.find(text, "sneed")) then
    hook.Run("ix_JobTrigger", sender, "chatSayTest")
  end
end