ITEM.name = "Sparkler"
ITEM.model ="models/lostsignalproject/items/artefacts/electra_flash.mdl"
ITEM.description = "A small, light blue, glowing orb."
ITEM.longdesc = "When the artifact is shaken, it will discharge a small static shock into the hand of the person holding it. Scientists are interested in the function of this artifact, as it might help with further development of electricity generation."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 4100
ITEM.flag = "A"
ITEM.rarity = 2
ITEM.baseweight = 0.480
ITEM.varweight  = 0.080

ITEM.functions.use = {
	name = "Shake",
    icon = "icon16/help.png",
    sound = "anomaly/electra_blast1.mp3",
    OnRun = function(item)
        if(item.player)then

            local TEMP_TargetDamage = DamageInfo()
                        
            TEMP_TargetDamage:SetDamage(10)
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