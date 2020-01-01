include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 5000) then
		self.Entity:DrawModel()
	end
end

/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return false
end

function MakeSprite( Entity, fx, color, spritePath, scale, transity)

	local Sprite = ents.Create("env_sprite");
	Sprite:SetPos( Entity:GetPos() );
	Sprite:SetKeyValue( "renderfx", fx )
	Sprite:SetKeyValue( "model", spritePath)
	Sprite:SetKeyValue( "scale", scale)
	Sprite:SetKeyValue( "spawnflags", "1")
	Sprite:SetKeyValue( "angles", "0 0 0")
	Sprite:SetKeyValue( "rendermode", "9")
	Sprite:SetKeyValue( "renderamt", transity)
	Sprite:SetKeyValue( "rendercolor", color )

	Sprite:Spawn()
	Sprite:Activate()
	Sprite:SetParent( Entity )
end 
