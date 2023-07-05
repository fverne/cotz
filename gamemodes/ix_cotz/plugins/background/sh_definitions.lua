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


ix.backgrounds["nothing"] = {
	name = "Nothing",
	description = "You have no idea how you ended up in this forsaken place, but you are not prepared.".. 
	"\n\nStarting Equipment:"..
	"\n  Nothing",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("value_personal_1")
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["alcoholic_light"] = {
	name = "Alcoholic (Light)",
	description = "You started drinking when you were young and could never kick the habit.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Contender (.45 ACP, .410 Magnum Buck) (Damaged)"..
	"\n  15x rounds of .45 ACP"..
	"\n  10x rounds of .410 Magnum Buck"..
	"\n  1x Ochakovo Beer, 2l (Almost Full)"..
	"\n  1x Baltika no 7, 900ml"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Homemade Poaching Knife"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("g2contender", 1, {["durability"] = 50})
		character:GetInventory():Add("45acp", 1, {["quantity"] = 15})
		character:GetInventory():Add("45acp41", 1, {["quantity"] = 10})
		character:GetInventory():Add("drink_bottlebeer_1", 1, {["quantity"] = 3})
		character:GetInventory():Add("drink_canbeer_5", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife_1", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}


ix.backgrounds["alcoholic_heavy"] = {
	name = "Alcoholic (Strong)",
	description = "After a traumatic event, you couldn't get back on your feet and started hitting the bottle.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Bat"..
	"\n  1x Smirnoff Vodka, 700ml"..
	"\n  1x Shevkoff Black Ultra Premium Vodka, 500ml (Half-Empty)"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Homemade Poaching Knife"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bat", 1)
		character:GetInventory():Add("drink_vodka_5", 1)
		character:GetInventory():Add("drink_vodka_3", 1, {["quantity"] = 1})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife_1", 1)
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
	"\n\nStarting Equipment:"..
	"\n  1x Lead Pipe"..
	"\n  1x 'Spark' Cigarettes (20pk) (Used)"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Homemade Poaching Knife"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("leadpipe", 1)
		character:GetInventory():Add("drug_cigarette_4", 1, {["quantity"] = math.random(13,15)})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife_1", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["druggie"] = {
	name = "Druggie",
	description = "You've tried it all, and you're still hooked.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Crowbar"..
	"\n  1x Painkillers"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Homemade Poaching Knife"..
	"\n  500 Rubles",
	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("crowbar", 1)
		character:GetInventory():Add("drug_painkillers", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 500})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife_1", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["addict_light"] = {
	name = "Addict (Light)",
	description = "You lived a luxury life, but a sudden turn of events made you go to the zone.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Contender (.45 ACP, .410 Magnum Buck) (Damaged)"..
	"\n  15x rounds of .45 ACP"..
	"\n  10x rounds of .410 Magnum Buck"..
	"\n  1x Ochakovo Beer, 2l (Almost Full)"..
	"\n  1x Baltika no 7, 900ml"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Homemade Poaching Knife"..
	"\n  1x 'Spark' Cigarettes (20pk) (Used)"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("g2contender", 1, {["durability"] = 50})
		character:GetInventory():Add("45acp", 1, {["quantity"] = 20})
		character:GetInventory():Add("45acp41", 1, {["quantity"] = 20})
		character:GetInventory():Add("drink_bottlebeer_1", 1, {["quantity"] = 3})
		character:GetInventory():Add("drink_canbeer_5", 1)
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife_1", 1)
		character:GetInventory():Add("drug_cigarette_4", 1, {["quantity"] = math.random(13,15)})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

]]--


ix.backgrounds["chef"] = {
	name = "Chef",
	description = "Being a chef at a promising restaurant has eventually grown boring to you. You decide to head to the Zone, to get a taste for various different kinds of cooking opportunities there. Armed only with your trusty kitchen knife, you head off to a place of endless culinary opportunities.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Kitchen Knife"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("knife2", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["outdoorsman"] = {
	name = "Outdoorsman",
	description = "You have an interest in the great outdoors, hunting animals, camping in the woods, preparing your own meals over a fireplace are all things you used to do in your spare time. You’re used to life in the wilderness, and have a lot of experience gutting animals for meat and parts. Now, money has become tight, and the zone seems like the perfect place to make a quick fortune as a hunter.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Hatchet"..
	"\n  1x Wood-Fueled Cooker"..
	"\n  1x Charcoal"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("hatchet", 1)
		character:GetInventory():Add("lowtiercooker", 1)
		character:GetInventory():Add("lowtiercookerfuel", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["mobpawn"] = {
	name = "Mob Pawn",
	description = "You've fallen in with the wrong crowd. The mob had a presence in your town, and it seemed like the only way up and out was to join in. You're at the bottom rung of the organization. The muscle. The foot soldier. The fall guy. Expendable.The boss says you've got to go in the exclusion zone, Mr. Big has smelled a goldmine of opportunities, and you better follow orders if you don't want to end up shooting yourself three times in the back of the head.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x TOZ-106"..
	"\n  30x .410 Magnum Buck"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("toz106", 1, {["durability"] = 35})
		character:GetInventory():Add("45acp41", 1, {["quantity"] = 30})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["constructionworker"] = {
	name = "Construction Worker",
	description = "Seeing a dear someone with someone else made you cave their head in, and you left for the exclusion zone.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x FUBar"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("fubar", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["alcoholic"] = {
	name = "Alcoholic",
	description = "You're always drinking. Things just dont feel right if you dont have a bit of a buzz going. Beer is best, a bit of vodka does the trick too.Your drinking money is up, and all your local bars are refusing you service until you pay back your tab. You're out of work, but rumors about the exclusion zone and how easy it is to make money there has enticed you.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Ochakovo Beer, 2l (Almost Full)"..
	"\n  2x Baltika no 7, 900ml"..
	"\n  1x Smirnoff Vodka, 700ml"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("leadpipe", 1)
		character:GetInventory():Add("drink_bottlebeer_1", 1, {["quantity"] = 3})
		character:GetInventory():Add("drink_canbeer_5", 2)
		character:GetInventory():Add("drink_vodka_5", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["doctor"] = {
	name = "Doctor",
	description = "The authorities finally caught up with you. You've been stealing morhpine out of the hospital supplies for years now to fuel your addiction. You're going to be looking at a long time in jail. If they catch you that is. One of your buddies can get you out of the city, into the exclusion zone where you can lay low until the heat blows over. Maybe you can even pick up some cash to bribe your way out of this mess.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Lead Pipe"..
	"\n  3x Gauze Bandage"..
	"\n  2x Medkit"..
	"\n  1x Medical Syrette Kit"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("leadpipe", 1)
		character:GetInventory():Add("medic_bandage_1", 3)
		character:GetInventory():Add("medic_medkit_1", 2)
		character:GetInventory():Add("medic_medkit_2", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["gambler"] = {
	name = "Gambler",
	description = "You have a serious gambling problem. After a particularly bad night out at the tables, you're in deep debt. You know the mob is going to come after you, and you know you have no way of paying them back. It's time to escape. You robbed your cocaine dealer for the last of his cocaine before taking off towards the exclusion zone.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Machete"..
	"\n  1x Die Cup"..
	"\n  1x Cocaine"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("machete", 1)
		character:GetInventory():Add("diecup", 1)
		character:GetInventory():Add("drug_cocaine", 2)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["mobhitman"] = {
	name = "Mob Hitman",
	description = "Your last job was a tad too messy, too many witnesses, too many victims. There's a bunch of people looking for you now, including the police. When you went to the boss to collect your payment, you were restrained, bound and blindfolded. After a long ride in the back of a car, you're thrust outside and set free. You realize you're in the exclusion zone, as your former associates speed away in the vehicle that brought you here.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x MP18"..
	"\n  15x 7.62x54mm"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("mp18", 1, {["durability"] = 25})
		character:GetInventory():Add("762x54", 1, {["quantity"] = 15})
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}


ix.backgrounds["athlete"] = {
	name = "Athlete",
	description = "Baseball was never really popular in Ukraine, so you decided to try out something else.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Bat"..
	"\n  2000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 2000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("bat", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}

ix.backgrounds["urbanexplorer"] = {
	name = "Urban Explorer",
	description = "You took off for the exclusion zone not knowing of the dangers it possessed, and now you are stuck here.".. 
	"\n\nStarting Equipment:"..
	"\n  1x Anorak"..
	"\n  1x Damaged Bag with Supplies"..
	"\n  1x Lead Pipe"..
	"\n  1x Backpack"..
	"\n  1000 Rubles",

	OnCreated = function(client, character) 
		--character:GetInventory():Add("kit_newchar")
		character:GetInventory():Add("anorak", 1, {["durability"] = 85})
		character:GetInventory():Add("bagrubles", 1, {["quantity"] = 1000})
		character:GetInventory():Add("kit_newchar", 1)
		character:GetInventory():Add("leadpipe", 1)
		character:GetInventory():Add("backpack_1", 1)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}