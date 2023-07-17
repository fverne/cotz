local Category = "S.T.A.L.K.E.R RP Humans"

local NPC = { 	Name = "Bandit (Rifles)", 
				Class = "npc_human_bandit_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Bandit (Shotguns)", 
				Class = "npc_human_bandit_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Bandit (Pistols)", 
				Class = "npc_human_bandit_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )



local NPC = { 	Name = "Mercenary (Rifles)", 
				Class = "npc_human_merc_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Mercenary (Shotguns)", 
				Class = "npc_human_merc_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Mercenary (Pistols)", 
				Class = "npc_human_merc_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )



local NPC = { 	Name = "Military (Rifles)", 
				Class = "npc_human_mili_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Military (Shotguns)", 
				Class = "npc_human_mili_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Military (Pistols)", 
				Class = "npc_human_mili_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )




local NPC = { 	Name = "Zombified Rookie (Rifles)", 
				Class = "npc_human_z_rookie_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Rookie (Shotguns)", 
				Class = "npc_human_z_rookie_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Rookie (Pistols)", 
				Class = "npc_human_z_rookie_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )



local NPC = { 	Name = "Zombified Mercenary (Rifles)", 
				Class = "npc_human_z_merc_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Mercenary (Shotguns)", 
				Class = "npc_human_z_merc_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Mercenary (Pistols)", 
				Class = "npc_human_z_merc_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )



local NPC = { 	Name = "Zombified Military (Rifles)", 
				Class = "npc_human_z_mili_rifleman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Military (Shotguns)", 
				Class = "npc_human_z_mili_shotgunner",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )
local NPC = { 	Name = "Zombified Military (Pistols)", 
				Class = "npc_human_z_mili_pistolman",
				Category = Category	}
list.Set( "NPC", NPC.Class, NPC )



local Npc = FindMetaTable("NPC")
 
function Npc:GetEyeTrace()
 local pos = self:GetShootPos() 
 local ang = self:GetAimVector() 
 local tracedata = {} 
 tracedata.start = pos 
 tracedata.endpos = pos+(ang*25000) 
 tracedata.filter = self
 local trace = util.TraceLine(tracedata) 
 return trace
end 
  
function Npc:Alive()
  if self:Health() > 0 then return true end
end
  
function Npc:KeyDown()
 if math.Rand(1,10)  == 1 then return true end --Someone should make A.I. to tell the npc which key to press, this is just a temp solution
end