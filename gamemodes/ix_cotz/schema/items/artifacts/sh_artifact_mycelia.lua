ITEM.name = "Mycelia"
ITEM.model ="models/lostsignalproject/items/artefacts/kislushka.mdl"
ITEM.description = "A dark green lumpy rock, seemingly formed by a strong pressure."
ITEM.longdesc = "There seems to be a network of small tunnels going through it. Over time, a light green fuzzy coating grows on the surface of the rock. This mold-esque growth seems edible, and can be quite easily scraped off the surface and eaten. It is currently unknown if this fungus-like growth will spread to other surfaces than the artifact itself. Scientists are very interested in this artifact as an experimental food source."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 7900
ITEM.flag = "A"
ITEM.rarity = 3
ITEM.baseweight = 2.500
ITEM.varweight  = 0.500

ITEM.functions.use = {
	name = "Eat",
    icon = "icon16/help.png",
    sound = "stalkersound/inv_eat_mutant_food.mp3",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time()+(3600*2) ) --2 hours

            ix.chat.Send(item.player, "iteminternal", "scrapes some mold off their "..item.name.." and eats it.", false)

            local hunger = item.player:GetCharacter():GetData("hunger", 100)
            ix.util.PlayerPerformBlackScreenAction(item.player, "Scraping off mold and eating it...", 8, function(player)
                player:AddBuff("debuff_radiation", 10, { amount = 0.25 })
                player:SetHunger(hunger + 25)
            end)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}
