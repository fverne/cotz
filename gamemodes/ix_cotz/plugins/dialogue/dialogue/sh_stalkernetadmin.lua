DIALOGUE.name = "Mute"
DIALOGUE.townContact = "mute"

ix.dialogue.AddTradeTopic(DIALOGUE, "Uhh... You got anything for sale?", "...")

DIALOGUE.addTopic("GREETING", {
	response = (
		" ** The man in front of you seems not even to aknowledge "
		.. "your presence, and stares at some object on the table **"
	),
	options = {
		"TradeTopic",
		"PDAAvatarTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Well... What's that on the table?",
	response = (" ** The man hides the object behind his hands, shielding " .. "it from your view. **"),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Right.",
	response = " ** He looks down a bit.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Eeh, Can you tell me something interesting?",
	response = "...",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("PDAAvatarTopic", {
	statement = "I'd like to change my avatar on the PDA Network.",
	response = (
		" ** Mute fiddles with his own PDA for a bit. He turns it "
		.. "around, and shows you a fee of 5000RU for a random PDA "
		.. "Avatar. He then hover's over a button, looking at you expectantly. "
		.. "** "
	),
	options = {
		"RandomizePDAAvatarTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if not client:GetCharacter():HasMoney(5000) then
			self.response = " ** He shakes his head at your poverty. You need 5000RU. **"

			return
		end
	end,
	ShouldAdd = function(self, client, target)
		return LocalPlayer():getReputation() >= 1600 -- Experienced
	end,
})

DIALOGUE.addTopic("RandomizePDAAvatarTopic", {
	statement = "I agree to 5000RU. Go ahead and do it.",
	response = " ** Presses the button, and nods once.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		local charCreateAvatars = ix.plugin.list["charcreation"].pdaavatars
		local rareAvatars = ix.plugin.list["pda"].pdaavatarsUpgrades
		local rareAvatarChance = 25
		local chosenAvatar

		if math.random(1, 100) <= 2 then
			chosenAvatar = rareAvatars[math.random(#rareAvatars)]
		else
			chosenAvatar = charCreateAvatars[math.random(#charCreateAvatars)]
		end

		if client:GetCharacter():HasMoney(5000) then
			if SERVER then
				client:GetCharacter():TakeMoney(5000)
				ix.dialogue.notifyMoneyLost(client, 5000)
				client:GetCharacter():SetPdaavatar(chosenAvatar)
			end
		else
			self.response = " ** The transaction doesn't go through. You don't have enough money. "
		end
	end,
	ShouldAdd = function(self, client, target)
		return LocalPlayer():GetCharacter():HasMoney(5000)
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "So, anyways...",
	response = "...",
	options = {
		"TradeTopic",
		"PDAAvatarTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = " ** He nods frantically.",
})
