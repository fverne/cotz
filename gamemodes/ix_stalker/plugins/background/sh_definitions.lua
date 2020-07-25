--[[
	ix.backgrounds[identifier] = {
		name : name of background,
		description = description of background,
		OnCreated = function(client, character) end, : Function that will run when character is created
		OnLoaded  = function(character) end, : Function that will run whenever the character is loaded

	}


	ix.backgrounds["cripple"] = {
		name = "Cripple",
		description = "Your right leg is busted, and you can't move around as fast. You use painkillers to numb the pain.",
		OnCreated = function(client, character) 
			character:GetInventory():Add("painkillers", 3)
		end,
		OnLoaded  = function(character) 
			local ply = character:GetPlayer()
			ply:SetRunSpeed(400)
			ply:SetWalkSpeed(200)
		end,
	}
]]--

ix.backgrounds["cripple"] = {
	name = "Cripple",
	description = "Your right leg is busted, and you can't move around as fast. You use painkillers to numb the pain.".. 
	"\n\nStarting Equipment:"..
	"\n  3x Painkillers"..
	"\n  1x Makarov"..
	"\n  1x 9x18 round",
	OnCreated = function(client, character) 
		character:GetInventory():Add("painkillers", 3)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["alcoholic"] = {
	name = "Alcoholic",
	description = "Alcoholic background for testing.",
	OnCreated = function(client, character) 
		character:GetInventory():Add("vodka", 5)
	end,
	OnLoaded = function(character)
	end,
}