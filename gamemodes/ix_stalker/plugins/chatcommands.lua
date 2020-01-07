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
ix.command.Add("spawnitem", {
	description = "Spawns an item where you look",
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, itemIDToSpawn)

		if (IsValid(client) and client:GetChar()) then
			local uniqueID = itemIDToSpawn:lower()
			if (!ix.item.list[uniqueID]) then
				for k, v in SortedPairs(ix.item.list) do
					if (ix.util.StringMatches(v.name, uniqueID)) then
						uniqueID = k
						break
					end
				end
			end

			if(!ix.item.list[uniqueID]) then
				client:Notify("No item exists with this unique ID.")
				return
			end

            local aimPos = client:GetEyeTraceNoCursor().HitPos 

            aimPos:Add(Vector(0, 0, 10))  

            ix.item.Spawn(uniqueID, aimPos)
                        
		end
	end
})

ix.command.Add("setdata", {
	description = "sets data on the items you look at",
	adminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, key, data)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local stasheditem = ix.item.instances
		
		if (!data or !isnumber(data) or data < 0) then
			return "@invalidArg", 2
		end

		for k, v in pairs( stasheditem ) do
			if v:GetEntity() then
			local dist = hitpos:Distance(client:GetPos())
			local distance = v:GetEntity():GetPos():Distance( hitpos )
				if distance <= 32 then
					v:SetData(key, data)

					client:Notify( "Data set successfully.")
				end
			end
		end
	end
})

hook.Add("PopulateScoreboardPlayerMenu", "ixAdmin", function(client, menu)
	--[[-------------------------------------------------------------------------
	WAY too lazy to convert this
	---------------------------------------------------------------------------]]
	local options = {}
	options["Set Name"] = {
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Change Character Name", "What do you want to change this character's name to?", client:Name(), function(text)
					ix.command.Send("CharSetName", client:Name(), text)
				end, nil, "Change", "Cancel")
			end
		end
	}

	options["Set Health"] = {
		
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Change Character Health", "What do you want to change their health to?", client:Health(), function(text)
					ix.command.Send("PlySetHP", client:Name(), text, "true") --Need to put ix.type.bools in quotes????
				end, nil, "Set", "Cancel")
			end
		end
	}

	options["Set Armor"] = {
		
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Change Character Armor", "What do you want to change their armor to?", client:Armor(), function(text)
					ix.command.Send("PlySetArmor", client:Name(), text, "true")
				end, nil, "Set", "Cancel")
			end
		end
	}

	options["Kick Player"] = {
		
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Kick Player", "Why do you want to kick them?", "", function(text)
					ix.command.Send("PlyKick", client:Name(), text)
				end, nil, "Kick", "Cancel")
			end
		end
	}

	options["Ban Player"] = {
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Ban Reason", "Why do you want to ban them?", "", function(text)
					--ix.command.Send("PlyBan", client:Name(), text)
					Derma_StringRequest("Ban Length","For how long do you want to ban them? 0 is permanent.","",function(text2) ix.command.Send("PlyBan", client:Name(), text2, text) end, nil)
				end, nil, "Ban", "Cancel")
			end
		end
	}

		options["Change Model"] = {
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			if (IsValid(client) and LocalPlayer():IsAdmin()) then
				Derma_StringRequest("Change Character Model", "What do you want to change this character's model to?", client:GetModel(), function(text)
					ix.command.Send("CharSetModel", client:Name(), text)
				end, nil, "Change", "Cancel")
			end
		end
	}

	options["Change Faction"] = {
		function()
			if LocalPlayer():IsAdmin() == false then ix.util.Notify("This function is only available for admins.") return end
			local menu = vgui.Create("DFrame")
			menu:SetSize(ScrW() / 6, ScrH() / 3)
			menu:MakePopup()
			menu:Center()
			menu:SetTitle("Change Player Faction")
			local header = menu:Add("DLabel")
			header:Dock(TOP)
			header:SetText("Pick a faction to change them to.")
			header:SetTextInset(3, 0)
			header:SetFont("ixMediumFont")
			header:SetTextColor(color_white)
			header:SetExpensiveShadow(1, color_black)
			header:SetTall(28)

			header.Paint = function(this, w, h)
				surface.SetDrawColor(ix.config.Get("color"))
				surface.DrawRect(0, 0, w, h)
			end

			for k, v in pairs(ix.faction.indices) do
				local button = vgui.Create("DButton", menu)
				button:Dock(TOP)
				button:SetText(L(v.name))
				function button:DoClick()
					ix.command.Send("PlyTransfer", client:Name(), v.uniqueID)
				end
			end
		end
	}
	for k, v in pairs(options) do
		menu:AddOption(k,v[1])
	end
end)

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