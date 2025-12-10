ITEM.name = "Compression Bandage"
ITEM.description = "A small bandage for wounds."
ITEM.longdesc = "A more advanced bandage, used for serious bleeding in combat situations. It is easy and quick to apply, but you do pay for the convenience."
ITEM.model = "models/lostsignalproject/items/medical/army_bandage.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.restore = 14
ITEM.restoreduration = 4
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = 140
ITEM.weight = 0.015

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 2.5,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)

		ix.chat.Send(item.player, "iteminternal", "unwraps and ties a "..item.name.." to their wound.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Wrapping Bandages", 10, function(player) 
			player:AddBuff("buff_slowheal", item.restoreduration, { amount = item.restore })
			--player:HealBleeding(90)
		end)

		local quantity = item:GetData("quantity", item.quantity)
		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.usetarget = {
	name = "Heal Target",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:GetData("quantity", item.quantity)
		if (IsValid(target) and target:IsPlayer()) then
			
			ix.chat.Send(item.player, "iteminternal", "unwraps a "..item.name.." and ties it to "..target:Name().."'s wound.", false)
			target:AddBuff("buff_slowheal", item.restoreduration, { amount = item.restore })
			target:SetLocalVar("stm", math.min(target:GetLocalVar("stm", 100) + item.restore*item.restoreduration, 100))
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:SetData("quantity", quantity)
				return false
			end
		else
			item.player:Notify("Not looking at a player!")
			return false
		end

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}