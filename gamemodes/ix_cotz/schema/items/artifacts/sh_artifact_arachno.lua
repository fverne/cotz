ITEM.name = "Arachno"
ITEM.model ="models/lostsignalproject/items/artefacts/black_angel.mdl"
ITEM.description = "A spindly artifact with many long, twisting 'legs'."
ITEM.longdesc = "The name 'Arachno' comes from its resemblance to a spider, as well as the fact that some of the ends of the legs are coated in a thin film of a venomous substance. This substance is a strong neuromuscular-blocking agent, able to completely paralyse a horse, let alone a man. There isn't much danger to stabbing yourself with it however, as the material is slightly brittle, and anything harder than bare skin will cause the venom-coated tendril to snap off rather than penetrate the skin."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 10500
ITEM.flag = "A"
ITEM.rarity = 5
ITEM.baseweight = 1.800
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
        	player:SetVelocity( player:EyeAngles():Forward()*Vector(400,400,0) + Vector(0,0,350) - player:GetVelocity())
        	item:SetData("cooldown", os.time() + 4 )
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetData("cooldown",0) < os.time() and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}
