AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Wooden Box"
ENT.Author = "Spenser&Kek1ch"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Helix"
ENT.RenderGroup = RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/lostsignalproject/items/misc/box_wood.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		self.hp = 40

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
		self.IsDamaged = false
	end

	function ENT:OnTakeDamage(dmginfo)
		self.hp = self.hp - dmginfo:GetDamage()
		if(self.hp > 0) then return end

		local pos = self:GetPos()
		local ang = self:GetAngles()

		if (!self.IsDamaged) then
			self.IsDamaged = true

			for i = 1,4 do
				if (math.random(1, 4) == 4) then
					local drop = ix.util.GetRandomItemFromPool(self.CustomSpawngroup or "ix_wood_entbox_drops")
					ix.item.Spawn(drop[1], self:GetPos()+Vector(0, 0, 2 + i), nil, AngleRand(), drop[2] or {})
				end
			end
		end

		self:Remove()

		local BottomBox = ents.Create("prop_physics")
		BottomBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		BottomBox:PhysicsInit(SOLID_VPHYSICS)
		BottomBox:SetPos(pos + Vector(0, 0, 1))
		BottomBox:SetAngles(ang)
		BottomBox:SetModel("models/lostsignalproject/items/misc/box_wood_01.mdl")

		local TopBox = ents.Create("prop_physics")
		TopBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		TopBox:PhysicsInit(SOLID_VPHYSICS)
		TopBox:SetPos(pos + Vector(0, 0, 1))
		TopBox:SetAngles(ang)
		TopBox:SetModel("models/lostsignalproject/items/misc/box_wood_05.mdl")
		
		local FrontBox = ents.Create("prop_physics")
		FrontBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		FrontBox:PhysicsInit(SOLID_VPHYSICS)
		FrontBox:SetPos(pos + Vector(0, 0, 1))
		FrontBox:SetAngles(ang)
		FrontBox:SetModel("models/lostsignalproject/items/misc/box_wood_03.mdl")

		local RightBox = ents.Create("prop_physics")
		RightBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		RightBox:PhysicsInit(SOLID_VPHYSICS)
		RightBox:SetPos(pos + Vector(0, 0, 1))
		RightBox:SetAngles(ang)
		RightBox:SetModel("models/lostsignalproject/items/misc/box_wood_02.mdl")
		

		local BackBox = ents.Create("prop_physics")
		BackBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		BackBox:PhysicsInit(SOLID_VPHYSICS)
		BackBox:SetPos(pos + Vector(0, 0, 1))
		BackBox:SetAngles(ang)
		BackBox:SetModel("models/lostsignalproject/items/misc/box_wood_04.mdl")
		

		local LeftBox = ents.Create("prop_physics")
		LeftBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		LeftBox:PhysicsInit(SOLID_VPHYSICS)
		LeftBox:SetPos(pos + Vector(0, 0, 1))
		LeftBox:SetAngles(ang)
		LeftBox:SetModel("models/lostsignalproject/items/misc/box_wood_06.mdl")
		

		local Left2Box = ents.Create("prop_physics")
		Left2Box:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		Left2Box:PhysicsInit(SOLID_VPHYSICS)
		Left2Box:SetPos(pos + Vector(0, 0, 1))
		Left2Box:SetAngles(ang)
		Left2Box:SetModel("models/lostsignalproject/items/misc/box_wood_07.mdl")
		
		
		timer.Simple(0.001, function()
			BottomBox:Spawn()
			TopBox:Spawn()
			TopBox:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
			FrontBox:Spawn()
			FrontBox:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
			RightBox:Spawn()
			RightBox:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
			BackBox:Spawn()
			BackBox:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
			LeftBox:Spawn()
			LeftBox:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
			Left2Box:Spawn()
			Left2Box:GetPhysicsObject():SetVelocity(Vector(math.random(-50,50),math.random(-50,50),100))
		end)

		timer.Simple(5, function()
			BottomBox:Remove()
			TopBox:Remove()
			FrontBox:Remove()
			RightBox:Remove()
			BackBox:Remove()
			LeftBox:Remove()
			Left2Box:Remove()
		end)
	end

	function ENT:SetCustomSpawngroup(custgroup)
		self.CustomSpawngroup = custgroup
	end
end

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText("Rotten Wooden Crate")
		name:SizeToContents()

		local description = container:AddRow("description")
		description:SetText("This crate seems like it is on the brink of falling apart, and can be broken by hitting it.")
		description:SizeToContents()
	end
end
