if(SERVER) then
	util.AddNetworkString("STALKERNPCControllerStopPsySound")
end
local TEMP_VOICEDIST = 350


local function AddNPC(NAME,TYPE)
	local NPC = {
		Name = NAME, 
		Class = TYPE,			
		Category = "S.T.A.L.K.E.R RP"	
	}

	list.Set( "NPC", TYPE, NPC )
end

AddNPC("Controller","npc_mutant_controller")
AddNPC("Burer","npc_mutant_burer")

AddNPC("Dog","npc_mutant_dog")
AddNPC("Snork","npc_mutant_snork")
AddNPC("Zombie","npc_mutant_classiczombie")
AddNPC("Boar","npc_mutant_boar")
AddNPC("Flesh","npc_mutant_flesh")
AddNPC("Cat","npc_mutant_cat")
AddNPC("Chimera","npc_mutant_chimera")
AddNPC("Bloodsucker","npc_mutant_bloodsucker")
AddNPC("Pseudodog","npc_mutant_pseudodog")
AddNPC("Psydog","npc_mutant_psydog")
AddNPC("Tushkano","npc_mutant_rodent")

local function AddSoundInterval(NAME,IMIN,IMAX,CHAN,VOL,LEV,PITMIN,PITMAX,PATH)
	for S=IMIN, IMAX do
		sound.Add( {
			name = NAME..S,
			channel = CHAN,
			volume = VOL,
			level = LEV,
			pitch = { PITMIN, PITMAX },
			sound = PATH..S..".wav"
		} )
	end
end


local function AddSound(NAME,CHAN,VOL,LEV,PITMIN,PITMAX,PATH)
	sound.Add( {
		name = NAME,
		channel = CHAN,
		volume = VOL,
		level = LEV,
		pitch = { PITMIN, PITMAX },
		sound = PATH
	} )
end

AddSound("Stalker.Controller.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_0.wav")
AddSound("Stalker.Controller.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_1.wav")

AddSound("Stalker.Controller.Pain1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_0.wav")
AddSound("Stalker.Controller.Pain2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_1.wav")
AddSound("Stalker.Controller.Pain3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_2.wav")

AddSound("Stalker.Controller.SpecialAttack1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_attack_hit.wav")

AddSound("Stalker.Controller.PsyAura1",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_1.wav")
AddSound("Stalker.Controller.PsyAura2",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_2.wav")
AddSound("Stalker.Controller.PsyAura3",CHAN_AUTO,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_3.wav")

AddSound("Stalker.Controller.Control.1",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_tube_prepare.wav")
AddSound("Stalker.Controller.Control.2",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_first_hit.wav")
AddSound("Stalker.Controller.Control.3",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_whoosh.wav")
AddSound("Stalker.Controller.Control.4",CHAN_WEAPON,1,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_final_hit.wav")

AddSoundInterval("Stalker.Controller.Glitches",1,11,CHAN_VOICE,0.15,0,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/psy_effects/galutination_")


sound.Add( {
	name = "Stalker.Burer.Footstep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 98, 102 },
	sound = {"GSC/S.T.A.L.K.E.R/Monsters/large_step1.wav",
	"GSC/S.T.A.L.K.E.R/Monsters/large_step2.wav" }
} )

sound.Add( {
	name = "Stalker.Controller.Footstep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 98, 102 },
	sound = {"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav",
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"}
} )






AddSound("Stalker.Burer.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attacking_0.wav")

AddSound("Stalker.Burer.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_0.wav")
AddSound("Stalker.Burer.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_1.wav")
AddSound("Stalker.Burer.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_2.wav")

AddSound("Stalker.Burer.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attack_0.wav")

AddSound("Stalker.Burer.Push1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_attack_0.wav")
AddSound("Stalker.Burer.Tele1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_telekinetic_0.wav")

AddSound("Stalker.BurerWave.Collide",CHAN_WEAPON,1,400,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_wave_0.wav")




AddSound("Stalker.Claw.Hit",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/slash_physics_hit1.wav")
AddSound("Stalker.Claw.Miss",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/claw_miss.wav")


-- Dog sounds
----IDLE
AddSound("Stalker.Dog.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_1.wav")
AddSound("Stalker.Dog.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_2.wav")
AddSound("Stalker.Dog.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_3.wav")
AddSound("Stalker.Dog.Idle4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_4.wav")
----HIT
AddSound("Stalker.Dog.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/attack_hit_1.wav")
AddSound("Stalker.Dog.Melee2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/attack_hit_2.wav")
AddSound("Stalker.Dog.Melee3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/attack_hit_3.wav")
AddSound("Stalker.Dog.Melee4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/attack_hit_4.wav")
----MISS
AddSound("Stalker.Dog.Miss1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Dog.Miss2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Dog.Miss3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Dog.Miss4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Dog.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_die_2.wav")
AddSound("Stalker.Dog.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/dog/bdog_die_3.wav")

-- Snork sounds
----IDLE
AddSound("Stalker.Snork.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_1.wav")
AddSound("Stalker.Snork.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_2.wav")
AddSound("Stalker.Snork.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_3.wav")
----HIT
AddSound("Stalker.Snork.Hit1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snork_attack_1.wav")
AddSound("Stalker.Snork.Hit2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snork_attack_2.wav")
----MISS
AddSound("Stalker.Snork.Miss1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Snork.Miss2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Snork.Miss3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Snork.Miss4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Snork.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snorkscream.wav")
AddSound("Stalker.Snork.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/snork/snorkbreath.wav")

-- Zombie sounds
----IDLE
AddSound("Stalker.Zombie.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_idle_3.wav")
AddSound("Stalker.Zombie.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_idle_5.wav")
----CHASE
AddSound("Stalker.Zombie.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_attack_7.wav")
AddSound("Stalker.Zombie.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_attack_3.wav")
----HIT
AddSound("Stalker.Zombie.Hit1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_attack_1.wav")
AddSound("Stalker.Zombie.Hit2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_attack_3.wav")
----MISS
AddSound("Stalker.Zombie.Miss1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Zombie.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_die_1.wav")
AddSound("Stalker.Zombie.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_die_2.wav")
AddSound("Stalker.Zombie.Die3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/zombie/zombie_die_3.wav")

-- Boar sounds
----IDLE
AddSound("Stalker.Boar.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_idle_1.wav")
AddSound("Stalker.Boar.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_idle_2.wav")
----HIT
AddSound("Stalker.Boar.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_attack_1.wav")
AddSound("Stalker.Boar.Melee2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_attack_2.wav")
----MISS
AddSound("Stalker.Boar.Miss1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Boar.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_death_1.wav")
AddSound("Stalker.Boar.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_death_2.wav")
AddSound("Stalker.Boar.Die3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/boar/boar_death_3.wav")

-- Flesh sounds
----IDLE
AddSound("Stalker.Flesh.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_1.wav")
AddSound("Stalker.Flesh.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_2.wav")
AddSound("Stalker.Flesh.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_3.wav")
AddSound("Stalker.Flesh.Idle4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_4.wav")
----CHASE
AddSound("Stalker.Flesh.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_1.wav")
AddSound("Stalker.Flesh.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_2.wav")
AddSound("Stalker.Flesh.Chase3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_3.wav")
----HIT
AddSound("Stalker.Flesh.Hit1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_1.wav")
AddSound("Stalker.Flesh.Hit2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_2.wav")
AddSound("Stalker.Flesh.Hit3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_3.wav")
----MISS
AddSound("Stalker.Flesh.Miss1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Flesh.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_1.wav")
AddSound("Stalker.Flesh.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_2.wav")
AddSound("Stalker.Flesh.Die3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_3.wav")

-- Cat sounds
----IDLE
AddSound("Stalker.Cat.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/cat_idle.wav")
----CHASE
AddSound("Stalker.Cat.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/9.wav")
AddSound("Stalker.Cat.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/cat_agr.wav")
----HIT
AddSound("Stalker.Cat.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/3.wav")
AddSound("Stalker.Cat.Melee2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/cat_att_dmg.wav")
----DEATH
AddSound("Stalker.Cat.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/cat_die.wav")
AddSound("Stalker.Cat.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/cat/cat_take_dmg.wav")


-- Chimera sounds
----IDLE
AddSound("Stalker.Chimera.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_idle_1.wav")
AddSound("Stalker.Chimera.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_idle_2.wav")
----HIT
AddSound("Stalker.Chimera.Hit1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_1.wav")
AddSound("Stalker.Chimera.Hit2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_2.wav")
AddSound("Stalker.Chimera.Hit3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_hit_1.wav")
AddSound("Stalker.Chimera.Hit4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_hit_2.wav")
----DEATH
AddSound("Stalker.Chimera.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/chimera/chimera_death_1.wav")


-- Bloodsucker sounds
----IDLE
AddSound("Stalker.Bloodsucker.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/idle_1.wav")
AddSound("Stalker.Bloodsucker.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/idle_2.wav")
AddSound("Stalker.Bloodsucker.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/idle_0.wav")
----CHASE
AddSound("Stalker.Bloodsucker.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/sucker_growl_1.wav")
AddSound("Stalker.Bloodsucker.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/sucker_growl_4.wav")
AddSound("Stalker.Bloodsucker.Chase3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_hit_2")
----HIT
AddSound("Stalker.Bloodsucker.Hit1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_0.wav")
AddSound("Stalker.Bloodsucker.Hit2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_1.wav")
AddSound("Stalker.Bloodsucker.Hit3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_2.wav")
AddSound("Stalker.Bloodsucker.Hit4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_hit_0.wav")
AddSound("Stalker.Bloodsucker.Hit5",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/attack_hit_1.wav")
----DEATH
AddSound("Stalker.Bloodsucker.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/die_0.wav")
AddSound("Stalker.Bloodsucker.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/die_1.wav")
AddSound("Stalker.Bloodsucker.Die3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/die_2.wav")
AddSound("Stalker.Bloodsucker.Die4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/die_3.wav")
----FEEDING
AddSound("Stalker.Bloodsucker.Feed",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/bs/vampire_sucking.wav")

-- Pseudodog sounds
----IDLE
AddSound("Stalker.Pseudodog.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_0.mp3")
AddSound("Stalker.Pseudodog.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_1.mp3")
AddSound("Stalker.Pseudodog.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_2.mp3")
----HIT
AddSound("Stalker.Pseudodog.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_0.mp3")
AddSound("Stalker.Pseudodog.Melee2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_1.mp3")
AddSound("Stalker.Pseudodog.Melee3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_2.mp3")
AddSound("Stalker.Pseudodog.Melee4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/attack_0.mp3")
----Chase
AddSound("Stalker.Pseudodog.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_0.mp3")
AddSound("Stalker.Pseudodog.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_1.mp3")
AddSound("Stalker.Pseudodog.Chase3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_2.mp3")
AddSound("Stalker.Pseudodog.Chase4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_idle_2.mp3.wav")
----DEATH
AddSound("Stalker.Pseudodog.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_death_0.mp3")
AddSound("Stalker.Pseudodog.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_death_1.mp3")

-- Tushkano sounds
----IDLE
AddSound("Stalker.Rodent.Idle1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_0.wav")
AddSound("Stalker.Rodent.Idle2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_1.wav")
AddSound("Stalker.Rodent.Idle3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_2.wav")
AddSound("Stalker.Rodent.Idle4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_3.wav")
----HIT
AddSound("Stalker.Rodent.Melee1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_0.mp3")
AddSound("Stalker.Rodent.Melee2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_1.mp3")
AddSound("Stalker.Rodent.Melee3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_2.mp3")
AddSound("Stalker.Rodent.Melee4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/attack_0.mp3")
----Chase
AddSound("Stalker.Rodent.Chase1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_0.wav")
AddSound("Stalker.Rodent.Chase2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_1.wav")
AddSound("Stalker.Rodent.Chase3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_2.wav")
AddSound("Stalker.Rodent.Chase4",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_3.wav")
----DEATH
AddSound("Stalker.Rodent.Die1",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_0.wav")
AddSound("Stalker.Rodent.Die2",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_1.wav")
AddSound("Stalker.Rodent.Die3",CHAN_VOICE,1,TEMP_VOICEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_2.wav")

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


local ControllerPlayerPsyEffectTime = 0
local LanguageChoosen = 0
local TEMP_CheckPosTime = 0

if(CLIENT) then
	local function ControllerWeaponFuncNoDraw( self )
		if(LocalPlayer():GetNWFloat("PsyDamage",0)>0.1) then		
			return
		end
		
		self:DrawModel()
	end
	
	local function ControllerNpcFuncChangeDraw( self )
		if(IsValid(self:GetActiveWeapon())) then
			self:GetActiveWeapon().RenderOverride = ControllerWeaponFuncNoDraw
		end
		
		local TEMP_RealModel = self:GetModel()
		local TEMP_RealPos = self:GetPos()
			
		if(LocalPlayer():GetNWFloat("PsyDamage",0)>0.1) then		
			if(!isvector(self.TEMP_PrevPos)) then
				self.TEMP_PrevPos = TEMP_RealPos
			end
			
			
			local TEMP_Seq = "S_Idle"
			
			if(TEMP_RealPos:Distance(self.TEMP_PrevPos)>3) then
				TEMP_Seq = "S_Walk"
			end
			
			self:SetModel("models/GSC/S.T.A.L.K.E.R/Monsters/Controller.mdl")
			self:SetModelScale(1)
			
			self:SetSequence(self:LookupSequence(TEMP_Seq))
			
			local TEMP_RandVec = (VectorRand()*math.random(5,10))
			self:SetPos(self:GetPos()+TEMP_RandVec)
			self:SetupBones()
			self:DrawModel()
			
			self:SetModel(TEMP_RealModel)
			self:SetPos(TEMP_RealPos)
			self:SetupBones()
			
			return
		end
		
		self:DrawModel()
	end

	local TEMP_ControllerReDrawNext = 0

	hook.Add("Think","StalkerControllerEntsRender",function()
		if(TEMP_ControllerReDrawNext<CurTime()) then
			local ply = LocalPlayer()
			
			if(ply:GetNWFloat("PsyDamage",0)>0.1&&ply:Alive()) then 
				local TEMP_NPCS = ents.FindInSphere(ply:GetPos(),3000)
				
				if(#TEMP_NPCS>0) then
					for N=1, #TEMP_NPCS do
						if(IsValid(TEMP_NPCS[N])&&TEMP_NPCS[N]!=NULL&&
						TEMP_NPCS[N]:GetClass()!="npc_stalker_controller"&&(TEMP_NPCS[N]:IsNPC()&&
						TEMP_NPCS[N]:GetMoveType()==MOVETYPE_STEP)||
						(TEMP_NPCS[N]:IsPlayer()&&TEMP_NPCS[N]!=ply&&TEMP_NPCS[N]:Alive())) then
							if(!isfunction(TEMP_NPCS[N].RenderOverride)) then
								TEMP_NPCS[N].RenderOverride = ControllerNpcFuncChangeDraw
							end
						end
					end
				end
			end
			
			TEMP_ControllerReDrawNext = CurTime()+1
		end
	end)
end

/*
hook.Add( "PostDrawOpaqueRenderables", "BControllerReRenderCreatures", function()
	local ply = LocalPlayer()
	
	if(ply:GetNWFloat("PsyDamage",0)>0.1&&ply:Alive()) then 
		local TEMP_NPCS = ents.FindInSphere(ply:GetPos(),3000)
		
		if(#TEMP_NPCS>0) then
			for N=1, #TEMP_NPCS do
				if((TEMP_NPCS[N]:IsNPC()&&TEMP_NPCS[N]!=NULL&&TEMP_NPCS[N]:GetMoveType()==MOVETYPE_STEP)||
				(TEMP_NPCS[N]:IsPlayer()&&TEMP_NPCS[N]!=ply&&TEMP_NPCS[N]:Alive())) then
					local TEMP_RealModel = TEMP_NPCS[N]:GetModel()
					local TEMP_RealPos = TEMP_NPCS[N]:GetPos()
					
					if(!isvector(TEMP_NPCS[N].TEMP_PrevPos)) then
						TEMP_NPCS[N].TEMP_PrevPos = TEMP_RealPos
					end
					
					
					local TEMP_Seq = "S_Idle"
					
					if(TEMP_RealPos:Distance(TEMP_NPCS[N].TEMP_PrevPos)>2) then
						TEMP_Seq = "S_Walk"
					end
					
					TEMP_NPCS[N]:SetModel("models/GSC/S.T.A.L.K.E.R/Monsters/Controller.mdl")
					TEMP_NPCS[N]:SetModelScale(1)
					
					TEMP_NPCS[N]:SetSequence(TEMP_NPCS[N]:LookupSequence(TEMP_Seq))
					
					local TEMP_RandVec = (VectorRand()*math.random(5,10))
					TEMP_NPCS[N]:SetPos(TEMP_NPCS[N]:GetPos()+TEMP_RandVec)
					//TEMP_NPCS[N]:SetupBones()
					TEMP_NPCS[N]:DrawModel()
					
					
					
					TEMP_NPCS[N]:SetPos(TEMP_RealPos)
					TEMP_NPCS[N]:SetModelScale(0)
					TEMP_NPCS[N]:SetModel(TEMP_RealModel)
					//TEMP_NPCS[N]:SetupBones()
					
					if(TEMP_CheckPosTime<CurTime()) then
						TEMP_NPCS[N].TEMP_PrevPos = TEMP_RealPos
						TEMP_CheckPosTime = CurTime()+0.1
					end
				end
			end
		end
	end
	
end)*/


hook.Add("Think","StalkerControllerPlayerPsyDamage",function()
	if(CLIENT) then
		if(IsValid(LocalPlayer())&&LocalPlayer()!=nil&&LocalPlayer()!=NULL) then
			if(LanguageChoosen==0) then
				if(system.GetCountry()=="RU"||system.GetCountry()=="BY"||system.GetCountry()=="UK") then
					language.Add("npc_stalker_burer", "Бюрер" )
					language.Add("npc_stalker_controller", "Контролёр" )
				else
					language.Add("npc_mutant_burer", "Burer" )
					language.Add("npc_mutant_controller", "Controller" )
					language.Add("npc_mutant_dog", "Dog" )
					language.Add("npc_mutant_snork", "Snork" )
					language.Add("npc_mutant_classiczombie", "Zombie" )
					language.Add("npc_mutant_boar", "Boar" )
					language.Add("npc_mutant_flesh", "Flesh" )
					language.Add("npc_mutant_cat", "Cat" )
					language.Add("npc_mutant_chimera", "Chimera" )
					language.Add("npc_mutant_bloodsucker", "Bloodsucker" )
					language.Add("npc_mutant_rodent", "Tushkano" )
					language.Add("npc_mutant_psydog", "Psydog" )
					language.Add("npc_mutant_pseudodog", "Pseudodog" )
				end
				LanguageChoosen = 1
			end
		end
	end
		
	for P=1, #player.GetAll() do
		local ply = player.GetAll()[P]
		
		if(SERVER) then
			if(ControllerPlayerPsyEffectTime<CurTime()) then
						
				local TEMP_CONTROLLERS = ents.FindByClass("npc_mutant_controller")
				
				if(GetConVar("ai_ignoreplayers"):GetInt()==0&&#TEMP_CONTROLLERS>0) then
					local TEMP_NEARESTCONTROLLER = ply
					local TEMP_NEARESTCONTROLLERDISTANCE = 1200
					
					for C=1, #TEMP_CONTROLLERS do
						local ent = TEMP_CONTROLLERS[C]
						local TEMP_CONTROLLERDISTANCE = ply:GetPos():Distance(ent:GetPos())
						
						if(ent:Visible(ply)&&TEMP_CONTROLLERDISTANCE<TEMP_NEARESTCONTROLLERDISTANCE) then
							TEMP_NEARESTCONTROLLERDISTANCE = TEMP_CONTROLLERDISTANCE
							TEMP_NEARESTCONTROLLER = ent
							
							ply:SetNWFloat("PsyDamage",
							math.Clamp(ply:GetNWFloat("PsyDamage",0)+((1200-TEMP_CONTROLLERDISTANCE)/500000),0,0.5))
						end
					end
					
					if(TEMP_NEARESTCONTROLLER!=ply) then
						if(ply:GetEyeTrace().Entity==TEMP_NEARESTCONTROLLER) then
							ply:ViewPunch(Angle(math.random(-1,1)*1.5,math.random(-1,1)*1.5,math.random(-1,1)*1.5))
						end
						
						if(ply.ControlPsyAuraPlayerSound&&!string.find(tostring(ply.ControlPsyAuraPlayerSound),
						"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_presence_3.wav")) then
							ply.ControlPsyAuraPlayerSound:Stop()
							ply.ControlPsyAuraPlayerSound = nil
						end
						
						
						if(!timer.Exists("ControllerCameraShake"..tostring(ply))||ply.ControlPsyAuraPlayerSound==nil) then
							ply.ControlPsyAuraPlayerSound = TEMP_NEARESTCONTROLLER:ControllerPlaySoundToPlayer(ply,"Stalker.Controller.PsyAura3")
						end
						
					else
						ply:SetNWFloat("PsyDamage",math.max(ply:GetNWFloat("PsyDamage",0)-0.01,0))
						
						if(ply.ControlPsyAuraPlayerSound) then
							ply.ControlPsyAuraPlayerSound:Stop()
							ply.ControlPsyAuraPlayerSound = nil
						end
								
					end
				else
					ply:SetNWFloat("PsyDamage",math.max(ply:GetNWFloat("PsyDamage",0)-0.01,0))
					
					if(ply.ControlPsyAuraPlayerSound) then
						ply.ControlPsyAuraPlayerSound:Stop()
						ply.ControlPsyAuraPlayerSound = nil
					end
				end

				ControllerPlayerPsyEffectTime = CurTime()+0.2
			end
		end
				
		if(ply:GetNWFloat("PsyHealthTemp",0)>0||ply:GetNWFloat("PsyDamage",0)>0) then 

			if(SERVER) then
				if(!timer.Exists("ControllerCameraShake"..tostring(ply))) then
					local TEMP_CAMSHAKENUM = 0
					local TEMP_CAMSHAKESIDE = -1
					
					if(timer.Exists("ControllerCameraShake"..tostring(ply))) then
						timer.Remove("ControllerCameraShake"..tostring(ply))
					end
					
						
					timer.Create("ControllerCameraShake"..tostring(ply),0.04,0,function()
						if(ply:GetNWFloat("PsyDamage",0)>0) then
							if(IsValid(ply)&&ply!=NULL) then
								ply:ViewPunch(Angle(0,0,(TEMP_CAMSHAKENUM*ply:GetNWFloat("PsyDamage",0))/6))
								
								
								TEMP_CAMSHAKENUM = TEMP_CAMSHAKENUM+TEMP_CAMSHAKESIDE
								
								if(TEMP_CAMSHAKENUM==30||TEMP_CAMSHAKENUM==-30) then
									TEMP_CAMSHAKESIDE = TEMP_CAMSHAKESIDE*-1
								end
							end
						end
					end)
				end
						
				ply:SetNWFloat("PsyHealthTemp",math.max(ply:GetNWFloat("PsyHealthTemp",0)-0.00001,0))
				
				ply:SetNWFloat("PsyHealthTemp",ply:GetNWFloat("PsyHealthTemp",0)+ply:GetNWFloat("PsyDamage",0))
				
				if(ply:GetNWFloat("PsyHealthTemp",0)>100) then
					if(ply:Health()>1) then
						if((game.MaxPlayers()==1&&ply:IsFlagSet(FL_GODMODE)==false)||
						(game.MaxPlayers()>1&&GetConVar("sbox_godmode"):GetInt()==0)) then
							ply:SetHealth(ply:Health()-1)
						end
						ply:SetNWFloat("PsyHealthTemp",ply:GetNWFloat("PsyHealthTemp",0)-100,0)
					else
						if(ply:IsFlagSet(FL_GODMODE)==false) then
							local TEMP_TargetDamage = DamageInfo()
							
							TEMP_TargetDamage:SetDamage(15)
							TEMP_TargetDamage:SetInflictor(ply)
							TEMP_TargetDamage:SetDamageType(DMG_SONIC)
							TEMP_TargetDamage:SetAttacker(ply)
							TEMP_TargetDamage:SetDamagePosition(ply:GetPos()+ply:OBBCenter())
							TEMP_TargetDamage:SetDamageForce(Vector(0,0,0))
							ply:TakeDamageInfo(TEMP_TargetDamage)
						end
					end
				end
			else
				util.ScreenShake( LocalPlayer():GetPos(), ply:GetNWFloat("PsyDamage",0)*2, 
				ply:GetNWFloat("PsyDamage",0)*2, 0.2, 5 )
			end
		end
	end
end)
	
if(CLIENT) then
	local TEMP_NEXTSCARYSOUNDTIME = 0
	local PsyVoicesPlaying = false
	
	hook.Add( "PreDrawHUD", "ControllerPsyEffect_Client", function()
		if(IsValid(LocalPlayer())&&LocalPlayer():Alive()) then
			local TEMP_PSYDMG = LocalPlayer():GetNWFloat("PsyDamage",0)
			
			if(TEMP_PSYDMG>0.2) then
				if(PsyVoicesPlaying==false) then
					LocalPlayer():EmitSound("Stalker.Controller.Voices")
					PsyVoicesPlaying = true
				end
				
				if(TEMP_NEXTSCARYSOUNDTIME<CurTime()) then
					local TEMP_SCARYSOUND = "Stalker.Controller.Glitches"..math.random(1,11)
					
					TEMP_NEXTSCARYSOUNDTIME = CurTime()+math.random(2,8)+SoundDuration(TEMP_SCARYSOUND)
					
					LocalPlayer():EmitSound(TEMP_SCARYSOUND)
				end
			else
				if(PsyVoicesPlaying==true) then
					LocalPlayer():StopSound("Stalker.Controller.Voices")
					PsyVoicesPlaying = false
				end
			end
				
			if(TEMP_PSYDMG>0) then
				local tab = {
					[ "$pp_colour_addr" ] = 0.01*(TEMP_PSYDMG*2),
					[ "$pp_colour_addg" ] = 0.02*(TEMP_PSYDMG*2),
					[ "$pp_colour_addb" ] = 0.3*(TEMP_PSYDMG*2),
					[ "$pp_colour_brightness" ] = -0.43*(TEMP_PSYDMG*2),
					[ "$pp_colour_contrast" ] = 1-(0.22*(TEMP_PSYDMG*2)),
					[ "$pp_colour_colour" ] = 1-(0.7*(TEMP_PSYDMG*2)),
				}

				DrawColorModify( tab )
				
				
				
				
				
				DrawMotionBlur( 0.3, 0.9*(TEMP_PSYDMG*2), 0.001 )
				
				
				
				
				
				local TEMP_BLUR = Material("pp/blurscreen")
			
				cam.Start2D()
					local x, y = 0, 0
					local scrW, scrH = ScrW(), ScrH()
					surface.SetDrawColor(255, 255, 255)
					surface.SetMaterial( TEMP_BLUR )
					
					for i = 1, 3 do
						TEMP_BLUR:SetFloat("$blur", (LocalPlayer():GetNWFloat("PsyDamage",0)*3)*i)
						TEMP_BLUR:Recompute()
						render.UpdateScreenEffectTexture()
						surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
					end
				cam.End2D()
			end
		end
	end )
	
	
	hook.Add("PostDrawOpaqueRenderables","StalkerControllerGlitches",function(isDrawingDepth, isDrawSkybox )
		if(LocalPlayer():Alive()&&LocalPlayer():GetNWFloat("PsyDamage",0)>0.2) then
			
		end
	end)
end

if(CLIENT) then
	net.Receive("STALKERNPCControllerStopPsySound", function()
		if(PsyVoicesPlaying==true) then
			LocalPlayer():StopSound("Stalker.Controller.Voices")
			PsyVoicesPlaying = false
		end
	end)
end



if(SERVER) then
	hook.Add("EntityTakeDamage" , "Burer Bolt Damage" , function( ent , dmginfo )
		if(IsValid(dmginfo:GetInflictor())&&dmginfo:GetInflictor():GetClass()=="crossbow_bolt"&&
		IsValid(dmginfo:GetInflictor():GetOwner())&&dmginfo:GetInflictor():GetOwner():GetClass()=="npc_stalker_burer") then
			if(isnumber(dmginfo:GetInflictor().BurerBoltDamage)) then
				dmginfo:SetAttacker(dmginfo:GetInflictor():GetOwner())
				dmginfo:SetDamage( dmginfo:GetInflictor().BurerBoltDamage )
			end
		end
	end)
end


function STALKERNPCClearPsyEffect(ply)
	if(timer.Exists("ControllerCameraShake"..tostring(ply))) then
		timer.Remove("ControllerCameraShake"..tostring(ply))
	end
	
	if(ply.ControlPsyAuraPlayerSound) then
		ply.ControlPsyAuraPlayerSound:Stop()
		ply.ControlPsyAuraPlayerSound = nil
	end
	
	ply:SetNWFloat("PsyDamage",0)
	ply:SetNWFloat("PsyHealthTemp",0)
	
	net.Start("STALKERNPCControllerStopPsySound")
	net.Send(ply)
end


hook.Add("PlayerDeath","StalkerControllerPlayerDeath",function(ply)
	STALKERNPCClearPsyEffect(ply)
end)


hook.Add("PlayerSpawn","StalkerControllerPlayerPsyHealthRestore",function(ply)
	STALKERNPCClearPsyEffect(ply)
end)
