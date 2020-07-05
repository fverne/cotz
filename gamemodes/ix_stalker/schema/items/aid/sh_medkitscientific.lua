ITEM.name = "Scientific Medkit"
ITEM.description = "Medkit used by ecologists."
ITEM.longdesc = "A medical kit designed specifically for use in the Zone.\nThe kit contains products for handling wounds, as well as preventing the development of radiation poisoning and reducing accumulated radiation in the body."
ITEM.model = "models/kek1ch/dev_aptechka_mid.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Aid"
ITEM.restore = 4
ITEM.radrem = 2
ITEM.sound = "stalkersound/inv_bandage.mp3"
ITEM.price = "750"
ITEM.flag = "A"
ITEM.busflag = {"medical2_1_1"}
ITEM.quantity = 3
ITEM.weight = 0.15
ITEM.flatweight = 0.1

function ITEM:GetWeight()
	return self.flatweight + (self.weight * self:GetData("quantity", self.quantity))
end

function ITEM:GetDescription()
	if (!self.entity or !IsValid(self.entity)) then
		local quant = self:GetData("quantity", self.quantity)
		local str = self.longdesc.."\n \nThere's only "..quant.." use left."

		return str
	else
		return self.desc
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)

		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_slowheal", 10, { amount = item.restore })
		item.player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem })
		ix.chat.Send(item.player, "iteminternal", "opens a "..item.name.." and uses it.", false)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
/*
ITEM.functions.usetarget = {
	name = "Heal Target",
	icon = "icon16/stalker/heal.png",
	onRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:getData("quantity", item.quantity)
		if (IsValid(target) and target:IsPlayer()) then
			target:AddBuff("buff_slowheal", 5, { amount = item.restore*(1+(item.player:getChar():getAttrib("medical", 0)/50))/10 })
			nut.chat.send(item.player, "iteminternal", "opens a "..item.name.." and uses it on "..target:Name()..".", false)
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:setData("quantity", quantity)
				return false
			end
			
			
		else
			item.player:notify("Not looking at a player!")
			return false
		end

		return true
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}