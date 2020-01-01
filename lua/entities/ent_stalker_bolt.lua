
------------------------------
------------------------------
------------------------------
--	STALKER Bolt Throwing SEnt
--	Author:	V92
--	Date: 2014/04/27
--
--	Throws bolts, detects hazards
------------------------------
------------------------------
------------------------------

AddCSLuaFile()

ENT.Type 			=	"anim"
ENT.Base 			=	"base_gmodentity"

---------------------------------------------------------
-- Remove
---------------------------------------------------------
function ENT:OnRemove() end

---------------------------------------------------------
-- PhysicsUpdate
---------------------------------------------------------
function ENT:PhysicsUpdate() end

---------------------------------------------------------
-- PhysicsCollide
---------------------------------------------------------
function ENT:PhysicsCollide(data,phys) end

if CLIENT then

	---------------------------------------------------------
	-- Initialize
	---------------------------------------------------------
	function ENT:Initialize() end

	---------------------------------------------------------
	-- Think
	---------------------------------------------------------
	function ENT:Think() end

	---------------------------------------------------------
	-- Draw
	---------------------------------------------------------
	function ENT:Draw() self:DrawModel() end

	---------------------------------------------------------
	-- IsTransluent
	---------------------------------------------------------
	function ENT:IsTranslucent() return false end

end

if SERVER then
/*
	function ENT:Touch( ent )
		if ( ent:IsValid() and ( ent:GetClass() == "trigger_hurt" or ent:GetClass() == "point_hurt" or ent:GetClass() == "*anomaly*" ) ) then
			self:EmitSound("ambient/fire/mtov_flame2.wav",100,90)

			local effectdata = EffectData()
			effectdata:SetOrigin(self.Entity:GetPos())
			effectdata:SetScale( 0.1 )
			util.Effect("HelicopterMegaBomb", effectdata)
				
			self:Remove()
		end
	end
*/
	---------------------------------------------------------
	--	Initialize
	---------------------------------------------------------
	function ENT:Initialize()

		self:SetModel(Model("models/kali/miscstuff/stalker/bolt.mdl"))
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:DrawShadow( true )
		
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:SetNetworkedString("Owner", "World")
		
		local phys = self:GetPhysicsObject()
		
		phys:SetMass(4)
		
		if (phys:IsValid()) then
			phys:Wake()
		end
		
	end

	local exp

	---------------------------------------------------------
	--	Think
	---------------------------------------------------------
	function ENT:Think() self:Fire("kill", "", 20) end

end