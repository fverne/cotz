ITEM.name = "Urchin"
ITEM.model ="models/nasca/etherealsrp_artifacts/urchin.mdl"
ITEM.description = "Spikey and brown artifact."
ITEM.longdesc = "An extremely spiky artifact, almost resembling a sea urchin, from which the name of the artifact comes from. There seems to be a hard lump at the very center of the spikes, much like the Thorn artifact. It also seems to absorb radiation from a bloodstream, when exposed to one. However, this procedure will severely hurt the user in the process."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 7500
ITEM.JumpPower = 100
ITEM.flag = "A"
ITEM.rarity = 3
ITEM.baseweight = 0.750
ITEM.varweight  = 0.050

ITEM.functions.use = {
	name = "Stab Self",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
    	local TEMP_TargetDamage = DamageInfo()

		ix.util.PlayerPerformBlackScreenAction(item.player, "Stabbing self with Urchin", 4, function(player)
            TEMP_TargetDamage:SetDamage(75)
			TEMP_TargetDamage:SetAttacker(player)
			TEMP_TargetDamage:SetDamageType(DMG_BULLET)
			TEMP_TargetDamage:SetInflictor(player)
			TEMP_TargetDamage:SetDamagePosition(player:GetPos())
			player:TakeDamageInfo(TEMP_TargetDamage)

			player:addRadiation(-25)
        end)

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}
