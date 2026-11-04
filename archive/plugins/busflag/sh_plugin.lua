local PLUGIN = PLUGIN

PLUGIN.name = "Business flags"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Implements the business flag library"

-- This plugin is not used in this gamemode, 
-- however it can be very useful in a roleplay context
-- It allows string-based business flags, rather than just char based
-- These flags can also be exclusively be used for business, 
-- rather than the multi-use flags of Helix
--
-- See sh_definitions for an example
--
-- Add an attribute "busflag" to your items, 
-- e.g. ITEM.busflag = "Small_Weapons"
-- to lock an item to characters that have this business flag

ix.util.Include("sh_definitions.lua")

function PLUGIN:CanPlayerUseBusiness(client, uniqueID)
	local itemTable = ix.item.list[uniqueID]

	if (itemTable.busflag) then
		if (!client:GetCharacter():hasBusFlags(itemTable.busflag)) then
			return false
		end
	end

end


ix.command.Add("traderupgrademenu", {
	adminOnly = true,
	arguments = {
		ix.type.player,
	},
	OnRun = function(self, client, target)
		netstream.Start(client, "traderupmenu", target)
	end,
	OnCanRun = function(self, client, target)
		 if !client:GetCharacter():HasFlags("1") then
		 	return false
		 end
	end
})

ix.command.Add("CharGiveBusflag", {
	description = "Adds the busflag to the character.",
	privilege = "Manage Character Attributes",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string
	},
	OnRun = function(self, client, target, busflagname)
		for k, v in pairs(ix.busflag.list) do
			if (ix.util.StringMatches(L(v.name, client), busflagname) or ix.util.StringMatches(k, busflagname)) then
				target:giveBusFlag(k)
				return "Busflag ("..(L(v.name, client))..") given to "..target:GetName()
			end
		end

		return "Busflag not found!"
	end
})

ix.command.Add("CharTakeBusflag", {
	description = "Takes the busflag from the character.",
	privilege = "Manage Character Attributes",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.string
	},
	OnRun = function(self, client, target, busflagname)
		for k, v in pairs(ix.busflag.list) do
			if (ix.util.StringMatches(L(v.name, client), busflagname) or ix.util.StringMatches(k, busflagname)) then
				target:takeBusFlag(k)
				return "Busflag ("..(L(v.name, client))..") removed from "..target:GetName()
			end
		end

		return "Busflag not found!"
	end
})

if (CLIENT) then
local buttons = {}

	netstream.Hook("traderupmenu", function(client, target)
		local frame = vgui.Create("DFrame")
		frame:SetTitle( "Trader Upgrade Menu" )
		frame:SetVisible( true )
		frame:SetDrawOnTop(false)
		frame:SetDraggable( true )
		frame:ShowCloseButton( true )
		frame:Center()
		frame:MakePopup()
		frame:SetSize(800, 600)
		frame:SetPos((ScrW()/2)-400,(ScrH()/2)-300)

			local flagpanel = frame:Add("DPanel")
			flagpanel:Dock(LEFT)
			flagpanel:SetSize( frame:GetWide()/2 - 15, frame:GetTall() )

				local flagscroll = flagpanel:Add("DScrollPanel")
				flagscroll:SetSize( flagpanel:GetWide(), flagpanel:GetTall()-35 )
				flagscroll:DockMargin( 0, 0, 100, 0 )

					for k, v in SortedPairs(ix.busflag.list) do

						flagscrollbutton = flagscroll:Add( "DButton" )
						flagscrollbutton:SetText( v.name )
						flagscrollbutton:Dock( TOP )
						flagscrollbutton:DockMargin( 0, 0, 0, 5 )
						if client:GetCharacter():hasBusFlags(k) then
							flagscrollbutton:SetTextColor( Color( 0, 255, 0 ) )
						else
							if v.req then
								local count = 0
								for _, j in pairs(v.req) do
									if client:GetCharacter():hasBusFlags(j) then
										count = count + 1
									end
								end
								if count == #v.req then
									flagscrollbutton:SetTextColor( Color( 255, 255, 0 ) )
								else
									flagscrollbutton:SetTextColor( Color( 255, 0, 0 ) )
								end
							else
								flagscrollbutton:SetTextColor( Color( 255, 255, 0 ) )
							end
						end
						function flagscrollbutton:DoClick()
							traderupmenucurrentflagprice = v.cost
							traderupmenucurrentflag = k
							traderupmenucurrentreqflag = v.req

							traderupmenudesc = v.desc.."\n\nThis connection unlocks the following:\n\n"
							for _, g in pairs(ix.busflag.getAllWithFlag(k)) do
								traderupmenudesc = traderupmenudesc.."\n"..g.name
							end
							traderdescmidtextpanel:SetText( traderupmenudesc )
							traderdesctoptextpanel:SetText( v.name )
							traderdescmidtextpanel:Show()
							if v.req then

								for x, d in pairs(v.req) do
									local busflagname = (ix.busflag.list[d].name)
									traderdescreqtextpanel:Show()
									traderdescreqtextpanel:SetText( "This upgrade requires the following connections:\n" )
									traderdescreqpanel:Show()
									traderdescreqpanel:SetText( busflagname )
								end
							else
								traderdescreqtextpanel:Hide()
								traderdescreqpanel:Hide()
							end
							traderdescbottextpanel:SetText( "Purchase ("..traderupmenucurrentflagprice.." rubles)" )
							traderdescbottextpanel:Show()
						end
					end

			traderdescpanel = frame:Add("DPanel")
			traderdescpanel:Dock(RIGHT)
			traderdescpanel:SetSize( frame:GetWide()/2 - 15, frame:GetTall() ) 

				traderdesctoptextpanel = traderdescpanel:Add("DLabel")
				traderdesctoptextpanel:Dock(TOP)
				traderdesctoptextpanel:SetContentAlignment( 8 )
				traderdesctoptextpanel:SetSize( traderdescpanel:GetWide(), traderdescpanel:GetTall()/8 )
				traderdesctoptextpanel:SetFont( "ixMediumFont" )
				traderdesctoptextpanel:SetText( "Select an option on the left" )

				traderdescmidtextpanel = traderdescpanel:Add("DLabel")
				traderdescmidtextpanel:Dock(FILL)
				traderdescmidtextpanel:SetContentAlignment( 8 )
				traderdescmidtextpanel:Hide()

				traderdescreqtextpanel = traderdescpanel:Add("DLabel")
				traderdescreqtextpanel:Dock(FILL)
				traderdescreqtextpanel:SetContentAlignment( 2 )
				traderdescreqtextpanel:Hide()

				traderdescreqpanel = traderdescpanel:Add("DLabel")
				traderdescreqpanel:Dock(FILL)
				traderdescreqpanel:SetContentAlignment( 2 )
				traderdescreqpanel:Hide()

				traderdescbottextpanel = traderdescpanel:Add("DButton")
				traderdescbottextpanel:Dock(BOTTOM)
				traderdescbottextpanel:SetContentAlignment( 5 )
				traderdescbottextpanel:Hide()
					function traderdescbottextpanel:DoClick()
						local money = client:GetCharacter():HasMoney(traderupmenucurrentflagprice)
						local hasbusflag = client:GetCharacter():hasBusFlags(traderupmenucurrentflag)
						local hasbusreqflag = client:GetCharacter():hasBusFlags(traderupmenucurrentreqflag)
						if money and !hasbusflag and (hasbusreqflag or traderupmenucurrentreqflag == nil) then
								frame:Close()
								netstream.Start("busflagpurchase", traderupmenucurrentflag, traderupmenucurrentflagprice)
							else
								netstream.Start("busflagpurchasedenied")
						end
					end

	end)

else
	netstream.Hook("busflagpurchase", function(client, flag, traderupmenucurrentflagprice)
		client:GetCharacter():TakeMoney(traderupmenucurrentflagprice)
		client:GetCharacter():giveBusFlag(flag)
		client:Notify("The selected upgrade has been successfully unlocked!")
		netstream.Start(client, "traderupmenu", client)
	end)

	netstream.Hook("busflagpurchasedenied", function(client)
		client:Notify("You cant unlock that!")
	end)

end