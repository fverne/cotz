PLUGIN.name = "Extra Commands"
PLUGIN.author = "Luna"
PLUGIN.desc = "A few useful commands."

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
*/

ix.command.Add("Event", {
	description = "@cmdEvent",
	arguments = ix.type.text,
	adminOnly = true,
	OnRun = function(self, client, text)
		ix.chat.Send(client, "event", text)
	end
})

ix.command.Add("cleanitems", {
	adminOnly = true,
	OnRun = function(self, client, arguments)

		for k, v in pairs(ents.FindByClass("ix_item")) do
			v:Remove()
		end

		client:Notify("All items have been cleaned up from the map.")
	end
})

ix.command.Add("cleannpcs", {
	adminOnly = true,
	OnRun = function(self, client, arguments)

	for k, v in pairs( ents.GetAll( ) ) do
	if IsValid( v ) and ( v:IsNPC() or baseclass.Get( v:GetClass() ).Base == 'base_nextbot' or baseclass.Get( v:GetClass() ).Base == 'nz_base' or  baseclass.Get( v:GetClass() ).Base == 'nz_risen' ) and !IsFriendEntityName( v:GetClass() ) then
		
		  v:Remove()
		
	   end
    end
	client:Notify("All NPCs and Nextbots have been cleaned up from the map.")
	
	end
})

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

-- Credit goes to SmithyStanley
ix.command.Add("clearinv", {
	description = "Removes all the items in the target characters inventory.",
	adminOnly = true,
	arguments = {
		ix.type.character
	},	
	OnRun = function (self, client, character)
		local target = character
		
		if (target) then
			for k, v in pairs(target:GetInventory():GetItems()) do
				v:Remove()
			end
			client:Notify("The inventory of "..target:GetName().." has been cleared.")
		end
	end
})

ix.command.Add("chartogglehidden", {
	description = "Hides the given character from being displayed on the scoreboard.",
	adminOnly = true,
	arguments = {
		ix.type.character
	},	
	OnRun = function (self, client, character)
		local target = character
		
		if (target) then
			if target:GetData("scoreboardhidden", false) then
				target:SetData("scoreboardhidden", false)
				client:Notify(target:GetName().." is now displayed on the scoreboard.")
			else
				target:SetData("scoreboardhidden", true)
				client:Notify(target:GetName().." has been hidden on the scoreboard.")
			end
		end
	end
})

function PLUGIN:ShouldShowPlayerOnScoreboard(client)
	if client:GetCharacter():GetData("scoreboardhidden", false) then
		return false
	end
end

ix.command.Add("coinflip", {
	OnRun = function(self, client, arguments)
		local coinSide = math.random(0, 1);
		if (coinSide > 0) then
			ix.chat.Send(client, "iteminternal", "flips a coin, and it lands on heads.");
		else
			ix.chat.Send(client, "iteminternal", "flips a coin, and it lands on tails.");
		end
	end,
});


ix.command.Add("giveitemmenu", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if client:GetCharacter():GetFlags("N") or client:IsAdmin() then
			netstream.Start(client, "ixItemMenu")
		else
			client:Notify("You need to be an admin or have the N flag.")
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

		for k, v in pairs(ix.item.list) do
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
				--print(d.name.." | Price: "..(d.price or "0"))
				self.menu:AddItem(button)

				function button:DoClick()
					LocalPlayer():ConCommand(Format('say /chargiveitem "%s" "%s"', LocalPlayer():Name(), d.uniqueID))
				end
			end
		end
	end

	vgui.Register("ixItemMenu", PANEL, "DFrame")

	netstream.Hook("ixItemMenu", function()
		local a = vgui.Create("ixItemMenu")
	end)
end