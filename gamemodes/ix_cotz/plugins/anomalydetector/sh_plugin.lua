local PLUGIN = PLUGIN
PLUGIN.name = "Anomaly Detector"
PLUGIN.author = "gumlefar, verne"
PLUGIN.desc = "Beeps when anomalies are nearby when you have an anomaly detector."

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

-- Function on Player meta object that lets you see if player has an anomaly detector
-- See item in this plugin for how this is set
function playerMeta:hasAnomdetector()
	local char = self:GetChar()
	local anomdetector = self:GetNetVar("ixhasanomdetector")

	if !anomdetector then
		return false
	else
		return true
	end
end

function PLUGIN:Think()
	for k,v in pairs(player.GetAll()) do
		if v.LastBeep == nil then 
			v.LastBeep = 0 
		end
		if IsValid(v) then
			if v:hasAnomdetector() then
				anoms = {}
				dist = 600
				for j,b in pairs(ents.FindInSphere(v:GetPos(), 512)) do
					if string.sub(b:GetClass(),1,4) == "anom" then
						table.insert(anoms, b)
					end
				end

				for j,b in pairs(anoms) do
					if v:GetPos():Distance(b:GetPos()) < dist then
						dist = v:GetPos():Distance(b:GetPos())
					end
				end

				if dist < 400 then
					if v.LastBeep + dist/400 - CurTime() <= 0 then
						v.LastBeep = CurTime()
						local randomsound = "stalkerdetectors/anom_prox.wav"
						v:EmitSound(randomsound)
					end
				end
			end
		end
	end
end
