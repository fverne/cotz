function PLUGIN:OnContextMenuOpen( )
    if ( IsValid( ix.gui.itemmenu ) ) then
        ix.gui.itemmenu:SetVisible( true )
        ix.gui.itemmenu:MoveTo( ScrW( ) - 350, 0, 0.2, 0, -1 )
    end
end

function PLUGIN:OnContextMenuClose( )
    if ( IsValid( ix.gui.itemmenu ) ) then
        ix.gui.itemmenu:MoveTo( ScrW( ) + 350, 0, 0.2, 0, -1, function( )
            ix.gui.itemmenu:SetVisible( false )
        end )

        --for live debugging, uncommenting these will rebuild the panel each time you close the context menu, please don't enable this live.
        ix.gui.itemmenu:Remove( )
        vgui.Create( "ixItemMenu" )
    end
end

function PLUGIN:PlayerSpawn( client )
    if self:CanPlayerUseItemMenu( client ) then
        vgui.Create( "ixItemMenu" )
    else
        ix.gui.itemmenu:Remove( )
    end
end

local PLUGIN = PLUGIN

hook.Add( "Think", "ixAdminMenuLoad", function( )
    if not IsValid( ix.gui.itemmenu ) and PLUGIN:CanPlayerUseItemMenu( LocalPlayer( ) ) then
        vgui.Create( "ixItemMenu" )
    end
end )