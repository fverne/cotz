AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Wooden Box"
ENT.Author = "Spenser&Kek1ch"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Helix"
ENT.RenderGroup = RENDERGROUP_BOTH

local items = {"545x39", "vodka", "bandage", "9x18", "762x25", "22lr"}

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/box/st_box_wood_01.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
		self.IsDamaged = false
	end

	function ENT:OnTakeDamage(damageInfo)
		local pos = self:GetPos()
		local ang = self:GetAngles()

		if (!self.IsDamaged) then
			self.IsDamaged = true

			for i = 1,4 do
				if (math.random(1, 2) == 2) then
					ix.item.Spawn(table.Random(items), self:GetPos()+Vector(0,0,2))
				end
			end
		end

		self:Remove()

		local BottomBox = ents.Create("prop_physics")
		BottomBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		BottomBox:SetPos(pos)
		BottomBox:SetAngles(ang)
		BottomBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_1.mdl")
		BottomBox:Spawn()
		BottomBox:Activate()

		local TopBox = ents.Create("prop_physics")
		TopBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		TopBox:SetPos(pos + Vector(0, 0, 0))
		TopBox:SetAngles(ang)
		TopBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_5.mdl")
		TopBox:Spawn()
		TopBox:Activate()

		local FrontBox = ents.Create("prop_physics")
		FrontBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		FrontBox:SetPos(pos + Vector(0, 0, 0))
		FrontBox:SetAngles(ang)
		FrontBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_2.mdl")
		FrontBox:Spawn()
		FrontBox:Activate()

		local RightBox = ents.Create("prop_physics")
		RightBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		RightBox:SetPos(pos + Vector(0, 0, 0))
		RightBox:SetAngles(ang)
		RightBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_3.mdl")
		RightBox:Spawn()
		RightBox:Activate()

		local BackBox = ents.Create("prop_physics")
		BackBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		BackBox:SetPos(pos + Vector(0, 0, 0))
		BackBox:SetAngles(ang)
		BackBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_4.mdl")
		BackBox:Spawn()
		BackBox:Activate()

		local LeftBox = ents.Create("prop_physics")
		LeftBox:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		LeftBox:SetPos(pos + Vector(0, 0, 0))
		LeftBox:SetAngles(ang)
		LeftBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_6.mdl")
		LeftBox:Spawn()
		LeftBox:Activate()

		local Left2Box = ents.Create("prop_physics")
		Left2Box:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		Left2Box:SetPos(pos + Vector(0, 0, 0))
		Left2Box:SetAngles(ang)
		Left2Box:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_wood_01_7.mdl")
		Left2Box:Spawn()
		Left2Box:Activate()



		timer.Simple(3, function()
			BottomBox:Remove()
			TopBox:Remove()
			FrontBox:Remove()
			RightBox:Remove()
			BackBox:Remove()
			LeftBox:Remove()
			Left2Box:Remove()
		end)
	end
end

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
end
