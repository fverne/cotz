-- PLUGIN.name = "Wish Helper Plugin"
-- PLUGIN.author = "verne"
-- PLUGIN.desc = "Helper functions and hooks for wishes"


function PLUGIN:PostPlayerLoadout(client)
    local wishes = client:GetCharacter():GetData("wishes", {})
    
    if wishes["hp"] then
        client:SetMaxHealth(125)
    end
end