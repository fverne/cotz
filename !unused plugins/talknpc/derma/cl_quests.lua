local color_red = Color(255,0,0)
local color_white = Color(255,255,255)
local color_black = Color(0,0,0)

local PLUGIN = PLUGIN
/*---------------------------------------------------------
						DIALOGUE PANEL
						SORRY FOR NASTY LOOKING CODE
						I WAS LAZY
						- rebel1324
---------------------------------------------------------*/

if CLIENT then
	local PANEL = {}
	function PANEL:Init()
		local sh = ScrH()/1.5
		self:SetTitle( "Dialogue" )
		self:SetSize( sh*.8, sh )
		self.content = vgui.Create( "Panel", self )
		self.content:Dock( FILL )
		self.btnlist = {}
		self:MakePopup()
		self:Center()
		self.text = self.content:Add( "DPanel" )
		self.text:SetPos( 0, 0 )
		self.text:SetSize( self.content:GetWide(), self.content:GetTall()*.8 - 5 )
		self.dialouge = vgui.Create( "DScrollPanel", self.text )
		self.dialouge:DockMargin(10, 10, 10, 10)
		self.dialouge:Dock( FILL )
		self.dialouge.Paint = function() end
		self.select = self.content:Add( "DPanel" )
		self.select:SetPos( 0, self.content:GetTall()*.8 )
		self.select:SetSize( self.content:GetWide(), self.content:GetTall()*.2 )
		self.sdialouge = vgui.Create( "DScrollPanel", self.select )
		self.sdialouge:DockMargin(3, 3, 3, 3)
		self.sdialouge:Dock( FILL )
		self.sdialouge.Paint = function() end
	end
	
	function PANEL:SetEntity(ent)
		self.name = ent:GetNetVar( "name", "John Doe" )

		--local questTbl = PLUGIN.defaultQuest
		--PLUGIN.defaultQuest.player["!test"] = "This is a test function."
		
		local quests = ent:GetNetVar("quests", {})
		
		local qDiaglogue = table.Copy(PLUGIN.defaultQuest)
		
		for k, v in pairs(quests) do
			local dataTbl = QUESTS.quests[v]
		
			if(dataTbl) then
				qDiaglogue.npc[v] = dataTbl.intro
				qDiaglogue.player[v] = dataTbl.name
			end
		end
		
		self.dialogue = qDiaglogue
		self:AddChat( self.name, self.dialogue.npc._start )
		self:AddSelection( self.dialogue.player )
	end
	
	function PANEL:AddSelection( tbl )
		for k, v in pairs( tbl ) do
			local btn = self.sdialouge:Add( "DButton" )
			btn:SetFont( "Nut_NPCChatSel" )
			btn:SetTextColor( color_white )
			btn:SetText(v )
			btn:DockMargin(0, 0, 0, 0)
			btn:Dock(TOP)
			btn.DoClick = function()
				if k == "_quit" then self:Close() return end
				if self.talking then return end
				local dat = self.dialogue.npc[ k ]
				self:AddChat( LocalPlayer():Name(), v )
				self.talking = true
				
				-- special dialogue hook.
				netstream.Start("nut_DialogueMessage", { name = self.name, request = "!fetch", quest = k } )
				self.talking = true
				
				--[[
				if !( string.Left( k, 1 ) == "!" ) then --important
					timer.Simple( math.Rand( PLUGIN.chatDelay.min, PLUGIN.chatDelay.max ), function()
						if self:IsValid() then
							self.talking = false
							self:AddChat(self.name, self.dialogue.npc[ k ])
						end
					end)
				else
				
					-- special dialogue hook.
					netstream.Start("nut_DialogueMessage", { name = self.name, request = "!fetch", quest = k } )
					self.talking = true
				end
				--]]
			end
		end
	end
	
	function PANEL:AddName( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetFont( "Nut_NPCChatName" )
		lab:SetTextColor( color_white )
		lab:SetText(str )
		lab:SizeToContents()
		lab:DockMargin(3, 3, 3, 0)
		lab:Dock(TOP)
	end
	
	function PANEL:AddText( str )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( color_white )
		lab:SetFont( "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	
	function PANEL:AddCustomText( str, font, color )
		local lab = self.dialouge:Add( "DLabel" )
		lab:SetTextColor( color or color_white )
		lab:SetFont( font or "Nut_NPCChatText" )
		lab:SetText( str )
		lab:SetWrap( true )
		lab:DockMargin(10, 0, 3, 5)
		lab:Dock(TOP)
		lab:SetAutoStretchVertical( true )
	end
	
	function PANEL:AddChat( str1, str2 )
		self:AddName( str1 )
		self:AddText( str2 )
	end
	
	vgui.Register( "Nut_Quest", PANEL, "DFrame" )
end

/*---------------------------------------------------------
	DIALOGUE EDITOR PANEL
	SORRY FOR NASTY LOOKING CODE
	I WAS LAZY
	- rebel1324
---------------------------------------------------------*/
local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	--self:Center()
	local sh = ScrH()/1.5
	self:SetTitle( "Dialogue" )
	self:SetSize( sh*.8, sh )
	self:SetPos( 0, (ScrH()-sh)/2)
	self.content = vgui.Create( "DPanel", self )
	self.content:Dock( FILL )
	self.btnlist = {}
	
	self.scroll = self.content:Add( "DScrollPanel" )
	self.scroll:Dock( FILL )
end

function PANEL:SetEntity( entity )
	local dialogue = entity:GetNetVar( "dialogue", PLUGIN.defaultQuest )
	local info = self.scroll:Add("DLabel")
	info:SetText("Left Click: Set UID, Right Click: Set Dialogue")
	info:DockMargin(3, 3, 3, 3)
	info:Dock(TOP)
	info:SetTextColor(color_white)
	info:SetFont("Default")
	info:SizeToContents()
	
	---Quest list
	local npcd = self.scroll:Add("DLabel")
	npcd:SetText("Quests")
	npcd:DockMargin(3, 3, 3, 3)
	npcd:Dock(TOP)
	npcd:SetTextColor(color_white)
	--npcd:SetFont("nut_ScoreTeamFont")
	npcd:SizeToContents()
	self.npcd = self.scroll:Add( "DListView" )
	self.npcd:SetPos( 0, 0 )
	self.npcd:SetSize( self.content:GetWide(), self.content:GetTall() )
	self.npcd:AddColumn("Unique ID")
	self.npcd.OnClickLine = function( p, l, s )				
		local menu = DermaMenu()
		menu:AddOption( "Edit Quest ID", function()
			if(l.uid == "_") then return end
			Derma_StringRequest("Edit Quest ID", "Input ID of the desired quest.", l.uid, function(text)
				l:SetValue(1,  text or l.uid)
				l.uid = text
			end)
		end):SetImage("icon16/textfield_key.png")
		menu:AddOption( "Remove Quest", function()
			if(l.uid == "_") then return end
			l:Remove()
			self.npcd.l = nil
		end):SetImage("icon16/textfield_delete.png")
		menu:AddOption( "Add Quest", function()	
			local line = self.npcd:AddLine("default")
			Derma_StringRequest("Quest ID", "Input ID of the desired quest.", "default", function(text)
				line:SetValue(1,  text or l.uid)
				line.uid = text
			end)
		end):SetImage("icon16/textfield_add.png")
		menu:Open()
	end
	self.npcd:Dock( TOP )
	self.npcd:SetTall( 150 )
	
	--this is here so you always have something to click on to make more things, i'm bad with gui :(
	local temp = self.npcd:AddLine("")
	temp.uid = "_"
	
	local quests = entity:GetNetVar("quests", {})
	for k, v in pairs(quests) do
		local line = self.npcd:AddLine(v)
		line.uid = v
	end	
	
	-- Save button (for top part)
	self.savet = self:Add("DButton")
	self.savet:Dock(BOTTOM)
	self.savet:DockMargin(0, 5, 0, 0)
	self.savet:SetText("Save List")
	self.savet.DoClick = function()
		self:ListSave()
	end		
	
	---------------------
	
	--new quests
	
	--quest name
	local name = self.scroll:Add("DLabel")
	name:SetText("Quest Name")
	name:DockMargin(3, 3, 3, 3)
	name:Dock(TOP)
	name:SetTextColor(color_white)
	--name:SetFont("nut_ScoreTeamFont")
	name:SizeToContents()
	self.name = self.scroll:Add("DTextEntry")
	self.name:Dock(TOP)
	self.name:DockMargin(3, 3, 3, 3)
	self.name:SetText("Fetch")		
	
	--quest uid
	local uid = self.scroll:Add("DLabel")
	uid:SetText("Quest ID")
	uid:DockMargin(3, 3, 3, 3)
	uid:Dock(TOP)
	uid:SetTextColor(color_white)
	--uid:SetFont("nut_ScoreTeamFont")
	uid:SizeToContents()
	self.uid = self.scroll:Add("DTextEntry")
	self.uid:Dock(TOP)
	self.uid:DockMargin(3, 3, 3, 3)
	self.uid:SetText("default")
	
	--quest intro
	local intro = self.scroll:Add("DLabel")
	intro:SetText("Quest Description")
	intro:DockMargin(3, 3, 3, 3)
	intro:Dock(TOP)
	intro:SetTextColor(color_white)
	--intro:SetFont("nut_ScoreTeamFont")
	intro:SizeToContents()
	self.intro = self.scroll:Add("DTextEntry")
	self.intro:Dock(TOP)
	self.intro:DockMargin(3, 3, 3, 3)
	self.intro:SetText("Go find this thing for me.")

	--quest outro
	local outro = self.scroll:Add("DLabel")
	outro:SetText("Quest Completion")
	outro:DockMargin(3, 3, 3, 3)
	outro:Dock(TOP)
	outro:SetTextColor(color_white)
	--outro:SetFont("nut_ScoreTeamFont")
	outro:SizeToContents()
	self.outro = self.scroll:Add("DTextEntry")
	self.outro:Dock(TOP)
	self.outro:DockMargin(3, 3, 3, 3)
	self.outro:SetText("Thanks for finding that thing for me.")
	
	--quest reminder
	local reminder = self.scroll:Add("DLabel")
	reminder:SetText("Quest Reminder")
	reminder:DockMargin(3, 3, 3, 3)
	reminder:Dock(TOP)
	reminder:SetTextColor(color_white)
	--reminder:SetFont("nut_ScoreTeamFont")
	reminder:SizeToContents()
	self.reminder = self.scroll:Add("DTextEntry")
	self.reminder:Dock(TOP)
	self.reminder:DockMargin(3, 3, 3, 3)
	self.reminder:SetText("You still don't have the thing I want.")
	
	--required items
	local required = self.scroll:Add("DLabel")
	required:SetText("Quest Requirements")
	required:DockMargin(3, 3, 3, 3)
	required:Dock(TOP)
	required:SetTextColor(color_white)
	--required:SetFont("nut_ScoreTeamFont")
	required:SizeToContents()
	self.required = self.scroll:Add( "DListView" )
	self.required:SetPos( 0, 0 )
	self.required:SetSize( self.content:GetWide(), self.content:GetTall() )
	self.required:AddColumn("Unique ID")
	self.required:AddColumn("Amount")
	self.required.OnClickLine = function( p, l, s )			
		local menu = DermaMenu()
		menu:AddOption( "UniqueID", function()
			if(l.uid == "_") then return end
			Derma_StringRequest("Item UniqueID", "Input item unique ID.", l.uid, function(text)
				l:SetValue(1,  text or l.uid)
				l.uid = text
			end)
		end)
		menu:AddOption( "Amount", function()
			if(l.uid == "_") then return end
			Derma_StringRequest("Amount", "The number of items", l.num, function(text)
				l:SetValue(2,  text or l.num)
				l.num = text
			end)
		end):SetImage("icon16/textfield_key.png")
		menu:AddOption( "Remove Item", function()
			if(l.uid == "_") then return end
			l:Remove()
			self.required.l = nil
		end):SetImage("icon16/textfield_delete.png")
		menu:AddOption( "Add Item", function()	
			local line = self.required:AddLine("food_banana", 1)
			line.uid = "food_banana"
			line.num = 1
		end):SetImage("icon16/textfield_add.png")
		menu:Open()
	end	
	self.required:Dock( TOP )
	self.required:SetTall( 150 )
	
	local temp = self.required:AddLine("")
	temp.uid = "_"	
	temp.num = 1
	temp = self.required:AddLine("food_banana", 1)
	temp.uid = "food_banana"
	temp.num = 1
	
	--reward items
	local reward = self.scroll:Add("DLabel")
	reward:SetText("Quest Rewards")
	reward:DockMargin(3, 3, 3, 3)
	reward:Dock(TOP)
	reward:SetTextColor(color_white)
	--reward:SetFont("nut_ScoreTeamFont")
	reward:SizeToContents()
	self.reward = self.scroll:Add( "DListView" )
	self.reward:SetPos( 0, 0 )
	self.reward:SetSize( self.content:GetWide(), self.content:GetTall() )
	self.reward:AddColumn("Unique ID")
	self.reward:AddColumn("Amount")
	self.reward.OnClickLine = function( p, l, s )			
		local menu = DermaMenu()
		menu:AddOption( "UniqueID", function()
			if(l.uid == "_") then return end
			Derma_StringRequest("Item UniqueID", "Input item unique ID.", l.uid, function(text)
				l:SetValue(1,  text or l.uid)
				l.uid = text
			end)
		end)
		menu:AddOption( "Amount", function()
			if(l.uid == "_") then return end
			Derma_StringRequest("Amount", "The number of items", l.num, function(text)
				l:SetValue(2,  text or l.num)
				l.num = text
			end)
		end):SetImage("icon16/textfield_key.png")
		menu:AddOption( "Remove Item", function()
			if(l.uid == "_") then return end
			l:Remove()
			self.reward.l = nil
		end):SetImage("icon16/textfield_delete.png")
		menu:AddOption( "Add Item", function()	
			local line = self.reward:AddLine("food_banana")
			line.uid = "food_banana"
			line.num = 1
		end):SetImage("icon16/textfield_add.png")
		menu:Open()
	end	
	self.reward:Dock( TOP )
	self.reward:SetTall( 150 )
	
	local temp = self.reward:AddLine("")
	temp.uid = "_"
	temp = self.reward:AddLine("food_banana", 1)
	temp.uid = "food_banana"
	temp.num = 1
	
	--Create button (for bottom part)
	self.create = self:Add("DButton")
	self.create:Dock(BOTTOM)
	self.create:DockMargin(0, 5, 0, 0)
	self.create:SetText("Create Quest")
	self.create.DoClick = function()
		self:QuestSave()
	end	
	
	function self:ListSave()
		if (IsValid(entity) and (self.nextSend or 0) < CurTime()) then
			self.nextSend = CurTime() + 1
			
			local quest = {}
			for k, v in pairs(self.npcd:GetLines()) do
				table.insert(quest, v.uid)
			end
			
			netstream.Start("nut_listQuest", entity, quest)
			--self:Close()
		end
	end	
	
	function self:QuestSave()
		if (IsValid(entity) and (self.nextSend or 0) < CurTime()) then
			self.nextSend = CurTime() + 1

			local reqs = {}
			for k, v in pairs(self.required:GetLines()) do
				if(v.uid == "_") then continue end
				
				reqs[v.uid] = v.num
			end
			
			local rewards = {}
			for k, v in pairs(self.reward:GetLines()) do
				if(v.uid == "_") then continue end
			
				rewards[v.uid] = v.num
			end
			
			local quest = {
				self.uid:GetText(),
				self.name:GetText(),
				self.intro:GetText(),
				self.outro:GetText(),
				self.reminder:GetText(),
				reqs,
				rewards
			}
			
			netstream.Start("nut_newQuest", entity, quest)
			--self:Close()
		end
	end
end
vgui.Register( "Nut_QuestEditor", PANEL, "DFrame" )