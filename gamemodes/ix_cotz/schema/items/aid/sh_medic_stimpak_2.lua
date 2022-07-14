ITEM.name = "Experimental Medical Stimpak MkII"
ITEM.description = "A small injector, produced in the zone."
ITEM.longdesc = "The second iteration of the ecologists stimpak project.\nAfter refining the formula, ecologists have managed to make the healing effect much stronger, however it is slightly more troublesome to produce, leading to a higher price."
ITEM.model = "models/lostsignalproject/items/medical/stim_pack2.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1200

ITEM.quantity = 1
ITEM.restore  = 70

ITEM.weight = 0.350
ITEM.flatweight = 0.125

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(1, -0.20000000298023, 200),
	ang = Angle(90, 0, 180),
	fov = 2.2,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Inject",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_rapidheal", 2, { amount = item.restore/4 })
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
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.usetarget = {
	name = "Inject Target",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local data = {}
			data.start = item.player:GetShootPos()
			data.endpos = data.start + item.player:GetAimVector()*96
			data.filter = item.player
		local target = util.TraceLine(data).Entity
		local quantity = item:GetData("quantity", item.quantity)
		if (IsValid(target) and target:IsPlayer()) then
			
			ix.chat.Send(item.player, "iteminternal", "jabs the "..item.name.." in "..target:Name().."'s leg.", false)
			target:AddBuff("buff_rapidheal", 2, { amount = item.restore/4 })
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

				target.player:AddBuff("buff_rapidheal", 2, { amount = item.restore/4 })
				ix.chat.Send(item.player, "iteminternal", "jabs the "..item.name.." in "..target:Name().."'s chest.", false)

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