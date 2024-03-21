---
-- Artifact jobs - Could technically be under item jobs, but just to avoid having that file grow to 3k+ lines
--                 These are split into two, one for egghead and one for the computer
--                 Egghead gives items, money and rep, whereas the computer only gives money and rep
---

------------------------------------------------
----------- ITEM RETRIEVAL - ARTIFACT ----------
-----------           EGGHEAD         ----------
------------------------------------------------

local tempJob = {}

tempJob.name = "Hand over 1 Arachno."
tempJob.desc = "1 Arachno."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_arachno"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {10000, 13000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_arachno")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Batteries."
tempJob.desc = "2 Batteries."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_battery"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 30
tempJob.moneyReward = {16500, 18400}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_battery")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Blown Capacitor."
tempJob.desc = "1 Blown Capacitor."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_blowncap"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.moneyReward = {7000, 9500}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_blowncap")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Anomalous Bolt."
tempJob.desc = "1 Anomalous Bolt."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_bolt"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.moneyReward = {800, 900}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_bolt")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Anomalous Bolts."
tempJob.desc = "2 Anomalous Bolts."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_bolt"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 25
tempJob.moneyReward = {1900, 2100}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_bolt")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 5 Anomalous Bolts."
tempJob.desc = "5 Anomalous Bolts."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_bolt"
tempJob.numberRec = 5
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 40
tempJob.moneyReward = {5000, 6000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob3eco_artifact_bolt")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Bone Cluster."
tempJob.desc = "1 Bone Cluster."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_bonecluster"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.moneyReward = {2000, 4500}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_bonecluster")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Bone Clusters."
tempJob.desc = "2 Bone Clusters."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_bonecluster"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 25
tempJob.moneyReward = {5000, 8000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_bonecluster")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Capacitor."
tempJob.desc = "1 Capacitor."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_capacitor"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.moneyReward = {17000, 22000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_capacitor")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Cell."
tempJob.desc = "1 Cell."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_cell"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {6200, 8600}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_cell")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Crystal."
tempJob.desc = "1 Crystal."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_crystal"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {10000, 13000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_crystal")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Droplet."
tempJob.desc = "1 Droplet."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_droplet"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {2500, 3800}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_droplet")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Dwarf Galaxy."
tempJob.desc = "1 Dwarf Galaxy."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_dwarfgalaxy"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {2000, 4000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_dwarfgalaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Dwarf Galaxy."
tempJob.desc = "1 Dwarf Galaxy."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_dwarfgalaxy"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {10000, 16000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_dwarfgalaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Eye."
tempJob.desc = "1 Eye."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_eye"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {15000, 19000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_eye")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Flame."
tempJob.desc = "1 Flame."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_flame"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {24000, 29000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_flame")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Flash."
tempJob.desc = "1 Flash."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_flash"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {3000, 5500}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_flash")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Gaia."
tempJob.desc = "1 Gaia."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_gaia"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {3000, 5500}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_gaia")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Galaxy."
tempJob.desc = "1 Galaxy."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_galaxy"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {18000, 23000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_galaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Grandmamas Beads."
tempJob.desc = "1 Grandmamas Beads."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_gmamasbeads"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {26000, 30000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_galaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Halo."
tempJob.desc = "1 Halo."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_halo"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {20000, 21000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_halo")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Kolobok."
tempJob.desc = "1 Kolobok."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_kolobok"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {6500, 8400}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_kolobok")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Mama's Beads."
tempJob.desc = "1 Mama's Beads."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mamasbeads"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {6000, 9000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_mamasbeads")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Memento Mori."
tempJob.desc = "1 Memento Mori."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mementomori"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {3000, 5500}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_mementomori")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Mica."
tempJob.desc = "1 Mica."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mica"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {10000, 13000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_mica")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Moonlight."
tempJob.desc = "1 Moonlight."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_moonlight"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {8500, 11000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_moonlight")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Moonlight."
tempJob.desc = "1 Moonlight."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_moonlight"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {8500, 11000}
tempJob.categories = {"artifactcollect_NPC_hard"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_moonlight")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Mycelia."
tempJob.desc = "1 Mycelia."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mycelia"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {7000, 9000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_mycelia")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Panacea."
tempJob.desc = "1 Panacea."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_panacea"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {1000, 2000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_panacea")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Slime."
tempJob.desc = "1 Slime."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_slime"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {500, 1000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_slime")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Slimes."
tempJob.desc = "2 Slimes."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_slime"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {2500, 3500}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_slime")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Slug."
tempJob.desc = "1 Slug."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_slug"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {4000, 5000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_slug")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Sparkler."
tempJob.desc = "1 Sparkler."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_sparkler"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {500, 1000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_sparkler")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Sparklers."
tempJob.desc = "2 Sparklers."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_sparkler"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {1500, 3000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_sparkler")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Thorn."
tempJob.desc = "1 Thorn."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_thorn"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {500, 1000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_thorn")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 2 Thorns."
tempJob.desc = "2 Thorns."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_thorn"
tempJob.numberRec = 2
tempJob.reward = {{"hidestash_2"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {1500, 3000}
tempJob.categories = {"artifactcollect_NPC_easy"}

ix.jobs.register(tempJob, "ItemJob2eco_artifact_thorn")

tempJob = nil

local tempJob = {}

tempJob.name = "Hand over 1 Urchin."
tempJob.desc = "1 Urchin."
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_urchin"
tempJob.numberRec = 1
tempJob.reward = {{"hidestash_3"}}
tempJob.rewardCount = 1
tempJob.repReward = 20
tempJob.moneyReward = {3000, 4000}
tempJob.categories = {"artifactcollect_NPC_medium"}

ix.jobs.register(tempJob, "ItemJob1eco_artifact_urchin")

tempJob = nil