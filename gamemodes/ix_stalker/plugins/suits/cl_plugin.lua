local PLUGIN = PLUGIN

function PLUGIN:RenderScreenspaceEffects()
local character = LocalPlayer():GetCharacter()
	if character then
		if ix.option.Get("gasmaskoverlay", false) then
			if (LocalPlayer():GetNetVar("gasmask") == true) then
				local inventory = character:GetInventory()
				local items = inventory:GetItems()
				local armorHealth = 100
				for k, v in pairs(items) do
					if (v.overlayPath != nil and v:GetData("equip")) then
						armorHealth = v:GetData("durability", 100)

						if (armorHealth <= 0) then
							DrawMaterialOverlay( v.overlayPath.."12.png", 0.2 )
						elseif (armorHealth <= 10) then
							DrawMaterialOverlay( v.overlayPath.."11.png", 0.2 )
						elseif (armorHealth <= 20) then
							DrawMaterialOverlay( v.overlayPath.."9.png", 0.2 )
						elseif (armorHealth <= 40) then
							DrawMaterialOverlay( v.overlayPath.."7.png", 0.2 )
						elseif (armorHealth <= 60) then
							DrawMaterialOverlay( v.overlayPath.."5.png", 0.2 )
						elseif (armorHealth <= 80) then
							DrawMaterialOverlay( v.overlayPath.."3.png", 0.2 )
						else
							DrawMaterialOverlay( v.overlayPath.."1.png", 0.2 )
						end
					end
				end
			end
		end
	end
end

function PLUGIN:HUDPaint()
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible()) then return end
	local armor = Material("vgui/hud/bron.png", "noclamp smooth") 
	local armor2 = Material("vgui/hud/bron2.png", "noclamp smooth") 
	local armor3 = Material("vgui/hud/bron3.png", "noclamp smooth") 
	local armor4 = Material("vgui/hud/bron4.png", "noclamp smooth") 

	surface.SetMaterial(armor)
	if LocalPlayer():getEquippedGasmask() != nil then
		if LocalPlayer():getEquippedGasmask():GetData("durability") >= 80 then
			surface.SetDrawColor(Color(0, 0, 0, 0))
		elseif LocalPlayer():getEquippedGasmask():GetData("durability") < 80 and LocalPlayer():getEquippedGasmask():GetData("durability") >= 60 then
			surface.SetMaterial(armor)
			surface.SetDrawColor(Color(255, 255, 255, 255))
		elseif LocalPlayer():getEquippedGasmask():GetData("durability") < 60 and LocalPlayer():getEquippedGasmask():GetData("durability") >= 40 then
			surface.SetMaterial(armor2)
			surface.SetDrawColor(Color(255, 255, 255, 255))
		elseif LocalPlayer():getEquippedGasmask():GetData("durability") < 40 and LocalPlayer():getEquippedGasmask():GetData("durability") >= 20 then
			surface.SetMaterial(armor3)
			surface.SetDrawColor(Color(255, 255, 255, 255))
		elseif LocalPlayer():getEquippedGasmask():GetData("durability") < 20 and LocalPlayer():getEquippedGasmask():GetData("durability") >= 0 then
			surface.SetMaterial(armor4)
			surface.SetDrawColor(Color(255, 255, 255, 255))
		end
	else
		surface.SetDrawColor(Color(0, 0, 0, 0))
	end
	surface.DrawTexturedRect(ScrW()-80, ScrH()-400, 33, 35, Color(0, 255, 0, 255))
end