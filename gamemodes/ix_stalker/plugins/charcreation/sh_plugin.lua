local PLUGIN = PLUGIN
PLUGIN.name = "STALKER Character Creation"
PLUGIN.author = "verne"
PLUGIN.desc = "New Character Creation"


ix.util.Include("sh_defs.lua")


PLUGIN.currentEvents = {} --To keep track of and update running events


function PLUGIN:GetFirstNameBySteamID(client)
	local steamid = client:AccountID()
	local firstname

	firstname = #self.stalkernames % steamid

	return self.stalkernames[firstname]
end

function PLUGIN:GetLastNameBySteamID(client)
	local steamid = client:AccountID()
	local lastname

	lastname = #self.stalkersnames % steamid
	
	return self.stalkersnames[lastname]
end

function PLUGIN:GetDefaultCharacterName(client)
	local firstname = self:GetFirstNameBySteamID(client)
	local lastname = self:GetLastNameBySteamID(client)

	return firstname.." "..lastname
end

do
	ix.char.RegisterVar("name", {
		field = "name",
		fieldType = ix.type.string,
		default = "lutz",
		index = 1,
		OnValidate = function(self, value, payload, client)
			value = tostring(value):gsub("\r\n", ""):gsub("\n", "")
			value = string.Trim(value)

			local minLength = ix.config.Get("minNameLength", 4)
			local maxLength = ix.config.Get("maxNameLength", 32)

			if (value:utf8len() < minLength) then
				return false, "nameMinLen", minLength
			elseif (!value:find("%S")) then
				return false, "invalid", "name"
			elseif (value:gsub("%s", ""):utf8len() > maxLength) then
				return false, "nameMaxLen", maxLength
			end

			return hook.Run("GetDefaultCharacterName", client, payload.faction) or value:utf8sub(1, 70)
		end,
		OnPostSetup = function(self, panel, payload)
			local faction = ix.faction.indices[payload.faction]
			local name, disabled = hook.Run("GetDefaultCharacterName", LocalPlayer(), payload.faction), true

			if (name) then
				panel:SetText(name)
				payload:Set("name", name)
			end

			if (disabled) then
				panel:SetDisabled(true)
				panel:SetEditable(false)
			end

			panel:SetBackgroundColor(faction.color or Color(255, 255, 255, 25))
		end
	})
end