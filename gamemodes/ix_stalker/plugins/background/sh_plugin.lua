local PLUGIN = PLUGIN

PLUGIN.name = "Backgrounds"
PLUGIN.author = "some faggot"
PLUGIN.description = "Lets you add a background to a character, instilling special properties in them."

ix.backgrounds = ix.backgrounds or {}

ix.util.Include("sh_definitions.lua")

function PLUGIN:OnCharacterCreated(client, character)
	if (false) then
		--ix.backgrounds[client:GetBackground()]:OnCreated(client, character)
	end
end

function PLUGIN:CharacterLoaded(char)
	if SERVER then
		if (false) then
			--ix.backgrounds[client:GetBackground()]:OnLoaded(char)
		end
	end
end

--[[
registervar background here? should a player be able to have multiple backgrounds? if so, how do we store it
]]--