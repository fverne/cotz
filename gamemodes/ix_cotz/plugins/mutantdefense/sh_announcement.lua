local PLUGIN = PLUGIN

local NEWS_COLOR = Color(0, 191, 255)
local TEXT_COLOR = Color(224, 182, 104)
local NEWS_ICON = Material("vgui/icons/news.png")

function PLUGIN:InitializedChatClasses()
	ix.chat.Register("cotz/mutantdefense/announcement", {
		prefix = {},
		CanSay = function(_, speaker)
			return not IsValid(speaker)
		end,
		CanHear = function()
			return true
		end,
		OnChatAdd = function(_, _, text)
			chat.AddText(NEWS_COLOR, "[LPDA-SYSTEM] ", TEXT_COLOR, NEWS_ICON, ": " .. text)
			LocalPlayer():EmitSound("stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO)
		end,
	})
	ix.chat.Register("cotz/mutantdefense/driver", {
		prefix = {},
		CanSay = function(_, speaker) return not IsValid(speaker) end,
		CanHear = function() return true end,
		OnChatAdd = function(_, _, text)
			chat.AddText(TEXT_COLOR, "[Truck driver] ", color_white, text)
		end,
	})
end
