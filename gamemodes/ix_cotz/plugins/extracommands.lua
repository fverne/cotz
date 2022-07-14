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

ix.command.Add("clearitems", {
	adminOnly = true,
	alias = {"removeitems", "cleanitems"},
	OnRun = function(self, client, arguments)

		for k, v in pairs(ents.FindByClass("ix_item")) do
			v:Remove()
		end

		client:Notify("All items have been cleaned up from the map.")
	end
})

ix.command.Add("clearnpcs", {
	adminOnly = true,
	alias = {"removenpcs", "cleannpcs"},
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

ix.command.Add("CharResetValues", {
    adminOnly = true,
    description = "Resets the specified characters values such as hunger, thirst, psyhealth, hp, etc.",
    arguments = {bit.bor(ix.type.string, ix.type.optional)},
    OnRun = function(self, client, target)
        if not target or target == "" then
            target = client:GetCharacter():GetName()
        end

        local target = ix.util.FindPlayer(target)

        if not target then
            client:Notify("Invalid Target!")

            return
        end

        target:SetPsyHealth(100)
        target:SetHunger(100)
        target:SetThirst(100)
        target:setRadiation(0)
        target:SetHealth(100)
        target:SetLocalVar("stm", 100)
        target:ResetDrunkLevel()

        if client == target then
            client:Notify("You have reset your character values")
        else
            client:Notify("You have reset " .. target:Name() .. "'s character values")
            target:Notify(client:Name() .. " has reset your character values")
        end

        target:UpdatePsyHealthState(target)
        target:UpdateHungerState(target)
        target:UpdateThirstState(target)
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

ix.command.Add("plytogglehidden", {
	description = "Hides the given player from being displayed on the scoreboard.",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function (self, client, target)
		if (target) then
			if target:GetNetVar("scoreboardhidden", false) then
				target:SetNetVar("scoreboardhidden", false)
				client:Notify(target:GetName().." is now displayed on the scoreboard.")
			else
				target:SetNetVar("scoreboardhidden", true)
				client:Notify(target:GetName().." has been hidden on the scoreboard.")
			end
		end
	end
})

function PLUGIN:ShouldShowPlayerOnScoreboard(client)
	if client:GetNetVar("scoreboardhidden", false) == true then
		return false
	end
end

ix.command.Add("coinflip", {
	OnRun = function(self, client, arguments)
		local coinSide = math.random(0, 1)
		if (coinSide > 0) then
			ix.chat.Send(client, "iteminternal", "flips a coin, and it lands on heads.")
		else
			ix.chat.Send(client, "iteminternal", "flips a coin, and it lands on tails.")
		end
	end,
})

ix.command.Add("content", {
	alias = {"workshop", "help"},
	OnRun = function(self, client, arguments)
	client:SendLua([[gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2290918731")]])
	client:ChatPrint("If you encounter any human NPCs such as Old Timer and they are T-posing, this is caused by model animation overrides, especially pirated CSS content, and is not something we can fix with the workshop.")
	client:ChatPrint("To fix this, head to the official Call of the Zone discord by typing /discord in-game. Head to the #information channel and follow the instructions on how to fix the T-posing Human NPCs.")
	end
})

ix.command.Add("discord", {
	OnRun = function(self, client, arguments)
	local url = ix.config.Get("communityURL")
	client:SendLua("gui.OpenURL(\"".. url.. "\")")
	end
})

ix.command.Add("suicide", {
	alias = {"unstuck", "respawn"},
	description = "Kill yourself, use if stuck somewhere.",
	OnRun = function(self, client)
		client:Kill()
	end
})
