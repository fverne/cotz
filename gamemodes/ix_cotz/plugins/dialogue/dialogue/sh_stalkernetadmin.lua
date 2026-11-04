DIALOGUE.name = "Mute"
DIALOGUE.townContact = "mute"

ix.dialogue.AddTradeTopic(DIALOGUE, "Uhh... You got anything for sale?", "...")

DIALOGUE.addTopic("GREETING", {
	response = (
		"** He notices you, sets a small screwdriver across the open device, and waits with one hand "
		.. "resting over the exposed components. **"
	),
	options = {
		"SpecialtyTopic",
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
	statement = "What are you working on?",
	response = (
		"** He covers the open device with one hand. His eyes move to your PDA, then back to you. After a "
		.. "moment, he takes a loose switch from the bench and presses it. Nothing happens. He presses it "
		.. "again, harder, then looks at you expectantly. **"
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Is that what we look like when the network goes down?",
	response = (
		"** His mouth shifts slightly. He sets the switch aside and retrieves his screwdriver. The hand "
		.. "covering the device remains where it is. **"
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Would you rather I stayed quiet?",
	response = (
		"** He considers you, then moves a stool clear of the trailing leads. A tap on the seat, followed by "
		.. "a finger laid briefly against his lips. **"
	),
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
	response = "** He sets the screwdriver down and looks up. **",
	options = {
		"SpecialtyTopic",
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
	response = "** He lifts two fingers from the bench in acknowledgement, then bends over the device again. **",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can I watch?",
	response = (
		"** He looks from you to the open device. After a pause, he turns it slightly. When his hand moves "
		.. "away, the small components are visible in separate trays. He touches the rim of an empty tray, then "
		.. "rests one finger across it and waits. **"
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "I can leave the tools alone.",
	response = (
		"** He gives a small nod and returns to work. A screw rolls towards the edge; he catches it without "
		.. "looking up. After a moment he slides the tray underneath it, within easy reach, and continues. **"
	),
	options = {"BackTopic"},
})
