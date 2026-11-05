local PLUGIN = PLUGIN
local COLORS = ix.cotzUI.colors
local bleedingColor = Color(COLORS.amber.r, COLORS.amber.g, COLORS.amber.b)
local BUFFS = {
	{id = "buff_slowheal", icon = "stalker/ui/heart.png", column = 0, row = 1, color = COLORS.teal, timed = true},
	{id = "buff_rapidheal", icon = "stalker/ui/heart.png", column = 0, row = 2, color = COLORS.green, timed = true},
	{id = "buff_staminarestore", icon = "stalker/ui/stamina.png", column = 1, row = 1, timed = true},
	{id = "buff_radprotect", icon = "stalker/ui/art.png", column = 2, row = 2, color = COLORS.teal},
	{id = "buff_radiationremoval", icon = "stalker/ui/art.png", column = 2, row = 1, timed = true},
	{id = "debuff_radiation", icon = "stalker/ui/art.png", column = 2, row = 0, color = COLORS.red, timed = true},
	{id = "buff_hijump", icon = "gui/arrow", column = 3, row = 1, color = COLORS.amber, timed = true},
	{id = "buff_lightningsprint", icon = "stalker/ui/stamina.png", column = 3, row = 2, color = COLORS.amber},
	{id = "buff_psysuppress", icon = "stalker/ui/psy.png", column = 6, row = 3, color = COLORS.green, timed = true},
	{id = "buff_psyblock", icon = "stalker/ui/psy.png", column = 6, row = 2, color = COLORS.teal, timed = true},
	{id = "buff_psyheal", icon = "stalker/ui/psy.png", column = 6, row = 1, timed = true},
	{id = "debuff_psy", icon = "stalker/ui/psy.png", column = 6, row = 0, color = COLORS.red, timed = true},
	{id = "buff_passivehealthregen", icon = "stalker/ui/heart.png", column = -1, row = 1, color = COLORS.green},
	{id = "buff_townradprotect", icon = "stalker/ui/art.png", column = -1, row = 2, color = COLORS.green},
}

function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	if not client:Alive() or not client:GetCharacter() or ix.option.Get("disablehud", false) then return end
	if IsValid(ix.gui.characterMenu) and ix.gui.characterMenu:IsVisible() then return end
	local x, y = ScrW() * 0.82, ScrH() * 0.75
	local stepX, stepY = ScrW() * 0.02, ScrH() * 0.035
	local width, height = ScrW() * 0.016, ScrH() * 0.032
	local severity = client:GetLocalVar("bleedingSeverity", 0)
	if severity > 0 then
		local fraction = math.Clamp(severity / ix.config.Get("bleedingMaximum", 100), 0, 1)
		bleedingColor.r = Lerp(fraction, COLORS.amber.r, COLORS.red.r)
		bleedingColor.g = Lerp(fraction, COLORS.amber.g, COLORS.red.g)
		bleedingColor.b = Lerp(fraction, COLORS.amber.b, COLORS.red.b)
		ix.util.DrawBuffIcon("stalker/ui/heart.png", x, y, width, height, bleedingColor, tostring(severity))
	end

	for _, definition in ipairs(BUFFS) do
		local buff = client:HasBuff(definition.id)
		if buff then
			local remaining = definition.timed and math.Round(buff[1] - CurTime() + 0.5) or nil
			ix.util.DrawBuffIcon(definition.icon, x + stepX * definition.column, y - stepY * definition.row,
				width, height, definition.color, remaining)
		end
	end
end
