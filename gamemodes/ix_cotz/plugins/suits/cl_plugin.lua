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
	local equippedgasmask = LocalPlayer():getEquippedGasmask()
	local equippedhelmet = LocalPlayer():getEquippedHelmet() 
	local equippedarmor = LocalPlayer():getEquippedBodyArmor()
	local equippedpartdura = 100
	local equippedpartdurafinal = 100
	local armor = Material("vgui/hud/bron.png", "noclamp smooth") 
	local armor2 = Material("vgui/hud/bron2.png", "noclamp smooth") 
	local armor3 = Material("vgui/hud/bron3.png", "noclamp smooth") 
	local armor4 = Material("vgui/hud/bron4.png", "noclamp smooth") 

	
	if equippedgasmask then
		if equippedgasmask:GetData("durability") and equippedgasmask:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedgasmask:GetData("durability")
			if equippedpartdurafinal > equippedpartdura then
				equippedpartdurafinal = equippedpartdura
			end
		end
	end
	if equippedhelmet then
		if equippedhelmet:GetData("durability") and equippedhelmet:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedhelmet:GetData("durability")
			if equippedpartdurafinal > equippedpartdura then
				equippedpartdurafinal = equippedpartdura
			end
		end
	end
	if equippedarmor then
		if equippedarmor:GetData("durability") and equippedarmor:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedarmor:GetData("durability")
			if equippedpartdurafinal > equippedpartdura then
				equippedpartdurafinal = equippedpartdura
			end
		end
	end

	if equippedpartdura then
	surface.SetMaterial(armor)
		if equippedpartdurafinal >= 80 then
			surface.SetDrawColor(Color(0, 0, 0, 0))
		elseif equippedpartdurafinal < 80 and equippedpartdurafinal >= 60 then
			surface.SetMaterial(armor)
			surface.SetDrawColor(Color(200, 200, 200, 255))
		elseif equippedpartdurafinal < 60 and equippedpartdurafinal >= 40 then
			surface.SetMaterial(armor2)
			surface.SetDrawColor(Color(200, 200, 200, 255))
		elseif equippedpartdurafinal < 40 and equippedpartdurafinal >= 20 then
			surface.SetMaterial(armor3)
			surface.SetDrawColor(Color(200, 200, 200, 255))
		elseif equippedpartdurafinal < 20 and equippedpartdurafinal >= 0 then
			surface.SetMaterial(armor4)
			surface.SetDrawColor(Color(200, 200, 200, 255))
		end
	else
		surface.SetDrawColor(Color(0, 0, 0, 0))
	end
	surface.DrawTexturedRect(ScrW()*0.88, ScrH()*0.79, ScrW()*0.018, ScrH()*0.032)
end