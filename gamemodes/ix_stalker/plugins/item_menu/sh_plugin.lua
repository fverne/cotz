PLUGIN.name = 'Admin Item Menu'
PLUGIN.description = 'Adds an item menu for admins.'
PLUGIN.author = 'TomSL / ZeMysticalTaco'

ix.util.Include( 'cl_plugin.lua' )
ix.util.Include( 'sv_plugin.lua' )
ix.util.Include( 'cl_panels.lua' )

if ( not CAMI.GetPrivilege( "Helix - Item Menu" ) ) then
    CAMI.RegisterPrivilege( {
        Name = 'Helix - Item Menu',
        MinAccess = "superadmin",
        Description = 'Whether or not this user has access to the Context Menu Item Spawner.'
    } )
end

function PLUGIN:CanPlayerUseItemMenu( client )
    return CAMI.PlayerHasAccess( client, "Helix - Item Menu", nil ) or client:IsSuperAdmin( )
end