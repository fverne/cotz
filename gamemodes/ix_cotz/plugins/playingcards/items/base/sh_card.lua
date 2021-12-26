ITEM.name = "Cards Base"
ITEM.model = "models/lostsignalproject/items/quest/keycard.mdl"
ITEM.material = "models/debug/debugwhite"
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

function ITEM:DrawEntity(entity)
    entity:SetModelScale(0.7)
    entity:DrawModel()
end

ITEM.functions.Flip = {
    name = "Flip the card",
    icon = "icon16/stalker/scrap.png",
    OnRun = function(itemTable)
        local client = itemTable.player
        local vStart = client:GetShootPos()
        local vForward = client:GetAimVector()
        local trace = {}
        trace.start = vStart
        trace.endpos = vStart + (vForward * 60)
        trace.filter = client
        local tr = util.TraceLine(trace)
        local ang = client:EyeAngles()
        ang.yaw = ang.yaw + 180
        ang.roll = 0
        ang.pitch = 0
        ix.chat.Send(itemTable.player, "iteminternal", "begins to flip his card, placing it down in front of him.", false)
        client:Notify("You have flipped the " .. itemTable.name .. " card.")
        --    ix.log.Add(client, "cardLog", "flipped their "..ITEM.name..".")  -- disabled for the time being
        client:EmitSound("stalkersound/inv_close.mp3", 120)

        ix.item.Instance(0, "cards_deck_cards", nil, 0, 0, function(item)
            item:Spawn(tr.HitPos, ang)
            item:SetData("cards", {[1] = itemTable.uniqueID})
        end)
    end
}
