if SERVER then
	AddCSLuaFile()
end
game.AddDecal("Slash_0","decals/slash_0")
game.AddDecal("Slash_45","decals/slash_45")
game.AddDecal("Slash_90","decals/slash_90")
game.AddDecal("Slash_135","decals/slash_135")
game.AddAmmoType( {
	name = "TFMSwordHitSlash",
	dmgtype = DMG_SLASH,
	tracer = TRACER_NONE
} )

game.AddAmmoType( {
	name = "TFMSwordHitGeneric",
	dmgtype = DMG_GENERIC,
	tracer = TRACER_NONE	
} )

game.AddAmmoType( {
	name = "TFMSwordHitGenericSlash",
	dmgtype = DMG_SLASH,
	tracer = TRACER_NONE	
} )

game.AddAmmoType( {
	name = "TFMSwordRayTest",
	dmgtype = 0,
	tracer = TRACER_NONE,
	plydmg = 0,
	npcdmg = 0,
	force = 0,
	minsplash = 1,
	maxsplash = 1
} )

function TFMPlayerSpawn(ply)
	ply:SetNWVector("TFM_SwordPosition",Vector(1,1,1))
	ply:SetNWVector("TFM_SwordNormal",Vector(1,1,1))
	ply:SetNWBool("TFM_IsSprinting",false)
	ply:SetNWBool("TFM_IsBlocking",false)
	ply:SetNWBool("TFM_IsSwinging",false)
	ply:SetNWFloat("TFM_SwingStart",CurTime())
end
hook.Add("PlayerSpawn","TFM_PlayerSpawn",TFMPlayerSpawn)

hook.Add("EntityTakeDamage","TFM_Block",function(ent, dmginfo)
	if ent:IsPlayer() then
		local wep;
		wep=ent:GetActiveWeapon()
		if ( wep.IsTFAWeapon and wep.BlockAngle ) then
			if (dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_CLUB) or (wep.NinjaMode and wep.NinjaMode==true and (dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_BULLET)))) then
				if ( wep:GetIronSights() ) then
					local damageinflictor,blockthreshold;
					damageinflictor=dmginfo:GetInflictor()
					if (!IsValid(damageinflictor)) then
						damageinflictor=dmginfo:GetAttacker()
					end
					blockthreshold=wep.BlockAngle/2 or 90
					if (IsValid(damageinflictor) and (math.abs((ent:GetAimVector():Angle()-(damageinflictor:GetPos()-ent:GetPos()):Angle()).y)<=blockthreshold) )or (math.abs((ent:GetAimVector():Angle()-(dmginfo:GetDamagePosition()-ent:GetPos()):Angle()).y)<=blockthreshold) then
						local fac = math.Clamp( ( CurTime()-wep:GetBlockStart()-wep.BlockWindow )/wep.BlockFadeTime, 0, 1)
						local dmgscale = Lerp( fac, wep.BlockMaximum, wep.BlockMinimum)
						--print(fac)
						dmginfo:ScaleDamage(dmgscale)
						dmginfo:SetDamagePosition(vector_origin)
						wep:EmitSound(wep.Primary.Sound_Impact_Metal)	
						if wep.BlockAnim then
							wep:BlockAnim()
						end
					end
				end
			end
		end
	end
end)
--Getting the position and angle of an attachment and sending it back to the server is wayyy too laggy.  Must be pre-coded.
--[[
if SERVER then
	util.AddNetworkString( "TFM_SAPacket" )
	net.Receive("TFM_SAPacket", function()
		local ply;
		ply = net.ReadEntity()
		local pos;
		pos = net.ReadVector()
		local norm;
		norm = net.ReadNormal()
		if IsValid(ply) then
			if pos and norm then
				ply:SetNWVector("TFM_SwordPosition",pos)
				ply:SetNWVector("TFM_SwordNormal",norm)
			end
		end			
	end)
end
]]--