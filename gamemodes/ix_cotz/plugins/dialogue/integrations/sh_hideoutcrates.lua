ix.dialogue = ix.dialogue or {}

function ix.dialogue.ConfigureHideoutCrates(dialogue, contact)
	local responses = {
		ballast = "Bring the fittings and packing materials. I'll put a storage crate together for you. The list shows what each one needs.",
		cleaner = "Choose the container you're arranging. The materials and assembly charge are listed together. Bring what the list says; an explanation of what's missing won't close a crate.",
		ledger = "Personal or squad storage? Pick the crate and check the materials. I'll show you the assembly charge before you agree to it.",
	}
	if not responses[contact.id] then return end
	dialogue.addTopic("HideoutBarter", {
		statement = "Can you assemble storage crates?",
		response = responses[contact.id],
		ShouldAdd = function()
			local plugin = ix.plugin.Get("hideouts")

			return plugin and type(plugin.GetCrateRecipe) == "function" and game.GetMap() == contact.map
		end,
		options = {"BackTopic"},
		preCallback = function(_, client, target)
			if SERVER then
				local plugin = ix.plugin.Get("hideouts")
				if plugin then plugin:OpenCrateBarter(client, target) end
			end
		end,
	})
	for _, id in ipairs({"GREETING", "BackTopic"}) do
		local root = dialogue.tree[id]
		if root and root.options then
			local present = false
			for _, option in ipairs(root.options) do
				if option == "HideoutBarter" then present = true break end
			end
			if not present then root.options[#root.options + 1] = "HideoutBarter" end
		end
	end
end
