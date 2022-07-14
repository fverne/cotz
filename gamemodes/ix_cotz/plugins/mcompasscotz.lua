local PLUGIN = PLUGIN
PLUGIN.name = "mCompass"
PLUGIN.author = "mCompass - ported to ix by verne and cyanide"
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
PLUGIN.Force_Server_Style = true -- Force the below compass settings on the client.
PLUGIN.Style_Selected = "cotz"

PLUGIN.Styles = {
    ["cotz"] = {
        heading = true, -- Whether or not the precise bearing is displayed. (Default: true)
        compassX = 0.5, -- This value is multiplied by users screen width. (Default: 0.5)
        compassY = 0.05, -- This value is multiplied by users screen height. (Default: 0.05)
        width = 0.25, -- This value is multiplied by users screen width. (Default: 0.25)
        height = 0.03, -- This value is multiplied by users screen height. (Default: 0.03)
        spacing = 2.5, -- This value changes the spacing between lines. (Default: 2.5)
        ratio = 1.8, -- The is the ratio of the size of the letters and numbers text. (Default: 2)
        offset = 0, -- The number of degrees the compass will offset by. (Default: 0)
        color = Color(255, 255, 255) -- The color of the compass.
    },
}

--------------------------------------------------------------
-- Dont edit anything below this line.
--------------------------------------------------------------
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
        }

        if PLUGIN.Force_Server_Style then
            compass_style.style = PLUGIN.Style_Selected
        end

        loadFonts()
    end

    displayDistanceFontTable = displayDistanceFontTable or {}

    -- This table is just going to hold all of the generated fonts for later use.
    fontRatioChangeTable = fontRatioChangeTable or {}

    -- Doing this just so we could remake fonts and see ratio effects live. Kinda messy, sorry :/
    hook.Add("mCompass_loadFonts", "mCompass_loadFonts_addon", function()
        local h = compass_style.height
        local r = compass_style.ratio

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
    local function getTextSize(font, text)
        surface.SetFont(font)
        local w, h = surface.GetTextSize(text)

        return w, h
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
            local heading = compass_style.heading
            local offset = compass_style.offset
            spacing = (width * cl_spacing) / 360
            numOfLines = width / spacing
            fadeDistMultiplier = 1
            fadeDistance = (width / 2) / fadeDistMultiplier
            surface.SetFont("exo_compass_Numbers_" .. ratio)

            for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do
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