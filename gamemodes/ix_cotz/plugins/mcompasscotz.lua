local PLUGIN = PLUGIN
PLUGIN.name = "mCompass"
PLUGIN.author = "mCompass - ported to ix by verne"
PLUGIN.description = "Adds a compass to the top of the HUD"
local playerMeta = FindMetaTable("Player")

function playerMeta:hasCompass()
    return self:GetNetVar("ixhascompass", false)
end

function PLUGIN:PostPlayerLoadout(client)
    if client:GetData("ixhascompass", false) then
        client:SetNetVar("ixhascompass", false)
    end
end

-- Enables/Disables compass for everyone in the entire server
PLUGIN.Compass_Enabled = true
PLUGIN.Force_Server_Style = false -- Force the below compass settings on the client.
PLUGIN.Use_FastDL = true -- Auto download the nessesary content for clients.
PLUGIN.Style_Selected = "cotz"
PLUGIN.Allow_Player_Spotting = false -- Allow / Disallow players from spotting. (Disabling just allows servers to implement their own method of spotting)
PLUGIN.Allow_Entity_Spotting = false -- Not yet working.
PLUGIN.Max_Spot_Distance = 15748.03 -- In GMOD units | Default( 15748.03 / 300m )
PLUGIN.Spot_Duration = 10 -- In seconds
PLUGIN.Spotted_Enemy_Color = Color(255, 0, 0)

PLUGIN.Styles = {
    ["cotz"] = {
        heading = true, -- Whether or not the precise bearing is displayed. (Default: true)
        compassX = 0.5, -- This value is multiplied by users screen width. (Default: 0.5)
        compassY = 0.05, -- This value is multiplied by users screen height. (Default: 0.05)
        width = 0.25, -- This value is multiplied by users screen width. (Default: 0.25)
        height = 0.03, -- This value is multiplied by users screen height. (Default: 0.03)
        spacing = 2.5, -- This value changes the spacing between lines. (Default: 2.5)
        ratio = 2, -- The is the ratio of the size of the letters and numbers text. (Default: 2)
        offset = 0, -- The number of degrees the compass will offset by. (Default: 0)
        maxMarkerSize = 1, -- Maximum size of the marker, note that this affects scaling (Default: 1)
        minMarkerSize = 0.5, -- Minimum size of the marker, note that this affects scaling (Default: 0.5)
        color = Color(255, 255, 255) -- The color of the compass.
        
    },
}

--------------------------------------------------------------
-- Dont edit anything below this line.
--------------------------------------------------------------
if SERVER then
    util.AddNetworkString("mCompass_AddMarker")
    util.AddNetworkString("mCompass_RemoveMarker")
    local mCompass_MarkerTable = mCompass_MarkerTable or {}

    -- DOCSTRING FOR THE 2 FUNCTIONS BELOW --
    -- ply: player who is currently spotting (used to grab info about players team)
    -- ent: entity that was spotted (used to track ent)
    -- pos: if not tracking ent, can also supply vector to pos
    -- time: amount of time marker is active for
    function mCompass_AddMarker(ply, pos, players, time, color, icon, name)
        name = name or ""
        icon = icon or ""
        color = color or PLUGIN.Spotted_Enemy_Color
        players = players or (ply and ply:IsPlayer()) and team.GetPlayers(ply:Team())
        local id = #mCompass_MarkerTable + 1

        if players then
            for k, v in pairs(players) do
                net.Start("mCompass_AddMarker")
                net.WriteInt(id, 4)
                net.WriteBool(false) -- IsEntity
                net.WriteVector(pos)
                net.WriteFloat(time)
                net.WriteColor(color)
                net.WriteString(icon)
                net.WriteString(name)
                net.Send(v)
            end
        else
            net.Start("mCompass_AddMarker")
            net.WriteInt(id, 4)
            net.WriteBool(false) -- IsEntity
            net.WriteVector(pos)
            net.WriteFloat(time)
            net.WriteColor(color)
            net.WriteString(icon)
            net.WriteString(name)
            net.Broadcast()
        end

        table.insert(mCompass_MarkerTable, {id, pos, time, color, icon, name})

        return id
    end

    function mCompass_AddEntityMarker(ply, ent, players, time, color, icon, name)
        name = name or ""
        icon = icon or ""
        color = color or PLUGIN.Spotted_Enemy_Color
        players = players or (ply and ply:IsPlayer()) and team.GetPlayers(ply:Team())
        local id = #mCompass_MarkerTable + 1

        if players then
            for k, v in pairs(players) do
                net.Start("mCompass_AddMarker")
                net.WriteInt(id, 4)
                net.WriteBool(true) -- IsEntity
                net.WriteEntity(ent)
                net.WriteFloat(time)
                net.WriteColor(color)
                net.WriteString(icon)
                net.WriteString(name)
                net.Send(v)
            end
        else
            net.Start("mCompass_AddMarker")
            net.WriteInt(id, 4)
            net.WriteBool(true) -- IsEntity
            net.WriteEntity(ent)
            net.WriteFloat(time)
            net.WriteColor(color)
            net.WriteString(icon)
            net.WriteString(name)
            net.Broadcast()
        end

        table.insert(mCompass_MarkerTable, {id, pos, time, color, icon, name})

        return id
    end

    function Adv_Compass_RemoveMarker(markerID)
        for k, v in pairs(mCompass_MarkerTable) do
            if markerID == v[1] then
                net.Start("mCompass_RemoveMarker")
                net.WriteInt(markerID, 4)
                net.Broadcast()
                table.remove(mCompass_MarkerTable, k)
            end
        end
    end

    if PLUGIN.Use_FastDL then
        resource.AddFile("materials/compass/compass_marker_01.vmt")
        resource.AddFile("materials/compass/compass_marker_02.vmt")
        resource.AddFile("resource/fonts/exo/Exo-Regular.ttf")
    end

    local function v(arg)
        local arg = tonumber(arg)

        return math.Clamp(arg and arg or 255, 0, 255)
    end

    concommand.Add("mcompass_spot", function(ply, cmd, args)
        if PLUGIN.Allow_Player_Spotting then
            local color = string.ToColor(v(args[1]) .. " " .. v(args[2]) .. " " .. v(args[3]) .. " " .. v(args[4]))

            local tr = util.TraceLine({
                start = ply:EyePos(),
                endpos = ply:EyePos() + ply:EyeAngles():Forward() * PLUGIN.Max_Spot_Distance,
                filter = ply
            })

            local id
            local t = CurTime() + PLUGIN.Spot_Duration

            if tr.Entity and not tr.HitWorld then
                id = mCompass_AddEntityMarker(ply, tr.Entity, nil, t)
            else
                id = mCompass_AddMarker(ply, tr.HitPos, nil, t)
            end
        end
    end)
end

if CLIENT then
    -- cvars defined by client
    local function loadFonts()
        local returnVal = hook.Call("mCompass_loadFonts")
    end

    -- not cvars
    local cl_style_selected_str, compass_style

    local function updateCompassSettings()
        -- ternary operators sorry not sorry
        cl_style_selected_str = 1 and "cotz"

        compass_style = PLUGIN.Force_Server_Style and PLUGIN.Styles[PLUGIN.Style_Selected] or {
            style = cl_style_selected_str,
            heading = true,
            compassX = 0.5,
            compassY = 0.05,
            width = 0.25,
            height = 0.03,
            spacing = 2.5,
            ratio = 1.8,
            offset = PLUGIN.Styles[cl_style_selected_str].offset,
            maxMarkerSize = 1,
            minMarkerSize = 0.5
        }

        if PLUGIN.Force_Server_Style then
            compass_style.style = PLUGIN.Style_Selected
        end

        loadFonts()
    end

    displayDistanceFontTable = displayDistanceFontTable or {}

    -- Function that handles fonts for the spot marker.
    local function markerScaleFunc(markerSizeScale)
        local returnVal
        local n = math.Round(markerSizeScale)

        if not oldMarkerSizeScale or oldMarkerSizeScale ~= n then
            if displayDistanceFontTable[n] then
                returnVal = displayDistanceFontTable[n].name
            else
                local newFontName = tostring("exo_compass_DDN_" .. n)

                displayDistanceFontTable[n] = {
                    name = newFontName,
                    size = n
                }

                surface.CreateFont(newFontName, {
                    font = "alsina",
                    size = n,
                    antialias = true
                })

                returnVal = displayDistanceFontTable[n].name
            end

            oldMarkerSizeScale = n
        else
            return displayDistanceFontTable[oldMarkerSizeScale].name
        end

        return returnVal
    end

    -- This table is just going to hold all of the generated fonts for later use.
    fontRatioChangeTable = fontRatioChangeTable or {}

    -- Doing this just so we could remake fonts and see ratio effects live. Kinda messy, sorry :/
    hook.Add("mCompass_loadFonts", "mCompass_loadFonts_addon", function()
        local h = compass_style.height
        local r = compass_style.ratio
        local ms = ScrH() * (compass_style.maxMarkerSize / 45)

        if r ~= mCompass_oldFontRatio then
            for k, v in pairs(fontRatioChangeTable) do
                if "exo_compass_Numbers_" .. r == v.numberName then
                    mCompass_oldFontRatio = r

                    return v
                end
            end

            surface.CreateFont("exo_compass_Numbers_" .. r, {
                font = "alsina",
                size = math.Round((ScrH() * h) / r),
                antialias = true
            })

            surface.CreateFont("exo_compass_Distance-Display-Numbers_" .. r, {
                font = "alsina",
                size = (ScrH() * (h / r)) * compass_style.maxMarkerSize,
                antialias = true
            })

            surface.CreateFont("exo_compass_Letters", {
                font = "alsina",
                size = ScrH() * h,
                antialias = true
            })

            local t = {
                ratio = r,
                numberName = "exo_compass_Numbers_" .. r
            }

            table.insert(fontRatioChangeTable, t)
            mCompass_oldFontRatio = r
        end
    end)

    updateCompassSettings()
    ----------------------------------------------------------------------------------------------------------------
    local cl_mCompass_MarkerTable = cl_mCompass_MarkerTable or {}
    local mat = Material("compass/compass_marker_01")
    local mat2 = Material("compass/compass_marker_02")

    net.Receive("mCompass_AddMarker", function(len)
        local id = net.ReadInt(4)
        local isEntity = net.ReadBool()
        local pos = not isEntity and net.ReadVector() or nil
        local ent = isEntity and net.ReadEntity() or nil
        local time = net.ReadFloat()
        local color = net.ReadColor()
        local icon_mat = net.ReadString()
        local icon_name = net.ReadString()
        icon_mat = (icon_mat == "") and mat or Material(icon_mat)
        icon_name = icon_name or ""

        table.insert(cl_mCompass_MarkerTable, {isEntity, pos or (ent or nil), time, color, id, icon_mat, icon_name})
    end)

    net.Receive("mCompass_RemoveMarker", function(len)
        local id = net.ReadInt(4)

        for k, v in pairs(cl_mCompass_MarkerTable) do
            if id == v[5] then
                table.remove(cl_mCompass_MarkerTable, k)
            end
        end
    end)

    local function getMetricValue(units)
        local meters = math.Round(units * 0.01905)
        local kilometers = math.Round(meters / 1000, 2)

        return (kilometers > 1) and kilometers .. "km" or meters .. "m"
    end

    local function getTextSize(font, text)
        surface.SetFont(font)
        local w, h = surface.GetTextSize(text)

        return w, h
    end

    -- Basically draws lines with two masks that limit where the lines can be drawn
    -- Not entirely sure how this affects performance... yolo
    local function custom_compass_DrawLineFunc(mask1, mask2, line, color)
        render.ClearStencil()
        render.SetStencilEnable(true)
        render.SetStencilFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
        render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
        render.SetStencilWriteMask(1)
        render.SetStencilReferenceValue(1)
        surface.SetDrawColor(Color(0, 0, 0, 1))
        surface.DrawRect(mask1[1], mask1[2], mask1[3], mask1[4]) -- left
        surface.DrawRect(mask2[1], mask2[2], mask2[3], mask2[4]) -- right
        render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
        render.SetStencilTestMask(1)
        surface.SetDrawColor(color)
        surface.DrawLine(line[1], line[2], line[3], line[4])
        render.SetStencilEnable(false)
    end

    local adv_compass_tbl = {
        [0] = "N",
        [45] = "NE",
        [90] = "E",
        [135] = "SE",
        [180] = "S",
        [225] = "SW",
        [270] = "W",
        [315] = "NW",
        [360] = "N"
    }

    function PLUGIN:HUDPaint()
        local ply = LocalPlayer()
        if not ply:GetCharacter() or not ply:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false) then return end

        if ply:hasCompass() then
            local ang = ply:GetAngles()
            local compassX, compassY = ScrW() * compass_style.compassX, ScrH() * compass_style.compassY
            local width, height = ScrW() * compass_style.width, ScrH() * compass_style.height
            local cl_spacing = compass_style.spacing
            local ratio = compass_style.ratio
            local color = compass_style.color
            local minMarkerSize = ScrH() * (compass_style.minMarkerSize / 45)
            local maxMarkerSize = ScrH() * (compass_style.maxMarkerSize / 45)
            local heading = compass_style.heading
            local offset = compass_style.offset
            spacing = (width * cl_spacing) / 360
            numOfLines = width / spacing
            fadeDistMultiplier = 1
            fadeDistance = (width / 2) / fadeDistMultiplier
            surface.SetFont("exo_compass_Numbers_" .. ratio)

            for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do
                -- DEBUGGING LINES
                -- local compassStart = compassX - width / 2
                -- local compassEnd = compassX + width / 2
                -- surface.SetDrawColor(Color(0, 255, 0))
                -- surface.DrawLine(compassStart, compassY, compassStart, compassY + height * 2)
                -- surface.DrawLine(compassEnd, compassY, compassEnd, compassY + height * 2)
                local x = (compassX - (width / 2)) + (((i + ang.y) % 360) * spacing)
                local value = math.abs(x - compassX)
                local calc = 1 - ((value + (value - fadeDistance)) / (width / 2))
                local calculation = 255 * math.Clamp(calc, 0.001, 1)
                local i_offset = -math.Round(i - offset - (numOfLines / 2)) % 360

                if i_offset % 15 == 0 and i_offset >= 0 then
                    local a = i_offset
                    local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)
                    local font = type(text) == "string" and "exo_compass_Letters" or "exo_compass_Numbers_" .. ratio
                    local w, h = getTextSize(font, text)
                    surface.SetDrawColor(Color(255, 255, 255, calculation))
                    surface.SetTextColor(Color(255, 255, 255, calculation))
                    surface.SetFont(font)

                    if compass_style.style == "cotz" then
                        if font == "exo_compass_Numbers_" .. ratio then
                            surface.DrawLine(x, compassY, x, compassY + height * 0.2)
                            surface.DrawLine(x, compassY, x, compassY + height * 0.3)
                            surface.SetTextPos(x - w / 2, compassY + height * 0.5)
                            surface.DrawText(text)
                        elseif font == "exo_compass_Letters" then
                            surface.SetTextPos(x - w / 2, compassY)
                            surface.DrawText(text)
                        end
                    end
                end
            end

            for k, v in pairs(cl_mCompass_MarkerTable) do
                if CurTime() > v[3] or (v[1] and not IsValid(v[2])) then
                    table.remove(cl_mCompass_MarkerTable, k)
                    continue
                end

                local spotPos = v[1] and v[2]:GetPos() or v[2]
                local d = ply:GetPos():Distance(spotPos)
                local currentVar = 1 - (d / (300 / 0.01905)) -- Converting 300m to gmod units
                local markerScale = Lerp(currentVar, minMarkerSize, maxMarkerSize)
                local font = markerScaleFunc(markerScale)
                local yAng = ang.y - (spotPos - ply:GetPos()):GetNormalized():Angle().y
                local markerSpot = math.Clamp((compassX + (width / 2 * cl_spacing)) - (((-yAng - offset - 180) % 360) * spacing), compassX - (width / 2), compassX + (width / 2))
                surface.SetMaterial(v[6])
                surface.SetDrawColor(v[4])
                surface.DrawTexturedRect(markerSpot - markerScale / 2, compassY - markerScale - markerScale / 2, markerScale, markerScale)
                -- Drawing text above markers
                local text = (v[7] ~= "") and v[7] .. " - " .. getMetricValue(d) or getMetricValue(d)
                local w, h = getTextSize(font, text)
                surface.SetFont(font)
                surface.SetTextColor(Color(255, 255, 255))
                surface.SetTextPos(markerSpot - w / 2, compassY - markerScale - markerScale / 2 - h)
                surface.DrawText(text)
            end

            if compass_style.heading then
                -- Middle Triangle
                local triangleSize = 8
                local triangleHeight = compassY

                local triangle = {
                    {
                        x = compassX - triangleSize / 2,
                        y = triangleHeight - (triangleSize * 2)
                    },
                    {
                        x = compassX + triangleSize / 2,
                        y = triangleHeight - (triangleSize * 2)
                    },
                    {
                        x = compassX,
                        y = triangleHeight - triangleSize
                    },
                }

                surface.SetDrawColor(255, 255, 255)
                draw.NoTexture()
                surface.DrawPoly(triangle)

                if heading then
                    local text = math.Round(-ang.y - offset) % 360
                    local font = "exo_compass_Numbers_" .. ratio
                    local w, h = getTextSize(font, text)
                    surface.SetFont(font)
                    surface.SetTextColor(Color(255, 255, 255))
                    surface.SetTextPos(compassX - w / 2, compassY - h - (triangleSize * 2))
                    surface.DrawText(text)
                end
            end
        end
    end
end