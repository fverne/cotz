AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

-- Preset
ENT.bleeds      = true
ENT.StartHealth = 100
ENT.PlayerFriendly = false
ENT.flatbulletresistance = 10
ENT.percentbulletresistance = 20
ENT.lootChance = 33
ENT.selectedWeaponItem = nil 
ENT.selectedWeaponSWEP = nil

ENT.alertsounds  = {
  "npc/bandit/enemy_1.ogg",
  "npc/bandit/enemy_2.ogg",
  "npc/bandit/enemy_3.ogg",
  "npc/bandit/enemy_4.ogg",
  "npc/bandit/enemy_5.ogg",
  "npc/bandit/enemy_6.ogg",
  "npc/bandit/enemy_7.ogg",
}

ENT.attacksounds = {  
  "npc/bandit/attack_1.ogg", 
  "npc/bandit/attack_2.ogg",
  "npc/bandit/attack_3.ogg",
  "npc/bandit/attack_4.ogg",
  "npc/bandit/attack_5.ogg",
  "npc/bandit/attack_6.ogg"
}

ENT.hurtsounds   = {
  "npc/bandit/hit_1.ogg",
  "npc/bandit/hit_2.ogg",
  "npc/bandit/hit_3.ogg",
  "npc/bandit/hit_4.ogg",
  "npc/bandit/hit_5.ogg",
  "npc/bandit/hit_6.ogg",
  "npc/bandit/hit_7.ogg"
}

ENT.diesounds    = {
  "npc/bandit/death_1.ogg",
  "npc/bandit/death_2.ogg",
  "npc/bandit/death_3.ogg",
  "npc/bandit/death_4.ogg",
  "npc/bandit/death_5.ogg",
  "npc/bandit/death_6.ogg"
}

ENT.models       = {
  "models/bandit/bandit_regulare.mdl",
  "models/bandit/bandit_veteran.mdl",
  "models/bandit/bandit_novice.mdl",
}

ENT.weapons      = {
  {{"toz106", { ["durability"] = 10, ["wear"] = 15, ["ammo"] = 2 }}, "weapon_npc_toz34"},
  {{"ij600", { ["durability"] = 10, ["wear"] = 15, ["ammo"] = 1 }}, "weapon_npc_toz34"},
  {{"mp27", { ["durability"] = 10, ["wear"] = 15, ["ammo"] = 2 }}, "weapon_npc_toz34"},
  {{"lax410s", { ["durability"] = 3, ["wear"] = 5, ["ammo"] = 2 }}, "weapon_npc_sawnoff"},
  {{"toz34short", { ["durability"] = 3, ["wear"] = 5, ["ammo"] = 1 }}, "weapon_npc_sawnoff"},
  {{"toz66short", { ["durability"] = 3, ["wear"] = 5, ["ammo"] = 1 }}, "weapon_npc_sawnoff"},
}

-- Live vars
ENT.Alerted     = false
ENT.MeleeAttacking = false
ENT.TakingCover = false
ENT.FindingLOS  = false
ENT.CanSeeEnemy = false
ENT.TimeToTakeCover = 0
ENT.GotACloseOne = false
ENT.dead = false
ENT.speaktime = 0
ENT.FireBurst = 0
ENT.NextAttack = 0
   
function ENT:Initialize()

  local selectedWeaponIndex = math.random(#self.weapons)
  for i=1, #self.weapons do
    if selectedWeaponIndex == i then
      self.selectedWeaponItem = self.weapons[i][1]
      self.selectedWeaponSWEP = self.weapons[i][2]
    end
  end

  self:Give(self.selectedWeaponSWEP)

  self:SetModel(self.models[math.random(1,#self.models)])

  self:SetSkin(math.random(1,self:SkinCount()))
   
  self:SetHullType( HULL_HUMAN )
  self:SetHullSizeNormal();
  self:SetSolid( SOLID_BBOX )
  self:SetMoveType( MOVETYPE_STEP )
  self:CapabilitiesAdd( CAP_MOVE_GROUND )
  self:CapabilitiesAdd( CAP_OPEN_DOORS )
  self:CapabilitiesAdd( CAP_SQUAD )
  self:CapabilitiesAdd( CAP_ANIMATEDFACE )
  self:CapabilitiesAdd( CAP_USE_WEAPONS )
  self:CapabilitiesAdd( CAP_SQUAD )
  self:CapabilitiesAdd( CAP_DUCK )
  self:CapabilitiesAdd( CAP_MOVE_SHOOT )
  self:CapabilitiesAdd( CAP_TURN_HEAD )
  self:CapabilitiesAdd( CAP_USE_SHOT_REGULATOR )
  self:CapabilitiesAdd( CAP_AIM_GUN )
  self:CapabilitiesAdd( CAP_WEAPON_RANGE_ATTACK1 )
  self:SetMaxYawSpeed( 5000 )

  self:SetHealth(self.StartHealth)
  self:SetEnemy(NULL)

  self:AddRelationship("player D_HT 10")
  self:InitEnemies()

  self:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD )
end
   
function ENT:OnTakeDamage(dmg)
  if(dmg:IsDamageType(DMG_BULLET)) then
		dmg:SubtractDamage(self.flatbulletresistance)
		dmg:SetDamage(dmg:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmg:SetDamage(math.max(0,dmg:GetDamage())) --So he can't heal from our attacks
	end
  
  self:SpawnBlood(dmg)
  self:SetHealth(self:Health() - dmg:GetDamage())
  
  if math.random(2) == 1 then
    self:StopSpeechSounds()
    self:PlayRandomSound(self.hurtsounds)
  end

  if (dmg:GetAttacker():GetClass() != self:GetClass() && dmg:IsDamageType(DMG_BULLET)) then
    self:AddEntityRelationship( dmg:GetAttacker(), 1, 10 )
    self:SetEnemy(dmg:GetAttacker())
  end

  self.Alerted = true
  if self:Health() <= 0 && self.dead == false then
    self.dead = true;
    self:KilledDan()
    gamemode.Call( "OnNPCKilled",  self, dmg:GetAttacker(), dmg:GetInflictor() )
  end
end

local schedd = ai_schedule.New( "FireSched" )
schedd:EngTask( "TASK_FACE_ENEMY",       0 )
schedd:EngTask( "TASK_RANGE_ATTACK1",    0 )

function ENT:InitEnemies()
  local zombifiedtable = ents.FindByClass("npc_human_z_*")
  local bandittable = ents.FindByClass("npc_human_bandit_*")
  local merctable = ents.FindByClass("npc_human_merc_*")
  local militable = ents.FindByClass("npc_human_mili_*")
  local mutanttable = ents.FindByClass("npc_mutant_*")

  for _, x in pairs(zombifiedtable) do
    x:AddEntityRelationship( self, D_LI, 10 )
    self:AddEntityRelationship( x, D_LI, 10 )
  end

  for _, x in pairs(bandittable) do
    x:AddEntityRelationship( self, D_LI, 10 )
    self:AddEntityRelationship( x, D_LI, 10 )
  end

  for _, x in pairs(merctable) do
    x:AddEntityRelationship( self, D_LI, 10 )
    self:AddEntityRelationship( x, D_LI, 10 )
  end

  for _, x in pairs(militable) do
    x:AddEntityRelationship( self, D_LI, 10 )
    self:AddEntityRelationship( x, D_LI, 10 )
  end

  for _, x in pairs(mutanttable) do
    x:AddEntityRelationship( self, D_LI, 10 )
    self:AddEntityRelationship( x, D_LI, 10 )
  end
end

function ENT:Think()
  if self:Health() > 0 then

    if (self.RecheckEnemyTimer or 0) < CurTime() then
      self.RecheckEnemyTimer = CurTime() + 8
      self:InitEnemies()
    end
  end
end

function ENT:PlayRandomSound(soundtable)
  if( (self.NextSound or 0) < CurTime() ) then
    local randsound = soundtable[math.random(1,#soundtable)]
    self:EmitSound( randsound, 100, 100)
    self.NextSound = CurTime() + SoundDuration(randsound) + 2.5
  end
end

function ENT:SelectSchedule()
  if self:Alive() then
    local haslos = self:HasLOS()

    local distance = 0
    local enemy_pos = 0
    if self:GetEnemy() == nil then
      self:FindEnemyDan()
      -- If there's still no enemy after looking for one, we patrol
      if( self:GetEnemy() == nil) then
        self:SetSchedule(SCHED_PATROL_WALK)
        self.TakingCover = false
        return
      end
    else

      if self.speaktime < CurTime() then
        self.speaktime = CurTime() + 8
        if math.random(1,100) < 30 then
          self:StopSpeechSounds()
          self:PlayRandomSound(self.attacksounds)
        end
      end

      enemy_pos = self:GetEnemy():GetPos()
      distance = self:GetPos():Distance(enemy_pos)
      if distance > 750 then
        self:SetSchedule(SCHED_CHASE_ENEMY)
      elseif (distance < 750 && distance > 200) then
        if (!haslos) then
          self:SetSchedule(SCHED_ESTABLISH_LINE_OF_FIRE) --move to shoot enemy
        else
          if (self.NextAttack < CurTime() and self:HasLOS()) then
            self:StartSchedule(schedd)
            self.NextAttack = CurTime() + 2
          else
            self:SetSchedule(SCHED_TAKE_COVER_FROM_ENEMY)
          end
        end
      elseif ( haslos and distance < 200 and (self.NextAttack or 0) < CurTime()) then
        self:StartSchedule(schedd)
        self.NextAttack = CurTime() + 2
      else
        self.TakingCover = false
        self:SetSchedule(SCHED_CHASE_ENEMY)//move to shoot enemy
      end
    end
  end
end

function ENT:FindEnemyDan()
  local MyNearbyTargets = ents.FindInCone(self:GetPos(),self:GetForward(),7000,45)

  for k,v in pairs(MyNearbyTargets) do
    if v:Disposition(self) == D_HT || v:IsPlayer() then

      self:StopSpeechSounds()
      self:ResetEnemy()
      self:AddEntityRelationship( v, D_HT, 10 )
      self:SetEnemy(v)
      local distance = self:GetPos():Distance(v:GetPos())
      local randomsound = math.random(1,5)

      if self.Alerted == false then
        self:EmitSound( self.alertsounds[math.random(#self.alertsounds)], 400, 100)
      end
      self.Alerted = true
    end
  end
end

function ENT:StopSpeechSounds()
  for i = 1, #self.alertsounds do
    self:StopSound(self.alertsounds[i])
  end

  for i = 1, #self.attacksounds do
    self:StopSound(self.attacksounds[i])
  end
end

function ENT:StopHurtSounds()
  for i = 1, #self.hurtsounds do
    self:StopSound(self.hurtsounds[i])
  end
end

function ENT:SpawnBlood(dmg)
  if (self.bleeds) then
    local bloodeffect = ents.Create( "info_particle_system" )
    bloodeffect:SetKeyValue( "effect_name", "blood_impact_red_01" )
    bloodeffect:SetPos( dmg:GetDamagePosition() ) 
    bloodeffect:Spawn()
    bloodeffect:Activate() 
    bloodeffect:Fire( "Start", "", 0 )
    bloodeffect:Fire( "Kill", "", 0.1 )
  end
end

function ENT:KilledDan()

  self:StopSpeechSounds()
  self:StopHurtSounds()
  self:PlayRandomSound(self.diesounds)

  //create ragdoll
  local ragdoll = ents.Create( "prop_ragdoll" )
  ragdoll:SetModel( self:GetModel() )
  ragdoll:SetPos( self:GetPos() )
  ragdoll:SetAngles( self:GetAngles() )
  ragdoll:Spawn()
  ragdoll:SetSkin( self:GetSkin() )
  ragdoll:SetColor( self:GetColor() )
  ragdoll:SetMaterial( self:GetMaterial() )
  ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

  cleanup.ReplaceEntity(self,ragdoll)
  undo.ReplaceEntity(self,ragdoll)

  if self:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 0 ) end
    for i=1,128 do
    local bone = ragdoll:GetPhysicsObjectNum( i )
    if IsValid( bone ) then
      local bonepos, boneang = self:GetBonePosition( ragdoll:TranslatePhysBoneToBone( i ) )
      bone:SetPos( bonepos )
      bone:SetAngles( boneang )
    end
  end
  -- Helix specific drops
  if(ix)then
    local item = self.selectedWeaponItem
    ix.item.Spawn(item[1], self:GetShootPos() + Vector(0,0,32), function(item, ent) ent.bTemporary = true end, AngleRand(), item[2] or {} )
  end

  if math.random(1, 100) <= self.lootChance then
    ragdoll:SetNetVar("loot", "bandit_shotgun_loot")
  end
  
  ragdoll:Fire("kill","",180)

  self:Remove()
end

function ENT:ResetEnemy()
  if( self:GetEnemy() ) then
    self:SetEnemy(nil)
  end
end

function ENT:OnRemove()
  timer.Remove("melee_attack_timer" .. self.Entity:EntIndex( ))
  timer.Remove("melee_done_timer" .. self.Entity:EntIndex( ))
end

function ENT:HasLOS()
  if IsValid(self:GetEnemy()) then
    local tracedata = {}

    tracedata.start = self:GetShootPos()
    if IsValid(self:GetEnemy():GetShootPos()) then
      tracedata.endpos = self:GetEnemy():GetShootPos()
    else
      tracedata.endpos = self:GetEnemy():GetPos() + Vector(0, 0, 8)
    end
    tracedata.filter = self

    local trace = util.TraceLine(tracedata)
    if trace.HitWorld == false then
      return true
    else 
      return false
    end
  end
  return false
end