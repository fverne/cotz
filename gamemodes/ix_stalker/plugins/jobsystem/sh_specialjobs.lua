--[[
  --TestJob
  local tempJob = {}

  tempJob.name = "Say sneed %d times."                  --Name that will be shown in dialogue when selecting tasks
  tempJob.desc = "I need you to sneed %d times for me." --Description of task, will be shown to the player when deciding to take quest or not
  tempJob.icon = "stalker/questpaper_item.png"          --Icon, unused?
  tempJob.tier = 1                                      --Tier, unused?
  tempJob.listenTrigger = "chatSayTest"                 --trigger word to listen for in the ix_JobTrigger hook, see sh_listeners
  tempJob.numberRec = 5                                 --integer amount of times the listenTrigger must be run through the ix_JobTrigger hook
  tempJob.reward = {{"kit_quest1"}}                     --table of item ids for rewarding the player with
  tempJob.rewardCount = 1                               --how many items should the player get
  tempJob.repReward = 80                                --how much reputation should be awarded for completion
  tempJob.categories = {"mutantkilleasy"}               --table of category identifiers, used for when npc gets tasks

  ix.jobs.register(tempJob, "TestJob")                  --If item delivery quest, the final part of the quest identifier should read "_<uniqueid>" for proper operation

  candidates for adding:
  tempJob.moneyReward = {2000,4000} OR 3000             --for adding money to the player, can technically be done through itemreward as well

]]--



do

end
