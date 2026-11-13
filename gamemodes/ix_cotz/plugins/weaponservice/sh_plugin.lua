PLUGIN.name = "Weapon Workshop"
PLUGIN.author = "COTZ"
PLUGIN.description = "Model-specific weapon rebuilding and technician dismantling."

ix.util.Include("sh_catalogue.lua")
ix.util.Include("sh_service.lua")
ix.util.Include("sh_dialogue.lua")
ix.util.Include("sv_delivery.lua")
ix.util.Include("sv_transactions.lua")

function PLUGIN:InitializedPlugins()
	self:AuditCatalogue()
	for _, id in ipairs({"technpc", "unisgnpc2"}) do
		local dialogue = ix.dialogue and ix.dialogue.list[id]
		if dialogue then self:ConfigureDialogue(dialogue) end
	end
end
