local PLUGIN = PLUGIN
PLUGIN.name = "In-World Task System"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Underlying system for enabling GasAnalyzer-type items to complete tasks."

local playerMeta = FindMetaTable("Player")

function playerMeta:hasGpstracker()
	return self:GetNetVar("ixhasgpstracker", false)
end

function PLUGIN:PostPlayerLoadout(client)
	if client:GetData("ixhasgpstracker", false) then
		client:SetNetVar("ixhasgpstracker", false)
	end
end

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

	function PLUGIN:HUDPaint()
		local ply = LocalPlayer()
		if (!ply:GetCharacter() or !ply:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

        if ply:hasGpstracker() then
			local ppos = ix.util.GetLongLatFromVector(ply:GetPos())
			local text = math.Round(ppos[1],4).."N "..math.Round(ppos[2],4).."E"			
			local font = "stalkerregularfont"

			draw.SimpleText(text, font, ScrW()*0.5, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end
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
	local ypos = -pos[2]

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