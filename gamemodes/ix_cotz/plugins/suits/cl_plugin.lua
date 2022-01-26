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
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end
	local equippedgasmask = LocalPlayer():getEquippedGasmask()
	local equippedhelmet = LocalPlayer():getEquippedHelmet()
	local equippedarmor = LocalPlayer():getEquippedBodyArmor()
	local equippedpartdura = 100


	if equippedgasmask then
		if equippedgasmask:GetData("durability") and equippedgasmask:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedgasmask:GetData("durability")
			ix.util.DrawStatusIcon("stalker/ui/gas.png", equippedpartdura, ScrW()*0.88, ScrH()*0.79, 0)
		end
	end
	if equippedhelmet then
		if equippedhelmet:GetData("durability") and equippedhelmet:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedhelmet:GetData("durability")
			ix.util.DrawStatusIcon("stalker/ui/helmet.png", equippedpartdura, ScrW()*0.88, ScrH()*0.79)
		end
	end
	if equippedarmor then
		if equippedarmor:GetData("durability") and equippedarmor:GetData("durability") < equippedpartdura then
			equippedpartdura = equippedarmor:GetData("durability")
			ix.util.DrawStatusIcon("stalker/ui/armor.png", equippedpartdura, ScrW()*0.88, ScrH()*0.79)
		end
	end
end
