util.AddNetworkString("STALKERNPCRagdoll")

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )


include( "STALKERNPCBaseVars.lua" )
include( "shared.lua" )
include( "schedules.lua" )
include( "tasks.lua" )

ENT.m_fMaxYawSpeed = 240
ENT.m_iClass = CLASS_NONE

AccessorFunc( ENT, "m_iClass", "NPCClass", FORCE_NUMBER )
AccessorFunc( ENT, "m_fMaxYawSpeed", "MaxYawSpeed", FORCE_NUMBER )


function ENT:STALKERNPCDamageTake(dmginfo,mul) return mul end
function ENT:STALKERNPCDistanceForMeleeTooSmall() end
function ENT:STALKERNPCDistanceForMeleeTooBig() end
function ENT:STALKERNPCThink() end
function ENT:STALKERNPCThinkNoEnemy() end
function ENT:STALKERNPCThinkEnemyValidNoAnimCheck() end
function ENT:STALKERNPCMeleeAttackEvent() end
function ENT:STALKERNPCHitSomething() end
function ENT:STALKERNPCOnEnemyCountFinded() end
function ENT:STALKERNPCMeleeSequenceEnd() end
function ENT:STALKERNPCMeleeDamagesEnd() end

function ENT:STALKERNPCOnCreateRagdoll() return true end
function ENT:STALKERNPCSetExplosionDamage() return false, false end
function ENT:STALKERNPCMeleeAttackDamageMultiple() return 1 end
function ENT:STALKERNPCAnimationIsPlaying() end
function ENT:STALKERNPCThinkEnemyValid() end

function ENT:STALKERNPCOnHeadLoss() end
function ENT:STALKERNPCOnDeath() end

function ENT:STALKERNPCRemove() end
function ENT:STALKERNPCStunEvent() end

function ENT:STALKERNPCMakeDamageToCreature() end

function ENT:STALKERNPCOnChaseSound() end

function ENT:STALKERNPCSelectMeleeAttack() end

function ENT:STALKERNPCCheckingNPCOnEnemyFind() end


function ENT:STALKERNPCIsFriendlyClass(NPC)

	if(NPC.SNPCClass==self.SNPCClass) then
		return true
	end
	
	return false
end

//Initialize
function ENT:STALKERNPCInit(VEC,MTYPE,CAPS)
	if(!CAPS) then
		CAPS = {}
	end
	
	self:SetModel( self.Model )
	
	self:SetCustomCollisionCheck()
	
	self:SetHullSizeNormal()
	if(isvector(VEC)) then
		VEC = Vector(math.abs(VEC.x),math.abs(VEC.y),math.abs(VEC.z))
		
		self:SetCollisionBounds(Vector(-VEC.x,-VEC.y,0),VEC)
	elseif(istable(VEC)) then
		self:SetCollisionBounds(VEC[1],VEC[2])
	end
	
	self:SetSolid(SOLID_BBOX)
	
	self:SetCollisionGroup(COLLISION_GROUP_NPC)

	self:SetUseType(SIMPLE_USE)
	
	self:SetMoveType( MTYPE )
	self:CapabilitiesAdd( bit.bor(CAP_MOVE_GROUND, CAP_AUTO_DOORS, CAP_USE, CAP_OPEN_DOORS, CAP_SQUAD, CAP_SKIP_NAV_GROUND_CHECK) )
	if(#CAPS>0) then
		for C=1,#CAPS do
			self:CapabilitiesAdd( bit.bor(CAPS[C]) )
		end
	end
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:SetSkin(math.random(0,self:SkinCount()-1))
	
	self:AddEFlags(EFL_NO_DISSOLVE)

	if(IsValid(self:GetActiveWeapon())) then
		self:GetActiveWeapon():Remove()
	end
	
	self:SetEnemy(nil)
	
	self:DropToFloor()
	
	--LAG COMP ATTEMPT
	self:SetLagCompensated(true)
	--END LAG COMP ATTEMPT

	self:Activate()
	
	
	
	duplicator.RegisterEntityClass( self:GetClass(), function( ply, data )
		duplicator.GenericDuplicatorFunction( ply, data )
	end, "Data" )
	
	
	if(self.SNPCClass=="C_ZOMBIE") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||string.sub(NPC.SNPCClass,1,8)=="C_MONSTER"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_SAVAGE") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_CAT"||
			NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC.SNPCClass=="C_MONSTER_CONTROLLER"||NPC.SNPCClass=="C_MONSTER_LAB"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_CAT") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_CAT"||
			NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC.SNPCClass=="C_MONSTER_LAB"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_DOG") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_DOG"||
			NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC.SNPCClass=="C_MONSTER_LAB"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_BOAR") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_BOAR"||
			NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC.SNPCClass=="C_MONSTER_LAB"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_RAT") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_RAT"||
			NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC.SNPCClass=="C_MONSTER_LAB"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_BIG") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC.SNPCClass=="C_MONSTER_BIG"||
			NPC:Classify()==CLASS_ZOMBIE||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_CONTROLLER") then
		function self:STALKERNPCIsFriendlyClass(NPC)

			/*if(NPC.SNPCClass=="C_ZOMBIE"||NPC.VJ_NPC_Class=="CLASS_ZOMBIE"||NPC:Classify()==CLASS_ZOMBIE||
			NPC.SNPCClass=="C_MONSTER_LAB"||NPC.SNPCClass=="C_MONSTER_SAVAGE"||NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end*/
			
			if(NPC:Classify()==CLASS_ZOMBIE||
			NPC:Classify()==CLASS_HEADCRAB) then
				return true
			end
				
			return false
		end
	elseif(self.SNPCClass=="C_MONSTER_PLAYERFOCUS") then
		function self:STALKERNPCIsFriendlyClass(NPC)
			return true
		end
	end
end

function ENT:STALKERNPCCanAttackThis(ENT2)
	if(self:STALKERNPCIsEnemyNPC(ENT2)||self:STALKERNPCIsEnemyPlayer(ENT2)||STALKERNPCIsProp(ENT2)) then
		return true
	end
end

function ENT:STALKERNPCIsEnemyNPC(ENT2)
	if(ENT2:IsNPC()&&ENT2:GetNPCState()!=NPC_STATE_DEAD&&(!self:STALKERNPCIsFriendlyClass(ENT2)||
	(ENT2==self:GetEnemy()||self==ENT2:GetEnemy()))) then
		return true
	end
	
	return false
end
	
function ENT:STALKERNPCIsEnemyPlayer(ENT2)
	if(ENT2:IsPlayer()&&ENT2:Alive()&&GetConVar("ai_ignoreplayers"):GetInt()==0) then
		return true
	end
	
	return false
end

function STALKERNPCIsProp(ENT2)
	if(IsValid(ENT2:GetPhysicsObject())&&!ENT2:IsPlayer()&&!ENT2:IsNPC()) then
		return true
	end
	return false
end

//Think
function ENT:STALKERNPCAnimEnemyIsValid()
	if(self.PlayingAnimation==true&&self.AttackIndex==1&&!self:IsMoving()) then
		local TEMP_YAW = ((self:GetEnemy():GetPos()-self:GetPos()):Angle().Yaw)-self:GetAngles().Yaw
		TEMP_YAW = math.NormalizeAngle(TEMP_YAW)
		TEMP_YAW = math.Clamp(TEMP_YAW,-20,20)
		self:SetAngles(Angle(0,self:GetAngles().Yaw+TEMP_YAW,0))
	end
end

function ENT:STALKERNPCTryToFindEnemy()
	local TEMP_VisibleTargets = {}
	local TEMP_NearEnemyCount = 0
	local TEMP_PossibleTarget = NULL
	
	local TEMP_NearestNpcDistance = 1500
	local TEMP_NearestNpc = self

	local TEMP_MyNearbyTargets = ents.FindInSphere(self:GetPos(),TEMP_NearestNpcDistance)
		
	if (#TEMP_MyNearbyTargets>0) then 
		for T=1, #TEMP_MyNearbyTargets do
			local TEMP_NPC = TEMP_MyNearbyTargets[T]
			
			if(IsValid(TEMP_NPC)&&TEMP_NPC!=nil&&TEMP_NPC!=NULL&&TEMP_NPC!=self&&TEMP_NPC:GetClass()!="bullseye_strider_focus") then
				if((TEMP_NPC:IsNPC()||TEMP_NPC:IsPlayer())) then
					if(TEMP_NPC:IsNPC()||self:STALKERNPCIsEnemyPlayer(TEMP_NPC)) then
						if(TEMP_NPC:IsNPC()&&TEMP_NPC:Disposition(self)!=D_HT&&TEMP_NPC:Disposition(self)!=D_LI) then
							if((self:STALKERNPCIsFriendlyClass(TEMP_NPC)&&TEMP_NPC:Disposition(self)==D_HT)||
							!self:STALKERNPCIsFriendlyClass(TEMP_NPC)) then
								self:AddEntityRelationship(TEMP_NPC,D_HT,self.Hate)
								TEMP_NPC:AddEntityRelationship(self,D_HT,self.Hate)
							end
						end
						
						if(TEMP_NPC:IsNPC()) then
							self:STALKERNPCCheckingNPCOnEnemyFind(TEMP_NPC,TEMP_NPC:Disposition(self))
						end
							
						local TEMP_Ang = (TEMP_NPC:GetPos()-self:GetPos()):Angle().Yaw-self:GetAngles().Yaw

						if(math.abs(TEMP_Ang)<90) then
						
							if(TEMP_NPC:IsPlayer()||TEMP_NPC:Disposition(self)==D_HT) then
								if(T==1) then
									TEMP_NearestNpcDistance = self:GetPos():Distance(TEMP_NPC:GetPos())
									TEMP_NearestNpc = TEMP_NPC
								else
									if(self:GetPos():Distance(TEMP_NPC:GetPos())<TEMP_NearestNpcDistance) then
										TEMP_NearestNpcDistance = self:GetPos():Distance(TEMP_NPC:GetPos())
										TEMP_NearestNpc = TEMP_NPC
									end
								end
								
								if(self.NearestEnemyFindDistance>0) then
									if(Tyrant_EnemyInMeleeRange(TEMP_NPC,0,self.NearestEnemyFindDistance)==2) then
										TEMP_NearEnemyCount = TEMP_NearEnemyCount+1
									end
								end
							end
						end
					end
				end
			end
		end
	end
	
	
	
	if(IsValid(TEMP_NearestNpc)&&TEMP_NearestNpc!=nil&&TEMP_NearestNpc!=NULL&&TEMP_NearestNpc!=self) then
		if(self.PlayingAnimation==false) then
			if(TEMP_NearestNpc!=self:GetEnemy()) then
				self:AddEntityRelationship( TEMP_NearestNpc, D_HT, 1 )
				self:SetEnemy(TEMP_NearestNpc)
				self:UpdateEnemyMemory(TEMP_NearestNpc,TEMP_NearestNpc:GetPos())
				
				//self:SetSchedule(SCHED_CHASE_ENEMY)
				self:SelectSchedule()
			end
		end
	end
	
	return TEMP_NearEnemyCount
end


function STALKERNPCBleed(Ent,INT,Pos,Ang)
	local TEMP_CEffectData = EffectData()
	TEMP_CEffectData:SetOrigin(Pos)
	TEMP_CEffectData:SetFlags(3)
	TEMP_CEffectData:SetScale(INT)
	TEMP_CEffectData:SetColor(0)
	TEMP_CEffectData:SetNormal(Ang:Forward())
	TEMP_CEffectData:SetEntity(Ent)
	TEMP_CEffectData:SetAngles(Ang)
	util.Effect( "BloodImpact", TEMP_CEffectData, false )
end


function ENT:STALKERNPCKill(dmginfo)
	
	if(self.IsAlive==true) then
		self.IsAlive = false
		
		self:STALKERNPCStopAllTimers()
		self.Animation = ""
		self.AttackIndex = 0
		
		local TEMP_KillTime = 2
		
		if(self.DieSoundEnabled==true) then
			self:STALKERNPCStopPreviousSound()
			self:STALKERNPCPlaySoundRandom(100,self.DieSound.name,self.DieSound.min,self.DieSound.max)
		end

		local TEMP_ATTACKER = dmginfo:GetAttacker()
		local TEMP_INFLICTOR = dmginfo:GetInflictor()
		
		
		local TEMP_OWNERVEL = self:GetVelocity()

		self:SetMaterial("")
		self:ClearSchedule()
		self:SetNPCState(NPC_STATE_DEAD)
		

		if(!(IsValid(TEMP_ATTACKER)&&TEMP_ATTACKER!=nil&&TEMP_ATTACKER!=NULL&&TEMP_ATTACKER:GetClass()=="npc_barnacle")) then
			if(GetConVar("ai_serverragdolls"):GetInt()==0) then
				net.Start("STALKERNPCRagdoll")
				net.WriteEntity(self)
				net.Broadcast()
			else
				local TEMP_Ragdoll = ents.Create("prop_ragdoll")
				TEMP_Ragdoll:SetModel(self:GetModel())
				TEMP_Ragdoll:SetPos(self:GetPos())
				TEMP_Ragdoll:SetAngles(self:GetAngles())
				TEMP_Ragdoll:Spawn()
				
				TEMP_Ragdoll:SetMaterial(self:GetMaterial())
				TEMP_Ragdoll:SetColor(self:GetColor())
				TEMP_Ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				
				for P=0, TEMP_Ragdoll:GetPhysicsObjectCount()-1 do
					local TEMP_Phys = TEMP_Ragdoll:GetPhysicsObjectNum(P)
					
					if(IsValid(TEMP_Phys)) then
						local TEMP_BoneMat = self:GetBoneMatrix(TEMP_Ragdoll:TranslatePhysBoneToBone(P))
						local TEMP_BonePos, TEMP_BoneAng = TEMP_BoneMat:GetTranslation(), TEMP_BoneMat:GetAngles()

						TEMP_Phys:SetPos(TEMP_BonePos)
						TEMP_Phys:SetAngles(TEMP_BoneAng)
					end
				end
				
				for B=0, self:GetBoneCount()-1 do
					TEMP_Ragdoll:ManipulateBoneScale(B,self:GetManipulateBoneScale(B))
					TEMP_Ragdoll:ManipulateBonePosition(B,self:GetManipulateBonePosition(B))
					TEMP_Ragdoll:ManipulateBoneAngles(B,self:GetManipulateBoneAngles(B))
				end
				timer.Simple(0.01,function()
					if(IsValid(TEMP_Ragdoll)&&TEMP_Ragdoll!=nil&&TEMP_Ragdoll!=NULL) then
						TEMP_Ragdoll:SetVelocity(TEMP_OWNERVEL)
					end
				end)
				
				TEMP_Ragdoll:TakeDamageInfo(dmginfo)

				TEMP_Ragdoll:Fire("kill","",30)
				TEMP_KillTime = 0.1
			end
		else
			TEMP_KillTime = 0.1
		end
		
		if(self:IsOnFire()) then
			self:Extinguish()
		end
		
		self:SetNoDraw(true)
		self:DrawShadow(false)
			
		self:STALKERNPCStopAllTimers()
		
		self:SetCondition(67)
		self:SetNPCState(NPC_STATE_DEAD)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:SetCollisionBounds(Vector(0,0,0),Vector(0,0,0))
		
		self:Fire("kill","",TEMP_KillTime)
		
		gamemode.Call( "OnNPCKilled",  self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
	end
end



//Melee
function ENT:STALKERNPCCreateMeleeTable()
	local TBL = {}
	TBL.damage = {}
	TBL.distance = {}
	TBL.radius = {}
	TBL.time = {}
	TBL.bone = {}
	TBL.damage = {}
	TBL.damagetype = {}
	TBL.distance = {}
	TBL.radius = {}
	TBL.time = {}
	TBL.bone = {}
	
	return TBL
end

function ENT:STALKERNPCRemoveMeleeTable(IND)
	self.MeleeDamageTime[IND] = {}
	self.MeleeDamageDamage[IND] = {}
	self.MeleeDamageType[IND] = {}
	self.MeleeDamageDistance[IND] = {}
	self.MeleeDamageBone[IND] = {}
	self.MeleeDamageRadius[IND] = {}
	
	self.MeleeAttackSequence[IND] = nil
	self.MeleeAttackGesture[IND] = nil
	self.MeleeDamageCount[IND] = nil
end

function ENT:STALKERNPCSetMeleeParams(NUM,SEQ,CNT,TBL,TBLH,TBLM)
	self.MeleeAttackSequence[NUM] = SEQ
	self.MeleeDamageCount[NUM] = CNT
	
	if(!self.MeleeHitSound[NUM]) then
		self.MeleeHitSound[NUM] = {}
	end
	
	if(!self.MeleeMissSound[NUM]) then
		self.MeleeMissSound[NUM] = {}
	end
	
	table.Add(self.MeleeHitSound[NUM],TBLH)
	table.Add(self.MeleeMissSound[NUM],TBLM)

	for N=1,CNT do
		if(!self.MeleeDamageTime[NUM]) then
			self.MeleeDamageTime[NUM] = {}
		end
		if(!self.MeleeDamageDamage[NUM]) then
			self.MeleeDamageDamage[NUM] = {}
		end
		if(!self.MeleeDamageType[NUM]) then
			self.MeleeDamageType[NUM] = {}
		end
		if(!self.MeleeDamageDistance[NUM]) then
			self.MeleeDamageDistance[NUM] = {}
		end
		if(!self.MeleeDamageRadius[NUM]) then
			self.MeleeDamageRadius[NUM] = {}
		end
		if(!self.MeleeDamageBone[NUM]) then
			self.MeleeDamageBone[NUM] = {}
		end
		
		self.MeleeDamageTime[NUM][N] = TBL.time[N]
		self.MeleeDamageDamage[NUM][N] = TBL.damage[N]
		self.MeleeDamageType[NUM][N] = TBL.damagetype[N]
		self.MeleeDamageDistance[NUM][N] = TBL.distance[N]
		self.MeleeDamageRadius[NUM][N] = TBL.radius[N]
		self.MeleeDamageBone[NUM][N] = TBL.bone[N]
	end
end

function ENT:STALKERNPCSetMeleeParamsGesture(NUM,SEQ,CNT,TBL,TBLH,TBLM)
	self.MeleeAttackSequence[NUM] = SEQ
	self.MeleeAttackGesture[NUM] = true
	self.MeleeDamageCount[NUM] = CNT
	
	if(!self.MeleeHitSound[NUM]) then
		self.MeleeHitSound[NUM] = {}
	end
	
	if(!self.MeleeMissSound[NUM]) then
		self.MeleeMissSound[NUM] = {}
	end
	
	table.Add(self.MeleeHitSound[NUM],TBLH)
	table.Add(self.MeleeMissSound[NUM],TBLM)
	
	for N=1,CNT do
		if(!self.MeleeDamageTime[NUM]) then
			self.MeleeDamageTime[NUM] = {}
		end
		if(!self.MeleeDamageDamage[NUM]) then
			self.MeleeDamageDamage[NUM] = {}
		end
		if(!self.MeleeDamageType[NUM]) then
			self.MeleeDamageType[NUM] = {}
		end
		if(!self.MeleeDamageDistance[NUM]) then
			self.MeleeDamageDistance[NUM] = {}
		end
		if(!self.MeleeDamageRadius[NUM]) then
			self.MeleeDamageRadius[NUM] = {}
		end
		if(!self.MeleeDamageBone[NUM]) then
			self.MeleeDamageBone[NUM] = {}
		end
		
		self.MeleeDamageTime[NUM][N] = TBL.time[N]
		self.MeleeDamageDamage[NUM][N] = TBL.damage[N]
		self.MeleeDamageType[NUM][N] = TBL.damagetype[N]
		self.MeleeDamageDistance[NUM][N] = TBL.distance[N]
		self.MeleeDamageRadius[NUM][N] = TBL.radius[N]
		self.MeleeDamageBone[NUM][N] = TBL.bone[N]
	end
end

function ENT:STALKERNPCMakeMeleeAttack(IND)
	if( self.PlayingAnimation == true ) then

		local TEMP_MeleeAttackSequenceName = self.Animation

		local TEMP_TargetTakeDamage = false
		local TEMP_SomeoneTakeDamage = false
		local TEMP_DamagesCount = 0
		
		for i=1, self.MeleeDamageCount[IND] do
			timer.Create("DamageAttack"..tostring(self)..i,self.MeleeDamageTime[IND][i]-0.2,1,function()
				if(IsValid(self)&&self!=nil&&self!=NULL) then
					if(istable(self.MeleeDamageDamage[IND])&&isnumber(self.MeleeDamageDamage[IND][i])) then
						local TEMP_TARGETDMG, TEMP_SOMEONEDMG, TEMP_DMGCNT = self:STALKERNPCDoMeleeDamage(self.MeleeDamageDamage[IND][i],
						self.MeleeDamageType[IND][i],self.MeleeDamageDistance[IND][i]+7,self.MeleeDamageRadius[IND][i],
						self.MeleeDamageBone[IND][i],self.MeleeHitSound[IND],self.MeleeMissSound[IND])
					
					
						if(TEMP_TARGETDMG==true) then
							TEMP_TargetTakeDamage = true
						end
						
						if(TEMP_SOMEONEDMG==true) then
							TEMP_SomeoneTakeDamage = true
						end
						
						TEMP_DamagesCount = TEMP_DamagesCount+TEMP_DMGCNT
						
						if(i==self.MeleeDamageCount[IND]) then
							self:STALKERNPCMeleeDamagesEnd(TEMP_TargetTakeDamage,TEMP_SomeoneTakeDamage,TEMP_DamagesCount==self.MeleeDamageCount[IND])
						end
					end
				end
			end )
		end
		
		TEMP_AnimDur = self:SequenceDuration(self:LookupSequence(self.Animation))
		
		if(self.PlayingGesture==true) then
			TEMP_AnimDur = (self:SequenceDuration(self:LookupSequence(self.Animation))/2)
		end
		
		timer.Create("EndAttack"..tostring(self),TEMP_AnimDur+0.1,1,function()
			if(IsValid(self)&&self!=nil&&self!=NULL) then
				self:STALKERNPCMeleeSequenceEnd(self.Animation)
				self:STALKERNPCClearAnimation()
			end
		end)
		
		
	end

end

function ENT:STALKERNPCDoMeleeDamage(DMG,TYPE,DIST,RAD,BONE,HITSND,MISSSND)
	local TEMP_TargetTakeDamage = false
	local TEMP_SomeoneTakeDamage = false
	local TEMP_DamagesCount = 0
	
	if(DIST!=nil) then
		local TEMP_OBBSize = (Vector(math.abs(self:OBBMins().x),math.abs(self:OBBMins().y),0)+
		Vector(math.abs(self:OBBMaxs().x),math.abs(self:OBBMaxs().y),0))/2
		local TEMP_PossibleDamageTargets = ents.FindInSphere(self:GetPos(), DIST+TEMP_OBBSize:Length()+15)
		local TEMP_DMGMAT = self:GetBoneMatrix(self:LookupBone(BONE))
		local TEMP_DMGPOS, TEMP_DMGANG = TEMP_DMGMAT:GetTranslation(), TEMP_DMGMAT:GetAngles()
		local TEMP_DamageApplied = false
			
		if(#TEMP_PossibleDamageTargets>0) then
			for _,v in pairs(TEMP_PossibleDamageTargets) do
				if(self:STALKERNPCCanAttackThis(v)&&self:Visible(v)&&v!=self) then

					local TEMP_DistanceForMelee = self:STALKERNPCEnemyInMeleeRange(v,0,DIST)
					
					local TEMP_DotVector = v:GetPos()
					local TEMP_DotDir = TEMP_DotVector - self:GetPos()
					TEMP_DotDir:Normalize()
					local TEMP_Dot = Vector(self:GetForward().x,self:GetForward().y,0):Dot(Vector(TEMP_DotDir.x,TEMP_DotDir.y,0))
					
					if(TEMP_DistanceForMelee==2&&(TEMP_Dot>math.cos(RAD)||RAD==360)) then
						TEMP_DamageApplied = true

						local TEMP_DAMAGEPOSITION = v:NearestPoint(TEMP_DMGPOS)
						local TEMP_DAMAGEFORCE = (TEMP_DAMAGEPOSITION-TEMP_DMGPOS):GetNormalized()
						
						local TEMP_TargetDamage = DamageInfo()
						
						TEMP_TargetDamage:SetDamage(DMG*self:STALKERNPCMeleeAttackDamageMultiple())
						TEMP_TargetDamage:SetInflictor(self)
						TEMP_TargetDamage:SetDamageType(TYPE)
						TEMP_TargetDamage:SetAttacker(self)
						TEMP_TargetDamage:SetDamagePosition(TEMP_DAMAGEPOSITION)
						TEMP_TargetDamage:SetDamageForce(TEMP_DAMAGEFORCE)
						v:TakeDamageInfo(TEMP_TargetDamage)
						
						if(v==self:GetEnemy()) then
							TEMP_TargetTakeDamage = true
						end
						
						if(v:IsNPC()||v:IsPlayer()) then
							TEMP_SomeoneTakeDamage = true
							TEMP_DamagesCount = 1
							self:STALKERNPCMakeDamageToCreature(v)
						end
						
						
						if(v:IsPlayer()) then
							v:ViewPunch(Angle(math.random(-10,10),math.random(-10,10),math.random(-10,10)))
						end
						
					end
				end
			end
		end
		
		if(TEMP_DamageApplied==true) then
			self:STALKERNPCHitSomething()
			
			sound.Play( table.Random(HITSND),TEMP_DMGPOS)
		else
			sound.Play( table.Random(MISSSND),TEMP_DMGPOS)
		end
	end
	
	
	
	return TEMP_TargetTakeDamage,TEMP_SomeoneTakeDamage,TEMP_DamagesCount
end



function ENT:STALKERNPCEnemyInMeleeRange(ENT2,DIST1,DIST2)
	if(self:STALKERNPCIsEnemyNPC(ENT2)||self:STALKERNPCIsEnemyPlayer(ENT2)||STALKERNPCIsProp(ENT2)) then
		local TEMP_Point1 = ENT2:NearestPoint(self:GetPos()+self:OBBCenter())
		local TEMP_Point2 = self:NearestPoint(TEMP_Point1)

		local TEMP_DistanceBetween = TEMP_Point1:Distance(TEMP_Point2)

		if(TEMP_Point2.z<(self:GetPos()+self:OBBMaxs()).z&&
		TEMP_Point2.z>((self:GetPos()+self:OBBMins()).z)) then

			if(TEMP_DistanceBetween<DIST2) then
				if(TEMP_DistanceBetween>DIST1||DIST1==0) then
					return 2, TEMP_DistanceBetween
				else
					return 1, TEMP_DistanceBetween
				end
			end
		end
		
		return 0, TEMP_DistanceBetween
	end

	return 0, 0
end

function ENT:STALKERNPCMeleePlay(TEMP_RandomMelee,ROT)
	if(!isnumber(ROT)) then
		ROT = 1
	end
	
	if(self.MeleeSoundEnabled==true) then
		self:STALKERNPCPlaySoundRandom(60,self.MeleeSound.name,self.MeleeSound.min,self.MeleeSound.max)
	end
	
	if(!isnumber(TEMP_RandomMelee)) then
		TEMP_RandomMelee = math.random(1,#self.MeleeAttackSequence)
	end

	if(!self.MeleeAttackGesture[TEMP_RandomMelee]) then
		self:STALKERNPCPlayAnimation(self.MeleeAttackSequence[TEMP_RandomMelee],ROT)
		self:STALKERNPCMakeMeleeAttack(TEMP_RandomMelee)
	else
		self:STALKERNPCPlayGesture(self.MeleeAttackSequence[TEMP_RandomMelee],ROT)
		self:STALKERNPCMakeMeleeAttack(TEMP_RandomMelee)
	end
	
	self:STALKERNPCMeleeAttackEvent()
end



//Sounds
function ENT:STALKERNPCPlaySoundRandom(CH,SNDNM,IMIN,IMAX,CHAN)
	if(self.NextSoundCanPlayTime<CurTime()) then

		local TEMP_SoundChance = math.random(1,100)
	
		if(TEMP_SoundChance<CH) then
			
			local TEMP_SND = SNDNM..math.random(IMIN,IMAX)
				
			self:EmitSound( TEMP_SND )
			self.NextSoundCanPlayTime = CurTime()+SoundDuration(TEMP_SND)+0.1
			self.LastPlayedSound = TEMP_SND
		end
	end
end

function ENT:STALKERNPCStopPreviousSound()
	self:StopSound(self.LastPlayedSound)
	self.LastPlayedSound = ""
	self.NextSoundCanPlayTime = -1
end
	



//Animations
function ENT:STALKERNPCPlayAnimation(ANM,IND,RESETCYCLE)
	self.PlayingAnimation = true
	self.PlayingGesture = false
	self.AttackIndex = IND
	self:ClearSchedule()
	
	if(RESETCYCLE==nil||RESETCYCLE==true) then
		self:ResetSequenceInfo()
		self:SetCycle(0)
	end
	
	self.Animation = ANM
	self:StopMoving()
	self:SetNPCState(NPC_STATE_NONE)

	if(self:GetSequence()!=self:LookupSequence(self.Animation)) then
		self:SetNPCState(NPC_STATE_SCRIPT)
		self:ResetSequence(self:LookupSequence(self.Animation))
	end
end

function ENT:STALKERNPCPlayGesture(ANM,IND,PRIOR)
	if(PRIOR==nil) then
		PRIOR = 2
	end

	local TEMP_Gesture = self:AddGestureSequence(self:LookupSequence(ANM))
	self:SetLayerPriority(TEMP_Gesture,PRIOR)
	self:SetLayerPlaybackRate(TEMP_Gesture,1)
	self:SetLayerCycle(TEMP_Gesture,0)
	
	if(ANM==self.FlinchSequence) then
		self.FlinchGestureIndex = TEMP_Gesture
	else
		self.AttackGestureIndex = TEMP_Gesture
	end
	
	self.Animation = ANM
	self.AttackIndex = IND
	self.PlayingAnimation = true
	self.PlayingGesture = true
end

function ENT:STALKERNPCClearAnimation()
	self.Animation = ""
	self.AttackIndex = 0
	
	if(self.PlayingGesture==false) then
		self:ClearSchedule()
		self:ResetSequenceInfo()
	else
		if(self.AttackGestureIndex!=nil&&self:IsValidLayer(self.AttackGestureIndex)) then
			self:SetLayerCycle(self.AttackGestureIndex,1)
		end
		
		if(self.FlinchGestureIndex!=nil&&self:IsValidLayer(self.FlinchGestureIndex)) then
			self:SetLayerCycle(self.FlinchGestureIndex,1)
		end
		
		self.AttackGestureIndex = nil
		self.FlinchGestureIndex = nil
	end
	
	self:SetNPCState(NPC_STATE_COMBAT)
	self.PlayingGesture = false
	self.PlayingAnimation = false

		
	if(GetConVar("ai_disabled"):GetInt()==1) then
		self:ResetSequence(self:LookupSequence(self.IdleSequence))
	end
end

//Timers
function ENT:STALKERNPCStopAllTimers(ALL)
	timer.Remove("StartAttack"..tostring(self))
	timer.Remove("PreMidAttack"..tostring(self))
	timer.Remove("MidAttack"..tostring(self))
	timer.Remove("PreAttack"..tostring(self))
	for i=1, 10 do
		timer.Remove("Attack"..tostring(self)..i)
	end
	timer.Remove("EndAttack"..tostring(self))
	timer.Remove("Anim"..tostring(self))
	timer.Remove("JustPlayAnimation"..tostring(self))
	timer.Remove("JustPlayAnimation2"..tostring(self))
	timer.Remove("AllowAttack"..tostring(self))
	for i=1, 10 do
		timer.Remove("DamageAttack"..tostring(self)..i)
	end
	
	if(ALL==true) then
		timer.Remove("AllowAttack"..tostring(self))
	end
end












//Base functions
function ENT:OnRemove()
	self:STALKERNPCStopAllTimers(ALL)
	self:STALKERNPCRemove()
end

function ENT:Use( activator, caller, type, value )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end

function ENT:GetRelationship( entity )
end

function ENT:ExpressionFinished( strExp )
end

function ENT:Think()
	if(GetConVar("ai_disabled"):GetInt()==0&&self.IsAlive==true) then
		
		self:STALKERNPCThink()
		
		if(self.PlayingAnimation==true) then
			self:STALKERNPCAnimationIsPlaying()
		end
		
		if(self.NextTryingFindEnemy<CurTime()) then
			self.NextTryingFindEnemy = CurTime()+2
			local TEMP_NearEnemyCount = self:STALKERNPCTryToFindEnemy()
			self:STALKERNPCOnEnemyCountFinded(TEMP_NearEnemyCount)
		end
		
		if(self:GetEnemy()&&IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=NULL&&
		(self:STALKERNPCIsEnemyNPC(self:GetEnemy())||self:STALKERNPCIsEnemyPlayer(self:GetEnemy()))) then
			if(self:IsOnGround()) then
				if(self.PlayingAnimation==false) then
					
					if(self:GetEnemy():Visible(self)) then
						local TEMP_MaxMeleeDistance = self.MeleeAttackDistance
						
						if(self:IsMoving()) then
							TEMP_MaxMeleeDistance = self.MeleeAttackDistance+5
						end

						local TEMP_DistanceForMelee, TEMP_DistToEnemy = self:STALKERNPCEnemyInMeleeRange(self:GetEnemy(),self.MeleeAttackDistanceMin,TEMP_MaxMeleeDistance)

						if(TEMP_DistanceForMelee==2) then
							local TEMP_IND = self:STALKERNPCSelectMeleeAttack()
							self:STALKERNPCMeleePlay(TEMP_IND)
						elseif(TEMP_DistanceForMelee==1) then
							self:STALKERNPCDistanceForMeleeTooSmall(TEMP_DistToEnemy)
						else
							self:STALKERNPCDistanceForMeleeTooBig(TEMP_DistToEnemy)
						end
					end
				end
				
				self:STALKERNPCThinkEnemyValidNoAnimCheck()
				
				if(self.PlayingAnimation==false) then
					self:STALKERNPCThinkEnemyValid()
					
					if(self.ChasingSoundEnabled==true&&self:IsCurrentSchedule(SCHED_CHASE_ENEMY)) then
						self:STALKERNPCPlaySoundRandom(self.ChasingSound.chance,self.ChasingSound.name,self.ChasingSound.min,self.ChasingSound.max,"Chase")
					end
						
				else
					self:STALKERNPCAnimEnemyIsValid()
				end
			end
		else
			if(self.IdlingSoundEnabled==true&&self.PlayingAnimation==false&&self:IsCurrentSchedule(SCHED_IDLE_WANDER)) then
				self:STALKERNPCPlaySoundRandom(15,self.IdlingSound.name,self.IdlingSound.min,self.IdlingSound.max)
			end
			
			self:STALKERNPCThinkNoEnemy()
		end
	end
	
end

function ENT:OnTakeDamage(dmginfo)
	if(self.IsAlive==false) then return end
	
	local TEMP_DMGMUL = 1
	
	local TEMP_RealAttacker = dmginfo:GetAttacker()
	local TEMP_RealInflictor = dmginfo:GetInflictor()
	
		
			
	if(!IsValid(TEMP_RealAttacker)&&IsValid(TEMP_RealInflictor)) then
		TEMP_RealAttacker = TEMP_RealInflictor
	end
	
	if(IsValid(TEMP_RealAttacker)&&!IsValid(TEMP_RealInflictor)) then
		TEMP_RealInflictor = TEMP_RealAttacker
	end
	
	if(IsValid(TEMP_RealAttacker)&&TEMP_RealAttacker:IsVehicle()&&IsValid(TEMP_RealAttacker:GetDriver())) then
		TEMP_RealAttacker = TEMP_RealAttacker:GetDriver()
	end

	
	if(IsValid(TEMP_RealInflictor)&&IsValid(TEMP_RealAttacker)&&TEMP_RealAttacker==TEMP_RealInflictor&&
	(TEMP_RealInflictor:IsPlayer()||TEMP_RealInflictor:IsNPC())) then
		if(IsValid(TEMP_RealInflictor:GetActiveWeapon())) then
			TEMP_RealAttacker = TEMP_RealInflictor
			TEMP_RealInflictor = TEMP_RealInflictor:GetActiveWeapon()
		end
	end
	
	if(!IsValid(TEMP_RealInflictor)&&!IsValid(TEMP_RealAttacker)) then
		TEMP_RealInflictor = self
		TEMP_RealAttacker = self
	end
	
	dmginfo:SetInflictor(TEMP_RealInflictor)
	dmginfo:SetAttacker(TEMP_RealAttacker)
	
	
	if(self.LastDamageHitgroup==-1||self.LastDamageHitgroup==0) then
		local TEMP_NearestPoint = self:NearestPoint(dmginfo:GetDamagePosition())
		
		local TEMP_HitTracer = util.TraceHull( {
			start = TEMP_NearestPoint,
			endpos = TEMP_NearestPoint,
			ignoreworld = true,
			mins = Vector(100,100,100),
			maxs = Vector(100,100,100),
			filter = function( ent ) if ( ent==self ) then return true end end
		} )
		
		if(TEMP_HitTracer.Hit) then
			self.LastDamageHitgroup = TEMP_HitTracer.HitGroup
		end
	end

	if(self.LastDamageHitgroup==-1||self.LastDamageHitgroup==0) then
		
		local TEMP_HitTracer = util.TraceLine( {
			start = dmginfo:GetDamagePosition(),
			endpos = dmginfo:GetDamagePosition()+(dmginfo:GetDamageForce()*100),
			ignoreworld = true,
			filter = function( ent ) if ( ent==self ) then return true end end
		} )
	
		
		if(TEMP_HitTracer.Hit) then
			self.LastDamageHitgroup = TEMP_HitTracer.HitGroup
		end
	end
	
	if(self.LastDamageHitgroup==-1||self.LastDamageHitgroup==0) then
		if(IsValid(TEMP_RealInflictor)&&isentity(TEMP_RealInflictor)&&!TEMP_RealInflictor:IsWeapon()) then
			local TEMP_InflictorHullMin, TEMP_InflictorHullMax = TEMP_RealInflictor:GetCollisionBounds()
			
			local TEMP_HitTracer = util.TraceHull( {
				start = TEMP_RealInflictor:GetPos(),
				endpos = TEMP_RealInflictor:GetPos()+(TEMP_RealInflictor:GetForward()*100),
				ignoreworld = true,
				mins = TEMP_InflictorHullMin*1.3,
				maxs = TEMP_InflictorHullMax*1.3,
				filter = function( ent ) if ( ent==self ) then return true end end
			} )
		
			if(TEMP_HitTracer.Hit) then
				self.LastDamageHitgroup = TEMP_HitTracer.HitGroup
			end
		end
	end
		
	if(self.LastDamageHitgroup==8) then
		TEMP_DMGMUL = TEMP_DMGMUL*1.25
	end

	TEMP_DMGMUL = self:STALKERNPCDamageTake(dmginfo,TEMP_DMGMUL)
	
	self:SetHealth(self:Health()-(dmginfo:GetDamage()*TEMP_DMGMUL))
	
	if(dmginfo:GetDamageType()!=DMG_SONIC&&dmginfo:GetDamageType()!=DMG_POISON) then
		STALKERNPCBleed(self,dmginfo:GetDamage()/4,dmginfo:GetDamagePosition(),Angle(math.random(1,360),math.random(1,360),math.random(1,360)))
	end
	
	if(self:Health()>0) then
		if(self.PainSoundEnabled==true) then
			self:STALKERNPCPlaySoundRandom(33,self.PainSound.name,self.PainSound.min,self.PainSound.max)
		end
	elseif(self:Health()<1&&self.IsAlive==true) then
		self:STALKERNPCKill(dmginfo)
		self:STALKERNPCOnDeath()
	end
	
	if(self.PlayingAnimation==false) then
		if(TEMP_RealAttacker!=game.GetWorld()&&IsValid(TEMP_RealAttacker)&&TEMP_RealAttacker!=nil&&TEMP_RealAttacker!=NULL&&
		TEMP_RealAttacker!=self&&(!IsValid(self:GetEnemy())||self:GetEnemy()==nil||self:GetEnemy()==NULL||
		self:GetEnemy():GetPos():Distance(self:GetPos())>TEMP_RealAttacker:GetPos():Distance(self:GetPos()))) then
			if(TEMP_RealAttacker:IsPlayer()||(TEMP_RealAttacker:IsNPC())) then
				self:AddEntityRelationship( TEMP_RealAttacker, D_HT, self.Hate )
				self:SetEnemy(TEMP_RealAttacker)
				self.RegEnemy = TEMP_RealAttacker
				self:UpdateEnemyMemory(TEMP_RealAttacker,TEMP_RealAttacker:GetPos())
			end
		end
	end
	
	self.LastDamageHitgroup = -1
end

function ENT:GetAttackSpread( Weapon, Target )
	return 0.1
end