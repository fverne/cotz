PLUGIN.name = "Town NPCs"
PLUGIN.author = "COTZ"
PLUGIN.description = "Editable town contacts, specialised work and sparse personal progression trees."

ix.util.Include("definitions/sh_config.lua")
ix.util.Include("definitions/sh_equipment.lua")
ix.util.Include("definitions/sh_pools.lua")
ix.util.Include("definitions/sh_sites.lua")
ix.util.Include("definitions/sh_old_timer.lua")
ix.util.Include("definitions/sh_spicy_lemon.lua")
ix.util.Include("definitions/sh_haggler.lua")
ix.util.Include("definitions/sh_jitters.lua")
ix.util.Include("definitions/sh_technut.lua")
ix.util.Include("definitions/sh_mute.lua")
ix.util.Include("definitions/sh_the_original.lua")
ix.util.Include("definitions/sh_atlas.lua")
ix.util.Include("definitions/sh_gasket.lua")
ix.util.Include("definitions/sh_ballast.lua")
ix.util.Include("definitions/sh_cleaner.lua")
ix.util.Include("definitions/sh_arena_master.lua")
ix.util.Include("definitions/sh_beanstalk.lua")
ix.util.Include("definitions/sh_smartass.lua")
ix.util.Include("definitions/sh_latch.lua")
ix.util.Include("definitions/sh_spoor.lua")
ix.util.Include("definitions/sh_brass.lua")
ix.util.Include("definitions/sh_wake.lua")
ix.util.Include("definitions/sh_vesper.lua")
ix.util.Include("definitions/sh_quartermaster.lua")
ix.util.Include("definitions/sh_boss.lua")
ix.util.Include("definitions/sh_egghead.lua")
ix.util.Include("definitions/sh_intern.lua")
ix.util.Include("definitions/sh_suture.lua")
ix.util.Include("definitions/sh_ledger.lua")
ix.util.Include("definitions/sh_spool.lua")
ix.util.Include("definitions/sh_carbon.lua")

function PLUGIN:InitializedPlugins()
	self:Install()
end

if SERVER then
	function PLUGIN:PostLoadData()
		ix.plugin.Get("vendor_adv"):RefreshTownVendors(self)
		for region, count in SortedPairs(self:GetMissingFieldSites()) do
			ErrorNoHalt("[Town NPCs] No usable " .. region .. " sites; " .. count .. " commissions unavailable.\n")
		end
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		self:InitializeTownCharacter(character)
	end

	function PLUGIN:ix_OnJobComplete(client, npc, identifier)
		self:JobCompleted(client, npc, identifier)
	end

	PLUGIN["cotz/arena/match-completed"] = function(self, first, second)
		self:ArenaCompleted(first, second)
		self:ArenaCompleted(second, first)
	end
end
