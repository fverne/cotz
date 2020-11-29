local PLUGIN = PLUGIN

PLUGIN.name = "Job System"
PLUGIN.author = "gumlefar, ported to ix by verne"
PLUGIN.desc = "Implements the job library."

function ix.jobs.register(jobstruct,identifier)
  if ix.jobs.isStructValid(jobstruct) then
    ix.jobs.list[identifier] = jobstruct
  else
    print("ERROR IN JOB DEFINITION")
  end
end

ix.char.RegisterVar("jobs", {
	field = "jobs",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = true,
})

ix.util.Include("sh_jobs.lua")
ix.util.Include("sh_listeners.lua")

if CLIENT then
local buttons = {}
	netstream.Hook("questmenu", function(client, entity, curQuests)
		if !IsValid(entity) then return end

		local frame = vgui.Create("DFrame")
		frame:SetTitle( " " )
		frame:SetVisible( true )
		--frame:SetDrawOnTop(true)
		frame:SetDraggable( true )
		frame:ShowCloseButton( true )
		frame:Center()
		frame:MakePopup()
		frame:SetSize(1300, 600)
		frame:SetPos((ScrW()/2)-650,(ScrH()/2)-300)
		frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) ) -- Draw a red box instead of the frame
		end

		local questscroll = frame:Add("DHorizontalScroller")
		questscroll:SetSize(frame:GetWide()*0.93, frame:GetTall()*0.8)
		questscroll:SetPos(frame:GetWide()/25, frame:GetTall()/10)
		questscroll:SetOverlap( -75 )

		local questbackground = frame:Add( "DImage" )
		questbackground:Center()
		questbackground:Dock( FILL )
		questbackground:DockMargin( 0, -25, 0, 0)
		questbackground:SetZPos(-1)
		questbackground:SetPaintBackground( false )
		questbackground:SetImage( "stalker/questboard.png" )

		for k, v in pairs(curQuests) do

			local questpanel = questscroll:Add( "DPanel" )
			questpanel:SetSize(350, 200)
			questpanel:SetPaintBackground( false )
			questscroll:AddPanel( questpanel )

				local questpanelbackground = questpanel:Add( "DImage" )
				questpanelbackground:SetSize(questpanel:GetWide(), 5)
				questpanelbackground:Center()
				questpanelbackground:Dock( FILL )
				questpanelbackground:SetImage( ix.quest.list[k].icon )

				local questpaneltext = questpanel:Add( "DLabel" )
				questpaneltext:SetText( ix.quest.getFormattedName(k, v) )
				questpaneltext:Dock( FILL )
				questpaneltext:SetContentAlignment( 2 ) 
				questpaneltext:SetColor( Color( 0, 0, 0 ) )
				questpaneltext:SetFont( "stalkerregularfont" )
				questpaneltext:DockMargin( 0, 0, 0, 105 )

				local rewardlist = "Rewards: "

				for _, l in pairs(ix.quest.list[k].reward) do
					rewardlist = rewardlist..ix.item.list[l[1]].name..", "
				end

				questpanelrewardtext = questpanel:Add( "DLabel" )
				questpanelrewardtext:SetText( rewardlist )
				questpanelrewardtext:SetColor( Color( 0, 0, 0 ) )
				questpanelrewardtext:Dock( FILL )
				questpanelrewardtext:SetFont( "ixSmallFont" )
				questpanelrewardtext:SetContentAlignment( 2 ) 
				questpanelrewardtext:DockMargin( 0, 0, 0, 55 )

	/*			questpaneldesctext = questpanel:Add( "DLabel" )
				questpaneldesctext:SetText( ix.quest.getFormattedDesc(k, v) )
				questpaneldesctext:SetColor( Color( 0, 0, 0 ) )
				questpaneldesctext:Dock( FILL )
				questpaneldesctext:SetContentAlignment( 8 ) 
				questpaneldesctext:DockMargin( 0, 55, 0, 0 )
	*/
				if v.isCompleted then
					local questpanelbutton = questpanel:Add( "DButton" )
					questpanelbutton:SetText( "COMPLETE QUEST" )
					questpanelbutton:SetPos( questpanel:GetWide()/6, 430)
					questpanelbutton:SetSize( questpanel:GetWide()/1.5, 50 )
					questpanelbutton:DockMargin( 25, 0, 25, 0 )
					questpanelbutton:SetFont( "stalkermainmenufont" )
					questpanelbutton:SetColor( Color( 0, 0, 0 ) )
					questpanelbutton.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
						draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) ) -- Draw a red box instead of the frame
					end
					function questpanelbutton:DoClick()
						questsystemquest = k
						if v.isCompleted then
							frame:Close()
							netstream.Start("questmenucomplete", questsystemquest)
						end
					end
				else
					if ix.quest.isItemQuest(k) and client:GetCharacter():GetInventory():HasItem(ix.quest.isItemQuest(k)) then
						local questpanelitembutton = questpanel:Add( "DButton" )
						questpanelitembutton:SetText( "DELIVER ITEM" )
						questpanelitembutton:SetPos( questpanel:GetWide()/6, 365)
						questpanelitembutton:SetSize( questpanel:GetWide()/1.5, 50 )
						questpanelitembutton:DockMargin( 25, 0, 25, 0 )
						questpanelitembutton:SetFont( "stalkermainmenufont" )
						questpanelitembutton:SetColor( Color( 0, 0, 0 ) )
						questpanelitembutton.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
							draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) ) -- Draw a red box instead of the frame
						end
						function questpanelitembutton:DoClick()
							questsystemquest = k
							if !v.isCompleted then
								netstream.Start("questmenuitemdeliver", questsystemquest)
								frame:Close()
							end
						end
					end
					local questpaneltextprog = questpanel:Add( "DLabel" )
					questpaneltextprog:SetText( "Progress: "..v.progress.." / "..v.numberRec )
					questpaneltextprog:SetColor( Color( 0, 0, 0 ) )
					questpaneltextprog:Dock( FILL )
					questpaneltextprog:SetFont( "stalkerregularfont" )
					questpaneltextprog:SetContentAlignment( 2 ) 
					questpaneltextprog:DockMargin( 0, 0, 0, 15 )
				end

			end


		end)
else
	netstream.Hook("job_deliveritem", function(client, npcidentifier)
		local jobidentifier = client:GetCharacter():GetJobs()[npcidentifier].identifier
		if client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier)) then
			hook.Run("ix_JobTrigger", client, "itemDeliver_"..ix.jobs.isItemJob(jobidentifier))
			client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier)):Remove()
			client:Notify("Item delivered!")
			netstream.Start(client, "questmenu", client)
		else
			client:Notify("Required item not in inventory!")
		end
	end)
	netstream.Hook("questmenucomplete", function(client, npcidentifier)
			client:ixJobComplete(npcidentifier)
			client:Notify("The job has been completed!")
			netstream.Start(client, "questmenu", client)
	end)

	function PLUGIN:LoadData()
		data = self:GetData()

		for k, v in ipairs(data.persistList or {}) do
			local entity = ents.Create("ix_questentity")
			entity:SetPos(v.pos)
			entity:SetAngles(v.angles)
			entity:Spawn()
		end
	end

	function PLUGIN:SaveData()
		local data = {}
		for k, v in ipairs(ents.FindByClass("ix_questentity")) do
			data[#data + 1] = {
				pos = v:GetPos(),
				angles = v:GetAngles(),
			}
		end
		local data2 = {
			persistList = data,
		}

		self:SetData(data2)
	end
end