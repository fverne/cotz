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
		format = "[PMPDA] %s %s -> %s %s: %s",
		color = Color(0, 191, 255, 255),
		deadCanChat = true,

		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			chat.AddText(self.color, "[PPDA-"..speaker:GetCharacter():GetData("pdanickname", speaker:GetCharacter():GetName()).."] ", " ", Material(speaker:GetCharacter():GetPdaavatar()), color_white, " TO  ", self.color, "[PPDA-"..data.target:GetCharacter():GetData("pdanickname", data.target:GetCharacter():GetName()).." ] ", " ", Material(data.target:GetCharacter():GetPdaavatar()), color_white, "\nMESSAGE : ", text)

			surface.PlaySound("stalkersound/pda/pda.wav")
		end
	})
end)

-- Overwrites defualt PM Command
function PLUGIN:InitializedPlugins()
	ix.command.list["pm"] = nil

	ix.command.Add("ppda", {
		description = "@cmdPM",
		arguments = {
			ix.type.player,
			ix.type.text
		},
		alias = {"PM", "pmpda"},
		OnRun = function(self, client, target, message)
			if ((client.ixNextPM or 0) < CurTime()) then
				ix.chat.Send(client, "pm", message, false, {client, target}, {target = target})

				client.ixNextPM = CurTime() + 0.5
				target.ixLastPM = client
			end
		end
	})
end

ix.char.RegisterVar("pdaavatar", {
	field = "pdaavatar",
	fieldType = ix.type.string,
	default = "vgui/icons/face_31.png",
	bNoDisplay = true,
})

-- NPC talker PDA
local icon = Material("vgui/icons/news.png")
ix.chat.Register("npcpdainternal", {
	CanSay = function(self, speaker, text)
		if speaker then
			speaker:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO ) 
		end 
		
		return true
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(Color(0,191,255), "[GPDA-"..data.name.."] ", Color(0,241,255), icon, ": "..data.message)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)

		return true
	end,
})

ix.command.Add("npcpda", {
	adminOnly = true,
	description = "Write a PDA message from an arbitrary name",
	arguments = {
			ix.type.string,
			ix.type.text
		},
	OnRun = function(self, client, npcname, message)
		
		ix.chat.Send(client, "npcpdainternal", message, nil, nil, {
			name = npcname,
			message = message
		})
	end
})