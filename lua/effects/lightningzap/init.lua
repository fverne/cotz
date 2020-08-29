function EFFECT:Init( data )
  self.Min       = data:GetOrigin( )
  self.Max       = data:GetStart(  )
  self.Angle     = data:GetNormal( )
  self.Arcs      = data:GetScale(  )
  self.ArcSpread = data:GetRadius( )

  self.DieTime = CurTime( ) + 0.2

  self.Distance  = ( self.Min - self.Max ):Length( )
  self.ArcLength = self.Distance / self.Arcs
  self.Points    = { }

  local i, j, ang, dist, n, v1, v2, a, b, c

  v1 = self.Min

  for j = 1, self.Arcs do
    a = ( math.random( ) * 2 - 1 ) * self.ArcSpread
    b = ( math.random( ) * 2 - 1 ) * self.ArcSpread
    c = ( math.random( ) * 2 - 1 ) * self.ArcSpread

    n = Vector( a, b, c )

    if self.Angle.z >= 0 then
      table.insert( self.Points,  v1 + ( self.ArcLength * self.Angle ) + n )
    else
      table.insert( self.Points,  v1 + ( self.ArcLength * self.Angle ) - n )
    end

    v1 = v1 + ( self.ArcLength * self.Angle )
  end
  
  self.Alpha = 255
end

function EFFECT:Think( )
  self:SetRenderBoundsWS( self.Min, self.Max )

  self.Alpha = self.Alpha - 51 * FrameTime( )

  if self.DieTime > CurTime( ) then
    return true
  else
    return false
  end
end

function EFFECT:Render( )
  local amt
  self.Mat = self.Mat or Material( "effects/laser1" )
  render.SetMaterial( self.Mat  )

  self:DrawBeams( self.Min, 1, 8, Color( 000, 000, 255, self.Alpha ) )
  self:DrawBeams( self.Min, 1, 4, Color( 255, 255, 255, self.Alpha ) )
end

function EFFECT:DrawBeams( v, i, r, c )
  render.DrawBeam( v, self.Points[ i ], r, 1, 0, c )

  if i < #self.Points then
    self:DrawBeams( self.Points[ i ], i + 1, r, c )
  end
end