ENT.Base = "base_anim" 
ENT.PrintName = "Teleport"
ENT.Author = "Limta Roulence & [Pollitto] Курритто"
ENT.Information = "bulb"
ENT.Category = "S.T.A.L.K.E.R. Anomalies"
ENT.Editable = false
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Editable = true
ENT.RenderGroup = RENDERGROUP_OTHER

if CLIENT then
	language.Add ("teleport", "Teleport")
end

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "TpName", { KeyName = "bubname", Edit = { type = "Generic", order = 1 } } )
	self:NetworkVar( "String", 1, "TpDest", { KeyName = "destname", Edit = { type = "Generic", order = 2 } } )
	if SERVER then self:SetName("anomaly_"..self:GetTpName()) end
end

sound.Add( {
	name = "teleport_idle",
	channel = CHAN_STATIC,
	volume = 1,
	level = 50,
	pitch = 100,
	sound = "anomaly/teleport_idle.wav"
} )



function ENT:OnRemove()
	self:StopSound("teleport_idle")
end

function ENT:RebuildPhysics( value )
	local size = 140 / 6.4
	self:PhysicsInitSphere( size, "water" )
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
end