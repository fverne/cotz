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
	description = "TODO".. 
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

ix.backgrounds["alcoholic_light"] = {
	name = "Alcoholic (Light)",
	description = "Beer is one of your favorite things to drink, ever since starting to do so at age 16. But since the mob came to fuck you over...".. 
	"\n\nAddicted to Light Alcohol"..
	"\n\nStarting Equipment:"..
	"\n  1x Contender (.45 ACP, .410 Magnum Buck) (Damaged)"..
	"\n  15x rounds of .45 ACP"..
	"\n  10x rounds of .410 Magnum Buck"..
	"\n  1x Lvivske Svitle, 1.5l"..
	"\n  1x Chernihivske White, 500ml"..
	"\n  1000 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("contender", 1, {["durability"] = 50})
		character:GetInventory():Add("45acp", 1, {["quantity"] = 15})
		character:GetInventory():Add("45acp41", 1, {["quantity"] = 10})
		character:GetInventory():Add("drink_bottlebeer_2", 1)
		character:GetInventory():Add("drink_canbeer_2", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}


ix.backgrounds["alcoholic_heavy"] = {
	name = "Alcoholic (Strong)",
	description = "Seeing your family fall apart due to your misuse didn't help it, actually it made it worse...".. 
	"\n\nAddicted to Strong Alcohol"..
	"\n\nStarting Equipment:"..
	"\n  1x CZ52 (7.62x25mm) (Damaged)"..
	"\n  32x rounds of 7.62x25mm"..
	"\n  2x Smirnoff Vodka, 700ml"..
	"\n  1000 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("cz52", 1, {["durability"] = 50})
		character:GetInventory():Add("762x25", 1, {["quantity"] = 32})
		character:GetInventory():Add("drink_vodka_3", 2)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["smoker"] = {
	name = "Smoker",
	description = "Smoking started as a pasttime, but after your traumatic event...".. 
	"\n\nAddicted to Nicotine"..
	"\n\nStarting Equipment:"..
	"\n  1x TT-33 (7.62x25mm) (Damaged)"..
	"\n  32x rounds of 7.62x25mm"..
	"\n  1x 'Petr 1.' Cigarettes (10pk)"..
	"\n  1000 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("tt33", 1, {["durability"] = 50})
		character:GetInventory():Add("762x25", 1, {["quantity"] = 32})
		character:GetInventory():Add("drug_cigarette_2", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["eater"] = {
	name = "Eater",
	description = "You've eaten a lot your entire life, and you are now addicted to doing so...".. 
	"\n\nAddicted to Eating"..
	"\n\nStarting Equipment:"..
	"\n  1x Makarov (9x18mm) (Damaged)"..
	"\n  32x rounds of 9x18mm"..
	"\n  1x Seliskaya Cheese"..
	"\n  1000 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("makarov", 1, {["durability"] = 50})
		character:GetInventory():Add("9x18", 1, {["quantity"] = 32})
		character:GetInventory():Add("food_cheese_2", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}