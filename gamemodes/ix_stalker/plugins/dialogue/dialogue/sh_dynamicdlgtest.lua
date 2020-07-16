DIALOGUE.name = "Dynamic Dialogue Option Test"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome to the zone!",
	options = {
		"RepairItems", 
		"GetTask",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Return", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"RepairItems", 
		"GetTask",
		"GOODBYE"
	} --Identical to GREETING's options
})

DIALOGUE.addTopic("RepairItem1", { -- Repair primary weapon
	statement = "",
	response = "",
	preCallback = function(self, client, target)
		local char = client:GetCharacter()
			
		local cost = 1000 -- Repair formula (?)
			
		if (char && char:HasMoney(cost)) then
			local items = client:GetCharacter():GetInventory():GetItems()
			local foundItem = "ERROR"

			for _, item in pairs( items ) do -- abstract this into library player:GetPrimaryWeapon()
				if item.weaponCategory == "primary" && item:GetData("equip", false) then
					foundName = item.name
					if (SERVER) then
						item:SetData("durability", math.Clamp(item:GetData("durability", 0) + 20, 0, 100))
						item:SetData("wear", 100);
						char:TakeMoney(cost)
					end
				end
			end
			if (CLIENT) then
				self.response = "Okay "..client:GetName()..", I have repaired and cleaned your "..foundName.."."
			end
		else 
			if(CLIENT) then
				self.response = "You don't have "..cost.." "..ix.currency.plural.."!"
			end
		end
	end,
	options = {
		"Return"
	}
})

DIALOGUE.addTopic("RepairItem2", { -- Repair secondary weapon
	statement = "",
	response = "",
	preCallback = function(self, client, target)
		local char = client:GetCharacter()

		local cost = 1000 -- Repair formula (?)
			
		if (char && char:HasMoney(cost)) then
			local items = client:GetCharacter():GetInventory():GetItems()
			local foundName = "ERROR"

			for _, item in pairs( items ) do
				if item.weaponCategory == "Secondary" && item:GetData("equip", false) then
					foundName = item.name
					if (SERVER) then
					 	item:SetData("durability", math.Clamp(item:GetData("durability", 0) + 20, 0, 100))
					 	item:SetData("wear", 100);
						char:TakeMoney(cost)
					end
				end
			end
			if (CLIENT) then
			 	self.response = "Okay "..client:GetName()..", I have repaired and cleaned your "..foundName.."."
			end
		else 
			if (CLIENT) then
			 	self.response = "You don't have "..cost.." "..ix.currency.plural.."!"
			end
		end
	end,
	options = {
		"Return"
	}
})

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you repair my items?",
	response = "What would you like me to look at?",
	options = {
		"RepairItem1",
		"RepairItem2"
	},
	preCallback = function(self, client, target)
		if(CLIENT)then
			self.response = self.response --Set up random phrases in library so the dialogue doesn't get too stale
		
			local char = client:GetCharacter()
			if (char) then
				local items = char:GetInventory():GetItems()

	      for _, item in pairs( items ) do
		  		if item.weaponCategory == "primary" && item:GetData("equip", false) then
		  			ix.dialogue.list["dynamicdlgtest"].tree["RepairItem1"].statement = item.name
		  		end
          if item.weaponCategory == "secondary" && item:GetData("equip", false) then
		  			ix.dialogue.list["dynamicdlgtest"].tree["RepairItem2"].statement = item.name
		  		end
		  	end
      end
    end
	end,
})

DIALOGUE.addTopic("GetTask", {
	statement = "Do you have any work for me?",
	response = "Yes, have a look.",
	options = {
		"Return"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER..."
})