ix.chat.Register("cotz_npc_say", {
	CanSay = function() return true end,
	OnChatAdd = function(_, _, text, _, data)
		chat.AddText(ix.config.Get("chatColor"), data.name .. " says, ", color_white, text)
	end,
	prefix = {},
})
