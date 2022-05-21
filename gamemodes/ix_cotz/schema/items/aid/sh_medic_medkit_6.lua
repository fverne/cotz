ITEM.name = "Scientific Syrette Kit"
ITEM.description = "A small cardboard box with medical supplies inside, made for the zone."
ITEM.longdesc = "A box of syrettes designed specifically for the harsh environments and dangers one might face in the exclusion zone.\nThe syrettes contain a solution that will both suppress pain, help the body stop possible bleeding, and attempt to purge radiation from the body as well."
ITEM.model = "models/lostsignalproject/items/medical/medkit_science.mdl"

ITEM.sound = "stalkersound/inv_bandage.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1800

ITEM.quantity = 2
ITEM.restore  = 80
ITEM.radrem   = 35

ITEM.weight = 0.025
ITEM.flatweight = 0.045

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(200, 0, 0),
	ang = Angle(180, -0, 180),
	fov = 2.1,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)



		ix.chat.Send(item.player, "iteminternal", "opens the "..item.name.." and injects himself with a syrette.", false)
		
		ix.util.PlayerPerformBlackScreenAction(item.player, "Injecting Syrette", 3, function(player) 
			player:AddBuff("buff_rapidheal", 20, { amount = item.restore/20 })
			player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem/20 })
		end)
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
			ix.chat.Send(item.player, "iteminternal", "opens a "..item.name.." and injects "..target:Name().." with a syrette.", false)
			ix.util.PlayerPerformBlackScreenAction(item.player, "Treating "..target:Name().."'s Wounds", 1.5, function(player) 
				target:AddBuff("buff_rapidheal", 20, { amount = item.restore/20 })
				player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem/20 })
			end)
			
			ix.util.PlayerPerformBlackScreenAction(target, "Being treated by "..item.player:Name()..".", 1.5)
			
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

				target.player:AddBuff("buff_rapidheal", 20, { amount = item.restore/20 })
				target.player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem/20 })
				ix.chat.Send(item.player, "iteminternal", "opens a "..item.name.." and injects "..target.player:Name().." with a syrette.", false)

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