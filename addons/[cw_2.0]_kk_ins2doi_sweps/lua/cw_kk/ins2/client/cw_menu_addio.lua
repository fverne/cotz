
CustomizableWeaponry_KK.ins2.rigTime = 0.15

local cvEp = CreateClientConVar("_cw_kk_add_epilepsy", 0, true, false)

local onceStarted
local nextRig

hook.Add("RenderScene", "CW20_KK_Epilepsy-ator", function()
	if (cvEp:GetInt() == 0) and not onceStarted then return end

	onceStarted = true

	for _,a in pairs(CustomizableWeaponry.registeredAttachments) do
		if a.description then
			for __,line in pairs(a.description) do
				line.c = Color(
					math.random(255),
					math.random(255),
					math.random(255),
					math.random(255) + 155
				)
			end
		end
	end

	if !nextRig or (nextRig < CurTime()) then
		local numRigs = CustomizableWeaponry_KK.ins2.hands.cacheSize

		RunConsoleCommand("cw_kk_ins2_rig", math.random(numRigs) + 1)

		nextRig = CurTime() + CustomizableWeaponry_KK.ins2.rigTime
	end
end)
