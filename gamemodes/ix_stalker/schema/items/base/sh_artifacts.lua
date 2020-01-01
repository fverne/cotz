ITEM.name = "Artifact"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Artifacts"
ITEM.description = "An artifact. Valuable."
ITEM.longdesc = "Longer description here."
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")
ITEM.price = 1

function ITEM:GetDescription()
    local quant = self:GetData("quantity", 1)
    local str = self.description
    if self.longdesc then
        str = str.."\n"..(self.longdesc or "")
    end

    local customData = self:GetData("custom", {})
    if(customData.desc) then
        str = customData.desc
    end

    if (self.entity) then
        return (self.description)
    else
        return (str)
    end
end

function ITEM:GetName()
    local name = self.name
    
    local customData = self:GetData("custom", {})
    if(customData.name) then
        name = customData.name
    end
    
    return name
end

ITEM.functions.Custom = {
    name = "Customize",
    tip = "Customize this item",
    icon = "icon16/wrench.png",
    OnRun = function(item)      
        ix.plugin.list["customization"]:startCustom(item.player, item)
        
        return false
    end,
    
    OnCanRun = function(item)
        local client = item.player
        return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
    end
}

ITEM.functions.Inspect = {
    name = "Inspect",
    tip = "Inspect this item",
    icon = "icon16/picture.png",
    OnClick = function(item, test)
        local customData = item:GetData("custom", {})

        local frame = vgui.Create("DFrame")
        frame:SetSize(540, 680)
        frame:SetTitle(item.name)
        frame:MakePopup()
        frame:Center()

        frame.html = frame:Add("DHTML")
        frame.html:Dock(FILL)
        
        local imageCode = [[<img src = "]]..customData.img..[["/>]]
        
        frame.html:SetHTML([[<html><body style="background-color: #000000; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..imageCode..[[</body></html>]])
    end,
    OnRun = function(item)
        return false
    end,
    OnCanRun = function(item)
        local customData = item:GetData("custom", {})
    
        if(!customData.img) then
            return false
        end
        
        if(item.entity) then
            return false
        end
        
        return true
    end
}

ITEM.functions.Clone = {
    name = "Clone",
    tip = "Clone this item",
    icon = "icon16/wrench.png",
    OnRun = function(item)
        local client = item.player  
    
        client:requestQuery("Are you sure you want to clone this item?", "Clone", function(text)
            if text then
                local inventory = client:GetCharacter():GetInventory()
                
                if(!inventory:Add(item.uniqueID, 1, item.data)) then
                    client:Notify("Inventory is full")
                end
            end
        end)
        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        return client:GetCharacter():HasFlags("N") and !IsValid(item.entity)
    end
}

if (CLIENT) then
    function ITEM:DrawEntity(entity, item)
        if LocalPlayer():GetPos():Distance(entity:GetPos()) > 128 then
            entity:SetMaterial("models/shadertest/predator.vmt")
            entity:DrawShadow(false)
        else
            entity:SetMaterial(null)
            entity:DrawShadow(true)
        end

        entity:DrawModel()
    end
/*    function ITEM:PaintOver(item, w, h)
        if (item:GetData("equip")) then
            surface.SetDrawColor(110, 255, 110, 255)
        else
            surface.SetDrawColor(255, 110, 110, 255)
        end

        surface.SetMaterial(item.equipIcon)
        surface.DrawTexturedRect(w-23,h-23,19,19)
    end*/
end



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