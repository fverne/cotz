AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Paper Parcel"
ENT.Author = "Spenser&Kek1ch"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Helix"
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/flaymi/anomaly/dynamics/box/box_paper.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		self.hp = 10

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
		self.IsDamaged = false
	end

	function ENT:OnTakeDamage(damageInfo)
		self.hp = self.hp - damageInfo:GetDamage()
		if(self.hp > 0) then return end

		local pos = self:GetPos()
		local ang = self:GetAngles()

		if (!self.IsDamaged) then
			self.IsDamaged = true

			for i = 1,4 do
				if (math.random(1, 6) == 6) then
					local drop = ix.util.GetRandomItemFromPool(self.CustomSpawngroup or "ix_paper_entbox_drops")
					ix.item.Spawn(drop[1], self:GetPos()+Vector(0, 0, 2 + i), function(item, ent) ent.bTemporary = true end, AngleRand(), drop[2] or {})
				end
			end
		end

		self:Remove()

		local BrokenBox = ents.Create("prop_ragdoll")
		BrokenBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		BrokenBox:PhysicsInit(SOLID_VPHYSICS)
		BrokenBox:SetPos(pos + Vector(0, 0, 1))
		BrokenBox:SetAngles(ang)
		BrokenBox:SetModel("models/flaymi/anomaly/dynamics/box/part/box_paper_part_1.mdl")
		
		timer.Simple(0.0001, function()
			BrokenBox:Spawn()
		end)

		timer.Simple(5, function()
			BrokenBox:Remove()
		end)
	end

	function ENT:SetCustomSpawngroup(custgroup)
		self.CustomSpawngroup = custgroup
	end
end

if (CLIENT) then
	function ENT:Draw()
		if LocalPlayer():GetPos():Distance(self:GetPos()) < 2048 then
            self:DrawModel()
        end
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Soaked Paper Parcel")
		name:SizeToContents()

		local description = container:AddRow("description")
		description:SetText("The box is soaked in liquid. It should be easy breaking it open.")
		description:SizeToContents()
	end
end

