

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
  local class = string.lower(entity:GetClass())
  if attacker:IsPlayer() then
    if(string.find( class, "npc_mutant" )) then
      hook.Run("ix_QuestTrigger", attacker, "mutantKilled")
    end

    if class == "npc_mutant_classiczombie" then
      hook.Run("ix_QuestTrigger", attacker, "zombieKilled")
    end

    if class == "npc_mutant_rodent" then
      hook.Run("ix_QuestTrigger", attacker, "rodentKilled")
    end

    if class == "npc_mutant_snork" then
      hook.Run("ix_QuestTrigger", attacker, "snorkKilled")
    end

    if class == "npc_mutant_cat" then
      hook.Run("ix_QuestTrigger", attacker, "catKilled")
    end

    if class == "npc_mutant_bloodsucker" then
      hook.Run("ix_QuestTrigger", attacker, "bloodsuckerKilled")
    end

    if class == "npc_mutant_boar" then
      hook.Run("ix_QuestTrigger", attacker, "boarKilled")
    end  

    if class == "npc_mutant_burer" then
      hook.Run("ix_QuestTrigger", attacker, "burerKilled")
    end

    if class == "npc_mutant_chimera" then
      hook.Run("ix_QuestTrigger", attacker, "chimeraKilled")
    end

    if class == "npc_mutant_controller" then
      hook.Run("ix_QuestTrigger", attacker, "controllerKilled")
    end

    if class == "npc_mutant_dog" then
      hook.Run("ix_QuestTrigger", attacker, "dogKilled")
    end

    if class == "npc_mutant_flesh" then
      hook.Run("ix_QuestTrigger", attacker, "fleshKilled")
    end

    if class == "npc_mutant_pseudodog" then
      hook.Run("ix_QuestTrigger", attacker, "pseudodogKilled")
    end

    if class == "npc_mutant_psydog" then
      hook.Run("ix_QuestTrigger", attacker, "psydogKilled")
    end 

    if class == "npc_mutant_pseudogiant" then
      hook.Run("ix_QuestTrigger", attacker, "pseudogiantKilled")
    end
  end
end