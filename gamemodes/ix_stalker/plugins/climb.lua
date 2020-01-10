PLUGIN.name = "Climb"
PLUGIN.author = "Hoooldini"
PLUGIN.description = "Adds the ability to climb up ledges."

if (SERVER) then
	function PLUGIN:KeyPress( ply, key )
		//-------------------------- Ledge code --------------------------\\
		--CREDIT: Code belongs to the creator of ClimbSwep
		if ply:KeyPressed( IN_JUMP ) then
			local trace = {}
			trace.start = ply:GetShootPos() + Vector( 0, 0, 15 )
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
		
			local trHi = util.TraceLine(trace)
		
			local trace = {}
			trace.start = ply:GetShootPos()
			trace.endpos = trace.start + ply:GetAimVector() * 30
			trace.filter = ply
		
			local trLo = util.TraceLine(trace)
			
			if trLo and trHi and trLo.Hit and !trHi.Hit then
				local dist = math.abs(trHi.HitPos.z - ply:GetPos().z)
				--[[print("JumpPower:"..ply:GetJumpPower())
				print("Distance: "..dist)
				ply:SetPos(trHi.HitPos)
				print("SetVelocity: "..(50 + dist * 3))]]-- Apparently it works
				ply:SetVelocity(Vector(0, 0, (50 + dist * 3)))
			end
		end
	end
end