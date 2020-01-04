/*
   ____          _          _   ____          __  __       _ _                     
  / ___|___   __| | ___  __| | | __ ) _   _  |  \/  | __ _| | |__   ___  _ __ ___  
 | |   / _ \ / _` |/ _ \/ _` | |  _ \| | | | | |\/| |/ _` | | '_ \ / _ \| '__/ _ \ 
 | |__| (_) | (_| |  __/ (_| | | |_) | |_| | | |  | | (_| | | |_) | (_) | | | (_) |
  \____\___/ \__,_|\___|\__,_| |____/ \__, | |_|  |_|\__,_|_|_.__/ \___/|_|  \___/ 
                                      |___/                                        
						Thanks to ARitz Cracker for this part
*/

function PermaProps.HasPermission( ply, name )

	if !PermaProps or !PermaProps.Permissions or !PermaProps.Permissions[ply:GetUserGroup()] then return false end

	if PermaProps.Permissions[ply:GetUserGroup()].Custom == false and PermaProps.Permissions[ply:GetUserGroup()].Inherits and PermaProps.Permissions[PermaProps.Permissions[ply:GetUserGroup()].Inherits] then

		return PermaProps.Permissions[PermaProps.Permissions[ply:GetUserGroup()].Inherits][name]

	end

	return PermaProps.Permissions[ply:GetUserGroup()][name]

end

local function PermaPropsPhys( ply, ent, phys )

	if ent.PermaProps then

		return PermaProps.HasPermission( ply, "Physgun")

	end
	
end
hook.Add("PhysgunPickup", "PermaPropsPhys", PermaPropsPhys)
hook.Add( "CanPlayerUnfreeze", "PermaPropsUnfreeze", PermaPropsPhys) -- Prevents people from pressing RELOAD on the physgun

local function PermaPropsTool( ply, tr, tool )

	if IsValid(tr.Entity) and tr.Entity.PermaProps then

		if tool == "permaprops" then

			return true

		end

		return PermaProps.HasPermission( ply, "Tool")

	end

end
hook.Add( "CanTool", "PermaPropsTool", PermaPropsTool)

local function PermaPropsProperty( ply, property, ent )

	if IsValid(ent) and ent.PermaProps and tool ~= "permaprops" then

		return PermaProps.HasPermission( ply, "Property")

	end

end
hook.Add( "CanProperty", "PermaPropsProperty", PermaPropsProperty)

timer.Simple(5, function() hook.Remove("CanTool", "textScreensPreventTools") end) -- Fuck OFF
timer.Simple(5, function() hook.Remove("CanTool", "textscreenpreventtools") end)