ITEM.name = "Revive Syringe"
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.description = "Placeholder."
ITEM.price = 800
ITEM.flag = "A"

ITEM.functions.use = {
	name = "Revive",
	icon = "icon16/stalker/unlock.png",
	OnRun = function(item)
		local ply = item.player
		local traceRes = ply:GetEyeTrace()
		if ( IsValid( traceRes.Entity ) and traceRes.Entity:GetClass( ) == "prop_ragdoll" ) then
			print(traceRes.Entity)
			local traceEnt = traceRes.Entity
			if ( traceEnt.isDeadBody ) then
				print(traceEnt)
				if not ( IsValid( traceEnt.player ) ) then
					ply:notify( "You cannot revive a disconnected player's body." )
					return false
				end

				traceEnt.player:UnSpectate()
				traceEnt.player:SetNetVar("resurrected", true)
				traceEnt.player:Spawn()
				traceEnt.player:SetHealth( 1 ) 
				traceEnt.player:SetPos(traceEnt:GetPos())
				ply:Notify( "You revived "..traceEnt.player:GetName() )
				traceEnt.player:Notify( "You were revived by "..ply:GetName() )

			end
		end
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("stashcoordinates", nil) == nil) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}