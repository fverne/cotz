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

ix.backgrounds["alcoholic_light"] = {
	name = "Alcoholic (Light)",
	description = "You started drinking when you were young and could never kick the habit.".. 
	"\n\nAddicted to Light Alcohol"..
	"\n\nStarting Equipment:"..
	"\n  1x Contender (.45 ACP, .410 Magnum Buck) (Damaged)"..
	"\n  15x rounds of .45 ACP"..
	"\n  10x rounds of .410 Magnum Buck"..
	"\n  1x Ochakovo Beer, 2l (Almost Full)"..
	"\n  1x Baltika no 7, 900ml"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("g2contender", 1, {["durability"] = 50})
		character:GetInventory():Add("45acp", 1, {["quantity"] = 15})
		character:GetInventory():Add("45acp41", 1, {["quantity"] = 10})
		character:GetInventory():Add("drink_bottlebeer_1", 1, {["quantity"] = 3})
		character:GetInventory():Add("drink_canbeer_5", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}


ix.backgrounds["alcoholic_heavy"] = {
	name = "Alcoholic (Strong)",
	description = "After a traumatic event, you couldn't get back on your feet and started getting deep in the bottle.".. 
	"\n\nAddicted to Strong Alcohol"..
	"\n\nStarting Equipment:"..
	"\n  1x CZ52 (7.62x25mm) (Damaged)"..
	"\n  32x rounds of 7.62x25mm"..
	"\n  1x Smirnoff Vodka, 700ml"..
	"\n  1x Shevkoff Black Ultra Premium Vodka, 500ml (Half-Empty)"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("cz52", 1, {["durability"] = 50})
		character:GetInventory():Add("762x25", 1, {["quantity"] = 32})
		character:GetInventory():Add("drink_vodka_5", 1)
		character:GetInventory():Add("drink_vodka_3", 1, {["quantity"] = 1})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["smoker"] = {
	name = "Smoker",
	description = "Despite many tries, you could never get rid of the nicotine addiction.".. 
	"\n\nAddicted to Nicotine"..
	"\n\nStarting Equipment:"..
	"\n  1x TT-33 (7.62x25mm) (Damaged)"..
	"\n  32x rounds of 7.62x25mm"..
	"\n  1x 'Spark' Cigarettes (20pk) (Used)"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("tokarev", 1, {["durability"] = 50})
		character:GetInventory():Add("762x25", 1, {["quantity"] = 32})
		character:GetInventory():Add("drug_cigarette_4", 1, {["quantity"] = math.random(13,15)})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["eater"] = {
	name = "Eater",
	description = "You've always snacked more than others. Hopefully there's food enough in the zone.".. 
	"\n\nAddicted to Eating"..
	"\n\nStarting Equipment:"..
	"\n  1x Makarov (9x18mm) (Damaged)"..
	"\n  32x rounds of 9x18mm"..
	"\n  1x Seliskaya Cheese"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		character:GetInventory():Add("makarov", 1, {["durability"] = 50})
		character:GetInventory():Add("9x18", 1, {["quantity"] = 32})
		character:GetInventory():Add("food_cheese_2", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}