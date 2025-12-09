ITEM.name = "Dwarf Galaxy"
ITEM.model ="models/lostsignalproject/items/artefacts/atom.mdl"
ITEM.description = "A spherical artifact with small spheres around it."
ITEM.longdesc = "It is unclear if this is a discharged, spent version of the rarer Galaxy artifact, or if its simply a specimen that hasn't had enough time to mature into one yet. This variant is much more common, and doesn't seem to have any of the gravity defying properties, and as such the demand for this artifact isn't as high as the true Galaxy."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 9600
ITEM.flag = "A"
ITEM.rarity = 4
ITEM.baseweight = 0.450
ITEM.varweight  = 0.100

ITEM.functions.use = {
	name = "Grasp",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time() + 15 )
            item.player:RemoveBuff( "buff_hijump" , {})
            item.player:AddBuff("buff_hijump", 5, { amount = 200 })
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}