TRACER_FLAG_USEATTACHMENT       = 0x0002;
SOUND_FROM_WORLD                        = 0;
CHAN_STATIC                                     = 6;

EFFECT.Thickness = 16
EFFECT.Life = 0.25

EFFECT.RotVelocity = 30

EFFECT.InValid = false;

local Mat_Impact                      = Material( "effects/combinemuzzle2" );
local Mat_Beam            = Material( "effects/tool_tracer" );
local Mat_TracePart            = Material( "effects/select_ring" );

function EFFECT:Init( data )	

		self.Position = data:GetStart()
		self.WeaponEnt = data:GetEntity()
		self.Attachment = data:GetAttachment()
		
		-- Keep the start and end pos - we're going to interpolate between them
		self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
		
        self.EndPos = data:GetOrigin()
		
        self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )
		
        self.Normal = ( self.EndPos - self.StartPos):GetNormalized()
        self.StartTime = 0
        self.LifeTime = self.Life
		
		self.data = data
		
		self.rot = 0
end

function EFFECT:Think()
		
		if self.InValid then return false end
		
        self.LifeTime = self.LifeTime - FrameTime();
        self.StartTime = self.StartTime + FrameTime();
 
        return self.LifeTime > 0;
 
end
 
local beamcol = table.Copy(color_white)

local beamcol2 = Color(0,225,255,255)

function EFFECT:Render()
		
		if self.InValid then return false end
 
		self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
		
        local startPos = self.StartPos
        local endPos = self.EndPos
		local tracerpos
		
		beamcol.a = self.LifeTime/self.Life * 255 
       
		self.rot = self.rot + FrameTime()*self.RotVelocity
	   
        render.SetMaterial( Mat_Impact );
        render.DrawSprite( endPos, 12, 12, ColorAlpha(color_white,beamcol.a) );
 
		render.SetMaterial( Mat_TracePart );
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life-0.1,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot-60)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life-0.05,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot-30)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life+0.05,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot+30)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life+0.1,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot+60)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life+0.15,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot+30)
		
		tracerpos = Lerp(math.Clamp(self.LifeTime/self.Life+0.2,0,1),endPos,startPos)
		render.DrawQuadEasy(tracerpos,self.Normal,12,12,beamcol2,self.rot+60)
        render.SetMaterial( Mat_Beam );		
        render.DrawBeam( startPos, endPos, self.Thickness, 0+beamcol.a/128, endPos:Distance(startPos)/64+beamcol.a/128, beamcol );
end