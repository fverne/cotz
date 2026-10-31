local PLUGIN = PLUGIN

PLUGIN.name = "Job System"
PLUGIN.author = "gumlefar, ported to ix by verne"
PLUGIN.description = "Repeatable contact jobs, field assignments and persistent task rewards."

ix.char.RegisterVar("jobs", {
	field = "jobs",
	fieldType = ix.type.text,
	default = {},
	bNoDisplay = true,
})

ix.util.Include("definitions/sh_itemjobs_artifacts_pc.lua")
ix.util.Include("definitions/sh_itemjobs_artifacts.lua")
ix.util.Include("definitions/sh_itemjobs_meals.lua")
ix.util.Include("definitions/sh_itemjobs_parts.lua")
ix.util.Include("definitions/sh_itemjobs_world.lua")
ix.util.Include("definitions/sh_killjobs_humans.lua")
ix.util.Include("definitions/sh_killjobs_mutants.lua")
ix.util.Include("definitions/sh_specialjobs.lua")
ix.util.Include("definitions/sh_fieldjobs.lua")
ix.util.Include("sv_jobs.lua")
ix.util.Include("sv_npcjobs.lua")
ix.util.Include("sv_fieldplacement.lua")
ix.util.Include("sv_fieldassignment.lua")
ix.util.Include("sv_fieldactions.lua")
ix.util.Include("sv_fieldtasks.lua")
ix.util.Include("sv_cargo.lua")
ix.util.Include("sv_fielddefence.lua")
ix.util.Include("cl_fieldtasks.lua")
ix.util.Include("sv_listeners.lua")
ix.util.Include("cl_plugin.lua")

ix.config.Add("taskAbandonCooldown", ix.jobs.settings.abandonCooldown,
	"The cooldown for abandoning a task, in seconds.", nil, {
		data = {min = 0, max = 604800},
		category = "Town NPCs",
	})

if SERVER then
	function PLUGIN:PostLoadData()
		ix.taskRewards.Validate()
	end

	function PLUGIN:LoadData()
		ix.jobs.activejobs = self:GetData({})
	end

	function PLUGIN:SaveData()
		self:SetData(ix.jobs.activejobs)
	end
end
