PLUGIN.name = "PDA chatting system"
PLUGIN.author = "verne"
PLUGIN.description = "PDA chatting system, supporting avatars and nicknames"

ix.chat.Register("gpda", {
	CanSay = function(self, speaker, text)
		local pda = speaker:GetCharacter():GetData("pdaequipped", false)
		if pda then
			return true
		else 
			return false
		end
		return true
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(Color(0,191,255), "[GPDA-"..data[1].."] ", Material(data[2]), color_white, ": "..text)
	end,
	--prefix = {"/gpda"},
	CanHear = function(self, speaker, listener)
		local pda = speaker:GetCharacter():GetData("pdaequipped", false)
		if pda then
			listener:EmitSound( "stalkersound/pda_news.wav", 50, 100, 1, CHAN_AUTO )
			return true
		else
			return false
		end
	end,
})

ix.command.Add("gpda", {
	description = "Sends a message on the global PDA network.",
	arguments = ix.type.text,
	OnRun = function(self, client, text)
		maximum = math.Clamp(maximum or 100, 0, 1000000)

		ix.chat.Send(client, "gpda", text, nil, nil, {
			client:GetCharacter():GetData("pdanickname") or client:GetCharacter():GetName(), client:GetCharacter():GetData("pdaavatar") or "vgui/icons/face_31.png"
		})
	end
})