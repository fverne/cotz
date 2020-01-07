
SWEP._kk_active_ounter = true

function SWEP:IndividualInitialize()
	CustomizableWeaponry_KK.stattrack.createCvar(self)
	CustomizableWeaponry.actionSequence.new(self, 3, nil, function()
		self.kk_counter_kills = self.Owner:GetInfoNum(self.kk_counter_cvar, -1)
	end)

	if CLIENT then
		function self:drawCounter(num, id)
			local ent = self.AttachmentModelsVM[id].ent
			local raw = num

			if raw then
				raw = raw:GetInt()

				ent:SetBodygroup(1,0)

				ent._KKCSGONUM = raw
			else
				ent:SetBodygroup(1,1)
			end

			self.AttachmentModelsVM[id].ignoreKKBGO = true
			self.AttachmentModelsVM[id].active = true
		end

		function self.elementRender:kk_counter()
			self:drawCounter(GetConVar(self.kk_counter_cvar), "kk_counter")
		end
	end
end
