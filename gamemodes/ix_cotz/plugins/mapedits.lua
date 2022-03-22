PLUGIN.name = "mapedits"
PLUGIN.author = "verne"
PLUGIN.description = "mapedits - primarily for rp_salvation_haven"

function PLUGIN:EntityKeyValue(ent, key, value)
    if IsValid(ent) and ent:GetClass() == "func_button" and ent:GetName() == "button_down" then
        
        if value != 5 then
            ent:SetKeyValue("wait", 5)
        end
    end
end