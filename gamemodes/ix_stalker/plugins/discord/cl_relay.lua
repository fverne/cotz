
net.Receive("DiscordRelay_MessageReceived", function(len)
	local username = net.ReadString()
	local message = net.ReadString()
	chat.AddText(COLOR_DISCORD, "[Discord] ", COLOR_USERNAME, username, COLOR_COLON, ": ", COLOR_MESSAGE, message)
end)

