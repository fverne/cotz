local PLUGIN = PLUGIN
PLUGIN.name = "Buffs and Debuffs"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1), verne (Helix)"
PLUGIN.desc = "Sometimes, You get sick or high. DrunkyBlur by Spy."
PLUGIN.buffs = {}

local playerMeta = FindMetaTable("Player")

ix.util.Include("sh_buffs.lua")
ix.util.Include("sh_buffhooks.lua")
ix.util.Include("sh_bleeding.lua")
ix.util.Include("sv_persistence.lua")
ix.util.Include("cl_hud.lua")

-- player:GetBuffs()
-- returns table
-- This function gets one's all buffs.
function playerMeta:GetBuffs()
	return self:GetNetVar( "buffs" ) or {}
end

-- player:AddBuff( string [Buff's unique name] )
-- returns table or boolean( false )
-- This function allows you handle buffs
function playerMeta:HasBuff( strBuff )
	if (self:GetNetVar( "buffs" ) ~= nil) then
		return ( self:GetNetVar( "buffs" )[ strBuff ] )
	else
		return false
	end
end

function PLUGIN:GetBuff( strBuff )
	return self.buffs[str]
end

if (SERVER) then
	-- player:AddBuff( string [Buff's unique name], integer [Buff's Duration Time], table [Parameters] )
	-- This function allows you to add some buffs to player.
	function playerMeta:AddBuff( strBuff, intDuration, parameter ) 
		if intDuration < 0 then intDuration = 1000000 end
		local tblBuffs = self:GetNetVar( "buffs" ) or {}
		local tblBuffInfo = PLUGIN.buffs[strBuff]
		if tblBuffInfo and tblBuffInfo.onbuffed then
			if not self:HasBuff( strBuff ) then
				tblBuffInfo.onbuffed( self, parameter )
			end
		end
		tblBuffs[ strBuff ] = { CurTime() + intDuration, parameter }
		hook.Call( "OnBuffed", GAMEMODE, strBuff, intDuration, parameter )
		self:SetNetVar( "buffs", tblBuffs )
	end
	
	function playerMeta:RemoveBuff(buffName, parameters)
		local currentBuffs = self:GetBuffs()
		local buff = currentBuffs[buffName]
		if not buff then return end

		parameters = parameters or buff[2]
		local definition = PLUGIN.buffs[buffName]
		if definition and definition.ondebuffed then
			definition.ondebuffed(self, parameters)
		end

		currentBuffs[buffName] = nil
		hook.Call("OnDebuffed", GAMEMODE, buffName, nil, parameters)
		self:SetNetVar("buffs", currentBuffs)
	end
	
	-- player:Think( )
	-- This hook handles every player's buff effect.
	-- I suggest you do not touch this function unless you know what you're doing.
	function PLUGIN:Think()
		self:ProcessBleeding()

		for _, v in player.Iterator() do
			if IsValid(v) and v:Alive() then self:ProcessBandageClotting(v) end
			local tblBuffs = v:IsValid() and v:Alive() and v:GetBuffs() or {}
			for name, dat in pairs( tblBuffs ) do
				local tblBuffInfo = self.buffs[ name ]
				if dat[1] <= CurTime() then
					v:RemoveBuff( name, dat[2] )
				elseif tblBuffInfo and tblBuffInfo.func then
					tblBuffInfo.func( v, dat[2] )
				end
			end
		end
	end

else

	function PLUGIN:Think()
		for _, v in player.Iterator() do
			local tblBuffs = v:IsValid() and v:Alive() and v:GetBuffs() or {}
			for name, dat in pairs( tblBuffs ) do
				local tblBuffInfo = self.buffs[ name ]
				if tblBuffInfo and tblBuffInfo.cl_func then
					tblBuffInfo.cl_func( v, dat[2] )
				end
			end
		end
	end

end
