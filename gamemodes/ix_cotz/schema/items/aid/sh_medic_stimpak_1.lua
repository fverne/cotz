ITEM.name = "Experimental Medical Stimpak MkI"
ITEM.description = "A small injector, produced in the zone."
ITEM.longdesc = "An experimental syringe produced by the ecologists in the zone.\nThis is the first succesful attempt at creating a healing substance with distillations from artifacts, without major side effects. The only noteable side effect is a slight headache, and that it might leave the area where the solution is injected sore for a good while after injection."
ITEM.model = "models/lostsignalproject/items/medical/stim_pack1.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 800

ITEM.quantity = 1
ITEM.restore  = 40

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