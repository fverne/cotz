ix.weapontables = {}

ix.weapontables.ammotypes = {}

ix.weapontables.ammotypes["7.62x25MM"] = {uID = "762x25"}
ix.weapontables.ammotypes["7.62x39MM"] = {uID = "762x39"}
ix.weapontables.ammotypes["7.62x51MM"] = {uID = "762x51"}
ix.weapontables.ammotypes["7.62x54MMR"] = {uID = "762x54"}
ix.weapontables.ammotypes["7.62x54MM"] = {uID = "762x54"}
ix.weapontables.ammotypes["5.45x39MM"] = {uID = "545x39"}
ix.weapontables.ammotypes["5.56x45MM"] = {uID = "556x45"}
ix.weapontables.ammotypes["5.7x28MM"] = {uID = "57x28"}
ix.weapontables.ammotypes["14.5x114MM"] = {uID = "145x114"}
ix.weapontables.ammotypes[".22LR"] = {uID = "22lr"}
ix.weapontables.ammotypes[".338 Lapua"] = {uID = "338lapua"}
ix.weapontables.ammotypes[".357 Magnum"] = {uID = "357magnum"}
ix.weapontables.ammotypes[".44 Magnum"] = {uID = "44magnum"}
ix.weapontables.ammotypes[".500 Magnum"] = {uID = "500magnum"}
ix.weapontables.ammotypes[".45 ACP"] = {uID = "45acp"}
ix.weapontables.ammotypes[".50 AE"] = {uID = "50ae"}
ix.weapontables.ammotypes["9x18MM"] = {uID = "9x18"}
ix.weapontables.ammotypes["9x19MM"] = {uID = "9x19"}
ix.weapontables.ammotypes["9x21MM"] = {uID = "9x21"}
ix.weapontables.ammotypes["9x39MM"] = {uID = "9x39"}
ix.weapontables.ammotypes["12 Gauge"] = {uID = "12gauge"}

ix.weapontables.attachments = {}

ix.weapontables.attachments["md_microt1"] = {name = "Aimpoint Micro T1", slot = 1, uID = "microt1"}
ix.weapontables.attachments["md_nightforce_nxs"] = {name = "Nightforce NXS", slot = 1, uID = "nightforce"}
ix.weapontables.attachments["md_rmr"] = {name = "Trijicon RMR", slot = 1, uID = "trijiconrmr"}
ix.weapontables.attachments["md_schmidt_shortdot"] = {name = "Schmidt Shortdot", slot = 1, uID = "shortdot"}
ix.weapontables.attachments["md_pso1"] = {name = "PSO-1", slot = 1, uID = "pso1"}
ix.weapontables.attachments["md_psothermal"] = {name = "PSO-T", slot = 1, uID = "psothermal"}
ix.weapontables.attachments["md_aimpoint"] = {name = "Aimpoint CompM4", slot = 1, uID = "aimpoint"}
ix.weapontables.attachments["md_cmore"] = {name = "CMore Railway", slot = 1, uID = "cmore"}
ix.weapontables.attachments["md_eotech"] = {name = "Eotech Holographic Sight", slot = 1, uID = "eotech"}
ix.weapontables.attachments["md_reflex"] = {name = "King Arms MR", slot = 1, uID = "kingarmsmr"}
ix.weapontables.attachments["md_kobra"] = {name = "Kobra Sight", slot = 1, uID = "kobra"}
ix.weapontables.attachments["md_acog"] = {name = "Trijicon ACOG Sight", slot = 1, uID = "acog"}
ix.weapontables.attachments["md_pbs1"] = {name = "PBS Supressor", slot = 2, uID = "pbssuppressor"}
ix.weapontables.attachments["md_cobram2"] = {name = "Cobra M2 Suppressor", slot = 2, uID = "cobrasuppressor"}
ix.weapontables.attachments["md_tundra9mm"] = {name = "Tundra Supressor", slot = 2, uID = "tundrasuppressor"}
ix.weapontables.attachments["md_saker"] = {name = "SAKER Supressor", slot = 2, uID = "sakersuppressor"}
ix.weapontables.attachments["md_foregrip"] = {name = "Foregrip", slot = 3, uID = "foregrip"}

ix.weapontables.ammosubtypes = {}

ix.weapontables.ammosubtypes["SG"] = {uID = "am_slugrounds"}
ix.weapontables.ammosubtypes["TR"] = {uID = "am_trishot"}
ix.weapontables.ammosubtypes["AP"] = {uID = "am_armorpiercing"}
ix.weapontables.ammosubtypes["HP"] = {uID = "am_hollowpoint"}
ix.weapontables.ammosubtypes["41"] = {uID = "am_410buck"}

ix.armortables = {}
ix.armortables.attachments = {} -- Artifacts, kevlar plates, mutant hides etc.




-- ATTACHMENTS --
-- EXAMPLE:
--ix.armortables.attachments["steelplate_1"] = {
--	name = "Well Worn Steel Plate",
--	br = 0.05,
--	ar = -0.10,
--	weight = 0.950,
--	uID = "attachment_steelplate_1",
--	onAttach = function(player) print("Ran onAttach with playername: ", player:GetName()) end,
--	onDetach = function(player) print("Ran onDetach with playername: ", player:GetName()) end,
--	onThink  = function(player) print("Ran onThink with playername: ", player:GetName()) end,
--}

ix.armortables.attachments["steelplate_1"] = {
	name = "Well Worn Steel Plate",
	br = 0.05,
	ar = -0.10,
	weight = 0.950,
	uID = "attachment_steelplate_1",
}

ix.armortables.attachments["steelplate_2"] = {
	name = "Steel Plate",
	br = 0.09,
	ar = -0.10,
	weight = 1.150,
	uID = "attachment_steelplate_2",
}

ix.armortables.attachments["steelplate_3"] = {
	name = "Galvanized Steel Plate",
	br = 0.13,
	ar = -0.10,
	weight = 1.550,
	uID = "attachment_steelplate_3",
}

ix.armortables.attachments["steelplate_4"] = {
	name = "Anomalous Steel Plate",
	br = 0.17,
	ar = -0.10,
	weight = 1.950,
	uID = "attachment_steelplate_4",
}

ix.armortables.attachments["kevlar_1"] = {
	name = "Kevlar K119 Plates",
	br = 0.02,
	ar = 0.05,
	weight = 0.550,
	uID = "attachment_kevlar_1",
}

ix.armortables.attachments["kevlar_2"] = {
	name = "Kevlar K29 Plates",
	br = 0.07,
	ar = 0.10,
	weight = 0.650,
	uID = "attachment_kevlar_2",
}

ix.armortables.attachments["carbonfibre"] = {
	name = "Carbon Fibre Layers",
	br = 0.01,
	ar = 0.15,
	weight = 0.200,
	uID = "attachment_carbonfibre",
}

ix.armortables.attachments["ceramicplate_1"] = {
	name = "Old Ceramic Plate",
	br = 0.03,
	weight = 1.400,
	uID = "attachment_ceramicplate_1",
}

ix.armortables.attachments["ceramicplate_2"] = {
	name = "Ceramic Plate",
	br = 0.06,
	weight = 1.250,
	uID = "attachment_ceramicplate_2",
}

ix.armortables.attachments["ceramicplate_3"] = {
	name = "Modern Ceramic Plate",
	br = 0.09,
	weight = 1.650,
	uID = "attachment_ceramicplate_3",
}

ix.armortables.attachments["ceramicplate_4"] = {
	name = "Glowing Ceramic Plate",
	br = 0.13,
	weight = 2.650,
	uID = "attachment_ceramicplate_4",
}

ix.armortables.attachments["steelframe"] = {
	name = "Steel Frame",
	weight = 2.500,
	ar = -0.20,
	uID = "attachment_steelframe",
	onAttach = function(player)
		local armor = player:getEquippedBodyArmor()
		if armor then
			armor:SetData("carryinc", armor:GetData("carryinc", 0) + 25)
		end
	end,
	onDetach = function(player)
		local armor = player:getEquippedBodyArmor()
		if armor then
			armor:SetData("carryinc", armor:GetData("carryinc", 0) - 25)
		end
	end,
}

ix.armortables.attachments["aluframe"] = {
	name = "Steel Frame",
	weight = 0.800,
	ar = -0.15,
	uID = "attachment_aluframe",
	onAttach = function(player)
		local armor = player:getEquippedBodyArmor()
		if armor then
			armor:SetData("carryinc", armor:GetData("carryinc", 0) + 15)
		end
	end,
	onDetach = function(player)
		local armor = player:getEquippedBodyArmor()
		if armor then
			armor:SetData("carryinc", armor:GetData("carryinc", 0) - 15)
		end
	end,
}

ix.armortables.attachments["fabric_1"] = {
	name = "Insulating Fabrics",
	ar = 0.10,
	weight = 1.200,
	uID = "attachment_fabric_1",
}

ix.armortables.attachments["fabric_2"] = {
	name = "Thick Insulating Fabrics",
	br = 0.02,
	ar = 0.20,
	weight = 3.400,
	uID = "attachment_fabric_2",
}

-- HIDES --
ix.armortables.attachments["hide_blinddog"] = {
	name = "Blind Dog Hide",
	br = 0.01,
	ar = 0.07,
	weight = 1.100,
	uID = "hide_blinddog",
}

ix.armortables.attachments["hide_tushkano"] = {
	name = "Tushkano Hide",
	br = 0.02,
	ar = 0.04,
	weight = 0.700,
	uID = "hide_tushkano",
}

ix.armortables.attachments["hide_pseudodog"] = {
	name = "Pseudodog Hide",
	br = 0.06,
	ar = 0.11,
	weight = 1.650,
	uID = "hide_pseudodog",
}

ix.armortables.attachments["hide_bloodsucker"] = {
	name = "Bloodsucker Hide",
	br = 0.11,
	ar = 0.03,
	weight = 1.800,
	uID = "hide_bloodsucker",
}

ix.armortables.attachments["hide_boar"] = {
	name = "Boar Hide",
	br = 0.08,
	ar = 0.02,
	weight = 2.500,
	uID = "hide_boar",
}

ix.armortables.attachments["hide_burer"] = {
	name = "Burer Scalp",
	br = 0.10,
	weight = 3.000,
	uID = "hide_burer",
	onAttach = function(player) --[[add 15psyprot]] end,
	onDetach = function(player) --[[remove 15psyprot]] end,
}

ix.armortables.attachments["hide_cat"] = {
	name = "Cat Hide",
	br = 0.08,
	ar = 0.09,
	weight = 1.250,
	uID = "hide_cat",
}

ix.armortables.attachments["hide_chimera"] = {
	name = "Chimera Hide",
	br = 0.15,
	ar = 0.12,
	weight = 2.150,
	uID = "hide_chimera",
}

ix.armortables.attachments["hide_sprig"] = {
	name = "Sprig Leg",
	weight = 0.500,
	uID = "hide_sprig",
}

ix.armortables.attachments["hide_flesh"] = {
	name = "Flesh Hide",
	br = 0.07,
	ar = 0.01,
	weight = 1.800,
	uID = "hide_flesh",
}

ix.armortables.attachments["hide_controller"] = {
	name = "Controller Scalp",
	br = 0.12,
	weight = 3.500,
	uID = "hide_controller",
	onAttach = function(player) --[[add 35psyprot]] end,
	onDetach = function(player) --[[remove 35psyprot]] end,
}

ix.armortables.attachments["hide_swampcontroller"] = {
	name = "Swampcontroller Scalp",
	br = 0.05,
	weight = 3.000,
	uID = "hide_swampcontroller",
	onAttach = function(player) --[[add 10psyprot]] end,
	onDetach = function(player) --[[remove 10psyprot]] end,
}

ix.armortables.attachments["hide_pseudogiant"] = {
	name = "Pseudogiant Hide",
	br = 0.30,
	ar = 0.30,
	weight = 5.550,
	uID = "hide_pseudogiant",
}


-- ARMOR UPGRADES --
ix.armortables.upgrades = {}
ix.armortables.upgrades["integratedceramics"] = {
	name = "Integrated Ceramic Plates",
	description = "Better bullet resistance at the cost of anomaly resistance",
	br = 0.03,
	ar = -0.03,
	weight = 0.500,
}
ix.armortables.upgrades["lightercomponents"] = {
	name = "Lighter Components",
	description = "Lighter, but less effective internals",
	br = -0.02,
	ar = -0.02,
	weight = -1.500,
}
