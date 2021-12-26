local PLUGIN = PLUGIN
ITEM.name = "Deck Cards Base"
ITEM.model = "models/lostsignalproject/items/misc/cards.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.description = ""
ITEM.longdesc = ""
ITEM.category = "Cards"

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

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        local count = item:GetData("cards") and #item:GetData("cards") or 54
        draw.SimpleTextOutlined(tonumber(count) .. "/54", "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
    end
end

function ITEM:PopulateTooltip(tooltip)
    local count = self:GetData("cards") and #self:GetData("cards") or 54
    local info = tooltip:AddRow("take")
    info:SetText("Number of Cards: " .. tonumber(count))
    info:SetBackgroundColor(Color(49, 115, 201)) -- for base helix
    info:SizeToContents()
end

ITEM.functions.PickUp = {
    name = "Take a card",
    icon = "icon16/stalker/equip.png",
    OnRun = function(itemTable)
        local client = itemTable.player

        if not itemTable:GetData("cards") then
            itemTable:SetData("cards", PLUGIN:FillDeckCards())
        end

        local cards = itemTable:GetData("cards")
        local last_card = cards[#cards]
        local bSuccess, fault = client:GetCharacter():GetInventory():Add(last_card)

        if not bSuccess then
            client:NotifyLocalized(fault)

            return false
        end

        local item = ix.item.list[last_card]
        cards[#cards] = nil
        itemTable:SetData("cards", cards)
        ix.chat.Send(itemTable.player, "iteminternal", "reaches over and takes a card from the deck.", false)
        client:Notify("You have taken a " .. item.name .. " from the deck, it is in your inventory.")
        client:EmitSound("stalkersound/inv_drop.mp3", 120)
        --  ix.log.Add(client, "cardLog", "took a "..item.name.." from a deck.") -- disabled for the time being
        if #cards <= 0 then return end

        return false
    end
}

ITEM.functions.Reset = {
    name = "Reset deck order",
    icon = "icon16/stalker/customize.png",
    OnRun = function(itemTable)
        local client = itemTable.player

        if itemTable:GetData("cards") then
            itemTable:SetData("cards", PLUGIN:FillDeckCards())
        end

        ix.chat.Send(itemTable.player, "iteminternal", "begins to reset the deck order.", false)
        client:EmitSound("stalkersound/money_1.mp3", 120)
        if #cards <= 0 then return end

        return false
    end,
    OnCanRun = function(itemTable)
        local client = itemTable.player
        if not itemTable:GetData("cards") then return false end
        if #itemTable:GetData("cards", PLUGIN:FillDeckCards()) < 54 then return false end

        return true
    end
}

ITEM.functions.Put = {
    name = "Put card into the deck",
    icon = "icon16/stalker/split.png",
    OnRun = function(itemTable)
        local client = itemTable.player

        if not itemTable:GetData("cards") then
            itemTable:SetData("cards", PLUGIN:FillDeckCards())
        end

        local item = PLUGIN:FindCards(client)
        local cards = itemTable:GetData("cards")
        cards[#cards + 1] = item.uniqueID
        itemTable:SetData("cards", cards)
        client:EmitSound("stalkersound/inv_drop.mp3", 120)
        ix.chat.Send(itemTable.player, "iteminternal", "places a card into the deck.", false)
        client:Notify("You have placed a " .. item.name .. " into the deck.")
        --  ix.log.Add(client, "cardLog", "placed a "..item.name.." into a deck.") -- disabled for the time being
        item:Remove()

        return false
    end,
    OnCanRun = function(itemTable)
        local client = itemTable.player
        if not PLUGIN:FindCards(client) then return false end
        if #itemTable:GetData("cards", PLUGIN:FillDeckCards()) >= 54 then return false end

        return true
    end
}

ITEM.functions.Shuffle = {
    name = "Shuffle the deck",
    icon = "icon16/stalker/dice.png",
    OnRun = function(itemTable)
        local client = itemTable.player

        if not itemTable:GetData("cards") then
            itemTable:SetData("cards", PLUGIN:FillDeckCards())
        end

        local cards = itemTable:GetData("cards")
        local newShuffle = PLUGIN:Shuffle(cards)
        itemTable:SetData("cards", newShuffle)
        ix.chat.Send(itemTable.player, "iteminternal", "begins to shuffle the deck.", false)
        client:EmitSound("stalkersound/money.mp3", 120)

        return false
    end
}
