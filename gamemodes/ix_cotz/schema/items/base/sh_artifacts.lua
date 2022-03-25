ITEM.name = "Artifact"
ITEM.category = "Artifacts"
ITEM.description = "An artifact. Valuable."
ITEM.longdesc = "Longer description here."

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0

ITEM.JumpPower = 900
ITEM.NoJump = false

ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")

ITEM.baseweight = 1.000
ITEM.varweight  = 0.500

function ITEM:GetDescription()
    local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
    local quantdesc = ""
    local invdesc = ""
    if self.longdesc then
        invdesc = "\n\n"..(self.longdesc)
    end

    if self.quantdesc then
        quantdesc = "\n\n"..Format(self.quantdesc, quant)
    end

    if (self.entity) then
        return (self.description)
    else
        return (self.description..quantdesc..invdesc)
    end
end

if (CLIENT) then
    function ITEM:DrawEntity(entity)
        if LocalPlayer():GetPos():Distance(entity:GetPos()) > 128 then
            entity:SetMaterial("models/shadertest/predator.vmt")
            entity:DrawShadow(false)
        else
            entity:SetMaterial(self:GetMaterial())
            entity:DrawShadow(true)
        end

        entity:DrawModel()
    end
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc(tooltip, "Artifact", Color(255, 255, 0), Material("materials/vgui/ui/stalker/weaponupgrades/genericmod.png"))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

function ITEM:OnInstanced(invID, x, y)
    if(!self:GetData("weight")) then
        self:SetData("weight", self.baseweight + math.random(-self.varweight, self.varweight))
    end
end

--[[
ITEM.functions.Sell = {
    icon = "icon16/coins.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        local client = item.player
        client:Notify( "Sold for "..(item.value).." rubles." )
        client:GetChar():GiveMoney(item.value)

    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
    end
}

ITEM.functions.Value = {
    icon = "icon16/help.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        local client = item.player
        client:Notify( "Item is sellable for "..(item.value).." rubles." )
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item:GetOwner():GetChar():HasFlags("1")
    end
}
]]--
