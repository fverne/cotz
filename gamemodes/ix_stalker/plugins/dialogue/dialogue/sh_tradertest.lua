DIALOGUE.name = "Trader Test"

DIALOGUE.addTopic("GREETING", {
	response = "Hmm?",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"RepairItems",
		"QuestTopic",
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
		"BackTopic",
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
		"BackTopic"
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

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something useful?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Helix is a good framework, but please learn a bit of lua before you try to make your own gamemode, and start with simple things. We can't code for you."
		end
	end,
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("QuestTopic", {
	statement = "Got a job for me?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Hmpf, about time you showed up. There are many mutants who keep attacking my couriers coming from the cordon, and I'm losing more supplies than ever. I want you to find three dead couriers in Cordon and bring me all of their belongings. You can keep their equipment, as your reward."
		end
	end,
	options = {
		"QuestAccept",
		"BackTopic"
	}
})

DIALOGUE.addTopic("QuestAccept", {
	statement = "I'll take it.",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Alright, I expect you to be back soon."
		end
	end,
	options = {
		"BackTopic"
	}
})


DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "All right.",
	options = {
		"TradeTopic",
		"InterestTopic",
		"QuestTopic",
		"RepairItems",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Come back soon, STALKER..."
})