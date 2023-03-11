local PLUGIN = PLUGIN

PLUGIN.name = "Job System"
PLUGIN.author = "gumlefar, ported to ix by verne"
PLUGIN.desc = "Implements the job library."

function ix.jobs.register(jobstruct,identifier)
  if ix.jobs.isStructValid(jobstruct) then
    ix.jobs.list[identifier] = jobstruct

    local amountofcats = 0
    for k,v in pairs(jobstruct.categories or {}) do
    	ix.jobs.jobsbycategory[v] = ix.jobs.jobsbycategory[v] or {}

    	table.insert(ix.jobs.jobsbycategory[v],identifier)
    	amountofcats = amountofcats + 1
    end

    if amountofcats == 0 then
    	ix.jobs.jobsbycategory["miscjobs"] = ix.jobs.jobsbycategory["miscjobs"] or {}

    	table.insert(ix.jobs.jobsbycategory["miscjobs"],identifier)
    end
  else
    print("ERROR IN JOB DEFINITION")
	PrintTable(jobstruct)
  end
end

ix.char.RegisterVar("jobs", {
	field = "jobs",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
})

ix.util.Include("sh_killjobs.lua")
ix.util.Include("sh_itemjobs.lua")
ix.util.Include("sh_artifactjobs.lua")
ix.util.Include("sh_specialjobs.lua")
ix.util.Include("sh_listeners.lua")
ix.util.Include("cl_plugin.lua")

ix.jobs.activejobs = {}

ix.config.Add("taskAbandonCooldown", 3600, "The cooldown for abandoning a task, in seconds.", nil, {
	data = {min = 0, max = 604800},
	category = "Town NPCs"
})

if SERVER then
	netstream.Hook("job_deliveritem", function(client, npcidentifier)
		local jobidentifier = client:GetCharacter():GetJobs()[npcidentifier].identifier
		if client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier)) then
			local item = client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier))
			local noremove = false
			local n = 0
			if(item.quantity) then
				for i=1, item:GetData("quantity", item.quantity) do
					hook.Run("ix_JobTrigger", client, "itemDeliver_"..ix.jobs.isItemJob(jobidentifier))
					n = n + 1
					if (client:GetCharacter():GetJobs()[npcidentifier].isCompleted) then 
						item:SetData("quantity", item:GetData("quantity", item.quantity)-n)
						noremove = (item:GetData("quantity", item.quantity) > 0)
						break 
					end
				end
			else
				hook.Run("ix_JobTrigger", client, "itemDeliver_"..ix.jobs.isItemJob(jobidentifier))
			end
			if(!noremove) then item:Remove() end
			ix.dialogue.notifyItemLost(client, ix.item.list[ix.jobs.isItemJob(jobidentifier)].name)
			client:Notify("Item delivered!")
		else
			client:Notify("Required item not in inventory!")
		end
	end)

	netstream.Hook("job_updatenpcjobs", function(client, targetnpc, npcidentifier, categories, amount) 
		local jobs = ix.jobs.getNPCJobs(npcidentifier, categories, amount)

		targetnpc:SetNetVar("jobs", jobs)
	end)

	netstream.Hook("job_removeplayerjob", function(client, npcidentifier) 
		client:ixJobRemove(npcidentifier)
	end)

	function ix.jobs.getNPCJobs(npcidentifier, categories, amount)
		ix.jobs.activejobs[npcidentifier] = ix.jobs.activejobs[npcidentifier] or {}

		local curamt = 0

		for k,v in pairs(ix.jobs.activejobs[npcidentifier]) do
			if (v.expiration and v.expiration < os.time()) then
				ix.jobs.activejobs[npcidentifier][k] = { identifier = ix.jobs.getJobFromCategory(categories), expiration = os.time() + 3600*2 }
			end

			curamt = curamt + 1
		end

		for i = 1, curamt-amount do --If too many jobs present
			ix.jobs.activejobs[npcidentifier][#ix.jobs.activejobs[npcidentifier]] = nil
		end

		for i = 1, amount-curamt do
			table.insert(ix.jobs.activejobs[npcidentifier], { identifier = ix.jobs.getJobFromCategory(categories), expiration = os.time() + 3600*2 })
		end

		local ret = {}
		for k,v in pairs(ix.jobs.activejobs[npcidentifier]) do
			table.insert(ret, #ret+1, v.identifier)
		end

		return ret
	end

	function ix.jobs.NPCHasJob(npcidentifier, jobidentifier)
		for k,v in pairs(ix.jobs.activejobs[npcidentifier]) do
			if (v.identifier == jobidentifier) then
				return true
			end
		end

		return false
	end

	function ix.jobs.setNPCJobTaken(npcidentifier, jobidentifier)
		ix.jobs.activejobs[npcidentifier] = ix.jobs.activejobs[npcidentifier] or {}

		for k,v in pairs(ix.jobs.activejobs[npcidentifier]) do
			if (v.identifier and v.identifier == jobidentifier) then
				ix.jobs.activejobs[npcidentifier][k] = nil
				break
			end
		end
	end

	function PLUGIN:LoadData()
		data = self:GetData()

		ix.jobs.activejobs = data

	end

	function PLUGIN:SaveData()
		self:SetData(ix.jobs.activejobs)
	end
end