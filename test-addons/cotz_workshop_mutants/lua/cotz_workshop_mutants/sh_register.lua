local CATEGORY = "COTZ Workshop Mutants"
local CLASS_PREFIX = "npc_mutant_workshop_"
local roster = include("cotz_workshop_mutants/roster.lua")

for id, profile in pairs(roster) do
	local class = CLASS_PREFIX .. id
	local translucent = profile.alpha or profile.cloak or profile.variants
	local entity = {
		Base = "cotz_workshop_mutant_base",
		Type = "ai",
		PrintName = profile.name,
		Category = CATEGORY,
		Spawnable = false,
		RenderGroup = translucent and RENDERGROUP_TRANSLUCENT or RENDERGROUP_OPAQUE,
	}
	if SERVER then
		entity.workshopProfile = profile
		if profile.variants then
			entity.workshopVariants = {}
			for index, variant in ipairs(profile.variants) do
				entity.workshopVariants[index] = roster[variant]
			end
		end
	end

	scripted_ents.Register(entity, class)
	list.Set("NPC", class, {
		Name = profile.name,
		Class = class,
		Category = CATEGORY,
	})
end
