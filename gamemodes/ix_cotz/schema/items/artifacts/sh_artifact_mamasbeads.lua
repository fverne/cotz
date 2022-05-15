ITEM.name = "Mama's Beads"
ITEM.model ="models/lostsignalproject/items/artefacts/glassbeads.mdl"
ITEM.description = "A red helical ladder structure of beads."
ITEM.longdesc = "When held close to the body for a short while, it seems to steel your mind towards psychic attacks, making you much less susceptible to mind control or general mind based attacks. It is a very popular artifacts among more experienced STALKERs that have seen a lot of the zone, and have felt the psychic pressure of a Controller or a Psydog. Scientists are also incredibly interested in the protective nature of the artifact, as it could aid in the production of proper psychic protection equipment for deeper exploration into the exclusion zone."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 12900
ITEM.flag = "A"
ITEM.rarity = 6
ITEM.baseweight = 0.400
ITEM.varweight  = 0.030

ITEM.functions.use = {
	name = "Inspect",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time()+300 ) --5 minutes
            ix.util.PlayerPerformBlackScreenAction(item.player, "Counting out the beads...", 10, function(player) 
                player:AddBuff("buff_psyblock", 60, { amount = 50 })
            end)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}