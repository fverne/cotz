ITEM.name = "Army Medkit"
ITEM.description = "A small military medkit."
ITEM.longdesc = "A specialized medical kit for providing first aid to combat casualties. The kit includes blood coagulants based on menadione, painkillers, antibiotics and immunostimulants."
ITEM.model = "models/lostsignalproject/items/medical/medical_bag_army.mdl"

ITEM.sound = "stalkersound/inv_bandage.mp3"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 650

ITEM.quantity = 3
ITEM.restore = 75

ITEM.weight = 0.050
ITEM.flatweight = 0.250

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0.5, 0.60000002384186),
	ang = Angle(0, -0, 90),
	fov = 5,
}

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.chat.Send(item.player, "iteminternal", "opens a "..item.name.." and uses it.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Treating Wounds", 8, function(player) 
			player:AddBuff("buff_slowheal", 60, { amount = item.restore/60 })
			--player:HealBleeding(60)
		end)

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