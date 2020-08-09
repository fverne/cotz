include('shared.lua')

function ENT:Initialize()
	self.RealModel = "models/monsters/slep_dog2.mdl"
	self.TEMP_Emitter = ParticleEmitter(Vector(0,0,0), false)
end

function ENT:Draw()
	
	self:SetModel("models/monsters/slep_dog2.mdl")
	self:DrawModel()
end

ENT.fireEffects = {
	"effects/fire_cloud1",
	"effects/fire_cloud2",
	"effects/fire_embers1",
	"effects/fire_embers2",
	"effects/fire_embers3"
}

function ENT:Think()


	self.TEMP_Emitter:SetPos(self:GetPos(), false)
		
	if(IsValid(self.TEMP_Emitter)) && self:GetNWBool("Burn", false) then
		local bonepos = self:GetBonePosition(self:LookupBone("bip01_head"))

		local TEMP_Particle = self.TEMP_Emitter:Add( table.Random(self.fireEffects), bonepos+
		Vector(math.Rand(-10,10),math.Rand(-10,10),math.Rand(-10,10)))
		TEMP_Particle:SetDieTime( 2 )
		TEMP_Particle:SetStartAlpha( 255 )
		TEMP_Particle:SetEndAlpha( 10 )
		TEMP_Particle:SetStartSize( 10 )
		TEMP_Particle:SetEndSize( 1 )
		TEMP_Particle:SetColor( 255,255,255 )
		TEMP_Particle:SetGravity(Vector(0,0,0))
		TEMP_Particle:SetVelocity((self:GetForward():GetNormalized()*math.random(200,300))+
		Vector(math.random(-28,28),math.random(-28,28),math.random(-28,28)))
		TEMP_Particle:SetCollide(true)
		
	end


end