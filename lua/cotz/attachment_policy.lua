-- Rollout policy for the CW attachment placement tool (lua/autorun/client/cotz_attachment_placement.lua).
-- The tool only adds sights this policy allows. It never removes existing entries and only repositions
-- other attachments, so suppressors stay limited to the calibre-specific ones each weapon already lists.
-- Kept as standard Lua so tests and offline tooling can read it.

-- Rail red dots for handguns. The Kobra is an AK side-mount sight, so only long guns take it.
local RED_DOTS = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_rmr"}
local ALL_SIGHTS = {
	"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_rmr",
	"md_schmidt_shortdot", "md_acog", "md_nightforce_nxs", "md_pso1",
}

local revolverSights = {"md_schmidt_shortdot"}
for _, id in ipairs(RED_DOTS) do
	revolverSights[#revolverSights + 1] = id
end

return {
	-- Ranked donors. For each sight, the first donor that shares the anchor model in the same slot and
	-- places the sight on the anchor's bone supplies its relative placement and aim.
	donors = {"cw_ak74", "cw_saigasport", "cw_dragunov", "cw_sks", "cw_toz34"},

	families = {
		rifle = {sights = ALL_SIGHTS},
		pistol = {sights = RED_DOTS},
		revolver = {sights = revolverSights},
		-- Shotguns take sights only on a viewmodel rail or dovetail listed in `mounts`.
		shotgun = {sights = ALL_SIGHTS, requiresMount = true},
		-- WW2 and period weapons take suppressors only.
		period = {sights = {}},
	},

	-- Family by ITEM.weaponCategory when a weapon has no override.
	categoryFamilies = {primary = "rifle", secondary = "pistol"},

	-- New entries for these sights need a dovetail: `mounts[class] == "dovetail"` or
	-- `SWEP.HasDovetailMount = true`.
	dovetailSights = {md_pso1 = true},

	-- Verified sight mounts on the viewmodel itself. Rail adapter models do not count. The Anomaly
	-- Remington 870 and Saiga-12 models support rail and dovetail sights; the TOZ-34 family keeps sights
	-- over its barrel.
	mounts = {
		cw_rem870ae = "rail",
		cw_saiga12 = "dovetail",
		cw_toz34 = "rail",
		cw_toz34short = "rail",
	},

	weapons = {
		cw_mateba = "revolver",
		cw_model29 = "revolver",
		cw_mr96 = "revolver",
		cw_ragingbull = "revolver",
		cw_sw500 = "revolver",
		cw_swr8 = "revolver",
		cw_taurusjudge = "revolver",

		cw_ij600 = "shotgun",
		cw_ithaca37 = "shotgun",
		cw_lax410 = "shotgun",
		cw_lax410s = "shotgun",
		cw_m1887 = "shotgun",
		cw_m3super90 = "shotgun",
		cw_m3supershort = "shotgun",
		cw_mossberg500 = "shotgun",
		cw_mp153 = "shotgun",
		cw_mp27 = "shotgun",
		cw_rem870ae = "shotgun",
		cw_saiga12 = "shotgun",
		cw_saiga410 = "shotgun",
		cw_stoegerdd = "shotgun",
		cw_stoegerddshort = "shotgun",
		cw_striker = "shotgun",
		cw_toz106 = "shotgun",
		cw_toz194 = "shotgun",
		cw_toz34 = "shotgun",
		cw_toz34short = "shotgun",
		cw_toz34special = "shotgun",
		cw_toz66 = "shotgun",
		cw_toz66short = "shotgun",

		cw_c96 = "period",
		cw_c96carbine = "period",
		cw_cz52 = "period",
		cw_dp28 = "period",
		cw_m1911chic = "period",
		cw_m1917 = "period",
		cw_m1928a1 = "period",
		cw_mp34 = "period",
		cw_mp40 = "period",
		cw_nagantrev = "period",
		cw_obrez = "period",
		cw_obrezmalfunction = "period",
		cw_p08 = "period",
		cw_ppsh = "period",
		cw_ptrs = "period",
		cw_sten = "period",
		cw_sterling = "period",
		cw_svt40 = "period",
		cw_tokarev = "period",
		cw_w1895 = "period",
		cw_ws_mosin = "period",
	},
}
