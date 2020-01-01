include('shared.lua')

local Heatwave = Material("effects/strider_bulge_dudv")
local Size = 100

function ENT:Draw()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then
		//self.Entity:DrawModel()
		
		render.UpdateScreenEffectTexture()	
		render.SetMaterial(Heatwave)
		
		if (render.GetDXLevel() >= 90) then
			//render.DrawSprite(self.Entity:GetPos(), Size, Size, Color(255, 0, 0, 25))
		end
	end
end 
	
function ENT:IsTranslucent()
	return false
end