ITEM.name = "Access Card (Ecologist)"
ITEM.description = "A small plastic card."
ITEM.longdesc = "This small, slim card is meant to open a variety of doors. The icon on the top left indicates this unlocks various ecologist doors."
ITEM.model = "models/lostsignalproject/items/quest/keycard.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 0
ITEM.weight = 0.01

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 8),
	ang = Angle(90, 90, 0),
	fov = 45,
}

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

ITEM.functions.usetarget = {
	name = "Unlock Ecobunker Door",
	icon = "icon16/stalker/unlock.png",
	OnRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
        
		if (IsValid(target) and target:GetClass() == "func_door_rotating") and target:GetName() == "ecoundergrounddoor" then
			ix.chat.Send(item.player, "iteminternal", "takes out their "..item.name.." and uses it on the door.", false)

            target:Input("Unlock")
            target:Input("Open")
            timer.Simple(10, function()
                target:Input("Close")
                target:Input("Lock")
            end)
		else
			item.player:Notify("Not looking at the correct door!")
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}
