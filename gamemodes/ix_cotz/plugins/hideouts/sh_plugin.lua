local PLUGIN = PLUGIN
PLUGIN.name = "Hideouts"
PLUGIN.author = "cotz"
PLUGIN.description = "Personal storage rooms and squad interiors loaded while occupied."

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

ix.util.Include("sh_definitions.lua")
ix.util.Include("sh_personal.lua")
ix.util.Include("sh_markers.lua")
ix.util.Include("sv_repository.lua")
ix.util.Include("sv_fts.lua")
ix.util.Include("sv_markers.lua")
ix.util.Include("sv_instances.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_ownership.lua")
ix.util.Include("sv_operations.lua")
ix.util.Include("sv_access.lua")
ix.util.Include("sv_containers.lua")
ix.util.Include("sv_trading.lua")
ix.util.Include("sh_building.lua")
ix.util.Include("sv_layout.lua")
ix.util.Include("sv_travel.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sh_management.lua")
ix.util.Include("sv_menus.lua")
ix.util.Include("sv_personal.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("cl_management.lua")
ix.util.Include("cl_markers.lua")
ix.util.Include("cl_personal.lua")
