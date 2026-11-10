local DEFAULT_SUMMON_RADIUS = 256

function ENT:STALKERNPCSpawnSummon(class, offset)
	local position
	if ix and ix.eventController then
		position = ix.eventController:GetSpawnLocation(
			self:GetPos(), self.summonSpawnRadius or DEFAULT_SUMMON_RADIUS, self
		)
		if not position or not ix.eventController:CanSpawnMutant(position, true) then return end
	else
		-- Keep the entity's original placement when this NPC base runs outside COTZ.
		position = self:GetPos() + self:GetForward() * offset.x
			+ self:GetRight() * offset.y + self:GetUp() * offset.z
	end

	local entity = ents.Create(class)
	if not IsValid(entity) then return end
	entity.cotzCombatPack = self.cotzCombatPack
	entity:SetPos(position)
	entity:SetAngles(self:GetAngles())
	entity:Spawn()
	entity:DropToFloor()
	if ix and ix.eventController then
		-- Summons need immediate entity references for replacement and owner-death cleanup.
		ix.eventController:RegisterMutant(entity, true, self.cotzCombatPack)
		if not IsValid(entity) or entity.cotzPopulationRejected then return end
	end

	return entity
end
