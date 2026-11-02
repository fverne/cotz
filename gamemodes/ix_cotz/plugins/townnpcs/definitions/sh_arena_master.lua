PLUGIN:Register("arena-master", {
	name = "'Arena Master'",
	template = "arenanpc",
	map = "rp_marsh_cs",
	job = {
		kind = "arena",
		category = "Arena bouts",
		description = "Arena bouts",
	},
	supplies = {"drink_bottlewater", "medic_bandage_1", "food_bread", "lowtiercookerfuel"},
	rewards = {
		packages = {
			{label = "Between rounds",
				items = {"medic_bandage_1", "drink_bottlewater"}},
			{label = "Recovery",
				items = {"medic_medkit_1", "drug_painkillers"}},
			{label = "Next bout",
				items = {"9x19", "12gauge"}},
		},
	},
	dialogue = {
		completedGreeting = (
			"Good to see you. Match on your mind, or are you giving yourself a well-earned afternoon "
			.. "off?"
		),
		workPrompt = "About my arena work.",
		offerPrompt = "Do you have arena work?",
		work = (
			"Qualifying sanctioned bouts against distinct eligible human opponents. Repeating the same "
			.. "convenient match won't build the account. Take time between bouts. It's much easier to enjoy a "
			.. "competitor thinking on their feet when they haven't used up all their thought explaining why they "
			.. "don't need a rest."
		),
		progressionPrompt = "What needs doing around the arena?",
		progression = (
			"There's arena work and the quieter business around it: supplies, shipment records, accounts of "
			.. "former contenders. Somebody has to remember the equipment between matches. We'll take the "
			.. "practical work a piece at a time. You can decide how much competition you want without promising "
			.. "me your whole afternoon at the door."
		),
	},
	catalogue = {
	},
	progression = {
		{
			id = "AR01",
			completionCash = 275,
			name = "Before the Bell",
			kind = "delivery",
			requires = {},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 1,
				},
			},
			benefits = {
				items = {
					{
						item = "drink_bottlewater",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "AR02",
			completionCash = 0,
			name = "The Missing Register",
			kind = "arena",
			requires = {"AR01"},
			briefing = (
				"Take a qualifying sanctioned bout here in Marsh against an eligible opponent you haven't faced "
				.. "before. I'd like a proper result before we begin describing your style."
			),
			completion = "First result recorded. You can think about what worked after you've caught your breath.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR03",
			completionCash = 0,
			name = "First Opponents",
			kind = "tracker",
			requires = {"AR02"},
			briefing = (
				"Keep taking qualifying sanctioned bouts against distinct opponents. Repeating the same convenient "
				.. "match won't do."
			),
			completion = (
				"A few different opponents now. You've begun seeing how much the person opposite changes the "
				.. "match."
			),
			target = 2,
			benefits = {},
		},
		{
			id = "AR04",
			completionCash = 0,
			name = "A Fair Match",
			kind = "arena",
			requires = {"AR03"},
			briefing = (
				"Another qualifying sanctioned bout in Marsh, with a new eligible opponent. The arrangement is the "
				.. "same even if you're feeling rather more confident about it."
			),
			completion = "A proper finish. Let the next discussion wait until you've had a rest.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR05",
			completionCash = 575,
			name = "Equipment Inspection",
			kind = "delivery",
			requires = {"AR04"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR06",
			completionCash = 850,
			name = "The Damaged Shipment",
			kind = "field",
			objective = (
				"Recover the arena protective-equipment case from the assigned search area in Marsh. Deliver it to "
				.. "'Suture' in Waystation, then come back to the issuing contact in Marsh."
			),
			requires = {"AR04"},
			briefing = (
				"Suture needs the recovered protective-equipment case. I'd prefer an inspection to another "
				.. "conversation about how it looked fine before the bout. Recover the arena protective-equipment "
				.. "case from the assigned search area in Marsh. Deliver it to 'Suture' in Waystation, then come back "
				.. "to me in Marsh."
			),
			completion = "Delivered. Good. I'll let Suture have the first opinion before the contenders offer theirs.",
			field = {
				description = (
					"A long reinforced equipment case with recessed handles and substantial end fittings. Arena "
					.. "Master's note: \"Suture needs the recovered protective-equipment case.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 1,
				cargo = "town_quest_armour",
				label = "Arena protective-equipment case",
				recipient = "suture",
			},
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
			stock = {
				item = "drink_bottlewater",
				bonus = 1,
			},
		},
		{
			id = "AR07",
			completionCash = 0,
			name = "Not the Same Face",
			kind = "tracker",
			requires = {"AR05"},
			briefing = "Continue the qualifying arena work. Give yourself a breather between bouts.",
			completion = (
				"Another useful spread of opponents. I hope you're giving the spectators less advice than they're "
				.. "giving you."
			),
			target = 5,
			benefits = {},
		},
		{
			id = "AR08",
			completionCash = 0,
			name = "The Referee's Record",
			kind = "arena",
			requires = {"AR06"},
			briefing = (
				"Take another qualifying Marsh bout against an eligible opponent you haven't faced. I'd like the "
				.. "result settled in the arena rather than in the audience's account."
			),
			completion = (
				"Result recorded. The spectators can begin explaining it now; you don't have to attend every "
				.. "conversation."
			),
			target = 1,
			benefits = {},
		},
		{
			id = "AR09",
			completionCash = 875,
			name = "Patch the Kit",
			kind = "delivery",
			requires = {"AR07"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR10",
			completionCash = 1250,
			name = "Restocking",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 2 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"AR08"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR11",
			completionCash = 0,
			name = "A Broader Field",
			kind = "tracker",
			requires = {"AR09"},
			briefing = "More qualifying bouts when you're ready. Keep the distinct-opponent requirement in mind.",
			completion = "You've had to adapt a fair amount now. That's becoming worth watching.",
			target = 9,
			benefits = {},
		},
		{
			id = "AR12",
			completionCash = 0,
			name = "An Honest Result",
			kind = "arena",
			requires = {"AR10"},
			briefing = (
				"There's another qualifying sanctioned bout to complete in Marsh against a new eligible opponent. "
				.. "Prepare for the match in front of you, not the one that went well last time."
			),
			completion = "A finished result. I hope you had time to notice how you adapted, not just how it ended.",
			target = 1,
			benefits = {
				items = {
					{
						item = "lowtiercookerfuel",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "AR13",
			completionCash = 1175,
			name = "No Empty Cabinets",
			kind = "delivery",
			requires = {"AR11"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR14",
			completionCash = 1650,
			name = "A Fighter's Effects",
			kind = "field",
			objective = (
				"Recover the former contender's records from the assigned search area in Marsh. Bring it back to "
				.. "the issuing contact in Marsh."
			),
			requires = {"AR12"},
			briefing = (
				"I'd like the former contender's records brought back together. A person's place in the arena "
				.. "shouldn't depend entirely on who still tells their story. Recover the former contender's records "
				.. "from the assigned search area in Marsh. Bring it back to me in Marsh."
			),
			completion = (
				"Leave the file here. I'll read the account before deciding which parts belong in the arena "
				.. "records."
			),
			field = {
				description = (
					"A cardboard file folder with an emblem and printed wording on the front. Arena Master's note: "
					.. "\"I'd like the former contender's records brought back together.\""
				),
				kind = "recovery",
				map = "rp_marsh_cs",
				tier = 2,
				cargo = "town_quest_personnel",
				label = "Former contender's records",
			},
			benefits = {},
		},
		{
			id = "AR15",
			completionCash = 0,
			name = "Veteran Company",
			kind = "tracker",
			requires = {"AR13"},
			briefing = "Continue the sanctioned bouts against eligible distinct opponents.",
			completion = "A proper stretch of competition. Take the recognition before planning how to defend it.",
			target = 14,
			benefits = {},
		},
		{
			id = "AR16",
			completionCash = 0,
			name = "The Missing Result",
			kind = "arena",
			requires = {"AR14"},
			briefing = (
				"Complete another qualifying Marsh bout against an eligible opponent you haven't faced. We still "
				.. "need the match properly finished before the account moves on."
			),
			completion = "That settles the result. Take some time before answering anybody who wants an immediate repeat.",
			target = 1,
			benefits = {},
		},
		{
			id = "AR17",
			completionCash = 1475,
			name = "Ready for the Final",
			kind = "delivery",
			requires = {"AR15"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR18",
			completionCash = 0,
			name = "A Place in the Record",
			kind = "arena",
			requires = {"AR16"},
			briefing = (
				"Another sanctioned bout here in Marsh, with an eligible opponent new to your account. Reputation "
				.. "doesn't replace the qualifying result."
			),
			completion = (
				"You've given that result a place in the record. You can put the performance down for a moment "
				.. "now."
			),
			target = 1,
			benefits = {
				items = {
					{
						item = "medic_bandage_1",
						data = {
							quantity = 1,
						},
					},
				},
			},
		},
		{
			id = "AR19",
			completionCash = 0,
			name = "Championship Form",
			kind = "tracker",
			requires = {"AR17", "AR18"},
			briefing = "There are more qualifying bouts to complete. Prepare rather than hurrying straight back in.",
			completion = "You've earned your reputation over more than an afternoon. I appreciate the patience behind that.",
			target = 20,
			benefits = {},
		},
		{
			id = "AR20",
			completionCash = 0,
			name = "The Championship Bout",
			kind = "arena",
			requires = {"AR19"},
			briefing = (
				"The championship step needs a qualifying sanctioned bout here in Marsh against a new eligible "
				.. "opponent. Don't let the title persuade you to skip the preparation."
			),
			completion = (
				"Championship result recorded. Enjoy being finished before you begin worrying about the next "
				.. "contender."
			),
			target = 1,
			benefits = {},
			stock = {
				item = "drink_bottlewater",
				bonus = 2,
			},
		},
		{
			id = "AR21",
			completionCash = 1775,
			name = "The Next Season",
			kind = "delivery",
			requires = {"AR20"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
		},
		{
			id = "AR22",
			completionCash = 2450,
			name = "A full supply order",
			kind = "delivery",
			retiredCommission = true,
			objective = (
				"Bring all 4 listed item types to this contact. The request shows each selected item and required "
				.. "units."
			),
			requires = {"AR21"},
			briefing = (
				"Between matches I need to keep the equipment and recovery supplies in order. Bring everything on "
				.. "the list back here; I need the full delivery."
			),
			completion = "Good. That gives me one less thing to chase before the next match.",
			requirements = {
				{
					pool = "town_delivery_medical_marsh_1",
					quantity = 4,
				},
				{
					pool = "town_delivery_medical_marsh_2",
					quantity = 3,
				},
				{
					pool = "town_delivery_medical_marsh_3",
					quantity = 2,
				},
				{
					pool = "town_delivery_medical_marsh_4",
					quantity = 1,
				},
			},
			benefits = {},
			recognition = "Arena Master's trusted contact",
		},
	},
})
