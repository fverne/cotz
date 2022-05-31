ITEM.name = "Ukrainian rubles"
ITEM.description = "A bunch of weathered ukrainian currency."
ITEM.longdesc = "Trade in the Zone is conducted mainly by means of electronic transactions for safety and managing reasons. But many stalkers keep at least a few rubles in their pockets in case they want to buy smaller things like cigarettes. This makes life easier and conserves battery life."
ITEM.quantdesc = "This bundle of cash has a value of %d rubles."
ITEM.model = "models/kek1ch/money_ukraina.mdl"

ITEM.width = 1
ITEM.height = 1

ITEM.quantity = 5000000
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.5,
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(item:GetData("quantity", 1), "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.use = {
	name = "Put in Wallet",
	icon = "icon16/stalker/sell.png",
	sound = "stalkersound/money_1.mp3",
	OnRun = function(item)
		local position = item.player:GetItemDropPos()
		local client = item.player
		local quant = item:GetData("quantity", 0)
		client:GetCharacter():GiveMoney(quant)
		ix.chat.Send(item.player, "iteminternal", "counts up some rubles and puts them in their wallet.", false)
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.quantity or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description..quantdesc)
	else
        return (self.description..quantdesc..invdesc)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end

		local targetItem = ix.item.instances[data[1]]

		if targetItem.ammo == item.ammo then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetAmmoDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetAmmoDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetAmmoDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}