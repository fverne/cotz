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

function ix.util.GetLongLatFromVector(pos, map)

	--Zone: 51.1621 LAT 29.9575 LONG
	--      51.4026 LAT 30.2735 LONG

	if not(map) then map = game.GetMap() end

	local offsettable = {
		["rp_marsh_cs"] 			= {0.0, 0.0},
		["rp_waystation"] 			= {0.75, -1.2},
		["rp_pripyat_remaster"] 	= {0.85, 0.8}
	}

	local xpos = pos[1]
	local ypos = -pos[2]

	local offset = offsettable[map] or {0.0, 0.0}

	local xposconv = ix.util.mapValueToRange(xpos, -8192, 8192, 51.1621 + offset[1], 51.4026 + offset[1])
	local yposconv = ix.util.mapValueToRange(ypos, -8192, 8192, 29.9575 + offset[2], 30.2735 + offset[2])

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

if CLIENT then
	netstream.Hook("ix_ShowTaskPositions", function(data, icon)
		local stashmaterial = Material("vgui/icons/quest2.png", "noclamp")
		for k,v in pairs(data) do
			local emitter = ParticleEmitter( v )
			local icon = emitter:Add( Material(icon, "noclamp") or stashmaterial, v + Vector(0,0,32) )
			icon:SetVelocity( Vector( 0, 0, 1 ) )
			icon:SetDieTime(10)
			icon:SetStartAlpha(255)
			icon:SetEndAlpha(255)
			icon:SetStartSize(8)
			icon:SetEndSize(8)
			icon:SetColor(255,255,255)
			icon:SetAirResistance(300)
			emitter:Finish()
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

function ix.util.GetRandomTaskPoint(map)
	map = map or game.GetMap()

	local radpts = ix.plugin.list["radiationcontroller"].radiationpoints[map]
	local anopts = ix.plugin.list["anomalycontroller"].anomalypoints[map]

	local allpts = {}
	table.Add(allpts, anopts)
	table.Add(allpts, radpts)

	return allpts[ math.random( #allpts ) ][1]
end

function ix.util.GetRandomStashTaskData(map)
	map = map or game.GetMap()

	local stashpts = ix.plugin.list["hidestashspawner"].stashspawnpoints[map]

	local tmpstashdata = stashpts[ math.random( #stashpts ) ]

	return {tmpstashdata[2], tmpstashdata[1]}
end

function ix.util.GetDataSearchColors(n)
	local colors = {"green", "blue", "red", "yellow", "purple", "orange"}
	local ret = {}

	table.Shuffle(colors)

	if (n > 6) then n = 6 end
	for i = 1,n do
		ret[i] = colors[i]
	end

	return ret
end

function PLUGIN:SaveData()
		local pcs = {}

		for _, entity in ipairs(ents.FindByClass("ix_dataextractpc")) do
			pcs[#pcs + 1] = {
				pos = entity:GetPos(),
				angles = entity:GetAngles(),
			}
		end

		local data = {}
		data.pcs = pcs

		self:SetData(data)
	end

	function PLUGIN:LoadData()
		for _, v in ipairs(self:GetData().pcs or {}) do
			local entity = ents.Create("ix_dataextractpc")
			entity:SetPos(v.pos)
			entity:SetAngles(v.angles)
			entity:Spawn()

			local physObj = entity:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
				physObj:Sleep()
			end
		end
	end

end