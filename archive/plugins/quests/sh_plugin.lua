local PLUGIN = PLUGIN

PLUGIN.name = "Quests"
PLUGIN.author = "Chancer"
PLUGIN.desc = "A questing you shall go."

QUESTS = QUESTS or {}
QUESTS.quests = QUESTS.quests or {}
function QUESTS:Register(tbl)
	if(tbl.uid) then
		self.quests[tbl.uid] = tbl
	end
end

function QUESTS:GetAll()
	return self.quests
end

if (SERVER) then
	function PLUGIN:Think()	
		
	end
end

if(CLIENT) then
	netstream.Hook("ShowQuests", function(quests)	
		local text = ""
		
		for k, v in pairs(quests) do		
			local quest = QUESTS.quests[k]
			
			if(quest) then
				text = text .. quest.name .. ": " .. quest.intro .. "\n\n"
			end
		end
	
		local menu = vgui.Create( "DFrame" )
		menu:SetSize( 500, 700 )
		menu:Center()

		menu:SetTitle(LocalPlayer():Name())

		menu:MakePopup()

		menu.DS = vgui.Create( "DScrollPanel", menu )
		menu.DS:SetPos( 10, 50 )
		menu.DS:SetSize( 500 - 10, 700 - 50 - 10 )
		function menu.DS:Paint( w, h ) end
		
		menu.B = vgui.Create( "DLabel", menu.DS )
		menu.B:SetPos( 0, 40 )
		menu.B:SetFont( "nutSmallFont" )
		menu.B:SetText( text )
		menu.B:SetAutoStretchVertical( true )
		menu.B:SetWrap( true )
		menu.B:SetSize( 500 - 20, 10 )
		menu.B:SetTextColor( Color( 255, 255, 255, 255 ) )
	end)
end

ix.command.Add("quests", {
	arguments = ix.type.text,
	OnRun = function(self, client, arguments)
		local quests = client:GetCharacter():GetData("quests", {})
		netstream.Start(client, "ShowQuests", quests)
	end
})

ix.command.Add("questdelete", {
	arguments = ix.type.number,
	OnRun = function(self, client, arguments)
		if(!arguments) then 
			client:Notify("No Quest ID")
			return false
		end
		
		if(QUESTS.quests[arguments]) then
			QUESTS.quests[arguments] = nil
			client:Notify("Quest deleted")
		else
			client:Notify("No Quest by that ID")
		end
	end
})

if(SERVER) then
	function PLUGIN:SaveData()
		local data = {}
		
		self:SetData(QUESTS.quests)
	end

	function PLUGIN:LoadData()
		timer.Simple(1, function()
			QUESTS.quests = self:GetData()
		end)
	end

	netstream.Hook("nut_newQuest", function(client, entity, data)
		if(QUESTS.quests[uid]) then
			client:Notify("A quest with that uniqueID already exists.")
			return false
		end
		
		local QUEST = {}
		QUEST.uid = data[1]
		QUEST.name = data[2]
		QUEST.intro = data[3]
		QUEST.outro = data[4]
		QUEST.reminder = data[5] or data[3]
		QUEST.required = data[6]
		QUEST.reward = data[7]

		QUESTS:Register(QUEST)
		
		client:Notify("Quest successfully created.")

		--pushes the updated quest table to everyone, might be unnecessary due to it being in advhandler
		for k, v in pairs(player.GetAll()) do
			netstream.Start(v, "nut_questUpdate", QUESTS.quests)
		end
	end)
	
	netstream.Hook("nut_listQuest", function(client, entity, data)
		local quests = {}
		for k, v in pairs(data) do
			if(v == "_") then continue end

			table.insert(quests, v)
		end
		
		entity:SetNetVar("quests", quests)
		
		client:Notify("Quest list updated.")
	end)
else
	netstream.Hook("nut_questUpdate", function(update)
		QUESTS.quests = update
	end)
end

ix.util.Include("sh_quests.lua")