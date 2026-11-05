DIALOGUE.name = "Suture"
DIALOGUE.townContact = "suture"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what gear and materials you're trading.",
	"Certainly. Put it where we can look at it without catching the straps under everything else."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. You can put the pack down; I won't make you stand to attention while we talk. What do you need?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"BackgroundTopic",
		"AdviceTopic",
		"ContactsTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "How did you come to work on field equipment?",
	response = "Mended what people brought. Started wishing I'd seen some of it before the expedition, while there was still enough left to show what had gone wrong. You learn from how someone wears a thing. They raise a shoulder, pull a cuff down, then tell you it fits beautifully. I like the moment we stop performing for one another and discuss the actual annoyance. Often a very small one, carried an unnecessarily long way.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("AdviceTopic", {
	statement = "What should I check before a long expedition?",
	response = "Pack for it, put the load on, and move as you normally would. People try equipment while standing in a position they won't hold past the first bank. Notice what you keep adjusting. You may be perfectly willing to put up with it; at least make that a decision. A strap doesn't become more comfortable because you've found a sufficiently important artifact to distract yourself from it.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("ContactsTopic", {
	statement = "Who understands what you need for this work?",
	response = "Quartermaster gives a specification I can actually consider. Sometimes takes a moment to apply the same attention to his own discomfort. Latch will keep an interesting piece of material intact once he knows what I'm looking for. Arena Master's people offer wonderful explanations of damage. I'd prefer the part about the fall before the part about how well they fought. We can all admire the contest after I've seen the seam.",
	options = {"BackTopic", "GOODBYE"},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Yes? Stand comfortably. I can still hear you.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"BackgroundTopic",
		"AdviceTopic",
		"ContactsTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll leave you to your work.",
	response = "Good journey. No need to spend the whole walk pretending the thing that rubs doesn't bother you.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Is there room for appearance in practical gear?",
	response = "Of course. Tell me you like a colour. Saves us both listening to a technical justification you don't believe. People here spend enough time choosing things because they must. You can care how a coat looks or want an old patch left alone. I still want to know whether you can move comfortably. Those are questions we can discuss together without making you defend the preference.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Does it bother you when someone brings back damaged work?",
	response = "I'd like them to tell me how it failed. A seam torn during a fall gives me something to consider. A vague account designed to make the owner look sensible gives me questions before I can begin. I don't expect expedition gear to spend its life on a chair. I can respect somebody for using a thing hard and still object to them making the account harder to follow.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Can you tell where a stalker has been from their clothes?",
	response = "Usually I can tell they've sat down in something and hoped it would dry before I noticed. People want a remarkable deduction: anomaly field, mutant chase, desperate escape. Sometimes a torn pocket means they caught it on a nail while reaching for a spoon. I'll ask. They can keep the grand account for supper. I'm more interested in why they're still pulling the cuff over their hand after assuring me it doesn't bother them.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Is Quartermaster as particular about his own gear?",
	response = "About its contents, certainly. About the small annoyance he's become accustomed to, less so. Very definite opinions until you ask him to stand as he usually stands. Then he knows what you've noticed and wishes you'd confined yourself to the requisition. I don't mind. He listens once the irritation has passed. Rather satisfying to hear a precise description of a problem instead of 'something feels wrong'.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "What if someone wants to keep an old patch?",
	response = "Then I leave the patch out of my opinions unless it's causing the trouble. Plenty of practical decisions to discuss without asking a stranger to justify being fond of a scrap of cloth. If they want to tell me, they will. They can stop pulling at it while we talk, though.",
	options = {"BackTopic"},
})
