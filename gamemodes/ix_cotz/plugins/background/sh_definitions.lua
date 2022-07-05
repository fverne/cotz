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
	"\n\nAddicted to Light Alcohol"..
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
		character:GetPlayer():AddAddiction("LightAlcoholic")
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
	"\n\nAddicted to Strong Alcohol"..
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
		character:GetPlayer():AddAddiction("StrongAlcoholic")
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
		character:GetPlayer():AddAddiction("StrongSmoker")
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
	"\n\nAddicted to drugs"..
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
		character:GetPlayer():AddAddiction("DrugUser")
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
	"\n\nAddicted to Light Alcohol"..
	"\n\nAddicted to Nicotine"..
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
		character:GetPlayer():AddAddiction("LightAlcoholic")
		character:GetPlayer():AddAddiction("LightSmoker")
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
	end,
}
