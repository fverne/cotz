local PANEL = { }

function PANEL:Init( )
    if ( IsValid( ix.gui.itemmenu ) ) then
        ix.gui.itemmenu:Remove( )
    end

    ix.gui.itemmenu = self
    --self:Dock(RIGHT)
    self:SetWide( 350 )
    self:SetMouseInputEnabled( true )
    self:SetTitle( "" )
    self:MakePopup( )
    self:SetScreenLock( true )
    self:ShowCloseButton( false )
    self:SetVisible( false )
    self:SetAlpha( 255 )
    self:SetTall( ScrH( ) )
    self.scrollpanel = self:Add( "DScrollPanel" )
    self.scrollpanel:Dock( FILL )
    self.categorylist = self:Add( "DCategoryList" )
    self.categorylist:Dock( FILL )
    self.categorylist:SetBackgroundColor( Color( 50, 50, 50, 255 ) )
    self:SetPos( ScrW( ) + 350, 0 )
    self.oldOnRelease = self.OnMouseReleased

    self.OnMouseReleased = function( this )
        self:oldOnRelease( )
    end

    local text = { 'Left Click on an item staring the ground to spawn it.', 'When looking at a player, it will go into their inventory.', 'Right Click on an item to give it to yourself.' }
    self.InfoPanel = self:Add( 'DPanel' )
    self.InfoPanel:Dock( TOP )
    self.InfoPanel:SetTall( 120 )

    for k, v in ipairs( text ) do
        local label = self.InfoPanel:Add( 'DLabel' )
        label:SetText( v )
        label:SetFont( 'ixSmallFont' )
        label:SetTextInset( 4, 0 )
        --
        label:SetWrap( true )
        --label:SizeToContentsY()
        label:Dock( TOP )
        label:SetTall( 40 )
        --label:SizeToContents()
        self.InfoPanel:InvalidateLayout( true )
    end

    self:Populate( )
end

function PANEL:Populate( )
    local indexedItems = { }
    local itemcategorys = { }

    for k, v in pairs( ix.item.list ) do
        itemcategorys[ v.category or v.Category ] = true
    end

    for k, v in pairs( itemcategorys ) do
        local cat = self.categorylist:Add( k )
        local panel = vgui.Create( "DScrollPanel" )
        panel:SetSize( self:GetWide( ), 250 )

        --so it would theoretically be faster to have some sort of sorted index for this that has sequential numerical sorting...
        --but helix, as far as I know, doesn't have a way to loop through a sequential index of items that doesn't just involve list looping.
        for k2, v2 in pairs( ix.item.list ) do
            if indexedItems[ k2 ] then continue end --skip if already indexed in another category, saves time.
            if string.find(k2, '_flipped') then continue end -- don't index flipped items.
            if v2.category == k then
                indexedItems[ k2 ] = true
                local dbutton = panel:Add( "ixMenuSelectionButton" )
                dbutton:Dock( TOP )
                dbutton:SetText( v2.name )
                dbutton:SetFont( "ixMediumFont" )
                dbutton:SetTall( 35 )

                dbutton.Paint = function( pnl )
                    local w, h = pnl:GetWide( ), pnl:GetTall( )
                    local alpha = 255

                    if ( pnl:GetDisabled( ) ) then
                        alpha = 10
                    elseif ( pnl.Depressed ) then
                        alpha = 180
                    elseif ( pnl.Hovered ) then
                        alpha = 255
                    end

                    surface.SetDrawColor( 30, 30, 30, alpha )
                    surface.DrawRect( 0, 0, w, h )
                    surface.SetDrawColor( 0, 0, 0, 180 )
                    surface.DrawOutlinedRect( 0, 0, w, h )
                    surface.SetDrawColor( 180, 180, 180, 2 )
                    surface.DrawOutlinedRect( 1, 1, w - 2, h - 2 )
                end

                dbutton.DoClick = function( )
                    if CAMI.PlayerHasAccess( LocalPlayer( ), "Helix - Item Menu", nil ) or LocalPlayer( ):IsSuperAdmin( ) then
                        local tr = LocalPlayer( ):GetEyeTrace( )
                        local hitpos = tr.HitPos
                        local ent = tr.Entity

                        if ent and ent:IsPlayer( ) then
                            net.Start( 'ixAdminSpawn' )
                            net.WriteBool( true ) --Whether or not we hit a player.
                            net.WriteString( v2.uniqueID )
                            net.WriteEntity( ent )
                            net.SendToServer( )

                            return
                        end

                        if hitpos then
                            net.Start( 'ixAdminSpawn' )
                            net.WriteBool( false ) --Whether or not we hit a player.
                            net.WriteString( v2.uniqueID )
                            net.SendToServer( )
                        end
                    end
                end

                dbutton.DoRightClick = function( )
                    if CAMI.PlayerHasAccess( LocalPlayer( ), "Helix - Item Menu", nil ) or LocalPlayer( ):IsSuperAdmin( ) then
                        net.Start( 'ixAdminSpawn' )
                        net.WriteBool( true )
                        net.WriteString( v2.uniqueID )
                        net.WriteEntity( LocalPlayer( ) )
                        net.SendToServer( )
                    end
                end

                cat:SetContents( panel )
            end
        end
    end
end

function PANEL:Paint( w, h )
    surface.SetDrawColor( 50, 50, 50, 150 )
end

vgui.Register( "ixItemMenu", PANEL, "DFrame" )