ITEM.name = "Grandmama's Beads"
ITEM.model ="models/lostsignalproject/items/artefacts/chelust.mdl"
ITEM.description = "A long string of beads, held together by some sort of force."
ITEM.longdesc = "The individual beads are seemingly impossible to pull apart, but there doesn't seem to be anything physically holding the beads in place. Similar to the slightly more common Mama's Beads, focusing on your breathing while counting out the beads give you a serene peace of mind, making any mental attacks against you almost fruitless for a short while."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 28760
ITEM.flag = "A"
ITEM.rarity = 9
ITEM.baseweight = 0.600
ITEM.varweight  = 0.080

ITEM.functions.use = {
	name = "Inspect",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time()+300 ) --5 minutes
            ix.util.PlayerPerformBlackScreenAction(item.player, "Counting out the beads...", 10, function(player)
                player:AddBuff("buff_psyblock", 180, { amount = 80 })
            end)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}
