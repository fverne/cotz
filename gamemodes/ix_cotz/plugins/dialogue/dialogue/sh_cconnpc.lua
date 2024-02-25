DIALOGUE.name = "CCON NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgessionValue(progressionIdentifier, amountToIncrement, client:Name())
-- and
--  			ix.progression.GetProgressionValue(progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "What is your wish?",
	options = {
		-- "TradeTopic", 
		"InterestTopic",
		-- "RepairItems",
		-- "AboutWorkTopic",
		-- "GetTaskByDifficulty",
		"GOODBYE"
	},
	preCallback = function(self, client, target)


	end
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		-- "TradeTopic", 
		"InterestTopic",
		-- "RepairItems",
		-- "AboutWorkTopic",
		-- "GetTaskByDifficulty",
		"GOODBYE"
	} --Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER..."
})

----------------------------------------------------------------
---------------------START-INTEREST-START-----------------------
----------------------------------------------------------------

DIALOGUE.addTopic("InterestTopic", {
    statement = "Can you tell me something interesting?",
    response = "",
    options = {
    	"InterestMoreTopic",
        "BackTopic"
    },
    preCallback = function(self, client, target)
        if (CLIENT) then
            local tbl = {	"The Zone is a dangerous place. Anomalies are everywhere, and all the mutants here are out to get you, I swear.",
							"Did you know people stash their stuff everywhere? If you have a keen eye, you can find some interesting things.",
							"We STALKERS, as we call ourselves, are incredibly creative. I don't think any other place in the world has our level of craftiness and ability to survive even the harshest conditions. Who would have thought of using cutlery as makeshift digging tools, for instance?",
							"I've heard rumours of creatures out there, who can mess you up. Not in the sense that they gnaw and tear you apart, but that they send even the strongest willed men into the deepest hole - if they can make it away. I'm not going out there...",
							"The mutants in here are, to nobodys surprise, very irradiated. If you ever do plan to eat them, I suggest cooking them first, as it takes away a lot of their radiation.",
							"I'm still having trouble believing this place is not more well known, but I assume it's because everyone in the surrounding areas are being told not to say a word, and the military are not too keen on rulebreakers around here.",
							"If you ever encounter something that shakes you up, I suggest smoking a couple of cigarettes. They calm the mind, and help you think clearer."}

            self.response = table.Random(tbl)
        end
    end,
} )

DIALOGUE.addTopic("InterestMoreTopic", {
    statement = "Very nice, more?",
    response = "",
    options = {
    	"InterestMoreTopic",
        "BackTopic"
    },
    preCallback = function(self, client, target)
        if (CLIENT) then
          	local tbl = {	"The Zone is a dangerous place. Anomalies are everywhere, and all the mutants here are out to get you, I swear.",
							"Did you know people stash their stuff everywhere? If you have a keen eye, you can find some interesting things.",
							"We STALKERS, as we call ourselves, are incredibly creative. I don't think any other place in the world has our level of craftiness and ability to survive even the harshest conditions. Who would have thought of using cutlery as makeshift digging tools, for instance?",
							"I've heard rumours of creatures out there, who can mess you up. Not in the sense that they gnaw and tear you apart, but that they send even the strongest willed men into the deepest hole - if they can make it away. I'm not going out there...",
							"The mutants in here are, to nobodys surprise, very irradiated. If you ever do plan to eat them, I suggest cooking them first, as it takes away a lot of their radiation.",
							"I'm still having trouble believing this place is not more well known, but I assume it's because everyone in the surrounding areas are being told not to say a word, and the military are not too keen on rulebreakers around here.",
							"If you ever encounter something that shakes you up, I suggest smoking a couple of cigarettes. They calm the mind, and help you think clearer."}

            self.response = table.Random(tbl)
        end
    end,
} )

----------------------------------------------------------------
-----------------------END-INTEREST-END-------------------------
----------------------------------------------------------------