
SWEP.particleLighter = "molotov_lighter"
SWEP.particleRag = "molotov_rag"

PrecacheParticleSystem(SWEP.particleLighter)
PrecacheParticleSystem(SWEP.particleRag)

if CLIENT then
	function SWEP:updateOtherParts()
		if self.Sequence != self._ragStop then
			self.AttachmentModelsVM.fx_rag.ent:StopParticles()
			self._ragStop = nil
		end

		if self.Sequence != self._lighterStop or self.CW_VM:GetCycle() >= 1 then
			self.AttachmentModelsVM.fx_light.ent:StopParticles()
			self._lighterStop = nil
		end
	end
end

local function lighter(wep)
	if SERVER then return end

	if wep.Owner:ShouldDrawLocalPlayer() then return end

	local vm = wep.AttachmentModelsVM.fx_light.ent

	ParticleEffectAttach(wep.particleLighter, PATTACH_POINT_FOLLOW, vm, 1)

	wep._lighterStop = wep.Sequence
end

local function lighterFin(wep)
	if SERVER then return end

	wep._lighterStop = nil
end

local function rag(wep)
	if SERVER then return end

	if wep.Owner:ShouldDrawLocalPlayer() then return end

	local vm = wep.AttachmentModelsVM.fx_rag.ent

	ParticleEffectAttach(wep.particleRag, PATTACH_POINT_FOLLOW, vm, 0)

	wep._ragStop = wep.Sequence
end

local function ragSkin(wep)
	wep:setSkin(1)
end

local function refreshRag(wep)
	wep:setSkin(0)
end

SWEP.Sounds = {
	base_draw = {
		-- {time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 0/30, sound = "CW_KK_INS2_MOLOTOV_DRAW", callback = refreshRag},
	},

	base_holster = {
		-- {time = 0/35, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
		{time = 0/35, sound = "CW_KK_INS2_MOLOTOV_HOLSTER"},
	},

	base_crawl = {
		{time = 10/29, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 20/29, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	pullback_high = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 30/30, sound = "", callback = ragSkin},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
		// { event 3900 52 ""},
	},

	pullback_highbake = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 30/30, sound = "", callback = ragSkin},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
		// { event 3900 52 ""},
	},

	pullback_low = {
		{time = 6/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTEROPEN"},
		{time = 14/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERSTRIKE", callback = lighter},
		{time = 17/30, sound = "CW_KK_INS2_MOLOTOV_IGNITE", callback = rag},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 17 "molotov_lighter follow_attachment lighter"},
		// { event AE_CL_CREATE_PARTICLE_EFFECT 30 "molotov_rag follow_attachment rag"},
		{time = 30/30, sound = "", callback = ragSkin},
		{time = 34/30, sound = "CW_KK_INS2_M67_ARMDRAW"},
		{time = 35/30, sound = "CW_KK_INS2_MOLOTOV_LIGHTERCLOSE", callback = lighterFin},
		// { event 3900 52 ""},
	},

	throw = {
		{time = 3/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3005 3 ""},
	},

	bakethrow = {
		{time = 3/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3013 3 ""},
	},

	lowthrow = {
		{time = 6/31.5, sound = "CW_KK_INS2_MOLOTOV_THROW"},
		// { event 3016 6 ""},
	},
}
