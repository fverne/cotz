
PLUGIN.name = "Stormfox Compatibility"
PLUGIN.author = "verne"
PLUGIN.description = "Adds basic stormfox functionality for the server."

if not StormFox2 then return end

if (SERVER) then
	hook.Add("StormFox - NewWeather", "IXSF_AVOIDCLOUDY", function(weather,old_weather)
		if weather == "clear" then
			print("ATTEMPTED TO SWITCH TO CLEAR WEATHER, RESETTING TO CLOUDY...")
			StormFox.SetWeather("cloudy",0.9,1)
		end
	end)
end

hook.Add("StormFox.PostEntity", "IXSF_MODIFYCLOUDY", function()
	local Cloudy = StormFox.GetWeatherType( "cloudy" )
	Cloudy.TimeDependentData.Fogdensity = {
		TIME_SUNRISE = 0.9,
		TIME_SUNSET = 0.95
	}

	Cloudy.TimeDependentData.Fogstart = {
		TIME_SUNRISE = -1000,
		TIME_SUNSET = -1000
	}

	Cloudy.TimeDependentData.Fogend = {
		 TIME_SUNRISE = 50,
		 TIME_SUNSET = 50
	}

	Cloudy.CalculatedData.MapDayLight = 0
	Cloudy.CalculatedData.MapNightLight = -50
	Cloudy.CalculatedData.CloudsAlpha = 255
	--[[
	Cloudy.DataCalculationFunctions.Fogdensity = function(flPercent)
		--return math.min(flPercent * 5,1)
		return 1
	end
	Cloudy.DataCalculationFunctions.Fogend = function(flPercent)
		local tv = StormFox.GetTimeEnumeratedValue()
		if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
			--day
			--return 3000 - 2800*flPercent
			return 1
		else
			--night
			return 3000 - 2800*flPercent
		end
	end
	Cloudy.DataCalculationFunctions.Fogstart = function(flPercent)
		local tv = StormFox.GetTimeEnumeratedValue()
		local rp = 1 - flPercent
		if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
			--day
			return -1250
		else
			--night
			return -1500
		end
	end]]
	StormFox.AddWeatherType( Cloudy )

end)
