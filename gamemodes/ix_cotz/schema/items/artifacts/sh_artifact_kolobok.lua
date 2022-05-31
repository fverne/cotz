ITEM.name = "Kolobok"
ITEM.model ="models/lostsignalproject/items/artefacts/kolobok.mdl"
ITEM.description = "Very spikey artifact."
ITEM.longdesc = "An extremely spiky artifact. It resembles its more common cousin, the Urchin artifact, however, unlike the Urchin this artifact has a gooey, pulsating, almost fleshlike substance around the solid core. Not much is known about this substance, but it seems almost alive, shuddering when exposed to irradiated blood.\nLike the Urchin, it can be used to purge radiation from a persons body, but this artifact is much more efficient, but will also cause a lot more harm to the subject. Most STALKERs do not attempt using this artifact without wearing a decent suit, since only a few of the spikes should be in contact with your body, as more than a couple will most likely kill the user."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 14600
ITEM.flag = "A"
ITEM.rarity = 7
ITEM.baseweight = 1.200
ITEM.varweight  = 0.200

ITEM.functions.use = {
	name = "Stab Self",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
    	local TEMP_TargetDamage = DamageInfo()
						
		ix.util.PlayerPerformBlackScreenAction(item.player, "Stabbing self with Kolobok", 4, function(player) 
            TEMP_TargetDamage:SetDamage(180)
			TEMP_TargetDamage:SetAttacker(player)
			TEMP_TargetDamage:SetDamageType(DMG_BULLET)
			TEMP_TargetDamage:SetInflictor(player)
			TEMP_TargetDamage:SetDamagePosition(player:GetPos())
			player:TakeDamageInfo(TEMP_TargetDamage)

			player:addRadiation(-95)
        end)

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}