
do
  --item return quest
  local tempQuest = {}

  tempQuest.name = "%d makarovs."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_makarov"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_makarov")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d lead pipes."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_leadpipe"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_leadpipe")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d crowbars."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_crowbar"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_crowbar")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d bats."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_bat"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_bat")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d fire axes."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_fireaxe"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_fireaxe")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d anomaly maps."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents0"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents0")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d military maps."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents1"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents1")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Anomaly Research Documents (simple)."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents2"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest3"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents2")

  tempQuest = nil

  /*local tempQuest = {}

  tempQuest.name = "%d Beretta 92s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_beretta92"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_beretta92")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Browning Highpowers."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_brhp"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_brhp")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Tokarevs."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_tokarev"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_tokarev")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d CZ-52s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_cz52"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_cz52")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d P99s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_p99"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_p99")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Fort 12s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_fort12"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_fort12")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Glock 17s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_glock17"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_glock17")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Ruger MK3s."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_rugermk3"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_rugermk3")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Black Flashdrives."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_flashdriveblack"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_flashdriveblack")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Blue Flashdrives."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_flashdriveblue"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_flashdriveblue")

  tempQuest = nil*/

  local tempQuest = {}

  tempQuest.name = "%d Personal Belongings."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents4"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents4")

  tempQuest = nil

  /*local tempQuest = {}

  tempQuest.name = "%d Traders Journals."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents8"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents8")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d Ecologists Journals."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_documents8"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_documents9")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d GPS Mapping Devices."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_gpsmappingdevice"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_gpsmappingdevice")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d GPS Tracking Devices."
  tempQuest.desc = "xD."
  tempQuest.icon = "stalker/questpaper_item.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "itemDeliver_gpstrackingdevice"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "itemQuest_gpstrackingdevice")

  tempQuest = nil*/

  --random amount of mutants
  local tempQuest = {}

  tempQuest.name = "%d mutants."
  tempQuest.desc = "%d mutants."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "mutantKilled"
  tempQuest.numberRec = {20,30}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killMutantsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d mutants."
  tempQuest.desc = "%d mutants."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "mutantKilled"
  tempQuest.numberRec = {40,50}
  tempQuest.reward = {{"kit_quest3"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killMutantsHigh")

  tempQuest = nil

--rodents

  local tempQuest = {}

  tempQuest.name = "%d rodents."
  tempQuest.desc = "%d rodents."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "rodentKilled"
  tempQuest.numberRec = {5,10}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killRodentsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d rodents."
  tempQuest.desc = "%d rodents."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "rodentKilled"
  tempQuest.numberRec = {10,15}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killRodentsHigh")

  tempQuest = nil

-- Zombies

  local tempQuest = {}

  tempQuest.name = "%d zombies."
  tempQuest.desc = "%d zombies."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "zombieKilled"
  tempQuest.numberRec = {5,10}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killZombiesLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d zombies."
  tempQuest.desc = "%d zombies."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "zombieKilled"
  tempQuest.numberRec = {10,15}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killZombiesHigh")

  tempQuest = nil    

-- Cats

  local tempQuest = {}

  tempQuest.name = "%d cats."
  tempQuest.desc = "%d cats."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "catKilled"
  tempQuest.numberRec = {2,3}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killCatsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d cats."
  tempQuest.desc = "%d cats."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "catKilled"
  tempQuest.numberRec = {4,6}
  tempQuest.reward = {{"kit_quest3"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killCatsHigh")

  tempQuest = nil

-- bloodsuckers

  local tempQuest = {}

  tempQuest.name = "%d bloodsuckers."
  tempQuest.desc = "%d bloodsuckers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "bloodsuckerKilled"
  tempQuest.numberRec = {1,3}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killBloodsuckersLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d bloodsuckers."
  tempQuest.desc = "%d bloodsuckers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "bloodsuckerKilled"
  tempQuest.numberRec = {3,6}
  tempQuest.reward = {{"kit_quest3"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killBloodsuckersHigh")

  tempQuest = nil

-- boars

  local tempQuest = {}

  tempQuest.name = "%d boars."
  tempQuest.desc = "%d boars."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "boarKilled"
  tempQuest.numberRec = {2,4}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killBoarsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d boars."
  tempQuest.desc = "%d boars."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "boarKilled"
  tempQuest.numberRec = {4,6}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killBoarsHigh")

  tempQuest = nil

-- Burers
  local tempQuest = {}

  tempQuest.name = "%d burers."
  tempQuest.desc = "%d burers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "burerKilled"
  tempQuest.numberRec = {1,2}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killBurersLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d burers."
  tempQuest.desc = "%d burers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "burerKilled"
  tempQuest.numberRec = {2,3}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killBurersHigh")

  tempQuest = nil

-- Chimeras
  local tempQuest = {}

  tempQuest.name = "%d chimeras."
  tempQuest.desc = "%d chimeras."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "chimeraKilled"
  tempQuest.numberRec = {1,2}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killChimerasLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d chimeras."
  tempQuest.desc = "%d chimeras."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 4
  tempQuest.listenTrigger = "chimeraKilled"
  tempQuest.numberRec = {2,3}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killChimerasHigh")

  tempQuest = nil

-- Controllers
/*
  local tempQuest = {}

  tempQuest.name = "%d controllers."
  tempQuest.desc = "%d controllers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "controllerKilled"
  tempQuest.numberRec = {1,2}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killControllersLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d controllers."
  tempQuest.desc = "%d controllers."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "controllerKilled"
  tempQuest.numberRec = {2,4}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killControllersHigh")
*/
-- dogs

  local tempQuest = {}

  tempQuest.name = "%d dogs."
  tempQuest.desc = "%d dogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "dogKilled"
  tempQuest.numberRec = {3,5}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killDogsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d dogs."
  tempQuest.desc = "%d dogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "dogKilled"
  tempQuest.numberRec = {6,10}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killDogsHigh")

  tempQuest = nil  

--fleshes

  local tempQuest = {}

  tempQuest.name = "%d fleshes."
  tempQuest.desc = "%d fleshes."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "fleshKilled"
  tempQuest.numberRec = {3,5}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killFleshesLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d fleshes."
  tempQuest.desc = "%d fleshes."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "fleshKilled"
  tempQuest.numberRec = {6,10}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killFleshesHigh")

  tempQuest = nil

-- pseudodogs

  local tempQuest = {}

  tempQuest.name = "%d pseudodogs."
  tempQuest.desc = "%d pseudodogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 1
  tempQuest.listenTrigger = "pseudodogKilled"
  tempQuest.numberRec = {1,3}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 10

  ix.quest.register(tempQuest, "killPseudodogsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d pseudodogs."
  tempQuest.desc = "%d pseudodogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "pseudodogKilled"
  tempQuest.numberRec = {3,5}
  tempQuest.reward = {{"kit_quest2"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killPseudodogsHigh")

  tempQuest = nil

-- psydogs
/*
  local tempQuest = {}

  tempQuest.name = "%d psydogs."
  tempQuest.desc = "%d psydogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 2
  tempQuest.listenTrigger = "psydogKilled"
  tempQuest.numberRec = {1,1}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killPsydogsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d psydogs."
  tempQuest.desc = "%d psydogs."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "psydogKilled"
  tempQuest.numberRec = {2,3}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killPsydogsLow")

  tempQuest = nil

-- Pseudogiants

  local tempQuest = {}

  tempQuest.name = "%d pseudogiants."
  tempQuest.desc = "%d pseudogiants."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 3
  tempQuest.listenTrigger = "pseudogiantKilled"
  tempQuest.numberRec = {1,2}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 15

  ix.quest.register(tempQuest, "killPseudogiantsLow")

  tempQuest = nil

  local tempQuest = {}

  tempQuest.name = "%d pseudogiants."
  tempQuest.desc = "%d pseudogiants."
  tempQuest.icon = "stalker/questpaper_mutant.png"
  tempQuest.tier = 4
  tempQuest.listenTrigger = "pseudogiantKilled"
  tempQuest.numberRec = {2,3}
  tempQuest.reward = {{"kit_quest1"}}
  tempQuest.rewardCount = {1,1}
  tempQuest.repReward = 20

  ix.quest.register(tempQuest, "killPseudogiantsHigh")

  tempQuest = nil
*/
end