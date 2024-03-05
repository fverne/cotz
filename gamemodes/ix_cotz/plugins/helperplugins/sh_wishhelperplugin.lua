-- PLUGIN.name = "Wish Helper Plugin"
-- PLUGIN.author = "verne"
-- PLUGIN.desc = "Helper functions and hooks for wishes"


function PLUGIN:PostPlayerLoadout(client)
    local wishes = client:GetCharacter():GetData("wishes", {})
    
    if wishes["hp"] then
        client:SetMaxHealth(125)
    end
end

if (CLIENT) then
	function PLUGIN:PopulateItemTooltip(tooltip, item)
		local blessed = item:GetData("unlimitedDurability")

        if (blessed) then
            ix.util.PropertyDesc2(tooltip, "Does not deteriorate", Color(255, 255, 255), Material("vgui/ui/stalker/misc/goldupgrade.png"))
        end
	end
end