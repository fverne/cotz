PLUGIN.name = "Corpse Destroyer"
PLUGIN.author = "Tracks and deletes corpse ragdolls regularly to avoid clutter."
PLUGIN.desc = "Handles corpses from dead muties"

if CLIENT then return end

local delay = 0
local oldmodeltable = {}
local modeltable = {}
modeltable[1] = "models/stalkertnb/boar1.mdl"
modeltable[2] = "models/stalkertnb/bloodsucker1.mdl"
modeltable[3] = "models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"
modeltable[4] = "models/jerry/mutants/stalker_anomaly_ca1.mdl"
modeltable[5] = "models/stalkertnb/chimera1.mdl"
modeltable[6] = "models/stalkertnb/zombie1.mdl"
modeltable[7] = "models/stalkertnb/dog1.mdl"
modeltable[8] = "models/jerry/mutants/stalker_anomaly_flesh.mdl"
modeltable[9] = "models/jerry/mutants/stalker_anomaly_pseudodog.mdl"
modeltable[10] = "models/jerry/mutants/stalker_anomaly_pseudodog.mdl"
modeltable[11] = "models/stalkertnb/rodent1.mdl"
modeltable[12] = "models/stalkertnb/snork1.mdl"

function PLUGIN:Think()
	if delay > CurTime() then return end
	delay = CurTime() + 1800
	local enttable = ents.GetAll()
	for _,ent in pairs(enttable) do
		if ent:IsRagdoll() then
			if table.HasValue(modeltable,ent:GetModel()) then
				if table.HasValue(oldmodeltable,ent) and table.HasValue(oldmodeltable,ent:GetPos()) then
					ent:Remove()
				else
					table.Add(oldmodeltable,{ent,ent:GetPos()})
				end
			else
				table.Empty(oldmodeltable)
			end
		end
	end
end