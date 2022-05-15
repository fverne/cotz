ITEM.name = "Memento Mori"
ITEM.model ="models/Gibs/HGIBS.mdl"
ITEM.description = "An artifact shaped like a human skull."
ITEM.longdesc = "A human skull that is missing its lower jaw.\nThis grisly artifact serves as a reminder to all STALKERs that death is around every corner in the exclusion zone. It seems to have a slightly unsettling aura around it, moreso than a normal skull. Some STALKERs carry these around, using them as a literal Memento Mori, a reminder that they're mortal, and that they should not attempt anything too heroic or daring. Because the Memento Mori is fairly common, the supply outweighs the demand in most cases, however some scientists are still interested in it, as it doesn't seem to be made of bone, and its origins are quite mysterious. Many different variants have been seen, made out of many kind of materials."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 5750
ITEM.flag = "A"
ITEM.rarity = 2
ITEM.baseweight = 1.050
ITEM.varweight  = 0.150

function ITEM:OnInstanced(invID, x, y)
    if(!self:GetData("weight")) then
        self:SetData("weight", self.baseweight + math.random(-self.varweight, self.varweight))
    end

    local materials = {
    	{"models/effects/splode1_sheet", 1},
    	{"models/cs_italy/light_orange", 1.9},
    	{"models/props/CS_militia/militiarockb", 0.8},
    	{"models/props_c17/frostedglass_01a", 1.3},
    	{"models/props_combine/prtl_sky_sheet", 1.6},
    	{"models/props_lab/cornerunit_cloud", 2.1},
    	{"models/props_wasteland/wood_fence01a_skin2", 0.3}
    }

    if(!self:GetData("material"))then
    	local tmp = table.Random(materials)
    	self:SetData("material", tmp[1])
    	self:SetData("valuemultiplier", tmp[2])
    end
end

function ITEM:GetPrice()
	return self.price * self:GetData("valuemultiplier", 1)
end

ITEM.functions.use = {
	name = "Inspect",
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)

        if(item:GetData("cooldown",0) < os.time())then
        	item:SetData("cooldown", os.time()+(3600*2) ) --2 hours
            ix.util.PlayerPerformBlackScreenAction(item.player, "Looking deep into the skull", 3, function(player) 
                player:HealPsyHealth(15)
            end)
        end

        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}