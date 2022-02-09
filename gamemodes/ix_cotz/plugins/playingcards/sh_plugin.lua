local PLUGIN = PLUGIN
PLUGIN.name = "Playing Cards"
PLUGIN.author = "armdupe"
PLUGIN.description = "Adds item-based playing cards that allow card games like Blackjack and Poker to happen."
ix.util.Include("sv_plugin.lua")

PLUGIN.CardSuits = {
    ["spades"] = "Spades",
    ["clubs"] = "Clubs",
    ["hearts"] = "Hearts",
    ["diamonds"] = "Diamonds"
}

PLUGIN.CardValues = {
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

PLUGIN.CardMisc = {
    ["red_joker"] = "Red Joker",
    ["black_joker"] = "Black Joker"
}

PLUGIN.CardProperties = {
  ["models/cotzcards/card1.mdl"] = {
    "A_clubs",
    "A_hearts",
    "A_diamonds",
    "A_spades",
    "2_clubs",
    "2_spades",
    "2_hearts",
    "2_diamonds",
    "3_clubs",
    "3_spades",
    "3_hearts",
    "3_diamonds",
    "4_clubs",
    "4_spades",
    "4_hearts",
    "4_diamonds",
    "5_clubs",
    "5_spades",
    "5_hearts",
    "5_diamonds",
    "6_clubs",
    "6_spades",
    "6_hearts",
    "6_diamonds",
    "7_clubs",
    "7_spades",
    "7_hearts",
    "7_diamonds",
    "8_clubs",
    "8_spades"
  },

  ["models/cotzcards/card2.mdl"] = {
    "8_hearts",
    "8_diamonds",
    "9_clubs",
    "9_spades",
    "9_hearts",
    "9_diamonds",
    "10_clubs",
    "10_spades",
    "10_hearts",
    "10_diamonds",
    "J_clubs",
    "J_spades",
    "J_hearts",
    "J_diamonds",
    "Q_clubs",
    "Q_spades",
    "Q_hearts",
    "Q_diamonds",
    "K_clubs",
    "K_spades",
    "K_hearts",
    "K_diamonds"
  }
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
    if (item.uniqueID == "cards_deck_cards") then return item.functions.PickUp, "PickUp" end
end

function PLUGIN:LoadedCards()
    self.cards = {}

    for k1, v1 in pairs(self.CardSuits or {}) do
        for k2, v2 in pairs(self.CardValues or {}) do
            self.cards[k2 .. "_" .. k1] = v2 .. " of " .. v1
        end
    end

    for k, v in pairs(self.CardMisc or {}) do
        self.cards[k] = v
    end

    function PLUGIN:GetProperties(item)
        for k, v in pairs(PLUGIN.CardProperties) do
            for k2, v2 in pairs(v) do
                if v2 == item then return k, k2 - 1, "", Color(255, 255, 255, 255) end
            end
        end

        return "models/cotzcards/card1.mdl", 0, "models/props_pipes/GutterMetal01a", Color(0, 0, 0, 255)
    end

    for k, v in pairs(self.cards or {}) do
        local itemmdl, itemskin, itemmat, itemcolor = PLUGIN:GetProperties(k)

        if k == "black_joker" then
            itemcolor = Color(61, 60, 60, 255)
        elseif k == "red_joker" then
            itemcolor = Color(255, 0, 0, 255)
        end

        local ITEM = ix.item.Register("cards_" .. k, "base_card", false, nil, true)
        ITEM.name = v
        ITEM.description = "An individual playing card that appears to be apart of a deck of 54 imported French playing cards."
        ITEM.longdesc = "An individual playing card that appears to have one of its corners slightly bent with some of the pattern being scratched off a little. The card appears to be in not the best condition as it has came from a deck that has been used by various STALKERs."
        ITEM.material = itemmat
        ITEM.img = ix.util.GetMaterial("materials/vgui/hud/misc/cards/" .. k .. ".png")
        ITEM.model = itemmdl
        ITEM.skin = itemskin
        ITEM.color = itemcolor
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