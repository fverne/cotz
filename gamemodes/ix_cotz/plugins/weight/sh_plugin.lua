PLUGIN.name = "Weight"
PLUGIN.author = "Vex"
PLUGIN.description = "Allows for weight to be added to items."

ix.weight = ix.weight or {}

ix.config.Add("maxWeight", 30, "The maximum weight in Kilograms someone can carry in their inventory.", nil, {
	data = {min = 1, max = 100},
	category = "Weight"
})

ix.config.Add("maxOverWeight", 20, "The maximum amount of weight in Kilograms they can go over their weight limit, this should be less than maxWeight to prevent issues.", nil, {
	data = {min = 1, max = 100},
	category = "Weight"
})

ix.util.Include("sh_meta.lua")
ix.util.Include("sv_plugin.lua")

function ix.weight.WeightString(weight, imperial)
	if (imperial) then
		if (weight < 0.453592) then -- Filthy imperial system; Why do I allow their backwards thinking?
			return math.Round(weight * 35.274, 2).." oz"
		else
			return math.Round(weight * 2.20462, 2).." lbs"
		end
	else
		if (weight < 1) then -- The superior units of measurement.
			return math.Round(weight * 1000, 2).." g"
		else
			return math.Round(weight, 2).." kg"
		end
	end
end

function ix.weight.BaseWeight(character) -- gets total carry cap, not the base carry cap
	local base = ix.config.Get("maxWeight", 30)
	local carryinc = character:GetTotalExtraCarry()

	return base + carryinc
end

function ix.weight.CanCarry(weight, carry, character) -- Calculate if you are able to carry something.
	local max = ix.weight.BaseWeight(character) + ix.config.Get("maxOverWeight", 20)

	return (weight + carry) <= max
end

if (CLIENT) then
	ix.option.Add("imperial", ix.type.bool, false, {
		category = "_stalkersettings"
	})

	function PLUGIN:PopulateItemTooltip(tooltip, item)
		local weight = item:GetWeight()
		local carryinc = item:GetCarryInc()

		if !item.entity then
			if (carryinc) then
				ix.util.PropertyDesc2(tooltip, "Carry Capacity Increase: "..ix.weight.WeightString(carryinc, ix.option.Get("imperial", false)), Color(255, 255, 255), Material("vgui/ui/stalker/armorupgrades/carryweightinc.png"))
			end
		end

		if (weight) then
			ix.util.PropertyDesc3(tooltip, "Weight: "..ix.weight.WeightString(weight, ix.option.Get("imperial", false)), Color(255, 255, 255), Material("vgui/ui/stalker/weaponupgrades/weight.png"), 999)
		end
	end
end

function PLUGIN:HUDPaint()
	local weight = Material("vgui/hud/gruz.png", "noclamp smooth")
	local weight2 = Material("vgui/hud/gruz2.png", "noclamp smooth")
	local weight3 = Material("vgui/hud/gruz3.png", "noclamp smooth")
	local weight4 = Material("vgui/hud/gruz4.png", "noclamp smooth")
	local lp = LocalPlayer()
	local char = lp:GetCharacter()
	if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

	surface.SetMaterial(weight)
	if (ix.weight.BaseWeight(char) - char:GetData("carry", 0)) >= 5 then
		surface.SetMaterial(weight)
		surface.SetDrawColor(Color(0, 0, 0, 0))
	elseif (ix.weight.BaseWeight(char) - char:GetData("carry", 0)) >= 0 then
		surface.SetMaterial(weight)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	elseif char:Overweight() then
		surface.SetMaterial(weight3)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	elseif char:HeavilyOverweight() then
		surface.SetMaterial(weight4)
		surface.SetDrawColor(Color(200, 200, 200, 255))
	end
	surface.DrawTexturedRect(ScrW()*0.92, ScrH()*0.79, ScrW()*0.018, ScrH()*0.032)
end
