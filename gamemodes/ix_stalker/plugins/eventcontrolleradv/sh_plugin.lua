local PLUGIN = PLUGIN
PLUGIN.name = "EventController - Adv"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Makes events occur randomly on your server. More intricate and complex configuration possible."

PLUGIN.eventdefs = PLUGIN.eventdefs or {}
PLUGIN.eventpoints = PLUGIN.eventpoints or {} -- EVENTPOINT STRUCTURE table.insert( PLUGIN.eventpoints, { position, name, difficulty } )

ix.util.Include("sh_eventdefs.lua")

PLUGIN.updaterate = 5

PLUGIN.spawnratebase = 1800
PLUGIN.spawnrateplayer = 30
PLUGIN.spawnradius = 128
PLUGIN.populateAmount = 5

PLUGIN.saferadius = 1000

PLUGIN.currentEvents = {} --To keep track of and update running events

local icon = Material("vgui/icons/news.png")

ix.chat.Register("eventpda", {
	CanSay = function(self, speaker, text)
		if IsValid(speaker) then
			if speaker:GetCharacter():HasFlags("N") or speaker:IsAdmin() then
				return true
			else
				return false
			end
		else
			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {"/eventpda"},
	CanHear = function(self, speaker, listener)
		local pda = listener:GetCharacter():GetData("pdaequipped", false)
		if pda then
			listener:EmitSound( "stalkersound/pda_alarm.wav", 55, 100, 1, CHAN_AUTO ) 
			return true
		else
			return false
		end
	end,
})

ix.chat.Register("eventpdainternal", {
	CanSay = function(self, speaker, text)
		local pda = speaker:GetCharacter():GetData("pdaequipped", false)
		if pda then
			speaker:EmitSound( "stalkersound/pda_alarm.wav", 55, 100, 1, CHAN_AUTO ) 
			return true
		else 
			return false
		end
		return false
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		local pda = listener:GetCharacter():GetData("pdaequipped", false)
		if pda then
			return true
		else
			return false
		end
	end,
})

if SERVER then
	local spawntime = 1
	local updatetime = 1
	local populate = true
	
	local function isClear(position)
		
		local currentdefs = {}
		local currentents = ents.FindInSphere( position, PLUGIN.saferadius )

		for i,j in pairs (currentents) do
			if j:IsPlayer() then
				return false
			end
		end
		return true
	end
	
	local function spawnEvent(eventpoint, spawn)
		if isClear(eventpoint[1]) then
			key = #currentEvents+1
			currentEvents[key].data = {}
			currentEvents[key].eventpoint = eventpoint
			currentEvents[key].eventDef = spawn.key

			/*currentEvents[key].dat = */self.eventdefs[v.key]:funcPrestart(currentEvents[key])
			/*currentEvents[key].dat = */self.eventdefs[v.key]:funcStart(currentEvents[key])
		end
	end

	function PLUGIN:setSpawnTime(time)
		spawntime = time
	end
	
	function PLUGIN:setPopulate(bool)
		populate = bool
	end

	function PLUGIN:LoadData()
		self.eventpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.eventpoints)
	end
	
	function PLUGIN:Think()
		if populate then
			for i = 1, self.populateAmount do
				local spawn = table.Random(self.eventdefs)
				local eventpoint = table.Random(self.eventpoints[table.Random(spawn.allowedPoints)])

				if (!eventpoint) then
					return
				end
				
				spawnEvent(eventpoint,spawn)
			end
			
			populate = false
		end
		
		if (updatetime < CurTime() ) then
			for k,v in pairs( self.currentEvents) do
				self.eventdefs[v.key]:funcUpdate(v.eventpoint, v.dat)
				if self.eventdefs[v.key]:funcShouldEnd(v.eventpoint, v.dat) then
					self.eventdefs[v.key]:funcEnd(v.eventpoint, v.dat)
					table.remove(self.currentEvents, k)
				end
			end

			updatetime = CurTime() + self.updaterate
		end

		if spawntime > CurTime() then return end
		spawntime = CurTime() + (self.spawnratebase - (self.spawnrateplayer * #player.GetAll()))

		local spawn = table.Random(self.eventdefs)
		local eventpoint = table.Random(self.eventpoints[table.Random(spawn.allowedPoints)])

		if (!eventpoint) then
			return
		end

		spawnEvent(eventpoint, spawn)

	end	
else
	netstream.Hook("nut_DisplaySpawnPoints", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v[1] )
			local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
			smoke:SetVelocity( Vector( 0, 0, 1 ) )
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255,186,50)
			smoke:SetAirResistance(300)
		end
	end)

end

ix.command.Add("eventadvadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string,
	},
	OnRun = function(self, client, name, internalname)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local name = name or "UNNAMED AREA"
		local internalname = internalname or "UNDEFINED_INTERNAL_NAME"

		table.insert( PLUGIN.eventpoints, internalname, { hitpos, name } )
		client:Notify( "Event area named '"..name.."'("..internalname..") succesfully added" )
	end
})

ix.command.Add("eventadvremove", {
	superAdminOnly = true,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs( PLUGIN.eventpoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.eventpoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( mt .. " event locations has been removed.")
	end
})

ix.command.Add("eventadvdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.eventpoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("eventadvforce", {
	adminOnly = true,
	OnRun = function(client, arguments)
		PLUGIN:setSpawnTime(1)
	end
})

ix.command.Add("eventadvpopulate", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		PLUGIN:setPopulate(true)
	end
})