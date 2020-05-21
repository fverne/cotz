PLUGIN.name = "Extra Chat Commands"
PLUGIN.author = "verne"
PLUGIN.desc = "A few useful chat commands."

ix.chat.Register("iteminternal", {
	format = "**%s %s",
	GetColor = function(speaker, text)
		return Color(255, 70, 0)
	end,
	CanHear = ix.config.Get("chatRange", 280),
	deadCanChat = true
})

ix.chat.Register("lev", {
	CanSay =  function(self, speaker, text)
		return speaker:IsAdmin() or speaker:getChar():hasFlags("N")
	end,
	CanHear = ix.config.Get("chatRange", 280) * 8,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(225, 150, 20), text)
	end,
	prefix = {"/eventlocal", "/levent", "/lev"}
})

-- scream out loud.
ix.chat.Register("s", {
	format = "%s screams \"%s\"",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)
		-- Make the yell chat slightly brighter than IC chat.
		return Color(200, 20, 20)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/s", "/scream"}
})

ix.chat.Register("me's", {
	format = "**%s's %s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r - 35, color.g - 35, color.b - 35)
	end,
	CanHear = ix.config.Get("chatRange", 280),
	prefix = {"/me's", "/action's"},
	filter = "actions",
	deadCanChat = true
})
		
-- me close.
ix.chat.Register("meclose", {
	format = "**%s %s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r - 35, color.g - 35, color.b - 35)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 0.25,
	prefix = {"/meclose", "/actionw", "/mew"},
	filter = "actions",
	deadCanChat = true
})
		
ix.chat.Register("meclose's", {
	format = "**%s's %s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r - 35, color.g - 35, color.b - 35)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 0.1,
	prefix = {"/meclose's", "/actionw's", "/mew's"},
	filter = "actions",
	deadCanChat = true
})
		
-- me far.
ix.chat.Register("mefar", {
	format = "**%s %s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r + 35, color.g + 35, color.b + 35)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 2,
	prefix = {"/mefar", "/actiony", "/mey"},
	filter = "actions",
	deadCanChat = true
})

ix.chat.Register("mefar's", {
	format = "**%s' s%s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r + 35, color.g + 35, color.b + 35)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 2,
	prefix = {"/mefar's", "/actiony's", "/mey's"},
	filter = "actions",
	deadCanChat = true
})		

-- me far far.
ix.chat.Register("mefarfar", {
	format = "**%s %s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

				-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r + 45, color.g + 45, color.b + 45)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/mefarfar", "/actionyy", "/meyy"},
	filter = "actions",
	deadCanChat = true
})
		
ix.chat.Register("mefarfar's", {
	format = "**%s' s%s",
	GetColor = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r + 45, color.g + 45, color.b + 45)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/mefarfar's", "/actionyy's", "/meyy's"},
	filter = "actions",
	deadCanChat = true
})


-- it close.
ix.chat.Register("itclose", {
	onChatAdd = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)
		chat.AddText(Color(color.r - 35, color.g - 35, color.b - 35), "**"..text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 0.25,
	prefix = {"/itclose", "itw"},
	filter = "actions",
	deadCanChat = true
})

-- it far.
ix.chat.Register("itfar", {
	onChatAdd = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)
		chat.AddText(Color(color.r + 35, color.g + 35, color.b + 35), "**"..text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 2,
	prefix = {"/itfar", "ity"},
	filter = "actions",
	deadCanChat = true
})
		
-- it far far.
ix.chat.Register("itfarfar", {
	onChatAdd = function(speaker, text)
		local color = ix.chat.classes.ic.GetColor(speaker, text)
		chat.AddText(Color(color.r + 45, color.g + 45, color.b + 45), "**"..text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/itfarfar", "ityy"},
	filter = "actions",
	deadCanChat = true
})

/*
nut.command.add("nickset", {
	syntax = "[String Nickname]",
	onRun = function(client, arguments)
		if (arguments[1]) then
			if (!string.find(client:Name(), "'")) then
				local name = string.Split(client:getChar():getName(), " ")
				local newName = name[1].." '"..arguments[1].."' "..name[2]
				
				client:getChar():setName(newName)
				client:ChatPrint("Your name is now "..newName..".")
			else
				local name = string.Split(client:getChar():getName(), " ")
				string.Split(client:getChar():getName(), " ")
				local newName = name[1].." '"..arguments[1].."' "..name[3]
				
				client:getChar():setName(newName)
				client:ChatPrint("Your name is now "..newName..".")
			end;
		else
			client:ChatPrint("You need to enter a nickname.")
		end;
	end;
})

nut.command.add("nickremove", {
	syntax = "[No Input]",
	onRun = function(client, arguments)
		if (!string.find(client:Name(), "'")) then
			client:ChatPrint("No nickname was detected.")
		else
			local name = string.Split(client:getChar():getName(), " ")
			string.Split(client:getChar():getName(), " ")
			local newName = name[1].." "..name[3]
			
			client:getChar():setName(newName)
			client:ChatPrint("Your name is now "..newName..".")
		end;
	end;
})

ix.command.Add("cleanitems", {
	adminOnly = true,
	onRun = function(client, arguments)

	for k, v in pairs(ents.FindByClass("nut_item")) do
		
		v:Remove()
		
	end;
		client:notify("All items have been cleaned up from the map.")
	end
})

ix.command.Add("cleannpcs", {
	adminOnly = true,
	onRun = function(client, arguments)

	for k, v in pairs( ents.GetAll( ) ) do
	if IsValid( v ) and ( v:IsNPC() or baseclass.Get( v:GetClass() ).Base == 'base_nextbot' or baseclass.Get( v:GetClass() ).Base == 'nz_base' or  baseclass.Get( v:GetClass() ).Base == 'nz_risen' ) and !IsFriendEntityName( v:GetClass() ) then
		
		  v:Remove()
		
	   end
    end
	client:notify("All NPCs and Nextbots have been cleaned up from the map.")
	
	end
})
*/

ix.chat.Register("adminchat", {
	format = "whocares",
	--font = "nutRadioFont",
	GetColor = function(self, speaker, text)
		return Color(0, 196, 255)
	end,
	CanHear = function(self, speaker, listener)
		if listener:IsAdmin() then
			return true
		end

		return false
	end,
	OnCanSay = function(self, speaker, text)

		if not speaker:IsAdmin() then
			speaker:Notify("You aren't an admin.")
		end

		--speaker.NextAR = ix.config.Get("arequestinterval")

		return true
	end,
	OnChatAdd = function(self, speaker, text)
		local color = team.GetColor(speaker:Team())
		chat.AddText(Color(100, 255, 100), "[ADMIN] ", color, speaker:Name() .. " (" .. speaker:SteamName() .. ")", ": ", Color(255, 255, 255), text)
	end,
	prefix = "/a"
})

function PLUGIN:PlayerSay(client, text)
	local chatType, message, anonymous = ix.chat.Parse(client, text, true)

	if (chatType == "ic") then
		if (string.sub(text, 1, 1) == "@") then
			message = string.gsub(message, "@", "", 1)
			print(message)

			if not client:IsAdmin() then
				return
			end

			serverguard.command.Run(client, "a", false, message)

			return false
		end
	end
end

/*
ix.command.Add("coinflip", {
	onRun = function(client, arguments)
		local coinSide = math.random(0, 1);
		if (coinSide > 0) then
			nut.chat.send(client, "iteminternal", "flips a coin, and it lands on heads.");
		else
			nut.chat.send(client, "iteminternal", "flips a coin, and it lands on tails.");
		end
	end,
});


nut.command.add("forums", {
    syntax = "<No Input>",
	onRun = function(client, arguments)
	 client:SendLua([[gui.OpenURL("http://spite.boards.net/")]])
	end
})

nut.command.add("content", {
    syntax = "<No Input>",
	onRun = function(client, arguments)
	client:SendLua([[gui.OpenURL("http://steamcommunity.com/workshop/filedetails/?id=1301132452")]])
	end
})


nut.command.add("giveitemmenu", {
--	adminOnly = true,
	onRun = function(client, arguments)
		if client:getChar():getFlags("N") or client:IsAdmin() then
			netstream.Start(client, "nutItemMenu")
		else
			client:notify("You need to be an admin or have the N flag.")
		end
	end
})

if (CLIENT) then
	local PANEL = {}

	function PANEL:Init()
		self:SetSize(600, 700)
		self:Center()
		self:MakePopup()

		self.menu = self:Add("PanelList")
		self.menu:Dock(FILL)
		self.menu:DockMargin(5, 5, 5, 5)
		self.menu:SetSpacing(2)
		self.menu:SetPadding(2)
		self.menu:EnableVerticalScrollbar()

		self:LoadItems()
	end

	function PANEL:LoadItems()
		local sorted = {}

		for k, v in pairs(nut.item.list) do
			if (v.base) then
				sorted[v.base] = sorted[v.base] or {}
				table.insert(sorted[v.base], v)
			else
				sorted["zzz"] = sorted["zzz"] or {}
				table.insert(sorted["zzz"], v)
			end
		end

		for k, v in SortedPairs(sorted) do
			local label = self.menu:Add("DLabel")
			label:SetText(k)
			self.menu:AddItem(label)

			for _, d in ipairs(v) do
				local button = self.menu:Add("DButton")
				button:SetText(d.name.." | Price: "..(d.price or "0").." | Value:"..(d.value or "0"))
				self.menu:AddItem(button)

				function button:DoClick()
					LocalPlayer():ConCommand(Format('say /chargiveitem "%s" "%s"', LocalPlayer():Name(), d.uniqueID))
				end
			end
		end
	end

	vgui.Register("nutItemMenu", PANEL, "DFrame")

	netstream.Hook("nutItemMenu", function()
		local a = vgui.Create("nutItemMenu")
	end)
end