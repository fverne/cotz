
local td = {}
local ang

local function mySetupVis(ply, viewEntity)
	if IsValid(ply) then
		td.start = ply:EyePos()
		ang = ply:EyeAngles()
	else
		return
	end

	if IsValid(viewEntity) then
		td.start = viewEntity:GetPos()
		ang = viewEntity:GetAngles()
	end

	for i = 1,640 do
		AddOriginToPVS(td.start + ang:Forward() * i * 100)
	end
end

-- hook.Add("SetupPlayerVisibility", "AddKKCamera", mySetupVis)
