DIALOGUE.name = "CCON NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgessionValue(progressionIdentifier, amountToIncrement, client:Name())
-- and
--  			ix.progression.GetProgressionValue(progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "What do you want?",
	options = {
		"InterestTopic",
		"WishTopic",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		local char = client:GetCharacter()
		if (SERVER) then
			local wishes = char:GetData("wishes", nil)
			if wishes == nil then
				char:SetData("wishes", {})
			end
		end
	end
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		-- "TradeTopic", 
		"InterestTopic",
		"WishTopic",
		"GOODBYE"
	} --Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll be back.",
	response = "Take care."
})

----------------------------------------------------------------
---------------------START-INTEREST-START-----------------------
----------------------------------------------------------------

DIALOGUE.addTopic("InterestTopic", {
    statement = "Who are you?",
    response = "Some call me the wishgranter.",
    options = {
        "BackTopic"
    },
    preCallback = function(self, client, target)
        if (CLIENT) then
            self.response = "..."
        end
    end,
} )

----------------------------------------------------------------
-----------------------END-INTEREST-END-------------------------
----------------------------------------------------------------


----------------------------------------------------------------
-----------------------START-WISH-START-------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("WishTopic", {
	statement = "I want to make a wish.",
	response = "What is your wish?",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		local items = client:GetCharacter():GetInventory():GetItems()
		local wishes = client:GetCharacter():GetData("wishes", {})
		local basecost = 1000000
		local finalcost = 0
		
		if !table.IsEmpty(wishes) then
			finalcost = math.Clamp(table.Count(wishes) * basecost, 0, 4000000)
		end

        table.insert(dynopts, {statement = "I wish to carry more of the riches of the zone.", topicID = "WishTopic", dyndata = {cost = finalcost, type="carryinc"}})
		table.insert(dynopts, {statement = "I wish for anomalous skin.", topicID = "WishTopic", dyndata = {cost = finalcost, type="far"}})
        table.insert(dynopts, {statement = "I wish for kevlar in my skin.", topicID = "WishTopic", dyndata = {cost = finalcost, type="fbsr"}})
        table.insert(dynopts, {statement = "I wish for my health to improve.", topicID = "WishTopic", dyndata = {cost = finalcost, type="hp"}})

		local items = client:GetCharacter():GetInventory():GetItems()
		for k,v in pairs(items) do
			if v.canRepair and v.isWeapon then
				table.insert(dynopts, {statement = "I wish for my "..v:GetName().." to never deteriorate.", topicID = "WishTopic", dyndata = {cost = finalcost, type="weapon", itemid = v:GetID()}})
			end
			if v.canRepair and v.isBodyArmor then
				table.insert(dynopts, {statement = "I wish for my "..v:GetName().." never to deteriorate.", topicID = "WishTopic", dyndata = {cost = finalcost, type="suit", itemid = v:GetID()}})
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if (client:GetCharacter():GetData("wishes", {})[dyndata.type]) then
			return "HasWish"
		end

		-- Return the next topicID
		if( !client:GetCharacter():HasMoney(dyndata.cost)) then
			return "NotEnoughMoneyWish"
		end

		return "ConfirmWish", dyndata
	end,
})


DIALOGUE.addTopic("ConfirmWish", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("Blessing you with your wish will cost you %s.", ix.currency.Get(dyndata.cost))
			else
				target.wishstruct = { dyndata.cost, dyndata.type, dyndata.itemid }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)

		local dynopts = {
			{statement = "Go ahead, bless me.", topicID = "ConfirmWish", dyndata = {accepted = true}},
			{statement = "Actually, wait.", topicID = "ConfirmWish", dyndata = {accepted = false}},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted ) then
			ix.dialogue.notifyMoneyLost(client, target.wishstruct[1])
			client:GetCharacter():TakeMoney(target.wishstruct[1])
			local wishes = client:GetCharacter():GetData("wishes", {})

			if table.IsEmpty(wishes) then
				client:GetCharacter():SetData("wishes", {})
			end


            if target.wishstruct[2] == "carryinc" then
                -- increase char carryinc by 15
				wishes["carryinc"] = true
				-- this auto updates thanks to the weight plugin
            elseif target.wishstruct[2] == "far" then
				-- increase far by +5
				wishes["far"] = true
				client:RecalculateResistances()
			elseif target.wishstruct[2] == "fbsr" then
                -- increase fbr and fsr by +2
				wishes["fbsr"] = true
				client:RecalculateResistances()
            elseif target.wishstruct[2] == "hp" then
				-- increase maxhp to 125
				wishes["hp"] = true
				client:SetMaxHealth(125)
			elseif target.wishstruct[2] == "weapon" and target.wishstruct[3] then
				-- set weapon durability and wear to never decrease
				local item = ix.item.instances[target.wishstruct[3]]
				item:SetData("unlimitedDurability", true)
			elseif target.wishstruct[2] == "suit" and target.wishstruct[3] then
				-- set suit durability and wear to never decrease    
				local item = ix.item.instances[target.wishstruct[3]] 
				item:SetData("unlimitedDurability", true)
				-- wishes["suit"] = true
			end

			client:GetCharacter():SetData("wishes", wishes)
		end
		if(SERVER)then
			target.wishstruct = nil
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})


DIALOGUE.addTopic("NotEnoughMoneyWish", {
	statement = "",
	response = "You do not possess the currency for me to bless you with my wish.",
	options = {
		"BackTopic"
	}
})


DIALOGUE.addTopic("HasWish", {
	statement = "",
	response = "You have already wished for that.",
	options = {
		"BackTopic"
	}
})
----------------------------------------------------------------
-----------------------END-WISH-END-------------------------
----------------------------------------------------------------