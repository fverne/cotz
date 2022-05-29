ITEM.name = "hidestasher"
ITEM.description = "hidestasher item."
ITEM.longdesc = "No Longer Description Available"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.quantdesc = "This tool has %d uses left."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.quantity = 1
ITEM.weight = 0

-- Inventory drawing
if (CLIENT) then
    local Texture2 = Material("cotz/panels/hp1.png", "noclamp smooth")

    function ITEM:PaintOver(item, w, h)
        --Less mental way of doing the above:
        local dura = 0

        if (item:GetData("quantity")) then
            dura = item:GetData("quantity", item.quantity or 100) / item.quantity * 100
        end

        --durability
        surface.SetMaterial(Texture2)
        surface.SetDrawColor(Color(120, 120, 120, 255))
        surface.DrawTexturedRectUV(5, h - 10, 38, 4.6, 0, 0, 0.2, 1)
        surface.SetMaterial(Texture2)

        if (dura >= 80) then
            surface.SetDrawColor(Color(120, 255, 120, 255))
        elseif (dura >= 60) then
            surface.SetDrawColor(Color(180, 255, 120, 255))
        elseif (dura >= 40) then
            surface.SetDrawColor(Color(255, 255, 120, 255))
        elseif (dura >= 20) then
            surface.SetDrawColor(Color(255, 180, 120, 255))
        elseif (dura > 0) then
            surface.SetDrawColor(Color(255, 120, 120, 255))
        end

        surface.DrawTexturedRectUV(5, h - 10, math.Clamp(dura / 100, 0, 1) * 38, 4.6, 0, 0, math.Clamp(dura / 100, 0, 1) * 0.2, 1)
    end
end

function ITEM:GetDescription()
    local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
    local quantdesc = ""
    local invdesc = ""

    if self.longdesc then
        invdesc = "\n\n" .. (self.longdesc)
    end

    if self.quantdesc then
        quantdesc = "\n\n" .. Format(self.quantdesc, quant)
    end

    if (self.entity) then
        return (self.description)
    else
        return (self.description .. quantdesc .. invdesc)
    end
end

function ITEM:PopulateTooltip(tooltip)
    if not self.entity then
        ix.util.PropertyDesc(tooltip, "Tool", Color(64, 224, 208))
        ix.util.PropertyDesc(tooltip, "Can Hide Stashes", Color(32, 223, 32))
    end

    if (self.PopulateTooltipIndividual) then
        self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM.functions.hidestash = {
    name = "Hide the Stash",
    tip = "equipTip",
    icon = "icon16/stalker/drop.png",
    OnRun = function(item)
        local trace = item.player:GetEyeTraceNoCursor()
        local texturecheck = false

    local TextureBlacklist = {
		"PLASTER/PLASTERWALL013C",
		"PLASTER/WALLPAPER001B",
		"PLASTER/WALLPAPER002A",
		"PLASTER/WALLPAPER002B",
		"PLASTER/WALLPAPER003A",
		"PLASTER/WALLPAPER003B",
		"PLASTER/WALLPAPER005A",
		}

        if IsValid(trace.Entity) and trace.Entity:GetClass() == "ix_item" then
            item.player:Notify("Do not look at an item when making a stash, look at the ground just next to it.")

            return false
        end

        if IsValid(trace.Entity) and trace.Entity:GetClass() == "ix_vendor_adv" or trace.Entity:GetClass() == "player" then
            item.player:Notify("You can not make a stash inside a fellow STALKER, it is rude to do so. Seriously, what did you expect?")

            return false
        end

        if trace.MatType == 68 and not IsValid(trace.Entity) and not table.HasValue(TextureBlacklist, trace.HitTexture) then
            texturecheck = true
        end

        if not texturecheck then
            item.player:Notify("You can not make a stash on this surface!")

            return false
        end

        if texturecheck then
            local quantity = item:GetData("quantity", item.quantity)
            ix.chat.Send(item.player, "iteminternal", "takes out their " .. item.name .. ".", false)
            ix.plugin.list["hidestash"]:StashHide(item.player)
            quantity = quantity - 1

            if (quantity >= 1) then
                item:SetData("quantity", quantity)

                return false
            end
        end

        item.player:Notify("Your " .. item.name .. " broke!")

        return true
    end,
    OnCanRun = function(item)
        local client = item.player

        return not IsValid(item.entity) and IsValid(client) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}

ITEM.functions.unhidestash = {
    name = "Search for a Stash",
    tip = "equipTip",
    icon = "icon16/stalker/open.png",
    OnRun = function(item)
        local quantity = item:GetData("quantity", item.quantity)
        ix.chat.Send(item.player, "iteminternal", "takes out their " .. item.name .. ".", false)
        ix.plugin.list["hidestash"]:StashUnhide(item.player)
        quantity = quantity - 1

        if (quantity >= 1) then
            item:SetData("quantity", quantity)

            return false
        end

        item.player:Notify("Your " .. item.name .. " broke!")

        return true
    end,
    OnCanRun = function(item)
        local client = item.player

        return not IsValid(item.entity) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
    end
}