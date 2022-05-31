ITEM.name = "Gauze Bandage"
ITEM.description = "A small bandage for wounds."
ITEM.longdesc = "A simple roll of gauze, which in a pinch can be used to apply pressure if bound tightly around a wound. It is not very effective, however it will work in a pinch."
ITEM.model = "models/kek1ch/dev_bandage.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.restore = 16
ITEM.quantity = 5

ITEM.sound = "stalkersound/inv_bandage_2p9.mp3"
ITEM.price = 40
ITEM.weight = 0.008

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 0, -45),
	fov = 3,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		
		
		ix.chat.Send(item.player, "iteminternal", "unwraps and ties a "..item.name.." to their wound.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Wrapping Bandages", 4, function(player) 
			player:AddBuff("buff_slowheal", 4, { amount = item.restore/4 })
			--player:HealBleeding(20)
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
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
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
			target:AddBuff("buff_slowheal", 4, { amount = item.restore/4 })
			target:SetLocalVar("stm", math.min(target:GetLocalVar("stm", 100) + item.restore, 100))
			
			quantity = quantity - 1

			if (quantity >= 1) then
				item:SetData("quantity", quantity)
				return false
			end
		elseif ( IsValid( target ) and target:GetClass( ) == "prop_ragdoll" ) then
			if ( target.isDeadBody ) then
				if not ( IsValid( target.player ) ) then
					item.player:Notify( "You cannot revive a disconnected player's body." )
					return false
				end

				target.player:UnSpectate()
				target.player:SetNetVar("resurrected", true)
				target.player:Spawn()
				target.player:SetHealth( 1 ) 
				target.player:SetPos(target:GetPos())

                if target.player:IsStuck() then
                    target.player:SetPos(target:GetPos() + Vector(0, 0, 16))

                    local positions = ix.util.FindEmptySpace(target.player, {target, target.player})

                    for _, v in ipairs(positions) do
                        target.player:SetPos(v)
                        if not target.player:IsStuck() then return end
                    end
                end
				
				item.player:Notify( "You revived "..target.player:GetName() )
				target.player:Notify( "You were revived by "..item.player:GetName() )

				target.player:AddBuff("buff_slowheal", 4, { amount = item.restore/4 })
				ix.chat.Send(item.player, "iteminternal", "unwraps a "..item.name.." and ties it to "..target:Name().."'s fatal wound.", false)

				quantity = quantity - 1
				if (quantity >= 1) then
					item:SetData("quantity", quantity)
					return false
				end
			end
		else
			item.player:Notify("Not looking at a player!")
			return false
		end

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}