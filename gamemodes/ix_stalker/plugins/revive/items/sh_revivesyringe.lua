ITEM.name = "Revive Syringe"
ITEM.model = "models/kek1ch/notes_letter_1.mdl"
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
			local traceEnt = traceRes.Entity
			if ( traceEnt.isDeadBody ) then
				if not ( IsValid( traceEnt.player ) ) then
					ply:notify( "You cannot revive a disconnected player's body." )
					return false
				end
				ply:SetAction("Reviving...", ix.config.Get("reviveRessurrectionTime", 2))
				ply:DoStaredAction(traceEnt, function()
					traceEnt.player:UnSpectate()
					traceEnt.player:SetNetVar("resurrected", true)
					traceEnt.player:Spawn()
					traceEnt.player:SetHealth( 1 ) 
					traceEnt.player:SetPos(traceEnt:GetPos())
					ply:notify( "You revived "..traceEnt.player:GetName() )
					traceEnt.player:notify( "You were revived by "..ply:GetName() )
				end, ix.config.Get("reviveRessurrectionTime", 2), function() ply:SetAction() end, 128)

				end
			end

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("stashcoordinates", nil) == nil)
	end
}