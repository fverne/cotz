ITEM.name = "Sattelite Phone"
ITEM.description = "A sattelite phone used by traders to make connection to their contacts and their storage."
ITEM.model = "models/illusion/eftcontainers/gphone.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = "500"
ITEM.flag = "1"

ITEM.functions.connection = { -- sorry, for name order.
	name = "Contact Connections",
	icon = "icon16/stalker/sell.png",
	OnRun = function(item)
		
		netstream.Start( item.player, "traderupmenu", item.player)
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

ITEM.functions.storage = { -- sorry, for name order.
	name = "Open Traders Storage",
	icon = "icon16/stalker/unlock.png",
	OnRun = function(item)
		
		if item.player:GetCharacter():GetData("stashid", nil) == nil then
			item.player:GetCharacter():SetData("stashid", item:GetData("id"))
		end

		requestStash(item.player)
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

function ITEM:OnInstanced(invID, x, y)
	local inventory = ix.item.inventories[invID]

	ix.inventory.New(inventory and inventory.owner or 0, self.uniqueID, function(inv)
		local client = inv:GetOwner()

		self:SetData("id", inv:GetID())

		if (IsValid(client)) then
			inv:AddReceiver(client)
		end
	end)
end

function ITEM:OnRegistered()
	ix.inventory.Register(self.uniqueID, 9999, 9999)
end