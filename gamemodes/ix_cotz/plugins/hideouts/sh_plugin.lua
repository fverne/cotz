local PLUGIN = PLUGIN
PLUGIN.name = "Character Hideouts"
PLUGIN.author = "cotz"
PLUGIN.description = "Character-owned interiors loaded only while occupied."

ix.config.Add(
	"hideoutGap",
	512,
	"Minimum clearance between allocated hideouts.",
	nil,
	{ category = "Hideouts", data = { min = 128, max = 4096 } }
)
ix.config.Add(
	"hideoutEntityLimit",
	256,
	"Maximum pasted entities in one hideout.",
	nil,
	{ category = "Hideouts", data = { min = 16, max = 1024 } }
)
ix.config.Add(
	"hideoutLoadTimeout",
	30,
	"Seconds before an incomplete hideout load is canceled.",
	nil,
	{ category = "Hideouts", data = { min = 5, max = 120 } }
)
ix.config.Add(
	"hideoutCheckpoint",
	30,
	"Seconds between hideout placement checkpoints.",
	nil,
	{ category = "Hideouts", data = { min = 5, max = 300 } }
)

PLUGIN.instances = PLUGIN.instances or {}
PLUGIN.members = PLUGIN.members or {}
PLUGIN.allowedShellClasses = {
	prop_physics = true,
	prop_physics_multiplayer = true,
	prop_dynamic = true,
	prop_dynamic_override = true,
}

ix.util.Include("sv_repository.lua")
ix.util.Include("sv_instances.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("cl_plugin.lua")
