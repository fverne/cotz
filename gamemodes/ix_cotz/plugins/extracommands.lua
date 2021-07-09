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
			ix.weight.Update(target)
			client:Notify("Weight of "..target:GetName().."has been set to 0.")
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
	if client:GetCharacter():GetData("scoreboardhidden", false) == true then
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
