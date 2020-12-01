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
  end
end

ix.char.RegisterVar("jobs", {
	field = "jobs",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = true,
})

ix.util.Include("sh_jobs.lua")
ix.util.Include("sh_listeners.lua")

ix.jobs.activejobs = {}

if SERVER then
	netstream.Hook("job_deliveritem", function(client, npcidentifier)
		local jobidentifier = client:GetCharacter():GetJobs()[npcidentifier].identifier
		if client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier)) then
			hook.Run("ix_JobTrigger", client, "itemDeliver_"..ix.jobs.isItemJob(jobidentifier))
			client:GetCharacter():GetInventory():HasItem(ix.jobs.isItemJob(jobidentifier)):Remove()
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

	function ix.jobs.setNPCJobTaken(npcidentifier, jobidentifier)
		ix.jobs.activejobs[npcidentifier] = ix.jobs.activejobs[npcidentifier] or {}

		for k,v in pairs(ix.jobs.activejobs[npcidentifier]) do
			if (v.identifier and v.identifier == jobidentifier) then
				ix.jobs.activejobs[npcidentifier][k] = { identifier = ix.jobs.getJobFromCategory(categories), expiration = os.time() + 3600*2 }
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