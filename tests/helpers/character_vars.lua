-- Lightweight accessor registration for existing gameplay fixtures; persistence has its own real-API spec.
ix.char = ix.char or {vars = {}}
ix.char.vars = ix.char.vars or {}

function ix.char.RegisterVar(key, definition)
	ix.char.vars[key] = definition
	local suffix = key:sub(1, 1):upper() .. key:sub(2)
	ix.meta.character["Get" .. suffix] = definition.OnGet or function(character)
		character.vars = character.vars or {}

		return character.vars[key] or table.Copy(definition.default)
	end
	if SERVER then
		ix.meta.character["Set" .. suffix] = function(character, value)
			character.vars = character.vars or {}
			character.vars[key] = value

			if not definition.bNoNetworking and character.replications then
				character.replications = character.replications + 1
			end
		end
	else
		ix.meta.character["Set" .. suffix] = nil
	end
end
