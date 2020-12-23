PLUGIN.name = "PDA chatting system"
PLUGIN.author = "verne"
PLUGIN.description = "PDA chatting system, supporting avatars and nicknames"

--removal of helix chats we dont use
hook.Add("InitializedChatClasses", "ixChatRemoval2", function()
	ix.chat.classes["ooc"] = nil
	ix.chat.classes["pm"] = nil

	ix.chat.Register("ooc", {
		CanSay = function(self, speaker, text)
			/*local pda = speaker:GetCharacter():GetData("pdaequipped", false)
			if pda then
				return true
			else 
				return false
			end*/
			return true
		end,
		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			chat.AddText(Color(0,191,255), "[GPDA-"..speaker:GetCharacter():GetData("pdanickname", speaker:GetCharacter():GetName()).."] ", Material(speaker:GetCharacter():GetPdaavatar()), color_white, ": "..text)
		end,
		prefix = {"//", "/OOC", "/gpda"},
		description = "Send a message over the Global PDA network",
		CanHear = function(self, speaker, listener)
			/*local pda = speaker:GetCharacter():GetData("pdaequipped", false)
			if pda then
				listener:EmitSound( "stalkersound/da-2_beep1.ogg", 90, 100, 1, CHAN_AUTO )
				return true
			else
				return false
			end*/
			listener:EmitSound( "stalkersound/da-2_beep1.ogg", 90, 100, 1, CHAN_AUTO )
			return true
		end,
	})

	ix.chat.Register("pm", {
	format = "[PM-PDA] %s -> %s: %s",
	color = Color(125, 150, 75, 255),
	deadCanChat = true,

	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(self.color, string.format(self.format, speaker:GetName(), data.target:GetName(), text))

		if (LocalPlayer() != speaker) then
			surface.PlaySound("stalkersound/pda/pda.wav")
		end
	end
})
end)

ix.char.RegisterVar("pdaavatar", {
	field = "pdaavatar",
	fieldType = ix.type.string,
	default = "vgui/icons/face_31.png",
	bNoDisplay = true,
})
