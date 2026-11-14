ITEM.name = "Moonlight"
ITEM.model ="models/lostsignalproject/items/artefacts/moonlight.mdl"
ITEM.description = "A light blue glowing orb, sending out small static shocks when touched."
ITEM.longdesc = "When the artifact is shaken, it will discharge an incredibly powerful shock into the person holding it and everyone in a large area, most likely killing everyone not in a protective suit. There are many weapon researchers that have a great interest in this artifact, as extremely destructive weapons could be developed with its properties."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 33000
ITEM.flag = "A"
ITEM.rarity = 8
ITEM.baseweight = 0.880
ITEM.varweight  = 0.120

ITEM.dischargeRadius = 256
ITEM.dischargeDamage = 940
ITEM.dischargePlayerDamage = 260
ITEM.operatorDamage = 80

ITEM.functions.use = {
    name = "Shake",
    icon = "icon16/help.png",
    sound = "anomaly/electra_blast1.mp3",
    OnRun = function(item)
        if  item.player and ( item:GetData("cooldown",0) < os.time() ) then
            item:SetData("cooldown", os.time() + 0.4 )
            for k, v in pairs(ents.FindInSphere(item.player:GetPos(), item.dischargeRadius)) do
                local dmg = item.dischargeDamage
                local attacker = item.player
                if(v:IsPlayer()) then 
                    dmg = item.dischargePlayerDamage
                    attacker = v
                end

                local TEMP_TargetDamage = DamageInfo()
                        
                TEMP_TargetDamage:SetDamage(dmg)
                TEMP_TargetDamage:SetAttacker(attacker)
                TEMP_TargetDamage:SetDamageType(DMG_SHOCK)
                TEMP_TargetDamage:SetInflictor(attacker)
                TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(v:GetPos()))
                TEMP_TargetDamage:SetDamageForce(v:GetForward()*10000)

                v:TakeDamageInfo(TEMP_TargetDamage)
            end

            -- Invoking player takes extra damage
            local TEMP_TargetDamage = DamageInfo()
                        
            TEMP_TargetDamage:SetDamage(item.operatorDamage)
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
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

function ITEM:GetIndividualProperties()
	return {
		{id = "dischargeRadius", text = "Discharge radius: " .. ix.itemProperties.Format("distance", self.dischargeRadius)},
		{id = "dischargePlayers", text = "Discharge impact (players): "
			.. ix.itemProperties.Format("health", -self.dischargePlayerDamage)},
		{id = "dischargeOthers", text = "Discharge impact (other targets): "
			.. ix.itemProperties.Format("health", -self.dischargeDamage)},
		{id = "operatorDamage", text = "Additional operator injury: "
			.. ix.itemProperties.Format("health", -self.operatorDamage)},
	}
end
