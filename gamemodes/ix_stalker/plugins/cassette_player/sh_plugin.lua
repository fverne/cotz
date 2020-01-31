local PLUGIN = PLUGIN
PLUGIN.name = "Cassette Player"
PLUGIN.author = "Kek1ch"
PLUGIN.desc = "Открывает возможность проигрывать музыку проигрывателям в зависимости от вставленной кассеты."

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	hook.Add("KeyPress", "RadioCar", function(ply, key)
		if ply:InVehicle() then
			if not ply.RadioCarDelay or ply.RadioCarDelay < CurTime() then 
				if (key == IN_RELOAD) then
					RadioCar = vgui.Create("RadioCar")
					ply.RadioCarDelay = CurTime() + 0.1
				end
			end
		end
	end)
end


