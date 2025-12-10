ITEM.name = "Panacea"
ITEM.model ="models/lostsignalproject/items/artefacts/bracelet.mdl"
ITEM.description = "A green bracelet, decorated with strange tree shapes."
ITEM.longdesc = "When put on, it seems to send infections, viruses and parasites into a hibernation-like state, stopping their symptoms almost completely, as well as halting the progression of any illness. Contrary to the colloquial name 'Panacea', this artifact is in fact not a cure-all, since as soon as it is removed from the body the symptoms start right back up."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 13400
ITEM.flag = "A"
ITEM.rarity = 6
ITEM.baseweight = 0.220
ITEM.varweight  = 0.060
ITEM.restore = 1
ITEM.restoreduration = 60

ITEM.JumpPower = 800

ITEM.exRender = true

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.chat.Send(item.player, "iteminternal", "Charges up a "..item.name.." and activates it.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Activating Panacea", 10, function(player) 
			player:AddBuff("buff_slowheal", item.restoreduration, { amount =  item.restore })
		end)

		return false
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
			
			ix.chat.Send(item.player, "iteminternal", "Charges up a "..item.name.." and uses it on "..target:Name()..".", false)
			ix.util.PlayerPerformBlackScreenAction(item.player, "Activating Panacea on "..target:Name(), 10, function(player) 
				target:AddBuff("buff_slowheal", item.restoreduration, { amount = item.restore })
			end)
			
		elseif ( IsValid( target ) and target:GetClass( ) == "prop_ragdoll" ) then
			if ( target.isDeadBody ) then

				if not ( IsValid( target.player ) ) then
					item.player:Notify( "You cannot revive a disconnected player's body." )
					return false
				end
				ix.chat.Send(item.player, "iteminternal", "Charges up a "..item.name.." and uses it on "..target.player:Name()..".", false)
				ix.util.PlayerPerformBlackScreenAction(item.player, "Activating Panacea on "..target.player:Name(), 10, function(player) 
					if !(player:Alive()) then return end
					target.player:UnSpectate()
					target.player:SetNetVar("resurrected", true)
					target.player:Spawn()
					target.player:SetHealth(5) 
					target.player:SetPos(target:GetPos())

	                if target.player:IsStuck() then
	                    target.player:SetPos(target:GetPos() + Vector(0, 0, 16))

	                    local positions = ix.util.FindEmptySpace(target.player, {target, target.player})

	                    for _, v in ipairs(positions) do
	                        target.player:SetPos(v)
	                        if not target.player:IsStuck() then break end
	                    end
	                end
					
					player:Notify( "You revived "..target.player:GetName() )
					target.player:Notify( "You were revived by "..player:GetName() )

					target.player:AddBuff("buff_slowheal", item.restoreduration, { amount = item.restore })
					

				end)

			end
		else
			item.player:Notify("Not looking at a player!")
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}