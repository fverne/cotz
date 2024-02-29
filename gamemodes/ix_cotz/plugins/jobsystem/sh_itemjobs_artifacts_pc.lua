---
-- Artifact jobs - Could technically be under item jobs, but just to avoid having that file grow to 3k+ lines
--                 These are split into two, one for egghead and one for the computer
--                 Egghead gives items, money and rep, whereas the computer only gives money and rep
---

------------------------------------------------
----------- ITEM RETRIEVAL - ARTIFACT ----------
-----------          COMPUTER         ----------
------------------------------------------------

local tempJob = {}

tempJob.name = "** 1 Arachno **."
tempJob.desc = "** The computer shows an image of a spindly artifact, loosely reminiscent of a spider. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_arachno"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 18
tempJob.moneyReward = {7000, 9000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_arachno")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Battery **."
tempJob.desc = "** The computer shows an image of an artifact, consisting of three bars connected at either end with an electric current running between them. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_battery"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {5200, 7200}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_battery")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Blown Capacitor **."
tempJob.desc = "** The computer shows an image of an artifact, consisting of two plates at a fixed distance from one another. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_blowncap"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 18
tempJob.moneyReward = {3000, 4800}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_bcap")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Capacitor **."
tempJob.desc = "** The computer shows an image of an artifact, consisting of two plates at a fixed distance from one another. A strange substance is present between them. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_capacitor"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 18
tempJob.moneyReward = {10000, 13000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_cap")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Cell **."
tempJob.desc = "** The computer shows an image of a spherical artifact. You can make out some sort of mass inside the sphere. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_cell"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 18
tempJob.moneyReward = {5300, 7800}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_cell")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Crystal **."
tempJob.desc = "** The computer shows an image of a crystalline artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_crystal"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {5000, 7200}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_crystal")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Droplet **."
tempJob.desc = "** The computer shows an image of a small teardrop shaped artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_droplet"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {1800, 2900}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_droplet")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Dwarf Galaxy **."
tempJob.desc = "** The computer shows an image of a small sphere with smaller spheres locked in orbit around it. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_dwarfgalaxy"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 30
tempJob.moneyReward = {6000, 8500}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_dwarfgalaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Eye **."
tempJob.desc = "** The computer shows an image of a teardrop shaped artifact. A readout in the corner shows high temperatures. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_eye"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 25
tempJob.moneyReward = {8500, 10000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_eye")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Flame **."
tempJob.desc = "** The computer shows an image of a spherical. A readout in the corner shows extreme temperatures. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_flame"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 130
tempJob.moneyReward = {25000, 30000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_flame")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Flash **."
tempJob.desc = "** The computer shows an image of a small shining ball of an artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_flash"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {4900, 6900}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_flash")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Gaia **."
tempJob.desc = "** The computer shows an image of a spherical artifact encased in a wing-like shroud. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_gaia"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 65
tempJob.moneyReward = {11000, 13000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_gaia")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Galaxy **."
tempJob.desc = "** The computer shows an image of a sphere with smaller spheres locked in orbit around it. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_galaxy"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 86
tempJob.moneyReward = {22000, 29000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_galaxy")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Grandmamas Beads **."
tempJob.desc = "** The computer shows an image of an artifact consisting of a string of spheres. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_gmamasbeads"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 86
tempJob.moneyReward = {17500, 21000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_gmamasbeads")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Halo **."
tempJob.desc = "** The computer shows an image of a halo-shaped object. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_halo"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 33
tempJob.moneyReward = {6800, 9000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_halo")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Kolobok **."
tempJob.desc = "** The computer shows an image of a small, spiky artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_kolobok"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 33
tempJob.moneyReward = {8600, 12400}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_kolobok")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Mama's Beads **."
tempJob.desc = "** The computer shows an image of a ladder-like structure of beads. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mamasbeads"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 27
tempJob.moneyReward = {7500, 9600}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_mamasbeads")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Memento Mori **."
tempJob.desc = "** The computer shows an image of a skull shaped artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mementomori"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 17
tempJob.moneyReward = {3000, 4500}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_mementomori")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Mica **."
tempJob.desc = "** The computer shows an image of a rock shaped artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_mica"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {6000, 8500}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_mica")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Midas **."
tempJob.desc = "** The computer shows an image of a reflective artifact shaped like a dotted sphere. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_midas"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 400
tempJob.moneyReward = {70000, 80000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_midas")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Moonlight **."
tempJob.desc = "** The computer shows an image of a small glowing orb. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_moonlight"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 35
tempJob.moneyReward = {12000, 14000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_moonlight")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Panacea **."
tempJob.desc = "** The computer shows an image of a small bracelet. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_panacea"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 32
tempJob.moneyReward = {8500, 10000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_panacea")

tempJob = nil

local tempJob = {}

tempJob.name = "** 1 Slime **."
tempJob.desc = "** The computer shows an image of a porous rock. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_slime"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 15
tempJob.moneyReward = {3400, 4000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_slime")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Slug **."
tempJob.desc = "** The computer shows an image of a jelly-like artifact covered in stone plates. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_slug"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 22
tempJob.moneyReward = {6500, 7500}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_slug")

tempJob = nil



local tempJob = {}

tempJob.name = "** 1 Sparkler **."
tempJob.desc = "** The computer shows an image of a small glowing orb. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_sparkler"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 12
tempJob.moneyReward = {3200, 3800}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_sparkler")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Thorn **."
tempJob.desc = "** The computer shows an image of a small thorny artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_thorn"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 9
tempJob.moneyReward = {1500, 2400}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_thorn")

tempJob = nil


local tempJob = {}

tempJob.name = "** 1 Urchin **."
tempJob.desc = "** The computer shows an image of a spiky artifact. **"
tempJob.icon = "propic/event/artifact"
tempJob.tier = 1
tempJob.requiredItem = "artifact_urchin"
tempJob.numberRec = 1
tempJob.reward = {}
tempJob.rewardCount = 0
tempJob.repReward = 19
tempJob.moneyReward = {5900, 7000}
tempJob.categories = {"artifactcollect_computer"}

ix.jobs.register(tempJob, "ItemJob1pc_artifact_urchin")

tempJob = nil
