--[[
	ix.backgrounds[identifier] = {
		name = name,
		description = description,
		OnCreated = function(client, character) end,
		OnLoaded  = function(character) end,

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
	description = "Your right leg is busted, and you can't move around as fast. You use painkillers to numb the pain.",
	OnCreated = function(client, character) 
		character:GetInventory():Add("painkillers", 3)
	end,
	OnLoaded = function(character)
		--local client = character:GetPlayer()  
		--client:SetRunSpeed(400) -- These things dont actually work, they're overridden by the stamina plugin almost instantly
		--client:SetWalkSpeed(200)
		print("loaded cripple")
	end,
}