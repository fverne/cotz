PLUGIN.name = "mapedits"
PLUGIN.author = "verne"
PLUGIN.description = "mapedits for various maps"

function PLUGIN:EntityKeyValue(ent, key, value)
    if game.GetMap() == "rp_salvation_2_haven" then
        -- fixes the elevator button not resetting after being pressed once
        if IsValid(ent) and ent:GetClass() == "func_button" and ent:GetName() == "button_down" then
            ent:SetKeyValue("wait", 5)
        end
    end

    if game.GetMap() == "rp_marsh_cs" then
        -- locks the underground bunker door, openable with accesscard_bunker
        if IsValid(ent) and ent:MapCreationID() == 1402 then
            ent:Input("Lock")
            ent:SetKeyValue("dmg", 0)
        end

        --disables swamp radio in marsh base
        if IsValid(ent) and ent:MapCreationID() == 3706 then
            ent:SetKeyValue("spawnflags", 0) -- disables all flags, including use actvates
        end
    end

    if game.GetMap() == "rp_waystation" then
        -- keeps elevatordoors open, regardless of the underground power switches
        if IsValid(ent) and ent:GetClass() == "func_door" and ent:GetName() == "lift_door" then
            ent:SetKeyValue("spawnpos", 1)
        end

        --removes BTR with missing textures
        if IsValid(ent) and ent:MapCreationID() == 1627 then
            ent:Remove()
        end
    end

    if game.GetMap() == "rp_pripyat_remaster" then
        -- removes kometa from apartments
        local kometaIDs = {
            [1523] = true,
            [1524] = true
        }
        if IsValid(ent) and kometaIDs[ent:MapCreationID()] then
            ent:Remove()
        end

        -- locks elevator to lab, openable with accesscard_laboratory
        local elevatorButtonIDs = {
            [1617] = true,
            [1623] = true,
        }
        if IsValid(ent) and elevatorButtonIDs[ent:MapCreationID()] then
            ent:SetKeyValue("spawnflags", 33) -- disables UseActivates flag
        end
    end
end