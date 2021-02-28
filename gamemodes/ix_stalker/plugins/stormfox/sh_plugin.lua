
PLUGIN.name = "Stormfox Compatibility"
PLUGIN.author = "verne"
PLUGIN.description = "Adds basic stormfox functionality for the server."

if (SERVER) then
	hook.Add("StormFox - PostEntityScan", "IXSF_STARTMAP", function()
		timer.Simple(5, function()
			StormFox.SetWeather("cloudy",0.9,1)
		end)
	end)

	hook.Add("StormFox - NewWeather", "IXSF_AVOIDCLOUDY", function(weather,old_weather)
		if weather == "clear" then
			print("ATTEMPTED TO SWITCH TO CLEAR WEATHER, RESETTING TO CLOUDY...")
			StormFox.SetWeather("cloudy",0.9,1)
		end
	end)
end