ITEM.name = "Experimental Medical Stimpak MkIII"
ITEM.description = "A small injector, produced in the zone."
ITEM.longdesc = "The third iteration of the ecologist medical stimpak.\nSome of the ecologists say that they've perfected the distillation process, and the improvement can definitely be felt by the users. It is an invaluable tool for STALKERs, and this is the top of the line."
ITEM.model = "models/lostsignalproject/items/medical/stim_pack3.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1800

ITEM.quantity = 1
ITEM.restore  = 100

ITEM.weight = 0.350
ITEM.flatweight = 0.125

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_slowheal", 2, { amount = item.restore/4 })
		item.player:SetLocalVar("stm", math.min(item.player:GetLocalVar("stm", 100) + item.restore, 100))
		ix.chat.Send(item.player, "iteminternal", "jabs the "..item.name.." in his leg and injects the payload.", false)

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
*/