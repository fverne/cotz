ITEM.name = "Flash"
ITEM.model ="models/lostsignalproject/items/artefacts/glass.mdl"
ITEM.description = "A small, light blue orb that glows with a yellow sheen."
ITEM.longdesc = "When the artifact is shaken, it will discharge a powerful shock into the hand of the person holding it and everyone standing close by. Scientists are very interested in the function of this artifact, as it might help with further development of electricity generation."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 8900
ITEM.flag = "A"
ITEM.rarity = 4
ITEM.baseweight = 0.680
ITEM.varweight  = 0.100

ITEM.functions.use = {
	name = "Shake",
    icon = "icon16/help.png",
    sound = "anomaly/electra_blast1.mp3",
    OnRun = function(item)
        if(item.player)then

            for k, v in pairs(ents.FindInSphere(item.player:GetPos(), 256)) do
                local dmg = 200
                if(v:IsPlayer()) then dmg = 80 end

                local TEMP_TargetDamage = DamageInfo()
                        
                TEMP_TargetDamage:SetDamage(dmg)
                TEMP_TargetDamage:SetAttacker(v)
                TEMP_TargetDamage:SetDamageType(DMG_SHOCK)
                TEMP_TargetDamage:SetInflictor(v)
                TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(v:GetPos()))
                TEMP_TargetDamage:SetDamageForce(v:GetForward()*10000)

                v:TakeDamageInfo(TEMP_TargetDamage)
            end

            -- Invoking player takes double damage
            local TEMP_TargetDamage = DamageInfo()
                        
            TEMP_TargetDamage:SetDamage(80)
            TEMP_TargetDamage:SetAttacker(item.player)
            TEMP_TargetDamage:SetDamageType(DMG_SHOCK)
            TEMP_TargetDamage:SetInflictor(item.player)
            TEMP_TargetDamage:SetDamagePosition(item.player:NearestPoint(item.player:GetPos()))
            TEMP_TargetDamage:SetDamageForce(item.player:GetForward()*10000)

            item.player:TakeDamageInfo(TEMP_TargetDamage)

            ParticleEffect( "electra_activated", item.player:GetPos() + Vector(0,0,16), Angle( 0, 0, 0 ) )
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}