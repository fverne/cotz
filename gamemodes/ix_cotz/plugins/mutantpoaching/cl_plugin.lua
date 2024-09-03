if (CLIENT) then
	netstream.Hook("mutantPoachOpen", function(client, entity, tool)
		netstream.Start("doPoach", tool, entity) --Don't look at me! I'm hideous! - El Diablo
	end)
else

end
