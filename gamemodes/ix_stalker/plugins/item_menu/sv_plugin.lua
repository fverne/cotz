util.AddNetworkString( 'ixAdminSpawn' )

if SERVER then
    net.Receive( 'ixAdminSpawn', function( len, ply )
        if CAMI.PlayerHasAccess( ply, "Helix - Item Menu", nil ) or ply:IsSuperAdmin( ) then
            local spawnType = net.ReadBool( )
            local itemID = net.ReadString( )
            local itemName = ix.item.list[ itemID ].name

            if spawnType then
                --If we hit a player, give them the item.
                local target = net.ReadEntity( )
                ix.log.AddRaw( ply:GetName( ) .. " has used the Item Menu to spawn a " .. itemName .. " (" .. itemID .. ")" .. " into " .. target:GetName( ) .. "'s inventory.", nil, Color( 100, 200, 200, 255 ) )
                local inv = target:GetChar( ):GetInventory( )
                inv:Add( itemID )
                ply:Notify( "You have given " .. target:GetName( ) .. " a " .. itemName )
                target:Notify( ply:GetName( ) .. " has given you a " .. itemName )
            else
                --If we didn't, spawn at hit pos.
                local location = ply:GetEyeTraceNoCursor( ).HitPos
                ix.log.AddRaw( ply:GetName( ) .. " has used the Item Menu to spawn a " .. itemName .. " (" .. itemID .. ")" .. " at " .. tostring( location ), nil, Color( 100, 200, 200, 255 ) )
                ix.item.Spawn( itemID, location + Vector( 0, 0, 25 ) )
                ply:Notify( "You have spawned 1 " .. itemName .. "." )
            end
        end
    end )
end