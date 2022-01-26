local PLUGIN = PLUGIN
PLUGIN.name = "hidehud"
PLUGIN.author = "verne"
PLUGIN.desc = "hider of hud"

ix.option.Add("disablehud", ix.type.bool, false, {
	category = "_stalkersettings",
})

function PLUGIN:HUDPaint()
	if ix.option.Get("disablehud", false) then
		return false
	end
end

/*
if (CLIENT) then
    function PLUGIN:PlayerButtonDown(client, key)
        if (key == KEY_F2 and client:GetCharacter() and IsFirstTimePredicted()) then
            if ix.option.Get("disablehud", false) then
                ix.option.Set("disablehud", false)
            elseif not ix.option.Get("disablehud", false) then
                ix.option.Set("disablehud", true)
            end
        end
    end
end
*/