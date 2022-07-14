ITEM.name = "Moonlight"
ITEM.model ="models/lostsignalproject/items/artefacts/moonlight.mdl"
ITEM.description = "A light blue glowing orb, sending out small static shocks when touched."
ITEM.longdesc = "When the artifact is shaken, it will discharge an incredibly powerful shock into the person holding it and everyone in a large area, most likely killing everyone not in a protective suit. There are many weapon researchers that have a great interest in this artifact, as extremely destructive weapons could be developed with its properties."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 17600
ITEM.flag = "A"
ITEM.rarity = 8
ITEM.baseweight = 0.880
ITEM.varweight  = 0.120

ITEM.functions.use = {
    name = "Shake",
    icon = "icon16/help.png",
    sound = "anomaly/electra_blast1.mp3",
    OnRun = function(item)
        if(item.player)then

            for k, v in pairs(ents.FindInSphere(item.player:GetPos(), 256)) do
                local dmg = 940
                if(v:IsPlayer()) then dmg = 260 end

                local TEMP_TargetDamage = DamageInfo()
                        
                TEMP_TargetDamage:SetDamage(dmg)
                TEMP_TargetDamage:SetAttacker(v)
                TEMP_TargetDamage:SetDamageType(DMG_SHOCK)
                TEMP_TargetDamage:SetInflictor(v)
                TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(v:GetPos()))
                TEMP_TargetDamage:SetDamageForce(v:GetForward()*10000)

                v:TakeDamageInfo(TEMP_TargetDamage)
            end

            -- Invoking player takes extra damage
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