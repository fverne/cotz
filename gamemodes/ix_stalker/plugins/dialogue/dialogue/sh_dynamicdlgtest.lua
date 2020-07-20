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
						
						local wep = client:GetWeapon(item.class)
						if (wep) then
							wep:SetWeaponDurability(math.Clamp(wep:GetWeaponDurability()+20,0,100))
							wep:SetWeaponWear(100)
						end
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

						local wep = client:GetWeapon(item.class)
						if (wep) then
							wep:SetWeaponDurability(math.Clamp(wep:GetWeaponDurability()+20,0,100))
							wep:SetWeaponWear(100)
						end

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
		"RepairItem2",
		"Return"
	},
	preCallback = function(self, client, target)
		if(CLIENT)then
			self.response = self.response --Set up random phrases in library so the dialogue doesn't get too stale
		
			local char = client:GetCharacter()
			if (char) then
				local items = char:GetInventory():GetItems()

				ix.dialogue.list["dynamicdlgtest"].tree["RepairItem1"].statement = ""
				ix.dialogue.list["dynamicdlgtest"].tree["RepairItem2"].statement = ""

	      for _, item in pairs( items ) do
		  		if item.weaponCategory == "primary" && item:GetData("equip", false) then
						local str = item.name
						local wep = client:GetWeapon(item.class)
						local cost = 1000 -- ix.util.GetRepairCost()
						if (wep) then
							str = str.." (Wear: "..wep:GetWeaponWear()..")"
						else
							str = str.." (Wear: "..item:GetData("wear",0)..")"
						end
						str = str.." - "..cost.." "..ix.currency.symbol

		  			ix.dialogue.list["dynamicdlgtest"].tree["RepairItem1"].statement = str
		  		end
          if item.weaponCategory == "secondary" && item:GetData("equip", false) then
						local str = item.name
						local wep = client:GetWeapon(item.class)
						local cost = 1000 -- ix.util.GetRepairCost()
						if (wep) then
							str = str.." (Wear: "..wep:GetWeaponWear()..")"
						else
							str = str.." (Wear: "..item:GetData("wear",0)..")"
						end
						str = str.." - "..cost.." "..ix.currency.symbol

		  			ix.dialogue.list["dynamicdlgtest"].tree["RepairItem2"].statement = str
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
	},
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {
			{statement = "Option 1", topicID = "GetTask", dyndata = {option = 1}},
			{statement = "Option 2", topicID = "GetTask", dyndata = {option = 2}},
			{statement = "Option 3", topicID = "GetTask", dyndata = {option = 3}},
			{statement = "Option 4", topicID = "GetTask", dyndata = {option = 4}}
		}
		
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		client:Notify("Selected option number: "..(dyndata.option or "INVALID OPTION"))

		return "Return"
	end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER..."
})