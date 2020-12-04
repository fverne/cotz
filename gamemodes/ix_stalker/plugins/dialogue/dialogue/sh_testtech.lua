DIALOGUE.name = "Universal Union"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome to the zone!",
	options = {
		"Topic01", 
		"Topic02",
		"Topic03",
		"TradeTopic",
		"RepairItems",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic01", {
	statement = "Who are you?",
	response = "I'm the tech here.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic02", {
	statement = "Can I get something for free?",
	response = "No.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic03", {
	statement = "Why is Helix such a nice framework?",
	response = "It's pretty neat, yeah.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Return", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"Topic01",
		"Topic02",
		"Topic03",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Yes",
	postCallback = function(self, client, target)
		if (SERVER) then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(target.items) do
				if (!table.IsEmpty(v) and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])) then
					items[k] = v
				end
			end

			target.scale = target.scale or 0.5

			client.ixVendorAdv = target

			-- force sync to prevent outdated inventories while buying/selling
			if (character) then
				character:GetInventory():Sync(client, true)
			end

			net.Start("ixVendorAdvOpen")
				net.WriteEntity(target)
				net.WriteUInt(target.money or 0, 16)
				net.WriteTable(items)
				net.WriteFloat(target.scale or 0.5)
			net.Send(client)

			ix.log.Add(client, "vendorUse", target:GetDisplayName())
		end
	end,
	options = {
		"Return",
		"GOODBYE"
	}
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

DIALOGUE.addTopic("GOODBYE", {
	statement = "Goodbye.",
	response = "Adios, negr..."
})