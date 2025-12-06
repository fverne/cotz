ITEM.name = "Grapes"
ITEM.model ="models/lostsignalproject/items/artefacts/grapes.mdl"
ITEM.description = "A mess of a twisting strands."
ITEM.longdesc = "This peculiar artifact consists of many bendy appendages that seem to move on their own. No matter how hard you twist or tie them together, they always untangle back into original form."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 5500
ITEM.flag = "A"
ITEM.rarity = 3
ITEM.baseweight = 1.300
ITEM.varweight  = 0.200

ITEM.functions.use = {
	name = "Grasp",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
    	local player = item.player
        if ( (item:GetData("cooldown",0) < os.time()) and player:IsOnGround() ) then
        	local iterator = 0
        	local pos = player:GetPos()

        	player:SetPos( pos + Vector(0,0,2) )
        	if player:IsStuck() then player:SetPos(pos) end
        	player:SetVelocity( player:EyeAngles():Forward()*Vector(300,300,0) + Vector(0,0,300) - player:GetVelocity())
        	item:SetData("cooldown", os.time() + 10 )
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}
