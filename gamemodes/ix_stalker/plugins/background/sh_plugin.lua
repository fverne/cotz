local PLUGIN = PLUGIN

PLUGIN.name = "Backgrounds"
PLUGIN.author = "some faggot"
PLUGIN.description = "Lets you add a background to a character, instilling special properties in them."

ix.backgrounds = ix.backgrounds or {}

ix.util.Include("sh_definitions.lua")

-- Will run all the characters background OnCreated functions
function PLUGIN:OnCharacterCreated(client, character)
	local backgrounds = character:GetBackgrounds()
	if (backgrounds != nil) then
		for background, _ in pairs(backgrounds) do
			local bck = ix.backgrounds[background]
			if (bck) then
				local func = bck.OnCreated or (function(client, char) return true end)
				func(client, character)
			end
		end
	end
end

if (SERVER) then
	-- Will run all the characters backgrounds OnLoaded functions
	function PLUGIN:CharacterLoaded(character)
		local backgrounds = character:GetBackgrounds()

		if (backgrounds != nil) then
			for background, _ in pairs(backgrounds) do
				local bck = ix.backgrounds[background]
				if (bck) then
					local func = bck.OnLoaded or (function(char) return true end)
					func(character)
				end
			end
		end
	end
end

ix.char.RegisterVar("backgrounds", {
	field = "backgrounds",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = false,
	OnValidate = function(self, value, payload)
		if (!ix.backgrounds[value]) then
			return false, "invalid", "background"
		end

		return value
	end,
	OnDisplay = function(self, container, payload)
		local panel = container:Add("DPanel")
		local combo = panel:Add("DComboBox")
		combo:Dock(TOP) -- TODO: don't fill so we can allow other panels
		combo.Paint = function(panel, width, height)
			derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, Color(255, 255, 255, 25))
		end

		local label = panel:Add("DLabel")
		label:Dock(TOP)
		label:SetText("")
		label:SizeToContents()
		label:SetContentAlignment(7)
		label:SetFont("stalkerregularfont")

		for bkid, bkstruct in SortedPairs(ix.backgrounds) do
			combo:AddChoice(bkstruct.name, bkid)
		end

		combo.OnSelect = function( self, index, value )
			local dat = self:GetOptionData(index)

			if (ix.backgrounds[dat]) then
				payload:Set("background", dat)
				label:SetText(ix.backgrounds[dat].description)
			end
		end

		return panel
	end,
})

local CHAR = ix.meta.character or {}

-- Helper to add background
function CHAR:AddBackground(background)
	local data = self:GetBackgrounds() or {}
	data[background] = true
	self:SetBackgrounds(data)

end

-- Helper to remove background
function CHAR:RemoveBackground(background)
	local data = self:GetBackgrounds() or {}
	data[background] = nil
	self:SetBackgrounds(data)
end

