local PLUGIN = PLUGIN
ix.plugin = ix.plugin or {}
ix.plugin.list = ix.plugin.list or {}
--PrintTable(ix.plugin.list.quests)
local questPLUGIN = ix.plugin.list.quests--ix.plugins.list( "quests" )
if not questPLUGIN then
	print( 'quest_honeya example will not work properly without "quest" plugin.' )
end

/*---------------------------------------------------------
	This is advanced handler for dialogue plugin.
	You can make some quest like things with this.
	But I recommends you don't care about this handler
	If you don't know how to code. 
	
	I will not answer any question about how to use this plugin.
	Unless you have any clue about this dialogue handler.
--------------------------------------------------------*/

local function canCompleteQuest(client, name)
	local char = client:GetCharacter()
	local inventory = char:GetInventory()
	
	local quest = QUESTS.quests[name]

	for k, v in pairs(quest.required) do
		if(inventory:GetItemCount(k) < v) then
			return false
		end
	end

	return true
end

local function questHandle(client, data, panel)
	if(SERVER) then
		local char = client:GetCharacter()
		local inventory = char:GetInventory()
		local quests = char:GetData("quests", {})
	
		--if has quest then complete
		if(quests[data.quest]) then
			if(canCompleteQuest(client, data.quest)) then
				client:Notify("Quest complete.")
			
				quests[data.quest] = nil
				
				for k, v in pairs(QUESTS.quests[data.quest].required) do
					local required = inventory:HasItem(k)
				
					if (required:GetData("Quantity")) then
					
					end
				
					for i = 1, v do
						required:Remove()
						required = inventory:HasItem(k)
					end
				end
				
				for k, v in pairs(QUESTS.quests[data.quest].reward) do
					for i = 1, v do
						timer.Simple(i/2, function()
							if(!inventory:Add(k)) then
								ix.item.Spawn(k, client:GetItemDropPos())
							end
						end)
					end
				end
				
				char:SetData("quests", quests)
			end
		else --give them the quest
			client:Notify("New Quest added.")
			
			quests[data.quest] = true
			char:SetData("quests", quests)
		end
	else
		local client = LocalPlayer()
		local char = client:GetCharacter()
		local quests = char:GetData("quests", {})
	
		 --if  they have the quest, complete it
		if(quests[data.quest]) then
			if(canCompleteQuest(client, data.quest)) then
				panel:AddChat(data.name, QUESTS.quests[data.quest].outro)
			else
				panel:AddChat(data.name, QUESTS.quests[data.quest].reminder)
			end
		else --if they don't, give it
			panel:AddChat(data.name, QUESTS.quests[data.quest].intro)
		end
	end
end

-- You can call SpecialCall with !.
-- example. when a player call dialouge that has uid "!quest_recieve_test" then it will call SpecialCall["quest_receive_test"].
PLUGIN.SpecialCall =
{
	["quest_honeya"] = { -- QUEST EXAMPLE.
		sv = function( client, data ) 
			if client:HasQuest( "honeya" ) then
				-- questPLUGIN = from the "quests" plugin.
				local pqst_dat = client:GetQuest( "honeya" ) -- get player quest data
				if client:CanCompleteQuest( "honeya", pqst_dat ) then -- If see player can complete quest
					client:GiveQuestReward( "honeya", pqst_dat ) -- Give quest reward
					client:RemoveQuest( "honeya" ) -- and remove player quest.
					data.done = true -- send client data.done. It will generate you're done text.
				else
					data.done = false
				end
			else
				-- set quest and get quest.
				data.gotquest = true -- Just got a quest!
				local d_qst = questPLUGIN:GetQuest( "honeya" )
				client:AddQuest( "honeya", d_qst:GenerateData( client ) ) -- Give a quest that has uniqueid 'honeya' and generates random data for quest.
				-- Quest data generating function is in sh_quests.lua file.
			end
			return data -- MUST RETURN DATA
		end,
	},
	["test"] = {
		sv = function( client, data )
			client:EmitSound( "items/smallmedkit1.wav" )
			client:SetHealth( 100 )
			return data -- MUST RETURN DATA
		end,
		cl = function( client, panel, data ) 
			panel:AddChat( data.name, "By the name of Black Tea! You're healed!" )
			panel.talking = false -- Ends the current conversation and allows player to talk about other topics.
		end,
	},
	
	["vendor"] = {
		sv = function(client, data)
			local vendor = client.nutVendor
			vendor.receivers[#vendor.receivers + 1] = client

			ix.log.Add(client, "vendorUse", vendor:GetNetVar("name", "reddit"))
			
			-- Finally, send the vendor state to the activator.
			hook.Run("PlayerAccessVendor", client, vendor)
		
			return data -- MUST RETURN DATA
		end,
		cl = function(client, panel, data)
			timer.Simple(2, function()
				if(IsValid(panel)) then
					--[[
					local entity = panel.entity
				
					--netstream.Start("nut_vendorMenuEX", {entity, LocalPlayer()})
					nutVendorEnt = entity
					hook.Run("VendorOpened", entity)
					--]]
					
					panel:Close()
				end
			end)
			
			panel:AddChat(data.name, panel.dialogue.npc["!" ..data.request])
			
			panel.talking = false -- Ends the current conversation and allows player to talk about other topics.
		end,
	},
	
	["quest"] = {
		sv = function( client, data )
			netstream.Start(client, "nut_questUpdate", QUESTS.quests)
		
			return data -- MUST RETURN DATA
		end,
		cl = function( client, panel, data )
			timer.Simple(2, function()
				if(IsValid(panel)) then
					local entity = panel.entity
					
					if(entity.openQuest) then 
						entity:openQuest()
					end
				end
			end)
			
			panel:AddChat(data.name, panel.dialogue.npc["!" ..data.request])
			
			panel.talking = false -- Ends the current conversation and allows player to talk about other topics.
		end,
	},	
	
	["fetch"] = {
		sv = function( client, data )
			--pushes the updated quest table to everyone, I don't really like this too much.
			netstream.Start(client, "nut_questUpdate", QUESTS.quests)
		
			questHandle(client, data)
			
			return data -- MUST RETURN DATA
		end,
		cl = function( client, panel, data )
			questHandle(client, data, panel)
			
			panel.talking = false -- Ends the current conversation and allows player to talk about other topics.
		end,
	},
}

-- Handler.
if SERVER then
	netstream.Hook("nut_DialogueMessage", function(client, data)
		if string.Left( data.request, 1 ) == "!" then
			data.request = string.sub( data.request, 2 )
			if PLUGIN.SpecialCall[ data.request ] then
				netstream.Start( client, "nut_DialoguePingpong", data )
				PLUGIN.SpecialCall[ data.request ].sv( client, data )
			else
				print( Format( "%s( %s ) tried to call invalid dialouge request( %s ) from %s.", client:Name(), client:Nick(), data.request, data.name ) )
				print( "Please check PLUGIN.SpecialCall or NPC's dialouge unique id." )
				client:EmitSound( "HL1/fvox/hev_general_fail.wav" )
				client:EmitSound( "HL1/fvox/hev_general_fail.wav" )
			end
		end
	end)
else
	netstream.Hook( "nut_DialoguePingpong", function( data )
		if IsValid( ix.gui.quest ) then
			if PLUGIN.SpecialCall[ data.request ] then
				PLUGIN.SpecialCall[ data.request ].cl(client, ix.gui.quest, data)
			end
		end
		
		if IsValid( ix.gui.dialogue ) then
			if PLUGIN.SpecialCall[ data.request ] then
				PLUGIN.SpecialCall[ data.request ].cl(client, ix.gui.dialogue, data)
			end
		end
	end)
end