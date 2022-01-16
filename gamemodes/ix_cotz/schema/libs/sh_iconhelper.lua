
ix.util.text = ix.util.text or {}

// returns material of the given item - either img, exicon, or the render
function ix.util.GetItemIcon(item)
    local icon
    local exIcon = ikon:GetIcon(item.uniqueID)

    if item.img then
        icon = item.img
    elseif item.exRender then
        if (exIcon) then
            icon = exIcon
        else
            ikon:renderIcon(
                item.uniqueID,
                item.width,
                item.height,
                item:GetModel(),
                item.material,
                item.iconCam
            )
            local tmpIcon = ikon:GetIcon(item.uniqueID)
            item = tmpIcon
        end
    else
        -- We dont want to end up here...
        -- USE img OR exRender PLEASE
        icon = iconrow:Add("SpawnIcon")
        icon:SetModel(item:GetModel())
        icon:SetSize(48 * item.width, 48 * item.height)
    end

    return icon
end