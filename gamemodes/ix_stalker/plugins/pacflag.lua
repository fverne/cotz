local PLUGIN = PLUGIN

PLUGIN.name = "PAC3 Flag"
PLUGIN.author = "Luna"
PLUGIN.desc = "Adds a flag to PAC3."

function PLUGIN:PrePACConfigApply(client)
	if client:GetCharacter() then
		return client:GetCharacter():HasFlags("P")
	end
end

function PLUGIN:PrePACEditorOpen(client)
    if client:GetCharacter() then
		return client:GetCharacter():HasFlags("P")
	end
end

function PLUGIN:pac_CanWearParts(client)
	if client:GetCharacter() then
		return client:GetCharacter():HasFlags("P")
	end
end

ix.flag.Add("P", "Access to PAC3.")