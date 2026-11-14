ITEM.name = "Kolobok"
ITEM.model ="models/lostsignalproject/items/artefacts/kolobok.mdl"
ITEM.description = "Very spikey artifact."
ITEM.longdesc = "An extremely spiky artifact. It resembles its more common cousin, the Urchin artifact, however, unlike the Urchin this artifact has a gooey, pulsating, almost fleshlike substance around the solid core. Not much is known about this substance, but it seems almost alive, shuddering when exposed to irradiated blood.\nLike the Urchin, it can be used to purge radiation from a persons body, but this artifact is much more efficient, but will also cause a lot more harm to the subject. Most STALKERs do not attempt using this artifact without wearing a decent suit, since only a few of the spikes should be in contact with your body, as more than a couple will most likely kill the user."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 27375
ITEM.flag = "A"
ITEM.rarity = 7
ITEM.baseweight = 1.200
ITEM.varweight  = 0.200

ITEM.contactDamage = 99
ITEM.radiationRemoved = 95
ITEM.applicationTime = 4

ITEM.functions.use = {
	name = "Stab Self",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
    	local TEMP_TargetDamage = DamageInfo()
						
		ix.util.PlayerPerformItemAction(item.player, item, "Stabbing self with Kolobok", item.applicationTime,
			function(player)
            TEMP_TargetDamage:SetDamage(item.contactDamage)
			TEMP_TargetDamage:SetAttacker(player)
			TEMP_TargetDamage:SetDamageType(DMG_BULLET)
			TEMP_TargetDamage:SetInflictor(player)
			TEMP_TargetDamage:SetDamagePosition(player:GetPos())
			player:TakeDamageInfo(TEMP_TargetDamage)

			player:addRadiation(-item.radiationRemoved)
        end)

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

function ITEM:GetIndividualProperties()
	return {
		{id = "radiationRemoval", text = "Radiation removal: "
			.. ix.itemProperties.Format("radiationAmount", -self.radiationRemoved)},
		{id = "contactDamage", text = "Treatment injury: " .. ix.itemProperties.Format("health", -self.contactDamage)},
		{id = "application", text = "Application time: " .. ix.itemProperties.Format("duration", self.applicationTime)},
	}
end
