
// some copy pastas

local statDisplay = {}
statDisplay.registered = {}
statDisplay.highest = {}
statDisplay.totalCount = 0
statDisplay.descFont = "CW_HUD32"
statDisplay.vertSpacing = 45

local orig = "_Orig"

// these would b better as part of CustomizableWeaponry.statDisplay
local fallbackFuncs = {}
fallbackFuncs.roundValue = 0
fallbackFuncs.mulAmount = 1

function fallbackFuncs:compare(wep)
	if self.reverse then
		local var1, var2 = wep[self.varName], wep[self.origVarName]

		if var1 < var2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 > var2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	else
		local var1, var2 = wep[self.varName], wep[self.origVarName]

		if var1 > var2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 < var2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	end

	return CustomizableWeaponry.textColors.REGULAR
end

local percentage = "%"

function fallbackFuncs:textFunc(wep)
	local addition, finalText

	if self.percentage then
		addition = percentage
	end

	finalText = math.Round(wep[self.varName])

	if addition then
		finalText = finalText .. addition
	end

	return finalText
end

function fallbackFuncs:origTextFunc(wep)
	return wep[self.origVarName]
end

fallbackFuncs.mtindex = {__index = fallbackFuncs}

function statDisplay:addStat(tbl)
	setmetatable(tbl, fallbackFuncs.mtindex)

	tbl.origVarName = tbl.varName .. orig
	tbl.textFont = tbl.textFont or "CW_HUD40"
	tbl.statFont = tbl.statFont or "CW_HUD40"

	tbl.desc = string.Explode("\n", tbl.desc)

	self.totalCount = self.totalCount + 1
	table.insert(self.registered, tbl)
end

local hud48 = "CW_HUD48"
local hud40 = "CW_HUD40"
local gradient = surface.GetTextureID("cw2/gui/gradient")

function statDisplay:draw(wep, tab)
	local baseY = -self.totalCount * self.vertSpacing * 0.5 + 100
	local baseX = -100

	surface.SetTexture(gradient)
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawTexturedRect(baseX, baseY - 170, 500, 100)

	draw.ShadowText(wep:getKeyBind("+attack") .. " - cycle descriptions forward", hud48, baseX + 2, baseY - 147, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText(wep:getKeyBind("+attack2") .. " - cycle descriptions back", hud48, baseX + 2, baseY - 96, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	draw.ShadowText("STAT", hud48, baseX, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText("BASE", hud48, baseX + 400, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.ShadowText("CUR", hud48, baseX + 580, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	surface.SetDrawColor(0, 0, 0, 150)

	baseY = baseY + self.vertSpacing

	surface.DrawRect(baseX + 340, baseY - self.vertSpacing * 0.5, 120, self.totalCount * self.vertSpacing)
	surface.DrawRect(baseX + 520, baseY - self.vertSpacing * 0.5, 120, self.totalCount * self.vertSpacing)

	for k, v in ipairs(self.registered) do
		if tab.descOfStat == k then
			draw.ShadowText(">", v.textFont, baseX - 50, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.POSITIVE, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.ShadowText(v.display, v.textFont, baseX, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.POSITIVE, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			if v.desc then
				local lines = #v.desc
				surface.SetDrawColor(0, 0, 0, 200)
				surface.DrawTexturedRect(baseX + 695, baseY - 20, 500, lines * self.vertSpacing)

				for k2, v2 in pairs(v.desc) do
					draw.ShadowText(v2, self.descFont, baseX + 700, baseY + (k2 - 1) * self.vertSpacing, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end
		else
			draw.ShadowText(v.display, v.textFont, baseX, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		draw.ShadowText(v:origTextFunc(wep), v.statFont, baseX + 400, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.GRAY, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		draw.ShadowText(v:textFunc(wep), v.statFont, baseX + 580, baseY + (k - 1) * self.vertSpacing, v:compare(wep), CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

// them stats

CustomizableWeaponry.originalValue:add("fuseTime", false, true)

	local stat = {}
	stat.varName = "fuseTime"
	stat.display = "FUSE TIMER"
	stat.desc = "Delay between spoon release and detonation."

	function stat:textFunc(wep)
		return (wep.fuseTime and wep.fuseTime > 0) and (wep.fuseTime .. "s") or "N/A"
	end

	function stat:origTextFunc(wep)
		return (wep.fuseTime_Orig and wep.fuseTime_Orig > 0) and (wep.fuseTime_Orig .. "s") or "N/A"
	end

	statDisplay:addStat(stat)

CustomizableWeaponry.originalValue:add("projectileClass", false, true)

	local stat = {}
	stat.varName = "projectileClass"
	stat.display = "TYPE"
	stat.descBase = "Grenade type."
	stat.desc = stat.descBase

	local known = {
		["cw_kk_ins2_projectile_frag"] = "HE/FG",
		["cw_kk_ins2_projectile_c4"] = "RCEx",
		["cw_kk_ins2_projectile_ied"] = "RCEx",
		["cw_kk_ins2_projectile_m84"] = "STUN",
		["cw_kk_ins2_projectile_m18"] = "SMOKE",
		["cw_kk_ins2_projectile_anm14"] = "INCD",
		["cw_kk_ins2_projectile_molotov"] = "INCD",
		["cw_kk_ins2_projectile_rpg"] = "JOKE",
		["npc_grenade_frag"] = "JOKE",
		["cw_kk_ins2_projectile_ww2_c4_de"] = "HE SC",
		["cw_kk_ins2_projectile_ww2_c4_us"] = "HE SC",
		["cw_kk_ins2_projectile_n69"] = "ID HE",
		["cw_kk_ins2_projectile_n76"] = "WP",
		["cw_kk_ins2_projectile_n77"] = "ID SM",
	}

	local long = {
		["HE/FG"] = "High-explosive or Fragmentation grenade.",
		["HE SC"] = "High-explosive satchel charge.",
		["RCEx"] = "Remote-controlled explosive charge.",
		["STUN"] = "Less-than-lethal stun grenade - \"flashbang\".",
		["SMOKE"] = "Creates temporary smoke cover in surrounding area.",
		["JOKE"] = "For admins and staff.",
		["INCD"] = "Incendiary - sets surrounding area on fire.",
		["ID HE"] = "Impact-detonated high-explosive grenade.",
		["WP"] = "Self-igniting phosphorus grenade.",
		["ID SM"] = "Impact-detonated smoke grenade.",
		["UNKWN"] = "Unknown grenade type."
	}

	local uknwn = "UNKWN"

	function stat:textFunc(wep)
		local txt = known[wep.projectileClass] or uknwn

		self.desc[1] = long[txt]

		return txt
	end

	function stat:origTextFunc(wep)
		return known[wep.projectileClass_Orig] or uknwn
	end

	function stat:compare(wep)
		return CustomizableWeaponry.textColors.REGULAR
	end

	statDisplay:addStat(stat)

CustomizableWeaponry.originalValue:add("canCook", false, true)

	local trans = {
		["MOUSE1"] = "LEFT MOUSE BUTTON",
		["MOUSE2"] = "RIGHT MOUSE BUTTON"
	}

	local b, e

	local function getKeyBind(bind)
		b = input.LookupBinding(bind)
		e = trans[b]

		return b and ("[" .. (e and e or string.upper(b)) .. "]") or "[NOT BOUND, " .. bind .. "]"
	end

	local keys = {"+attack", "+attack2"}

	local stat = {}
	stat.varName = "canCook"
	stat.display = "COOK-ABLE"
	stat.descBase = "Does the fuse mechanism allow cooking."
	stat.desc = stat.descBase

	function stat:textFunc(wep)
		local out = wep.canCook and "YES" or "NO"

		if wep.KKINS2RCE then
			self.desc[1] = "I guess."
			self.desc[2] = "Kinda?"
		else
			self.desc[1] = self.descBase
			self.desc[2] = wep.canCook and "Press and hold " .. getKeyBind(keys[wep:getControlls()]) .. " to cook." or nil
		end

		return out
	end

	function stat:origTextFunc(wep)
		local out = wep.canCook_Orig and "YES" or "NO"

		if wep.KKINS2RCE then
			out = "YES"
		end

		return out
	end

	function stat:compare(wep)
		return CustomizableWeaponry.textColors.REGULAR
	end

	statDisplay:addStat(stat)

CustomizableWeaponry.originalValue:add("mustCook", false, true)

	local stat = {}
	stat.varName = "mustCook"
	stat.display = "COOK-ONLY"
	stat.desc = "Does the fuse always start with pin-pull."

	function stat:textFunc(wep)
		self.desc[2] = wep.mustCook and "Both primary and secondary attacks cook." or nil
		return wep.mustCook and "YES" or "NO"
	end

	function stat:origTextFunc(wep)
		return wep.mustCook_Orig and "YES" or "NO"
	end

	function stat:compare(wep)
		return CustomizableWeaponry.textColors.REGULAR
	end

	statDisplay:addStat(stat)

CustomizableWeaponry.originalValue:add("canPlant", false, true)

	local stat = {}
	stat.varName = "canPlant"
	stat.display = "PLANT-ABLE"
	stat.desc = "Is it possible to attach explosive to world and objects."

	function stat:textFunc(wep)
		self.desc[2] = wep.canPlant and "Go near-wall and press " .. getKeyBind(keys[wep:getControlls()]) .. " to plant." or nil
		return wep.canPlant and "YES" or "NO"
	end

	function stat:origTextFunc(wep)
		return wep.canPlant_Orig and "YES" or "NO"
	end

	function stat:compare(wep)
		return CustomizableWeaponry.textColors.REGULAR
	end

	statDisplay:addStat(stat)

// I really just wanted to use SWEP.Trivia

local tab = {}
tab.name = "TAB_INS2NADESTATS"
tab.text = "GRENADE STATS"
tab.switchToKey = "gm_showteam"
tab.descOfStat = 1

if CLIENT then
	tab.callback = function(self)
		tab.descOfStat = 1
	end

	function tab:processKey(key, press)
		if key == "+attack" then
			if tab.descOfStat >= statDisplay.totalCount then
				tab.descOfStat = 1
			else
				tab.descOfStat = math.Clamp(tab.descOfStat + 1, 1, statDisplay.totalCount)
			end
			return true
		elseif key == "+attack2" then
			if tab.descOfStat == 1 then
				tab.descOfStat = statDisplay.totalCount
			else
				tab.descOfStat = math.Clamp(tab.descOfStat - 1, 1, statDisplay.totalCount)
			end

			return true
		end

		return nil
	end

	function tab:drawFunc()
		statDisplay:draw(wep, tab)
	end
end

CustomizableWeaponry.interactionMenu:addTab(tab)

SWEP.CustomizationTabOverride = tab.id
