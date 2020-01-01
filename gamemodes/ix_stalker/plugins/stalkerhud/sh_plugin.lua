local PLUGIN = PLUGIN
PLUGIN.name = "STALKER Hud"
PLUGIN.author = "Verne"
PLUGIN.desc = "A hud in the stalker theme"

ix.util.Include("cl_plugin.lua")

function PLUGIN:CanDrawAmmoHUD()
	return false
end

if ix.bar then
	ix.bar.Remove("health")
	ix.bar.Remove("armor")
	ix.bar.Remove("stm")

	function ix.bar.DrawAction()
		local start, finish = ix.bar.actionStart, ix.bar.actionEnd
		local curTime = CurTime()
		local scrW, scrH = ScrW(), ScrH()
		

		if (finish > curTime) then
			local fraction = 1 - math.TimeFraction(start, finish, curTime)
			local alpha = fraction * 255

			if (alpha > 0) then
				local w, h = scrW * 0.35, 28
				local x, y = (scrW * 0.5) - (w * 0.5), (scrH * 0.725) - (h * 0.5)

				ix.util.DrawBlurAt(x, y, w, h)

				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(Material("stalker/buttontab.png"))
				surface.DrawTexturedRect(x, y, w, h)

				surface.SetDrawColor(125, 200, 0, 255)
				surface.SetMaterial(Material("stalker/ui/bar3.png"))
				surface.DrawTexturedRect(x + 4, y + 4, math.max(w * fraction, 8) - 8, h - 8)

				draw.SimpleText(ix.bar.actionText, "stalkerregularfont", x, y - 24, TEXT_COLOR)
			end
		end
	end
end

ix.option.Add("cursor", ix.type.bool, true, {
	category = "appearance",
})

ix.option.Add("gasmaskoverlay", ix.type.bool, true, {
	category = "appearance",
})
