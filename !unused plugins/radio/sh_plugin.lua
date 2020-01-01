PLUGIN.name = "Radio"
PLUGIN.author = "ZeMysticalTaco"
PLUGIN.description = "Grs4s style radios."
local RADIO_CHATCOLOR = Color(100, 255, 50)
-- This is how initialize Language in Single File.
local langkey = "english"

local langTable = {
	radioFreq = "Frequency",
	radioSubmit = "Submit",
	radioNoRadio = "You don't have any radio to adjust.",
	radioNoRadioComm = "You don't have any radio to communicate",
	radioFormat = "%s radios in on %s \"%s\""
}

function PLUGIN:PluginLoaded()
	table.Merge(ix.lang.stored[langkey], langTable)
end

ix.chat.Register("radio", {
	format = "%s radios in on %s: \"%s\"",
	--font = "nutRadioFont",
	OnGetColor = function(self, speaker, text)
		return RADIO_CHATCOLOR
	end,
	OnCanHear = function(self, speaker, listener)
		local listenerInv = listener:GetInventory()
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = listener:GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq
		local dist = speaker:GetPos():Distance(listener:GetPos())
		local speakRange = ix.config.Get("chatRange", 280)

		if (dist <= speakRange) then
			return true
		end

		--[[--printTable(listenFreq)
		--print(curFreq)

		if table.HasValue(listenFreq, curFreq) then
			--return true if the listener frequency table has the value the speaker is radioing on
			return true
		end

		return false--]]
		return false
	end,
	CanSay = function(self, speaker, text)
		local char = speaker:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()

		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return
		end

		for k, v in pairs(items) do
			if speaker:GetNetVar("curfreq") == v:GetData("freq") and v:GetData("power", false) == false then
				speaker:Notify("Your primary radio is currently off!")

				return false
			end

			if v.isRadio and v:GetData("power", false) == true then
				speaker:EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)

				return true
			end
		end

		return false
	end,
	OnChatAdd = function(self, speaker, text)
		local schar = speaker:GetCharacter()
		local freq
		----print(speaker:GetNetVar("lastfreq"))
		--speaker.freq = speaker:GetNetVar("lastfreq")
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = LocalPlayer():GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq

		--printTable(listenFreq)
		--print(curFreq)
		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return
		end

		if table.HasValue(listenFreq, curFreq) then
			if speaker:GetNetVar("curfreq") == LocalPlayer():GetNetVar("curfreq") then
				RADIO_CHATCOLOR = Color(200, 255, 50)
				chat.AddText(RADIO_CHATCOLOR, speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)

				if speaker ~= LocalPlayer() then
					LocalPlayer():EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)
				end
			else
				RADIO_CHATCOLOR = Color(100, 255, 50)
				chat.AddText(RADIO_CHATCOLOR, speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)

				if speaker ~= LocalPlayer() then
					LocalPlayer():EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)
				end
			end
			--return true if the listener frequency table has the value the speaker is radioing on
		else
			local dist = speaker:GetPos():Distance(LocalPlayer():GetPos())
			local speakRange = ix.config.Get("chatRange", 280)

			if (dist <= speakRange) then
				chat.AddText(Color(175, 255, 150), speaker:Name() .. " uses their radio to say: " .. text)
			end
		end
	end,
	prefix = {"/r", "/radio"}
})

--Normal radio functions, main shit goes here, be sure to change command and ooc when you do do stuff
ix.chat.Register("radiocommand", {
	format = "%s radios in on %s: \"%s\"",
	--font = "nutRadioFont",
	OnGetColor = function(self, speaker, text)
		return RADIO_CHATCOLOR
	end,
	OnCanHear = function(self, speaker, listener)
		local listenerInv = listener:GetInventory()
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = listener:GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq
		local dist = speaker:GetPos():Distance(listener:GetPos())
		local speakRange = ix.config.Get("chatRange", 280)

		if (dist <= speakRange) then
			return true
		end

		--[[--printTable(listenFreq)
		--print(curFreq)

		if table.HasValue(listenFreq, curFreq) then
			--return true if the listener frequency table has the value the speaker is radioing on
			return true
		end

		return false--]]
		return false
	end,
	CanSay = function(self, speaker, text)
		local char = speaker:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()

		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return
		end

		for k, v in pairs(items) do
			if speaker:GetNetVar("curfreq") == v:GetData("freq") and v:GetData("power", false) == false then
				speaker:Notify("Your primary radio is currently off!")

				return false
			end

			if v.isRadio and v:GetData("power", false) == true then
				speaker:EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)

				return true
			end
		end

		return false
	end,
	OnChatAdd = function(self, speaker, text)
		local schar = speaker:GetCharacter()
		local freq
		----print(speaker:GetNetVar("lastfreq"))
		--speaker.freq = speaker:GetNetVar("lastfreq")
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = LocalPlayer():GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq

		--printTable(listenFreq)
		--print(curFreq)
		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return
		end

		if table.HasValue(listenFreq, curFreq) then
			if speaker:GetNetVar("curfreq") == LocalPlayer():GetNetVar("curfreq") then
				RADIO_CHATCOLOR = Color(220, 0, 0, 255)
				chat.AddText(RADIO_CHATCOLOR, speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)

				if speaker ~= LocalPlayer() then
					LocalPlayer():EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)
				end
			else
				RADIO_CHATCOLOR = Color(170, 0, 0, 255)
				chat.AddText(RADIO_CHATCOLOR, speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)

				if speaker ~= LocalPlayer() then
					LocalPlayer():EmitSound("stalkersound/contact_" .. math.random(2, 7) .. ".wav", 50, 100)
				end
			end
			--return true if the listener frequency table has the value the speaker is radioing on
		else
			local dist = speaker:GetPos():Distance(LocalPlayer():GetPos())
			local speakRange = ix.config.Get("chatRange", 280)

			if (dist <= speakRange) then
				chat.AddText(Color(175, 255, 150), speaker:Name() .. " uses their radio to say: " .. text)
			end
		end
	end,
	prefix = {"/rc", "/radioc"}
})

ix.chat.Register("radiooc", {
	format = "%s radios in on %s: \"%s\"",
	--font = "nutRadioFont",
	OnGetColor = function(self, speaker, text)
		return RADIO_CHATCOLOR
	end,
	OnCanHear = function(self, speaker, listener)
		local listenerInv = listener:GetInventory()
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = listener:GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq
		local dist = speaker:GetPos():Distance(listener:GetPos())
		local speakRange = ix.config.Get("chatRange", 280)

		if (dist <= speakRange) then
			return true
		end

		--[[--printTable(listenFreq)
		--print(curFreq)

		if table.HasValue(listenFreq, curFreq) then
			--return true if the listener frequency table has the value the speaker is radioing on
			return true
		end

		return false--]]
		return false
	end,
	CanSay = function(self, speaker, text)
		local char = speaker:GetCharacter()
		local inv = char:GetInventory()
		local items = inv:GetItems()

		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return false
		end

		for k, v in pairs(items) do
			if speaker:GetNetVar("curfreq") == v:GetData("freq") and v:GetData("power", false) == false then
				speaker:Notify("Your primary radio is currently off!")

				return false
			end

			if v.isRadio and v:GetData("power", false) == true then
				return true
			end
		end

		return false
	end,
	OnChatAdd = function(self, speaker, text)
		local schar = speaker:GetCharacter()
		local freq
		----print(speaker:GetNetVar("lastfreq"))
		--speaker.freq = speaker:GetNetVar("lastfreq")
		local curFreq = speaker:GetNetVar("curfreq", "none") --curfreq is a value assigned to the speaker, who is currently using the radio, which will radio to their assigned frequency.
		local listenFreq = LocalPlayer():GetNetVar("freq", {"nope"}) -- two separate values as the default to ensure people can't blind freq

		--printTable(listenFreq)
		--print(curFreq)
		if table.Count(speaker:GetNetVar("freq", {})) < 1 then
			return
		end

		if table.HasValue(listenFreq, curFreq) then
			if speaker:GetNetVar("curfreq") == LocalPlayer():GetNetVar("curfreq") then
				RADIO_CHATCOLOR = Color(0, 196, 255)
				chat.AddText(RADIO_CHATCOLOR, "[OOC] " .. speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)
			else
				RADIO_CHATCOLOR = Color(0, 146, 200)
				chat.AddText(RADIO_CHATCOLOR, "[OOC] " .. speaker:Name() .. " radios in on *" .. speaker:GetNetVar("curfreq") .. "*: " .. text)
			end
			--return true if the listener frequency table has the value the speaker is radioing on
		else
			local dist = speaker:GetPos():Distance(LocalPlayer():GetPos())
			local speakRange = ix.config.Get("chatRange", 280)

			if (dist <= speakRange) then
				chat.AddText(Color(175, 255, 150), speaker:Name() .. " uses their radio to say: " .. text)
			end
		end
	end,
	prefix = {"/rad", "/oocradio"}
})

function PLUGIN:CharacterLoaded(char)
	if SERVER then
		if char:GetData("curfreq", false) then
			char:GetPlayer():SetNetVar("curfreq", char:GetData("curfreq", {}))
		else
			char:GetPlayer():SetNetVar("curfreq", nil)
		end

		if char:GetFaction() == FACTION_MPF or char:GetFaction() == FACTION_OTA then
			local data = char:GetData("freq", {})

			if not table.HasValue(data, "cp main") then
				table.insert(data, "cp main")
				table.insert(data, "cp tactical")
				char:SetData("freq", data)
				char:GetPlayer():SetNetVar("freq", data)
			end
		end

		if char:GetData("freq", false) then
			char:GetPlayer():SetNetVar("freq", char:GetData("freq", {}))
		else
			char:GetPlayer():SetNetVar("freq", nil)
		end
	end
end

ix.command.Add("SetPrimaryFrequency", {
	description = "Set your primary frequency. USE QUOTES.",
	arguments = ix.type.string,
	OnRun = function(self, client, frequency)
		local data = client:GetCharacter():GetData("freq", false)

		if data then
			if table.HasValue(data, frequency) then
				client:SetNetVar("curfreq", frequency)
				client:GetCharacter():SetData("curfreq", frequency)
				client:Notify("You have set your frequency to " .. frequency .. ".")
			else
				client:Notify("You do not have that frequency!")
			end
		else
			client:Notify("You do not have any valid frequencies!")
		end
	end
})

ix.command.Add("ToggleFrequency", {
	description = "Toggle a frequency for a player, use quotes if you have spaces.",
	arguments = {ix.type.character, ix.type.string},
	adminOnly = true,
	OnRun = function(self, client, target, frequency)
		local data = target:GetData("freq", {})

		if data then
			if table.HasValue(data, frequency) then
				table.RemoveByValue(data, frequency)
				target:SetData("freq", data)
				target:GetPlayer():SetNetVar("freq", data)

				if target:GetData("curfreq", {}) == frequency then
					target:SetData("curfreq", nil)
					target:GetPlayer():SetNetVar("curfreq", nil)
				end

				client:Notify("You have given " .. target:GetName() .. " access to " .. frequency .. ".")
				target:GetPlayer()
				Notify(client:Name() .. " has given you access to " .. frequency .. ".")
			else
				table.insert(data, frequency)
				target:SetData("freq", data)
				target:GetPlayer():SetNetVar("freq", data)
				client:Notify("You have taken " .. target:GetName() .. "'s access to " .. frequency .. ".")
				target:GetPlayer():Notify(client:Name() .. " has taken your access to " .. frequency .. ".")
			end
		end
	end
})

function Schema:CreateCharacterInfo(panel)
	if LocalPlayer():GetNetVar("freq", false) then
		panel.freq = panel:Add("ixListRow")
		panel.freq:SetList(panel.list)
		panel.freq:Dock(TOP)
		panel.freq:DockMargin(0, 0, 0, 8)
	end
end

function Schema:UpdateCharacterInfo(panel)
	if LocalPlayer():GetNetVar("freq", false) then
		local data = LocalPlayer():GetNetVar("freq", {})
		panel.freq:SetLabelText("Frequencies")
		panel.freq:SetText(table.concat(data, ", "))
		panel.freq:SizeToContents()
	end
end

function PLUGIN:HUDPaint()
	local scrw = ScrW()

	if LocalPlayer():GetNetVar("freq", false) then
		draw.SimpleText("Frequencies: " .. table.concat(LocalPlayer():GetNetVar("freq", {}), ", "), "BudgetLabel", scrw - 50, 0, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
		draw.SimpleText("Current Frequency: " .. LocalPlayer():GetNetVar("curfreq", "no frequency"), "BudgetLabel", scrw - 50, 12, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
	end
end