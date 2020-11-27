if(SERVER) then
	util.AddNetworkString("STALKERNPCControllerStopPsySound")
end
local TEMP_ANGERDIST = 85
local TEMP_IDLEDIST = 55

game.AddParticles("particles/stalker_anomaly.pcf")
PrecacheParticleSystem("electra")
PrecacheParticleSystem("electra_activated")
PrecacheParticleSystem("electra_static")
PrecacheParticleSystem("electra_static_electra")

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
AddNPC("Zombie (Babka)","npc_mutant_classiczombie_babka")
AddNPC("Zombie (Radioactive)","npc_mutant_classiczombie_radio")
AddNPC("Zombie (Volatile)","npc_mutant_classiczombie_volatile")
AddNPC("Boar","npc_mutant_boar")
AddNPC("Flesh","npc_mutant_flesh")
AddNPC("Cat","npc_mutant_cat")
AddNPC("Chimera","npc_mutant_chimera")
AddNPC("Bloodsucker","npc_mutant_bloodsucker")
AddNPC("Pseudodog","npc_mutant_pseudodog")
AddNPC("Psydog","npc_mutant_psydog")
AddNPC("Tushkano","npc_mutant_rodent")

--AddNPC("Snork - New","npc_mutant_snorkold")  --Old snork

AddNPC("Controller (Fast)","npc_mutant_controller_fast")
AddNPC("Controller (Electric)","npc_mutant_controller_electro")

AddNPC("Izlom","npc_mutant_izlom")

AddNPC("Bear","npc_mutant_bear")

AddNPC("Skeleton","npc_mutant_skeleton")

AddNPC("Chimera (Electro)","npc_mutant_chimera_electro")

AddNPC("Pseudogiant (Fast)","npc_mutant_pseudogiant_fast")
AddNPC("Pseudogiant (Slow)","npc_mutant_pseudogiant_slow")

AddNPC("Karlik","npc_mutant_karlik")

AddNPC("Hellhound","npc_mutant_hellhound")

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

AddSound("Stalker.Controller.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_0.wav")
AddSound("Stalker.Controller.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_die_1.wav")

AddSound("Stalker.Controller.Pain1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_0.wav")
AddSound("Stalker.Controller.Pain2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_1.wav")
AddSound("Stalker.Controller.Pain3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_hit_2.wav")

AddSound("Stalker.Controller.SpecialAttack1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/controller/controller_attack_hit.wav")

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






AddSound("Stalker.Burer.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attacking_0.wav")

AddSound("Stalker.Burer.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_0.wav")
AddSound("Stalker.Burer.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_1.wav")
AddSound("Stalker.Burer.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_2.wav")

AddSound("Stalker.Burer.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attack_0.wav")

AddSound("Stalker.Burer.Push1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_attack_0.wav")
AddSound("Stalker.Burer.Tele1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_telekinetic_0.wav")


AddSound("Stalker.Karlik.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attacking_0.wav")

AddSound("Stalker.Karlik.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_0.wav")
AddSound("Stalker.Karlik.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_1.wav")
AddSound("Stalker.Karlik.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_idle_2.wav")

AddSound("Stalker.Karlik.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_attack_0.wav")

AddSound("Stalker.Karlik.Push1",CHAN_VOICE,1,TEMP_ANGERDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_attack_0.wav")
AddSound("Stalker.Karlik.Tele1",CHAN_VOICE,1,TEMP_ANGERDIST,120,130,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_telekinetic_0.wav")

AddSound("Stalker.KarlikWave.Collide",CHAN_WEAPON,1,400,98,102,"GSC/S.T.A.L.K.E.R/Monsters/burer/burer_gravi_wave_0.wav")




AddSound("Stalker.Claw.Hit",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/slash_physics_hit1.wav")
AddSound("Stalker.Claw.Miss",CHAN_WEAPON,1,300,98,102,"GSC/S.T.A.L.K.E.R/Monsters/claw_miss.wav")

-- Pseudogiant sounds
----IDLE
AddSound("Stalker.Pseudogiant.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/giant2/11.ogg")
AddSound("Stalker.Pseudogiant.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/giant2/giant_underground_0.ogg")
AddSound("Stalker.Pseudogiant.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/giant2/giant_threaten_0.ogg")
AddSound("Stalker.Pseudogiant.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/giant2/giant_threaten_1.ogg")
----CHASE
AddSound("Stalker.Pseudogiant.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_aggressive_0.ogg")
AddSound("Stalker.Pseudogiant.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_aggressive_1.ogg")
AddSound("Stalker.Pseudogiant.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_breath_0.ogg")
AddSound("Stalker.Pseudogiant.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_breath_1.ogg")
AddSound("Stalker.Pseudogiant.Chase5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_breath_2.ogg")
AddSound("Stalker.Pseudogiant.Chase6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_breath_3.ogg")
AddSound("Stalker.Pseudogiant.Chase7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_breath_4.ogg")
----HIT
AddSound("Stalker.Pseudogiant.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_hit.ogg")
AddSound("Stalker.Pseudogiant.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_threaten_1.ogg")
AddSound("Stalker.Pseudogiant.Melee3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_attack_0.ogg")
AddSound("Stalker.Pseudogiant.Melee4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_attack_1.ogg")
----MISS
AddSound("Stalker.Pseudogiant.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Pseudogiant.Miss2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Pseudogiant.Miss3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Pseudogiant.Miss4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Pseudogiant.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_death_1.ogg")
AddSound("Stalker.Pseudogiant.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/giant/giant_hurt_4.ogg")

-- Dog sounds
----IDLE
AddSound("Stalker.Dog.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_1.wav")
AddSound("Stalker.Dog.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_2.wav")
AddSound("Stalker.Dog.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_3.wav")
AddSound("Stalker.Dog.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/dog/bdog_idle_4.wav")
----HIT
AddSound("Stalker.Dog.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/attack_hit_1.wav")
AddSound("Stalker.Dog.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/attack_hit_2.wav")
AddSound("Stalker.Dog.Melee3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/attack_hit_3.wav")
AddSound("Stalker.Dog.Melee4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/attack_hit_4.wav")
----MISS
AddSound("Stalker.Dog.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Dog.Miss2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Dog.Miss3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Dog.Miss4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Dog.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/bdog_die_2.wav")
AddSound("Stalker.Dog.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/dog/bdog_die_3.wav")

-- Bear sounds
----IDLE
AddSound("Stalker.Bear.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/bear/bear_aggressive_0.ogg")
AddSound("Stalker.Bear.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/bear/bear_idle_0.ogg")
AddSound("Stalker.Bear.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/bear/bear_threaten_1.ogg")
----HIT
AddSound("Stalker.Bear.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_attack_0.ogg")
AddSound("Stalker.Bear.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_attack_1.ogg")
----MISS
AddSound("Stalker.Bear.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Bear.Miss2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Bear.Miss3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Bear.Miss4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Bear.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_death_0.ogg")
AddSound("Stalker.Bear.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_death_1.ogg")
AddSound("Stalker.Bear.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_death_2.ogg")
AddSound("Stalker.Bear.Die4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/bear/bear_death_3.ogg")

-- Izlom sounds
----IDLE
AddSound("Stalker.Izlom.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/izlome/izlome_idle_1.ogg")
AddSound("Stalker.Izlom.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/izlome/izlome_idle_12.ogg")
AddSound("Stalker.Izlom.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/izlome/izlome_idle_2.ogg")
AddSound("Stalker.Izlom.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/izlome/izlome_idle_3.ogg")
AddSound("Stalker.Izlom.Idle5",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/izlome/izlome_idle_4.ogg")
----CHASE
AddSound("Stalker.Izlom.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_1.ogg")
AddSound("Stalker.Izlom.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_2.ogg")
AddSound("Stalker.Izlom.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_3.ogg")
AddSound("Stalker.Izlom.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_4.ogg")
AddSound("Stalker.Izlom.Chase5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_5.ogg")
AddSound("Stalker.Izlom.Chase6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_6.ogg")
AddSound("Stalker.Izlom.Chase7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_7.ogg")
AddSound("Stalker.Izlom.Chase8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_attack_8.ogg")
AddSound("Stalker.Izlom.Chase9",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_enemy_1.ogg")
AddSound("Stalker.Izlom.Chase10",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_enemy_2.ogg")
AddSound("Stalker.Izlom.Chase11",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_enemy_3.ogg")
AddSound("Stalker.Izlom.Chase12",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_enemy_4.ogg")
AddSound("Stalker.Izlom.Chase13",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_enemy_5.ogg")
----HIT
AddSound("Stalker.Izlom.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_hit_1.ogg")
AddSound("Stalker.Izlom.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_hit_2.ogg")
AddSound("Stalker.Izlom.Melee3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_hit_3.ogg")
AddSound("Stalker.Izlom.Melee4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_hit_4.ogg")
----MISS
AddSound("Stalker.Izlom.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Izlom.Miss2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Izlom.Miss3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Izlom.Miss4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Izlom.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_death_2.ogg")
AddSound("Stalker.Izlom.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_death_3.ogg")
AddSound("Stalker.Izlom.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_death_4.ogg")
AddSound("Stalker.Izlom.Die4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_death_5.ogg")
AddSound("Stalker.Izlom.Die5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/izlome/izlome_death_6.ogg")

-- Snork sounds
----IDLE
AddSound("Stalker.Snork.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_1.wav")
AddSound("Stalker.Snork.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_2.wav")
AddSound("Stalker.Snork.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/snork/snork_idle_3.wav")
----HIT
AddSound("Stalker.Snork.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/snork/snork_attack_1.wav")
AddSound("Stalker.Snork.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/snork/snork_attack_2.wav")
----MISS
AddSound("Stalker.Snork.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
AddSound("Stalker.Snork.Miss2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss2.wav")
AddSound("Stalker.Snork.Miss3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss3.wav")
AddSound("Stalker.Snork.Miss4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss4.wav")
----DEATH
AddSound("Stalker.Snork.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/snork/snorkscream.wav")
AddSound("Stalker.Snork.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/snork/snorkbreath.wav")

-- Zombie sounds
----IDLE
AddSound("Stalker.Zombie.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_1.ogg")
AddSound("Stalker.Zombie.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_2.ogg")
AddSound("Stalker.Zombie.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_3.ogg")
AddSound("Stalker.Zombie.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_4.ogg")
AddSound("Stalker.Zombie.Idle5",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_5.ogg")
AddSound("Stalker.Zombie.Idle6",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_6.ogg")
AddSound("Stalker.Zombie.Idle7",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_7.ogg")
AddSound("Stalker.Zombie.Idle8",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_8.ogg")
AddSound("Stalker.Zombie.Idle9",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_9.ogg")
AddSound("Stalker.Zombie.Idle10",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie/zombie_idle_10.ogg")
----CHASE
AddSound("Stalker.Zombie.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_take_damage_1.ogg")
AddSound("Stalker.Zombie.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_11.ogg")
AddSound("Stalker.Zombie.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_12.ogg")
AddSound("Stalker.Zombie.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_13.ogg")
AddSound("Stalker.Zombie.Chase5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_14.ogg")
AddSound("Stalker.Zombie.Chase6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_15.ogg")
AddSound("Stalker.Zombie.Chase7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_16.ogg")
AddSound("Stalker.Zombie.Chase8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_idle_17.ogg")
----HIT
AddSound("Stalker.Zombie.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_1.ogg")
AddSound("Stalker.Zombie.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_2.ogg")
AddSound("Stalker.Zombie.Hit3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_3.ogg")
AddSound("Stalker.Zombie.Hit4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_4.ogg")
AddSound("Stalker.Zombie.Hit5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_5.ogg")
AddSound("Stalker.Zombie.Hit6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_6.ogg")
AddSound("Stalker.Zombie.Hit7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_7.ogg")
AddSound("Stalker.Zombie.Hit8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_8.ogg")
AddSound("Stalker.Zombie.Hit9",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_9.ogg")
AddSound("Stalker.Zombie.Hit10",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_attack_10.ogg")
----MISS
AddSound("Stalker.Zombie.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Zombie.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_1.ogg")
AddSound("Stalker.Zombie.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_2.ogg")
AddSound("Stalker.Zombie.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_3.ogg")
AddSound("Stalker.Zombie.Die4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_4.ogg")
AddSound("Stalker.Zombie.Die5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_5.ogg")
AddSound("Stalker.Zombie.Die6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_6.ogg")
AddSound("Stalker.Zombie.Die7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_7.ogg")
AddSound("Stalker.Zombie.Die8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_8.ogg")
AddSound("Stalker.Zombie.Die9",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie/zombie_die_9.ogg")

-- ZombieBabka sounds
----IDLE
AddSound("Stalker.ZombieB.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_1.ogg")
AddSound("Stalker.ZombieB.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_2.ogg")
AddSound("Stalker.ZombieB.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_3.ogg")
AddSound("Stalker.ZombieB.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_4.ogg")
AddSound("Stalker.ZombieB.Idle5",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_5.ogg")
AddSound("Stalker.ZombieB.Idle6",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_6.ogg")
AddSound("Stalker.ZombieB.Idle7",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_7.ogg")
AddSound("Stalker.ZombieB.Idle8",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_8.ogg")
AddSound("Stalker.ZombieB.Idle9",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_9.ogg")
AddSound("Stalker.ZombieB.Idle10",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_10.ogg")
AddSound("Stalker.ZombieB.Idle11",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_11.ogg")
AddSound("Stalker.ZombieB.Idle12",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_12.ogg")
AddSound("Stalker.ZombieB.Idle13",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_13.ogg")
AddSound("Stalker.ZombieB.Idle14",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_14.ogg")
AddSound("Stalker.ZombieB.Idle15",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_15.ogg")
AddSound("Stalker.ZombieB.Idle16",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_16.ogg")
AddSound("Stalker.ZombieB.Idle17",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_17.ogg")
AddSound("Stalker.ZombieB.Idle18",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_18.ogg")
AddSound("Stalker.ZombieB.Idle19",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_19.ogg")
AddSound("Stalker.ZombieB.Idle20",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_20.ogg")
AddSound("Stalker.ZombieB.Idle21",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_21.ogg")
AddSound("Stalker.ZombieB.Idle22",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_22.ogg")
AddSound("Stalker.ZombieB.Idle23",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_23.ogg")
AddSound("Stalker.ZombieB.Idle24",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_24.ogg")
AddSound("Stalker.ZombieB.Idle25",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_25.ogg")
AddSound("Stalker.ZombieB.Idle26",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_26.ogg")
AddSound("Stalker.ZombieB.Idle27",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_27.ogg")
AddSound("Stalker.ZombieB.Idle28",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_28.ogg")
AddSound("Stalker.ZombieB.Idle29",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_29.ogg")
AddSound("Stalker.ZombieB.Idle30",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"npc/zombie_w/zombie_idle_30.ogg")
----CHASE
AddSound("Stalker.ZombieB.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_take_damage_1.ogg")
AddSound("Stalker.ZombieB.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_11.ogg")
AddSound("Stalker.ZombieB.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_12.ogg")
AddSound("Stalker.ZombieB.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_13.ogg")
AddSound("Stalker.ZombieB.Chase5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_14.ogg")
AddSound("Stalker.ZombieB.Chase6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_15.ogg")
AddSound("Stalker.ZombieB.Chase7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_16.ogg")
AddSound("Stalker.ZombieB.Chase8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_idle_17.ogg")
----HIT
AddSound("Stalker.ZombieB.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_1.ogg")
AddSound("Stalker.ZombieB.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_3.ogg")
AddSound("Stalker.ZombieB.Hit3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_4.ogg")
AddSound("Stalker.ZombieB.Hit4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_5.ogg")
AddSound("Stalker.ZombieB.Hit5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_6.ogg")
AddSound("Stalker.ZombieB.Hit6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_8.ogg")
AddSound("Stalker.ZombieB.Hit7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_10.ogg")
AddSound("Stalker.ZombieB.Hit8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_11.ogg")
AddSound("Stalker.ZombieB.Hit9",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_12.ogg")
AddSound("Stalker.ZombieB.Hit10",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_13.ogg")
AddSound("Stalker.ZombieB.Hit11",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_14.ogg")
AddSound("Stalker.ZombieB.Hit12",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_15.ogg")
AddSound("Stalker.ZombieB.Hit13",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_16.ogg")
AddSound("Stalker.ZombieB.Hit14",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_17.ogg")
AddSound("Stalker.ZombieB.Hit15",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_attack_18.ogg")
----MISS
AddSound("Stalker.ZombieB.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.ZombieB.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_1.ogg")
AddSound("Stalker.ZombieB.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_2.ogg")
AddSound("Stalker.ZombieB.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_3.ogg")
AddSound("Stalker.ZombieB.Die4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_4.ogg")
AddSound("Stalker.ZombieB.Die5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_5.ogg")
AddSound("Stalker.ZombieB.Die6",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_6.ogg")
AddSound("Stalker.ZombieB.Die7",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_7.ogg")
AddSound("Stalker.ZombieB.Die8",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_8.ogg")
AddSound("Stalker.ZombieB.Die9",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_9.ogg")
AddSound("Stalker.ZombieB.Die10",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_10.ogg")
AddSound("Stalker.ZombieB.Die11",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_11.ogg")
AddSound("Stalker.ZombieB.Die12",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_12.ogg")
AddSound("Stalker.ZombieB.Die13",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_13.ogg")
AddSound("Stalker.ZombieB.Die14",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_14.ogg")
AddSound("Stalker.ZombieB.Die15",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_15.ogg")
AddSound("Stalker.ZombieB.Die16",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_16.ogg")
AddSound("Stalker.ZombieB.Die17",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_17.ogg")
AddSound("Stalker.ZombieB.Die18",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"npc/zombie_w/zombie_die_18.ogg")

-- Boar sounds
----IDLE
AddSound("Stalker.Boar.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/boar/boar_idle_1.wav")
AddSound("Stalker.Boar.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/boar/boar_idle_2.wav")
----HIT
AddSound("Stalker.Boar.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/boar/boar_attack_1.wav")
AddSound("Stalker.Boar.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/boar/boar_attack_2.wav")
----MISS
AddSound("Stalker.Boar.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Boar.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/boar/boar_death_1.wav")
AddSound("Stalker.Boar.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/boar/boar_death_2.wav")
AddSound("Stalker.Boar.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/boar/boar_death_3.wav")

-- Flesh sounds
----IDLE
AddSound("Stalker.Flesh.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_1.wav")
AddSound("Stalker.Flesh.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_2.wav")
AddSound("Stalker.Flesh.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_3.wav")
AddSound("Stalker.Flesh.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/flesh/flesh_idle_4.wav")
----CHASE
AddSound("Stalker.Flesh.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_1.wav")
AddSound("Stalker.Flesh.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_2.wav")
AddSound("Stalker.Flesh.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_aggressive_3.wav")
----HIT
AddSound("Stalker.Flesh.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_1.wav")
AddSound("Stalker.Flesh.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_2.wav")
AddSound("Stalker.Flesh.Hit3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_attack_3.wav")
----MISS
AddSound("Stalker.Flesh.Miss1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"misses/miss1.wav")
----DEATH
AddSound("Stalker.Flesh.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_1.wav")
AddSound("Stalker.Flesh.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_2.wav")
AddSound("Stalker.Flesh.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/flesh/flesh_death_3.wav")

-- Cat sounds
----IDLE
AddSound("Stalker.Cat.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/cat/cat_idle.wav")
----CHASE
AddSound("Stalker.Cat.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/9.wav")
AddSound("Stalker.Cat.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/cat_agr.wav")
----HIT
AddSound("Stalker.Cat.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/3.wav")
AddSound("Stalker.Cat.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/cat_att_dmg.wav")
----DEATH
AddSound("Stalker.Cat.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/cat_die.wav")
AddSound("Stalker.Cat.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/cat/cat_take_dmg.wav")


-- Chimera sounds
----IDLE
AddSound("Stalker.Chimera.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/chimera/chimera_idle_1.wav")
AddSound("Stalker.Chimera.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/chimera/chimera_idle_2.wav")
----HIT
AddSound("Stalker.Chimera.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_1.wav")
AddSound("Stalker.Chimera.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_2.wav")
AddSound("Stalker.Chimera.Hit3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_hit_1.wav")
AddSound("Stalker.Chimera.Hit4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/chimera/chimera_attack_hit_2.wav")
----DEATH
AddSound("Stalker.Chimera.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/chimera/chimera_death_1.wav")


-- Bloodsucker sounds
----IDLE
AddSound("Stalker.Bloodsucker.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/bs/idle_1.wav")
AddSound("Stalker.Bloodsucker.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/bs/idle_2.wav")
AddSound("Stalker.Bloodsucker.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/bs/idle_0.wav")
----CHASE
AddSound("Stalker.Bloodsucker.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/sucker_growl_1.wav")
AddSound("Stalker.Bloodsucker.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/sucker_growl_4.wav")
AddSound("Stalker.Bloodsucker.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_hit_2")
----HIT
AddSound("Stalker.Bloodsucker.Hit1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_0.wav")
AddSound("Stalker.Bloodsucker.Hit2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_1.wav")
AddSound("Stalker.Bloodsucker.Hit3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_2.wav")
AddSound("Stalker.Bloodsucker.Hit4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_hit_0.wav")
AddSound("Stalker.Bloodsucker.Hit5",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/attack_hit_1.wav")
----DEATH
AddSound("Stalker.Bloodsucker.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/die_0.wav")
AddSound("Stalker.Bloodsucker.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/die_1.wav")
AddSound("Stalker.Bloodsucker.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/die_2.wav")
AddSound("Stalker.Bloodsucker.Die4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/die_3.wav")
----FEEDING
AddSound("Stalker.Bloodsucker.Feed",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/bs/vampire_sucking.wav")

-- Pseudodog sounds
----IDLE
AddSound("Stalker.Pseudodog.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_0.mp3")
AddSound("Stalker.Pseudodog.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_1.mp3")
AddSound("Stalker.Pseudodog.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/pseudodog/idle_2.mp3")
----HIT
AddSound("Stalker.Pseudodog.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_0.mp3")
AddSound("Stalker.Pseudodog.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_1.mp3")
AddSound("Stalker.Pseudodog.Melee3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/attack_hit_2.mp3")
AddSound("Stalker.Pseudodog.Melee4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/attack_0.mp3")
----Chase
AddSound("Stalker.Pseudodog.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_0.mp3")
AddSound("Stalker.Pseudodog.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_1.mp3")
AddSound("Stalker.Pseudodog.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_aggression_2.mp3")
AddSound("Stalker.Pseudodog.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_idle_2.mp3.wav")
----DEATH
AddSound("Stalker.Pseudodog.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_death_0.mp3")
AddSound("Stalker.Pseudodog.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/pseudodog/pdog_death_1.mp3")

-- Tushkano sounds
----IDLE
AddSound("Stalker.Rodent.Idle1",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_0.wav")
AddSound("Stalker.Rodent.Idle2",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_1.wav")
AddSound("Stalker.Rodent.Idle3",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_2.wav")
AddSound("Stalker.Rodent.Idle4",CHAN_VOICE,1,TEMP_IDLEDIST,98,102,"hgn/stalker/creature/rodent/tushkano_idle_3.wav")
----HIT
AddSound("Stalker.Rodent.Melee1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_0.mp3")
AddSound("Stalker.Rodent.Melee2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_1.mp3")
AddSound("Stalker.Rodent.Melee3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/attack_hit_2.mp3")
AddSound("Stalker.Rodent.Melee4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/attack_0.mp3")
----Chase
AddSound("Stalker.Rodent.Chase1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_0.wav")
AddSound("Stalker.Rodent.Chase2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_1.wav")
AddSound("Stalker.Rodent.Chase3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_2.wav")
AddSound("Stalker.Rodent.Chase4",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_aggressive_3.wav")
----DEATH
AddSound("Stalker.Rodent.Die1",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_0.wav")
AddSound("Stalker.Rodent.Die2",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_1.wav")
AddSound("Stalker.Rodent.Die3",CHAN_VOICE,1,TEMP_ANGERDIST,98,102,"hgn/stalker/creature/rodent/tushkano_death_2.wav")

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


local ControllerPlayerPsyEffectTime = 0
local LanguageChoosen = 0
local TEMP_CheckPosTime = 0

/*
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

*/