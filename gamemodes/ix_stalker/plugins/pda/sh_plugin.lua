PLUGIN.name = "PDA chatting system"
PLUGIN.author = "verne"
PLUGIN.description = "PDA chatting system, supporting avatars and nicknames"

--removal of helix chats we dont use
function PLUGIN:InitializedChatClasses()
	ix.chat.classes["ooc"] = nil
	ix.chat.classes["pm"] = nil
end

-- Overwrites defualt PM Command
function PLUGIN:InitializedPlugins()
	ix.command.list["pm"] = nil
end

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
	format = "[PMPDA] %s %s -> %s %s: %s",
	color = Color(0, 191, 255, 255),
	deadCanChat = true,

	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(self.color, "[PPDA-"..speaker:GetCharacter():GetData("pdanickname", speaker:GetCharacter():GetName()).."] ", " ", Material(speaker:GetCharacter():GetPdaavatar()), color_white, " TO  ", self.color, "[PPDA-"..data.target:GetCharacter():GetData("pdanickname", data.target:GetCharacter():GetName()).." ] ", " ", Material(data.target:GetCharacter():GetPdaavatar()), color_white, "\nMESSAGE : ", text)

		surface.PlaySound("stalkersound/pda/pda.wav")
	end
})

ix.command.Add("pmpda", {
	description = "@cmdPM",
	arguments = {
		ix.type.player,
		ix.type.text
	},
	alias = {"PM", "ppda"},
	OnRun = function(self, client, target, message)
		if ((client.ixNextPM or 0) < CurTime()) then
			ix.chat.Send(client, "pm", message, false, {client, target}, {target = target})

			client.ixNextPM = CurTime() + 0.5
			target.ixLastPM = client
		end
	end
})

ix.char.RegisterVar("pdaavatar", {
	field = "pdaavatar",
	fieldType = ix.type.string,
	default = "vgui/icons/face_31.png",
	bNoDisplay = true,
})
