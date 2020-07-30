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

ix.backgrounds["sickly"] = {
	name = "Sickly",
	description = "You’ve always been sickly. Colds, influenzas, sore throats, rashes, ear and sinus infections, you just can’t seem to avoid them. Your immune system is working overtime, all the time. You’re not exactly in top physical shape, and can’t really keep up with most people. You’ve heard rumors that wonders can happen inside the exclusion zone, and you wonder if your frail nature could be overturned in there.".. 
	"\n\nCons:"..
	"\n  Start with 20% less max health."..
	"\n  Start with 20% less max stamina."..
	"\n  Start with 10kg less carrying capacity."..
	"\n\nStarting Equipment:"..
	"\n  3x Bottle of painkillers."..
	"\n  1x TOZ-34 Sawn off ( 25% dur, 90% wear )."..
	"\n  1x 1x 12 gauge buckshot shells ( 36 quantity )."..
	"\n  1400 Rubles.",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("painkillers", 3)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

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