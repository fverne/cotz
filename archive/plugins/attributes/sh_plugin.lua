local PLUGIN = PLUGIN
PLUGIN.name = "Rollable Stats"
PLUGIN.author = "Verne"
PLUGIN.desc = "Stats used for rolling in various situations."

function PLUGIN:CharacterAttributeUpdated(client, self, key)
	local character = client:GetCharacter()

	if key == "endurance" then
		character:SetAttrib("healthpoints", 8 + math.floor(tonumber(character:GetAttribute("endurance")/10)))
	end

	if key == "agility" then
		character:SetAttrib("movement", math.floor(tonumber(character:GetAttribute("agility")/10)))
		character:SetAttrib("initiative", math.floor(tonumber(character:GetAttribute("agility")/10)))
	end
end

function PLUGIN:CharacterAttributeBoosted(client, self, key)
	local character = client:GetCharacter()
	local totalboost = 0

	if key == "endurance" then
		character:SetAttrib("healthpoints", 8 + math.floor(tonumber(character:GetAttribute("endurance")/10)))
	end

	if key == "agility" then
		local agi = character:GetAttribute("agility", 0)

		if character:GetBoost("agility") then
			for k, v in pairs(character:GetBoost("agility")) do
				totalboost = v + totalboost
			end
		end

		character:RemoveBoost("agiderivativeboost", "movement")
		character:RemoveBoost("agiderivativeboost2", "initiative")

		character:AddBoost("agiderivativeboost", "movement", math.floor(totalboost)/10)
		character:AddBoost("agiderivativeboost2", "initiative", math.floor(totalboost)/10)
		
	end
end

function PLUGIN:OnCharacterCreated(client, character)
	character:SetAttrib("healthpoints", 8 + math.floor(tonumber(character:GetAttribute("endurance")/10)))
	character:SetAttrib("movement", math.floor(tonumber(character:GetAttribute("agility")/10)))
	character:SetAttrib("initiative", math.floor(tonumber(character:GetAttribute("agility")/10)))
end

ix.command.Add("rollstat", {
	description = "Tests the given attribute against a roll of 100.",
	arguments = {
		ix.type.string,
		ix.type.string,
		ix.type.text
	},
	OnRun = function(self, client, stat, modifier, description)
		local character = client:GetCharacter()
		local modsign
		local perkmodifier
		local parentstat
		local parentstattranslated
		local str = "tested his "
		local realattriname
		local perksign = nil
		local stat = string.lower(stat)
		
		for k, v in pairs(ix.perks.list) do
			if v.shortname == stat or v.name == stat or k == stat then
				if client:GetCharacter():GetPerk(k, 0) == 0 then
					perkmodifier = -20
					perksign = ""
				elseif client:GetCharacter():GetPerk(k, 0) == 1 then
					perkmodifier = 0
					perksign = ""
				elseif client:GetCharacter():GetPerk(k, 0) == 2 then
					perkmodifier = 10
					perksign = "+"
				elseif client:GetCharacter():GetPerk(k, 0) == 3 then
					perkmodifier = 20
					perksign = "+"
				elseif client:GetCharacter():GetPerk(k, 0) == 4 then
					perkmodifier = 30
					perksign = "+"
				elseif client:GetCharacter():GetPerk(k, 0) == 5 then
					perkmodifier = 40
					perksign = "+"
				end
				
				if v.name != nil then
					internalattriname = v.parent
					str = str..(v.shortname).." "..character:GetAttribute(internalattriname)
					realattriname = v.name
				end
			end
		end

		for k, v in pairs(ix.attributes.list) do
			if v.shortname == stat or v.name == stat or k == stat then
				if v.name != nil then
					internalattriname = k
					str = str..(v.shortname).." "..character:GetAttribute(internalattriname, 0)
					realattriname = v.name
				end
			end
		end

		if realattriname == nil then
			client:Notify("You typed in an invalid perk/attribute!")
			return false
		end

		if string.len(modifier) != 0 then
			if string.sub(modifier, 1, 1) == "+" then
				modifier = string.sub(modifier, 2)
				modsign = "+"
			elseif string.sub(modifier, 1, 1) == "-" then
				modifier = string.sub(modifier, 2)
				modsign = "-"
			elseif modifier == "0" then
				modsign = ""
			else
				return client:Notify("Please include a + or - in front of your modifier.")
			end

			str = str.." (Difficulty: "..modsign..modifier..")"
		else
			modsign = ""
			modifier = ""
		end
		
		if perksign != nil then
			str = str.." (Perk: "..perksign..perkmodifier..")"
		end

		if (character and character:GetAttribute(internalattriname, 0)) then
			local statvalue = character:GetAttribute(internalattriname, 0)
			local roll = tostring(math.random(1, 100))
			local successrate = math.floor(math.abs(((modifier+statvalue+(perkmodifier or 0))-roll))/10)

			if modifier then
				str = str.." (You: "..statvalue+(modifier or 0)+(perkmodifier or 0).." vs System: "..roll..")"
			end

			if string.len(description) != 0 then
				str = str.." \""..description.."\""
			end

			if (modifier+statvalue+(perkmodifier or 0))-roll >=0 then
				str = str.." Success by "..successrate
			else
				str = str.." Failure by "..successrate
			end
		end

		ix.chat.Send(client, "rollstat", str, nil, nil)
	end
})


ix.command.Add("roll", {
	description = "Rolls the given dies with a modifier.",
	arguments = {
		ix.type.number,
		ix.type.number,
		ix.type.string,
		ix.type.text
	},
	OnRun = function(self, client, dies, sides, modifier, description)
		local character = client:GetCharacter()
		local modsign
		local perkmodifier
		local parentstat
		local parentstattranslated
		local str = "rolled "
		local realattriname
		local perksign = nil
		local roll = 0

		str = str..dies.."d"..sides

		for i = 1, dies do
			roll = roll + math.random(1, sides)
		end

		roll = roll + modifier

		if string.len(modifier) != 0 then
			if string.sub(modifier, 1, 1) == "+" then
				modifier = string.sub(modifier, 2)
				modsign = "+"
			elseif string.sub(modifier, 1, 1) == "-" then
				modifier = string.sub(modifier, 2)
				modsign = "-"
			elseif modifier == "0" then
				modsign = ""
			else
				return client:Notify("Please include a + or - in front of your modifier.")
			end

			str = str..modsign..modifier
		else
			modsign = ""
			modifier = ""
		end

		str = str.." totalling "..roll.."."

		if (character) then
			local statvalue = character:GetAttribute(internalattriname, 0)
			local roll = tostring(math.random(1, sides))
			local successrate = math.floor(math.abs(((modifier+statvalue+(perkmodifier or 0))-roll))/10)

			if string.len(description) != 0 then
				str = str.." \""..description.."\""
			end
		end

		ix.chat.Send(client, "rollstat", str, nil, nil)
	end
})


-- Roll information in chat.
ix.chat.Register("rollstat", {
	format = "** %s has %s",
	color = Color(155, 111, 176),
	CanHear = ix.config.Get("chatRange", 280),
	deadCanChat = true,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(self.color, string.format(self.format,
			speaker:GetName(), text
		))
	end
})


local charMeta = ix.meta.character

if (SERVER) then
	function charMeta:setRPGValues()
		local inventory = self:GetInventory()
		local total = 0
		if inventory then
			local items = self:GetInventory():GetItems(true)

			for k, v in pairs(items) do
				if v.ballisticrpglevels and v.ballisticrpglevels["head"] and v:GetData("equip") == true then
					total = total + v.ballisticrpglevels["head"]
				end
			end
			self:SetAttrib("armorpointshead", total)
			total = 0

			for k, v in pairs(items) do
				if v.ballisticrpglevels and v.ballisticrpglevels["body"] and v:GetData("equip") == true then
					total = total + v.ballisticrpglevels["body"]
				end
			end
			self:SetAttrib("armorpointsbody", total)
			total = 0

			for k, v in pairs(items) do
				if v.ballisticrpglevels and v.ballisticrpglevels["limb"] and v:GetData("equip") == true then
					total = total + v.ballisticrpglevels["limb"]
				end
			end
			self:SetAttrib("armorpointslimb", total)
			total = 0
		end
	end
end