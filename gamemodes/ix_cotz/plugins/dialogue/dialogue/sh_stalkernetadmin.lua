DIALOGUE.name = "Mute"
DIALOGUE.townContact = "mute"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Can I see what you're trading?",
	"** He sets the device aside and clears a space for the exchange. **"
)

DIALOGUE.addTopic("GREETING", {
	response = "** He finishes a turn of the screwdriver before looking up. One hand stays beside the open device; the other moves a closed parts box out of the space in front of you. **",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "May I ask what you're working on?",
	response = "** His fingers close over the exposed components. After a pause he picks up a loose switch from another tray and presses it. Nothing happens. He tries once more, more deliberately, then holds it out where you can see it. **",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Is that how we look when we keep checking a broken PDA?",
	response = "** The switch lowers. For a moment he watches you over it; then his mouth shifts at one corner. He puts it away and uncovers his work, keeping the tray close to his side of the bench. **",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Am I disturbing you?",
	response = "** He glances at the doorway, then moves a stool clear of the trailing leads. A tap on the seat, a finger to his lips, and a brief look towards the covered cup. **",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("PDAAvatarTopic", {
	statement = "Can you change my PDA network avatar?",
	response = "** He turns his PDA towards you. The screen shows a fee of 5000RU for a random avatar. His finger rests beside the confirmation button while he waits. **",
	options = {
		"RandomizePDAAvatarTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if not client:GetCharacter():HasMoney(5000) then
			self.response = "** He taps the 5000RU fee, then shakes his head and turns the PDA back towards himself. **"

			return
		end
	end,
	ShouldAdd = function(self, client, target)
		return LocalPlayer():getReputation() >= 1600 -- Experienced
	end,
})

DIALOGUE.addTopic("RandomizePDAAvatarTopic", {
	statement = "I'll pay 5000RU for a random avatar.",
	response = "** He presses the button, checks the display, and gives a small nod. **",
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
			self.response = "** He checks the failed payment, points to the fee, and gives a small shake of his head. **"
		end
	end,
	ShouldAdd = function(self, client, target)
		return LocalPlayer():GetCharacter():HasMoney(5000)
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "** He rests the screwdriver across its tray and waits. **",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
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
	statement = "I'll leave you to it.",
	response = "** He lifts a hand briefly. Before returning to the device, he settles the lid back onto his cup. **",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can I watch you work for a moment?",
	response = "** He looks from you to the device, then turns it slightly. The components sit in separate trays. He draws an empty tray towards the spare stool, places a finger across its rim, and waits until his eyes meet yours. **",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "I'll keep my hands away from the parts.",
	response = "** He nods once and returns to work. A screw rolls towards the edge; he catches it, puts it in the empty tray, and slides the tray back beside himself. The corner of his mouth moves again. **",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Does all the talk about artifact finds distract you?",
	response = "** A voice rises outside. He waits with the screwdriver poised until it subsides, then finishes the turn. Beside the bench stands a cold cup with a small lid over it. He lifts the lid, looks inside, and sets it back down. When he looks up at you again, one eyebrow is raised. **",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Technut leave his experiments here?",
	response = "** He reaches to the far end of the bench and turns a small assembly so its loose lead is visible. After a pause he places a clear cover over the whole thing, then moves his own work a little further away. His mouth shifts at one corner. **",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever get to drink that while it's hot?",
	response = "** He lifts the lid and tips the cup slightly. Nothing steams. His eyes move to you, then to the door as another voice rises outside. He sets the lid down on the bench and takes a drink anyway. **",
	options = {"BackTopic"},
})
