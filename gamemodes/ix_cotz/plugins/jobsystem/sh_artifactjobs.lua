---
-- Artifact jobs - Could technically be under item jobs, but just to avoid having that file grow to 3k+ lines
--                 These are split into two, one for egghead and one for the computer
--                 Egghead gives items, money and rep, whereas the computer only gives money and rep
---

do
------------------------------------------------
----------- ITEM RETRIEVAL - ARTIFACT ----------
-----------          COMPUTER         ----------
------------------------------------------------

  local tempJob = {}

  tempJob.name = "** 1 Arachno **."
  tempJob.desc = "** The computer shows an image of a spindly artifact, loosely reminiscent of a spider. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_arachno"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 18
  tempJob.moneyReward = {7000, 9000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_arachno")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Arachnos **."
  tempJob.desc = "** The computer shows an image of a spindly artifact, loosely reminiscent of a spider.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_arachno"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 18
  tempJob.moneyReward = {12000, 16000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_arachno")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Battery **."
  tempJob.desc = "** The computer shows an image of an artifact, consisting of three bars connected at either end with an electric current running between them. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_battery"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {5200, 7200}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Batteries **."
  tempJob.desc = "** The computer shows an image of an artifact, consisting of three bars connected at either end with an electric current running between them.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_battery"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 50
  tempJob.moneyReward = {9700, 15000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Blown Capacitor **."
  tempJob.desc = "** The computer shows an image of an artifact, consisting of two plates at a fixed distance from one another. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_blowncap"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 18
  tempJob.moneyReward = {3000, 4800}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_bcap")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Blown Capacitors **."
  tempJob.desc = "** The computer shows an image of an artifact, consisting of two plates at a fixed distance from one another.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_blowncap"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 43
  tempJob.moneyReward = {5500, 9200}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_bcap")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 4 Anomalous Bolts **."
  tempJob.desc = "** The computer shows an image of a small glowing bolt.\nIt also shows a number: '4' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bolt"
  tempJob.numberRec = 4
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 13
  tempJob.moneyReward = {2500, 4300}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_bolt")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 6 Anomalous Bolts **."
  tempJob.desc = "** The computer shows an image of a small glowing bolt.\nIt also shows a number: '6' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bolt"
  tempJob.numberRec = 6
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 39
  tempJob.moneyReward = {4700, 6300}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_bolt")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 3 Bone Clusters **."
  tempJob.desc = "** The computer shows an image of a small knotted bone.\nIt also shows a number: '3' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bonecluster"
  tempJob.numberRec = 3
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 24
  tempJob.moneyReward = {3000, 6000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_bcluster")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 5 Bone Clusters **."
  tempJob.desc = "** The computer shows an image of a small knotted bone.\nIt also shows a number: '5' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bonecluster"
  tempJob.numberRec = 5
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 55
  tempJob.moneyReward = {5000, 9500}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_bcluster")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Capacitor **."
  tempJob.desc = "** The computer shows an image of an artifact, consisting of two plates at a fixed distance from one another. A strange substance is present between them. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_capicator"
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
  tempJob.listenTrigger = "itemDeliver_artifact_cell"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 18
  tempJob.moneyReward = {5300, 7800}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_cell")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Cells **."
  tempJob.desc = "** The computer shows an image of a spherical artifact. You can make out some sort of mass inside the sphere.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_cell"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 43
  tempJob.moneyReward = {8000, 12800}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_cell")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Crystal **."
  tempJob.desc = "** The computer shows an image of a crystalline artifact. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_crystal"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {5000, 7200}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_crystal")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Crystals **."
  tempJob.desc = "** The computer shows an image of a crystalline artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_crystal"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 54
  tempJob.moneyReward = {10500, 15000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_crystal")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Droplet **."
  tempJob.desc = "** The computer shows an image of a small teardrop shaped artifact. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_droplet"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {1800, 2900}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_droplet")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Droplets **."
  tempJob.desc = "** The computer shows an image of a small teardrop shaped artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_droplet"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 54
  tempJob.moneyReward = {3500, 5300}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_droplet")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Dwarf Galaxy **."
  tempJob.desc = "** The computer shows an image of a small sphere with smaller spheres locked in orbit around it. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_dwarfgalaxy"
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
  tempJob.listenTrigger = "itemDeliver_artifact_eye"
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
  tempJob.listenTrigger = "itemDeliver_artifact_flame"
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
  tempJob.listenTrigger = "itemDeliver_artifact_flash"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {4900, 6900}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_flash")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Flashes **."
  tempJob.desc = "** The computer shows an image of a small shining ball of an artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_flash"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 50
  tempJob.moneyReward = {9000, 14500}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_flash")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Gaia **."
  tempJob.desc = "** The computer shows an image of a spherical artifact encased in a wing-like shroud. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_gaia"
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
  tempJob.listenTrigger = "itemDeliver_artifact_galaxy"
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
  tempJob.listenTrigger = "itemDeliver_artifact_gmamasbeads"
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
  tempJob.listenTrigger = "itemDeliver_artifact_halo"
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
  tempJob.listenTrigger = "itemDeliver_artifact_kolobok"
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
  tempJob.listenTrigger = "itemDeliver_artifact_mamasbeads"
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
  tempJob.listenTrigger = "itemDeliver_artifact_mementomori"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 17
  tempJob.moneyReward = {3000, 4500}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_mementomori")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Memento Mori **."
  tempJob.desc = "** The computer shows an image of a skull shaped artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mementomori"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 40
  tempJob.moneyReward = {5500, 8000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_mementomori")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Mica **."
  tempJob.desc = "** The computer shows an image of a rock shaped artifact. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mica"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {6000, 8500}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_mica")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Mica **."
  tempJob.desc = "** The computer shows an image of a rock shaped artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mica"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 53
  tempJob.moneyReward = {10000, 14000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_mica")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Midas **."
  tempJob.desc = "** The computer shows an image of a reflective artifact shaped like a dotted sphere. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_midas"
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
  tempJob.listenTrigger = "itemDeliver_artifact_moonlight"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 35
  tempJob.moneyReward = {12000, 14000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_moonlight")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Mycelia **."
  tempJob.desc = "** The computer shows an image of a lumpy rock.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mycelia"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 30
  tempJob.moneyReward = {6800, 9600}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_mycelia")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Panacea **."
  tempJob.desc = "** The computer shows an image of a small bracelet. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_panacea"
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
  tempJob.listenTrigger = "itemDeliver_artifact_slime"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 15
  tempJob.moneyReward = {3400, 4000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_slime")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Slimes **."
  tempJob.desc = "** The computer shows an image of a porous rock.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slime"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 37
  tempJob.moneyReward = {6000, 8400}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_slime")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Slug **."
  tempJob.desc = "** The computer shows an image of a jelly-like artifact covered in stone plates. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slug"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 22
  tempJob.moneyReward = {6500, 7500}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_slug")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Slugs **."
  tempJob.desc = "** The computer shows an image of a jelly-like artifact covered in stone plates.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slug"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 47
  tempJob.moneyReward = {9000, 16000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_slug")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Sparkler **."
  tempJob.desc = "** The computer shows an image of a small glowing orb. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_sparkler"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 12
  tempJob.moneyReward = {3200, 3800}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_sparkler")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Sparklers **."
  tempJob.desc = "** The computer shows an image of a small glowing orb.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_sparkler"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 27
  tempJob.moneyReward = {6000, 8000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_sparkler")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Thorn **."
  tempJob.desc = "** The computer shows an image of a small thorny artifact. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_thorn"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 9
  tempJob.moneyReward = {1500, 2400}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_thorn")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 2 Thorns **."
  tempJob.desc = "** The computer shows an image of a small thorny artifact.\nIt also shows a number: '2' **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_thorn"
  tempJob.numberRec = 2
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 21
  tempJob.moneyReward = {3200, 5300}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob2pc_artifact_thorn")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "** 1 Urchin **."
  tempJob.desc = "** The computer shows an image of a spiky artifact. **"
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_urchin"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 19
  tempJob.moneyReward = {5900, 7000}
  tempJob.categories = {"artifactcollect_computer"}

  ix.jobs.register(tempJob, "ItemJob1pc_artifact_urchin")

  tempJob = nil

------------------------------------------------
----------- ITEM RETRIEVAL - ARTIFACT ----------
-----------           EGGHEAD         ----------
------------------------------------------------

  local tempJob = {}

  tempJob.name = "Hand over 1 Arachno."
  tempJob.desc = "1 Arachno."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_arachno"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {10000, 13000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_arachno")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Batteries."
  tempJob.desc = "2 Batteries."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_battery"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 30
  tempJob.moneyReward = {16500, 18400}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Blown Capacitor."
  tempJob.desc = "1 Blown Capacitor."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_blowncap"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {7000, 9500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_blowncap")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Anomalous Bolt."
  tempJob.desc = "1 Anomalous Bolt."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bolt"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {100, 900}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_bolt_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Anomalous Bolts."
  tempJob.desc = "2 Anomalous Bolts."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bolt"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 25
  tempJob.moneyReward = {300, 2100}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_bolt_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 5 Anomalous Bolts."
  tempJob.desc = "5 Anomalous Bolts."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bolt"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 40
  tempJob.moneyReward = {1000, 6000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_bolt_5")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Bone Cluster."
  tempJob.desc = "1 Bone Cluster."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bonecluster"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {2000, 4500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_bonecluster_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Bone Clusters."
  tempJob.desc = "2 Bone Clusters."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_bonecluster"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 25
  tempJob.moneyReward = {5000, 8000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_bonecluster_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Capacitor."
  tempJob.desc = "1 Capacitor."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_capicator"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_rare"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {27000, 32000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_capicator")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Cell."
  tempJob.desc = "1 Cell."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_cell"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {6200, 8600}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_cell")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Crystal."
  tempJob.desc = "1 Crystal."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_crystal"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {10000, 13000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_crystal")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Droplet."
  tempJob.desc = "1 Droplet."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_droplet"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {2500, 3800}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_droplet")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Dwarf Galaxy."
  tempJob.desc = "1 Dwarf Galaxy."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_dwarfgalaxy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 3
  tempJob.repReward = 20
  tempJob.moneyReward = {2000, 4000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_dwarfgalaxy_ammo")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Dwarf Galaxy."
  tempJob.desc = "1 Dwarf Galaxy."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_dwarfgalaxy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 0
  tempJob.repReward = 20
  tempJob.moneyReward = {10000, 16000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_dwarfgalaxy_money")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Eye."
  tempJob.desc = "1 Eye."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_eye"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 0
  tempJob.repReward = 20
  tempJob.moneyReward = {15000, 19000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_eye")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Flame."
  tempJob.desc = "1 Flame."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_flame"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_rare"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {24000, 29000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_flame")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Flash."
  tempJob.desc = "1 Flash."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_flash"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {3000, 5500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_flash")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Gaia."
  tempJob.desc = "1 Gaia."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_gaia"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {3000, 5500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_gaia")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Galaxy."
  tempJob.desc = "1 Galaxy."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_galaxy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {18000, 23000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_galaxy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Grandmamas Beads."
  tempJob.desc = "1 Grandmamas Beads."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_gmamasbeads"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 0
  tempJob.repReward = 20
  tempJob.moneyReward = {26000, 30000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_galaxy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Halo."
  tempJob.desc = "1 Halo."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_halo"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {2000, 4000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_halo")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Kolobok."
  tempJob.desc = "1 Kolobok."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_kolobok"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {6500, 8400}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_kolobok")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Mama's Beads."
  tempJob.desc = "1 Mama's Beads."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mamasbeads"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {6000, 9000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_mamasbeads")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Memento Mori."
  tempJob.desc = "1 Memento Mori."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mementomori"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {3000, 5500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_mementomori")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Mica."
  tempJob.desc = "1 Mica."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mica"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {10000, 13000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_mica")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Moonlight."
  tempJob.desc = "1 Moonlight."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_moonlight"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {8500, 11000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_moonlight")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Moonlight."
  tempJob.desc = "1 Moonlight."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_moonlight"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {8500, 11000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_moonlight")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Mycelia."
  tempJob.desc = "1 Mycelia."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_mycelia"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 0
  tempJob.repReward = 20
  tempJob.moneyReward = {9000, 15000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_mycelia")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Panacea."
  tempJob.desc = "1 Panacea."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_panacea"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_large"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {1000, 2000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_panacea")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Slime."
  tempJob.desc = "1 Slime."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slime"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {500, 1000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_slime_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Slimes."
  tempJob.desc = "2 Slimes."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slime"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {2500, 3500}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_slime_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Slug."
  tempJob.desc = "1 Slug."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_slug"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {4000, 5000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_slug")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Sparkler."
  tempJob.desc = "1 Sparkler."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_sparkler"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {500, 1000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_sparkler_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Sparklers."
  tempJob.desc = "2 Sparklers."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_sparkler"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {1500, 3000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_sparkler_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Thorn."
  tempJob.desc = "1 Thorn."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_thorn"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {500, 1000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_thorn_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 2 Thorns."
  tempJob.desc = "2 Thorns."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_thorn"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {1500, 3000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_thorn_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over 1 Urchin."
  tempJob.desc = "1 Urchin."
  tempJob.icon = "propic/event/artifact"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_artifact_urchin"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {3000, 4000}
  tempJob.categories = {"artifactcollect_eco"}

  ix.jobs.register(tempJob, "ItemJob1eco_artifact_urchin")

  tempJob = nil

end