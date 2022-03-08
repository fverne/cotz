local PLUGIN = PLUGIN
PLUGIN.name = "In-World Task System"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Underlying system for enabling GasAnalyzer-type items to complete tasks."

if CLIENT then
	netstream.Hook("ix_ShowTaskPositions", function(data)
		local stashmaterial = Material("vgui/icons/quest2.png", "smooth noclamp")
		for k,v in pairs(data) do
			local emitter = ParticleEmitter( v )
			local icon = emitter:Add( stashmaterial, v )
			icon:SetVelocity( Vector( 0, 0, 1 ) )
			icon:SetDieTime(10)
			icon:SetStartAlpha(255)
			icon:SetEndAlpha(255)
			icon:SetStartSize(8)
			icon:SetEndSize(8)
			icon:SetColor(255,255,255)
			icon:SetAirResistance(300)
		end
	end)
end

if SERVER then

function ix.util.GetRandomTaskPoint()
	local radpts = ix.plugin.list["radiationcontroller"].radiationpoints
	local anopts = ix.plugin.list["anomalycontroller"].anomalypoints

	local allpts = {}
	table.Add(allpts, anopts)
	table.Add(allpts, radpts)

	return allpts[ math.random( #allpts ) ][1]
end

end

function ix.util.GetLongLatFromVector(pos)

	--Zone: 51.1621 LAT 29.9575 LONG
	--      51.4026 LAT 30.2735 LONG

	local xpos = pos[1]
	local ypos = pos[2]

	local xposconv = ix.util.mapValueToRange(xpos, -8192, 8192, 51.1621, 51.4026)
	local yposconv = ix.util.mapValueToRange(ypos, -8192, 8192, 29.9575, 30.2735)

	return {xposconv, yposconv}
end

function ix.util.GetHeadingFromAngle(ang)
	local tmp = ang[2]

	local str = "The compass is spinning wildly"

	--nice code
	if( tmp < -157.5 or tmp > 157.5 ) then
		return "S"
	end
	if( tmp > 112.5 and tmp <= 157.5 ) then
		return "SW"
	end
	if( tmp > 67.5 and tmp <= 112.5 ) then
		return "W"
	end
	if( tmp > 22.5 and tmp <= 67.5 ) then
		return "NW"
	end
	if( tmp > -22.5 and tmp <= 22.5 ) then
		return "N"
	end
	if( tmp > -67.5 and tmp <= -22.5 ) then
		return "NE"
	end
	if( tmp > -112.5 and tmp <= -67.5 ) then
		return "E"
	end
	if( tmp > -157.5 and tmp <= -112.5 ) then
		return "SE"
	end

	return str
end