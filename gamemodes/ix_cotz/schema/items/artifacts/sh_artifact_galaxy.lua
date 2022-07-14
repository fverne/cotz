ITEM.name = "Galaxy"
ITEM.model ="models/artefacts/atom.mdl"
ITEM.description = "A spherical artifact with small spheres around it."
ITEM.longdesc = "It is unnaturally light for its size. When held it seems to reduce the pull of gravity on the holder. This artifact is extremely sought after, both by STALKERs to get to previously unreachable places, and by scientists as this gravity defying physical oddity could lead to massive breakthroughs in understanding the universe. It is quite rare, and the price reflects that."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 38700
ITEM.JumpPower = 500
ITEM.flag = "A"
ITEM.rarity = 9
ITEM.baseweight = 0.025
ITEM.varweight  = 0.010

ITEM.functions.use = {
	name = "Grasp",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time() + 15 )

            item.player:AddBuff("buff_hijump", 10, { amount = 300 })
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}
