local PLUGIN = PLUGIN
PLUGIN.name = "Playing Cards"
PLUGIN.author = "armdupe"
PLUGIN.description = "Adds item-based playing cards that allow card games like Blackjack and Poker to happen."
ix.util.Include("sv_plugin.lua")

PLUGIN.all_types = {
    ["spades"] = "Spades",
    ["clubs"] = "Clubs",
    ["hearts"] = "Hearts",
    ["diamonds"] = "Diamonds"
}

PLUGIN.all_cards = {
    ["2"] = "2",
    ["3"] = "3",
    ["4"] = "4",
    ["5"] = "5",
    ["6"] = "6",
    ["7"] = "7",
    ["8"] = "8",
    ["9"] = "9",
    ["10"] = "10",
    ["J"] = "Jack",
    ["Q"] = "Queen",
    ["K"] = "King",
    ["A"] = "Ace"
}

PLUGIN.other_cards = {
    ["red_joker"] = "Red Joker",
    ["black_joker"] = "Black Joker"
}

PLUGIN.cards = {}

function PLUGIN:FindCards(client)
    if not client then return end
    local character = client:GetCharacter()
    if not character then return end
    local inventory = character:GetInventory()

    for k, v in pairs(inventory:GetItems() or {}) do
        for k2, v2 in pairs(self.cards) do
            if v.uniqueID == "cards_" .. k2 then return v end
        end
    end
end

function PLUGIN:Shuffle(tbl)
    local len, random = #tbl, math.random

    for i = len, 2, -1 do
        local j = random(1, i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end

    return tbl
end

function PLUGIN:FillDeckCards()
    local data = {}

    for k, v in SortedPairs(self.cards) do
        data[#data + 1] = "cards_" .. k
    end

    return data
end

function PLUGIN:ItemPressedRightShift(icon, item)
  if (item.base == "base_deck_cards") then
    return item.functions.PickUp, "PickUp"
  end
end


function PLUGIN:LoadedCards()
    self.cards = {}

    for k1, v1 in pairs(self.all_types or {}) do
        for k2, v2 in pairs(self.all_cards or {}) do
            self.cards[k2 .. "_" .. k1] = v2 .. " of " .. v1
        end
    end

    for k, v in pairs(self.other_cards or {}) do
        self.cards[k] = v
    end



    for k, v in pairs(self.cards or {}) do
        local ITEM = ix.item.Register("cards_" .. k, "base_card", false, nil, true)
        ITEM.name = v
        ITEM.description = "An individual playing card that appears to be apart of a deck of 54 imported French playing cards."
        ITEM.longdesc = "An individual playing card that appears to have one of its corners slightly bent with some of the pattern being scratched off a little. The card appears to be in not the best condition as it has came from a deck that has been used by various STALKERs."
        ITEM.material = "models/debug/debugwhite"
        ITEM.img = ix.util.GetMaterial("materials/vgui/hud/misc/cards/" .. k .. ".png")
        ITEM.model = "models/lostsignalproject/items/quest/keycard.mdl"
        ITEM.width = 1
        ITEM.height = 1
    end

    local ITEM = ix.item.Register("cards_deck_cards", "base_deck_cards", false, nil, true)
    ITEM.name = "French Playing Cards"
    ITEM.description = "A deck of 54 imported French playing cards that use the french suits - clubs (♣), diamonds (♦), hearts (♥) and spades (♠)."
    ITEM.longdesc = "A second hand deck of 54 French playing cards which were brought into the Zone and used by many STALKERs. Each suit contains three face cards and the deck sizes tend to vary. STALKERs tend to play various popular international card games such as Poker and Blackjack. Some STALKERs have managed to make their own card games, the games being local to the Zone."
    ITEM.img = ix.util.GetMaterial("materials/vgui/hud/misc/cards/back.png")
    ITEM.model = "models/lostsignalproject/items/misc/cards.mdl"
    ITEM.width = 1
    ITEM.height = 1
end

PLUGIN:LoadedCards()
