ITEM.name = "Storm"
ITEM.model ="models/artefacts/helium.mdl"
ITEM.description = "A miniature storm is raging inside."
ITEM.longdesc = "Just a light touch induces an electrical surge through the hand, full grasp - and the wielder becomes uncatchable. Those who endure the destructive force of this artifact boast about it as a lightning in a bottle."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 53000
ITEM.flag = "A"
ITEM.rarity = 5
ITEM.baseweight = 0.700
ITEM.varweight  = 0.250
ITEM.JumpPower = 300
ITEM.exRender = true

ITEM.iconCam = {
    pos = Vector(509.64, 427.61, 310.24),
    ang = Angle(24.77, 220, 0),
    fov = 0.7
}

ITEM.functions.use = {
	name = "Grasp",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if item.player:HasBuff("buff_lightningsprint") then
        	item.player:RemoveBuff("buff_lightningsprint")
        else
        	item.player:AddBuff("buff_lightningsprint", -1, { dps = 5, multiplier = 1.6 })
        end
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}