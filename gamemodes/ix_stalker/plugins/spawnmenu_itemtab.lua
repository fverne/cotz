PLUGIN.name = "Spawn Menu: Items"; 
PLUGIN.author = "Rune Knight";
PLUGIN.description = "Adds a tab to the spawn menu which players can use to spawn items.";
PLUGIN.license = [[Copyright 2021 Rune Knight

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.]];

--[[
	STEAM: https://steamcommunity.com/profiles/76561198028996329/
	DISCORD: Rune Knight#5972
]]


CAMI.RegisterPrivilege({
	Name = "Spawn Menu: Items - Spawning",
	MinAccess = "superadmin"
})

function PLUGIN:GetExpectedIcon( s )
	local i = {
		["Ammunition"] = "icon16/tab.png", -- :shrug:
		["Clothing"] = "icon16/user_suit.png",
		["Consumables"] = "icon16/pill.png",
		["Medical"] = "icon16/heart.png",
		["misc"] = "icon16/error.png",
		["Permits"] = "icon16/note.png",
		["Storage"] = "icon16/package.png",
		["Weapons"] = "icon16/gun.png",

	};
	return hook.Run( "GetIconsForSpawnMenuItems", s ) or i[s] or "icon16/folder.png";
end

if( SERVER ) then
	util.AddNetworkString( "spawnmenuspawnitem" );

	ix.log.AddType( "spawnmenuspawnitem", function( client, name )
		return string.format( "%s has spawned \"%s\".", client:GetCharacter():GetName(), tostring( name ) )
	end );

	net.Receive("spawnmenuspawnitem", function( len, client )
		local u = net.ReadString();
		if( !CAMI.PlayerHasAccess( client, "Spawn Menu: Items - Spawning", nil ) ) then return end;
		for _, t in pairs( ix.item.list ) do
			if( t.uniqueID == u ) then
				ix.item.Spawn( t.uniqueID, client:GetShootPos() + client:GetAimVector() * 84 + Vector( 0, 0, 16 ) );
				ix.log.Add( client, "spawnmenuspawnitem", t.name )
				break;
			end
		end
	end );
else

	function PLUGIN:InitializedPlugins()
		if( SERVER ) then return end;
		RunConsoleCommand( "spawnmenu_reload" ); -- If someone legit knows how to insert stuff into the spawn menu without breaking it or doing it before the spawn menu is created, please tell me. Otherwise, this is the best I got.
	end

	local PLUGIN = PLUGIN;

	spawnmenu.AddCreationTab( "Items", function()
	
		local p = vgui.Create( "SpawnmenuContentPanel" );
		local t, n = p.ContentNavBar.Tree, p.OldSpawnlists;
	
		local l = {};
		for uid, i in pairs( ix.item.list ) do
			local c = i.category;
			l[c] = l[c] or {};
			table.insert( l[c], i );
		end

		for c, i in SortedPairs( l ) do

			local icon16 = PLUGIN:GetExpectedIcon( c );
			local node = t:AddNode( L(c), icon16 )
			node.DoClick = function( self )
				
				if( self.PropPanel and IsValid( self.PropPanel ) ) then 
					self.PropPanel:Remove()
					self.PropPanel = nil;
				end;

				self.PropPanel = vgui.Create( "ContentContainer", p );
				self.PropPanel:SetVisible( false );
				self.PropPanel:SetTriggerSpawnlistChange( false );
	
				for _, t in SortedPairsByMemberValue( i, "name" ) do
	
					spawnmenu.CreateContentIcon( "item", self.PropPanel, {
						nicename	= ( t.GetName and t:GetName() ) or t.name,
						spawnname	= t.uniqueID,
					} )
	
				end
	
				p:SwitchPanel( self.PropPanel );
	
			end
	
		end
	
		local FirstNode = t:Root():GetChildNode( 0 );
		if ( IsValid( FirstNode ) ) then
			FirstNode:InternalDoClick();
		end
	
		return p;
	
	end, "icon16/cog_add.png", 201 );

	spawnmenu.AddContentType( "item", function( p, data )
		
		local n = data.nicename;
		local u = data.spawnname;
		
		local icon = vgui.Create( "SpawnIcon", p );
		icon:SetWide( 64 );
		icon:SetTall( 64 );
		icon:InvalidateLayout( true );

		local t = ix.item.list;
		local i = t[u];

		icon:SetModel( ( i.GetModel and i:GetModel() ) or i.model );
		icon:SetTooltip( n );

		icon.DoClick = function( s ) 
			surface.PlaySound( "ui/buttonclickrelease.wav" );
			if( !CAMI.PlayerHasAccess( LocalPlayer(), "Spawn Menu: Items - Spawning", nil ) ) then 
				return;
			end

			net.Start( "spawnmenuspawnitem" );
				net.WriteString( u );
			net.SendToServer();
		end

		icon:InvalidateLayout( true );

		if ( IsValid( p ) ) then
			p:Add( icon )
		end

		return icon;
		
	end );

end
