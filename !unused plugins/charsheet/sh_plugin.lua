local PLUGIN = PLUGIN
PLUGIN.name = "Enhanced Description"
PLUGIN.author = "Subleader"
PLUGIN.desc = "Another description with more capacity."
DESCRIPTIONLIMIT = 2000

if (CLIENT) then
	netstream.Hook("ixReceiveDescription", function(client, contents, url, sheetdata, isadmin)
		local description = vgui.Create("ixDescriptionEn")
		local character = client:GetCharacter()
		local content = character:GetData("sheetPhysDesc", contents)
		local url = character:GetData("UrlDesc", url)

		description:buildSheet(client, isadmin)
		description:setText(content, url)
	end)
	
	netstream.Hook("ixReceiveViewDescription", function(target, contents, url, playerdata, isadmin)
		local description = vgui.Create("ixDescriptionEnView")
		local character = target:GetCharacter()
		local content = character:GetData("sheetPhysDesc", contents)
		local url = character:GetData("UrlDesc", url)

		description:buildSheet(target, isadmin, playerdata)
		description:setText(content, url)
	end)
else	
	netstream.Hook("ixDescriptionSendText", function(client, contents, url, sheetdata)
		local character = client:GetCharacter()
		character:SetData("sheetDesc", contents)
		character:SetData("UrlDesc", url)
		character:SetData("charsheetinfo", sheetdata)
	end)

	netstream.Hook("ixDescriptionTargetSendText", function(client, target, sheet)
		local character = target:GetCharacter()

		character:SetData("charsheetinfo", sheet)
	end)
end

function PLUGIN:PlayerUse(client, entity)
	if (entity:IsPlayer()) then
	local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + (client:GetAimVector() * 400)
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer()) then
			client:ConCommand( "say /viewdesc" )
		end
	end
end


function PLUGIN:OnCharacterCreated(client, character)
	local charsheetinfo = character:GetData("charsheetinfo", nil) or {}
	charsheetinfo["Full Name"] = {left = "Full Name", right = character:GetData("sheetFullName", nil) or character:GetName(), nonadmin = false}
	charsheetinfo["Nickname"] = {left = "Nickname", right = character:GetData("sheetFullName", nil) or "None", nonadmin = true}
	charsheetinfo["Age"] = {left = "Age", right = character:GetData("sheetAge", nil) or "Fill me.", nonadmin = false}
	charsheetinfo["Race"] = {left = "Race", right = character:GetData("sheetRace", nil) or "Fill me.", nonadmin = false}
	charsheetinfo["Nationality"] = {left = "Nationality", right = character:GetData("sheetNationality", nil) or "Fill me.", nonadmin = false}
	charsheetinfo["Physical Description"] = {left = "Physical Description", right = character:GetData("sheetPhysDesc", nil) or "Fill me.", nonadmin = true}
	charsheetinfo["Psychological Description"] = {left = "Psychological Description", right = character:GetData("sheetPsychDesc", nil) or "Fill me.", nonadmin = true}
	charsheetinfo["Backstory"] = {left = "Backstory", right = character:GetData("sheetBackstory", nil) or "Fill me.", nonadmin = true}
	charsheetinfo["Injuries"] = {left = "Injuries", right = character:GetData("sheetInjuries", nil) or "None.", nonadmin = false}

	character:SetData("charsheetinfo", charsheetinfo)
end

do
	local COMMAND = {}
	COMMAND.description = "Edit your own description"
	COMMAND.adminOnly = false

	function COMMAND:OnRun(client)
			if (IsValid(client)) then
			local character = client:GetCharacter()
				netstream.Start(client, "ixReceiveDescription",client, character:GetData("sheetPhysDesc", contents), character:GetData("UrlDesc", url), character:GetData("charsheetinfo", nil), client:IsAdmin())
			else
				return "Not a valid player"
			end
	end

	ix.command.Add("Selfdesc", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "See the description of the person you are looking at"
	COMMAND.adminOnly = false

	function COMMAND:OnRun(client)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + (client:GetAimVector() * 400)
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer()) then
			local character = target:GetCharacter()
				local playerdata = {}
				playerdata.repname = target:getCurrentRankName()
				playerdata.charsheetinfo = character:GetData("charsheetinfo", nil)
				playerdata.attributes = {}
				playerdata.perks = {}

				for k, v in pairs(ix.attributes.list) do
					playerdata.attributes[k] = target:GetCharacter():GetAttribute(k, 0)
				end

				for k, v in pairs(ix.perks.list) do
					playerdata.perks[k] = target:GetCharacter():GetPerk(k, 0)
				end


				netstream.Start(client, "ixReceiveViewDescription", target, character:GetData("sheetPhysDesc", contents), character:GetData("UrlDesc", url), playerdata, client:IsAdmin())
			else
				return "Not a valid player"
			end
	end

	ix.command.Add("Viewdesc", COMMAND)
end

ix.char.RegisterVar("age", {
	field = "age",
	fieldType = ix.type.text,
	category = "charsheet",
	default = "",
	index = 6,
	OnValidate = function(self, value, payload)
		value = tonumber(string.Trim((tostring(value):gsub("\r\n", ""):gsub("\n", ""))))

		if !isnumber(value) then
			return false, "Age is not a number"
		end

		local minLength = 15
		local maxLength = 99

		if (value < minLength) then
			return false, "You can't be below the age of 15.", minLength
		elseif (value > maxLength) then
			return false, "You can't be above the age of 99.", maxLength
		end

		return value
	end,
	OnPostSetup = function(self, panel, payload)
		panel:SetMultiline(true)
		panel:SetFont("ixMenuButtonFont")
		panel:SetTall(panel:GetTall() * 1 + 6) -- add another line
		panel.AllowInput = function(_, character)
			if (character == "\n" or character == "\r") then
				return true
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.data.sheetAge = value
	end,
	ShouldDisplay = function(self, container, payload)
		return true --!table.IsEmpty(ix.perks.list)
	end
})

ix.char.RegisterVar("race", {
	field = "race",
	fieldType = ix.type.text,
	category = "charsheet",
	default = "Caucasian",
	index = 7,
	OnValidate = function(self, value, payload)
		value = string.Trim((tostring(value):gsub("\r\n", ""):gsub("\n", "")))
		
		local minLength = 4
		local maxLength = 30

		if (#value < minLength) then
			return false, "Invalid Race", minLength
		elseif (!value:find("%S")) then
			return false, "invalid", "race"
		elseif (#value:gsub("%s", "") > maxLength) then
			return false, "Invalid Race", maxLength
		end

		return value
	end,
	OnPostSetup = function(self, panel, payload)
		panel:SetMultiline(true)
		panel:SetFont("ixMenuButtonFont")
		panel:SetTall(panel:GetTall() * 1 + 6) -- add another line
		panel.AllowInput = function(_, character)
			if (character == "\n" or character == "\r") then
				return true
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.data.sheetRace = value
	end,
	ShouldDisplay = function(self, container, payload)
		return true --!table.IsEmpty(ix.perks.list)
	end
})

ix.char.RegisterVar("nationality", {
	field = "nationality",
	fieldType = ix.type.text,
	category = "charsheet",
	default = "Ukranian",
	index = 8,
	OnValidate = function(self, value, payload)
		value = string.Trim((tostring(value):gsub("\r\n", ""):gsub("\n", "")))
		
		local minLength = 1
		local maxLength = 30

		if (#value < minLength) then
			return false, "Invalid Nationality", minLength
		elseif (!value:find("%S")) then
			return false, "invalid", "nationality"
		elseif (#value:gsub("%s", "") > maxLength) then
			return false, "Invalid Nationality", maxLength
		end

		return value
	end,
	OnPostSetup = function(self, panel, payload)
		panel:SetMultiline(true)
		panel:SetFont("ixMenuButtonFont")
		panel:SetTall(panel:GetTall() * 1 + 6) -- add another line
		panel.AllowInput = function(_, character)
			if (character == "\n" or character == "\r") then
				return true
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.data.sheetNationality = value
	end,
	ShouldDisplay = function(self, container, payload)
		return true --!table.IsEmpty(ix.perks.list)
	end
})

ix.char.RegisterVar("backstory", {
	field = "backstory",
	fieldType = ix.type.text,
	category = "charsheet",
	default = "Backstory",
	index = 9,
	OnValidate = function(self, value, payload)
		value = string.Trim((tostring(value):gsub("\r\n", ""):gsub("\n", "")))
		
		local minLength = 0
		local maxLength = 2000

		if (#value < minLength) then
			return false, "Invalid Backstory", minLength
		elseif (!value:find("%S")) then
			return false, "invalid", "name"
		elseif (#value:gsub("%s", "") > maxLength) then
			return false, "Invalid Backstory (Cant be more than 2000 characters)", maxLength
		end

		return value
	end,
	OnPostSetup = function(self, panel, payload)
		panel:SetMultiline(true)
		panel:SetFont("ixMenuButtonFont")
		panel:SetTall(panel:GetTall() * 6 + 6) -- add another line
		panel.AllowInput = function(_, character)
			if (character == "\n" or character == "\r") then
				return true
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.data.sheetBackstory = value
	end,
	ShouldDisplay = function(self, container, payload)
		return true --!table.IsEmpty(ix.perks.list)
	end
})