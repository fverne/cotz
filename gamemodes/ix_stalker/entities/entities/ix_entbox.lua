AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Metal Box"
ENT.Author = "Spenser&Kek1ch"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Helix"
ENT.RenderGroup = RENDERGROUP_BOTH

local items = {"545x39", "vodka", "bandage", "9x18", "762x25", "22lr"}

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/z-o-m-b-i-e/st/box/st_box_metall_01.mdl")
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
					ix.item.Spawn(table.Random(items), self:GetPos()+Vector(0,0,i))
				end
			end
		end

		self:Remove()

		local BottomBox = ents.Create("prop_physics")
		BottomBox:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		BottomBox:SetPos(pos)
		BottomBox:SetAngles(ang)
		BottomBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_metall_01_1.mdl")
		BottomBox:Spawn()
		BottomBox:Activate()
		

		local TopBox = ents.Create("prop_physics")
		TopBox:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
		TopBox:SetPos(pos + Vector(0, 0, 5))
		TopBox:SetAngles(ang)
		TopBox:SetModel("models/z-o-m-b-i-e/st/box/part/st_box_metall_01_2.mdl")
		TopBox:Spawn()
		TopBox:Activate()
		

		timer.Simple(25, function()
			BottomBox:Remove()
			TopBox:Remove()
		end)
	end
end

if (CLIENT) then
	function ENT:Draw()
		self:DrawModel()
	end
end

