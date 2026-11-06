net.Receive("cotz/townnpcs/capture-spawn", function()
	local npc = net.ReadEntity()
	if not IsValid(npc) or npc:GetClass() ~= "ix_vendor_adv" then
		print("[Town NPCs] The advanced vendor is no longer available to capture.")

		return
	end
	local animation = npc:GetSequenceName(npc:GetSequence())
	if animation == "" then
		print("[Town NPCs] The advanced vendor has no current animation sequence to capture.")

		return
	end
	local position, angles = npc:GetPos(), npc:GetAngles()
	print("[Town NPCs] Spawn point for " .. npc:GetDisplayName() .. " on " .. game.GetMap() .. ":")
	print("{")
	print(string.format("\tposition = Vector(%.6f, %.6f, %.6f),", position.x, position.y, position.z))
	print(string.format("\tangles = Angle(%.6f, %.6f, %.6f),", angles.p, angles.y, angles.r))
	print(string.format("\tidleanim = %q,", animation))
	print("},")
end)
