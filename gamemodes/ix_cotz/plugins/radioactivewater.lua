PLUGIN.name = "Radioactive Water"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Makes water less safe to traverse."

ix.config.Add("radioactiveWaterEnabled", true, "If true, water will be radioactive.", nil, {
	category = "World"
})

PLUGIN.isEnabled = true

PLUGIN.enableTimer = 0
PLUGIN.thinkTimer = 0

PLUGIN.geigerLight = {"geiger/light/geiger_light_1.wav", "geiger/light/geiger_light_2.wav", "geiger/light/geiger_light_3.wav", "geiger/light/geiger_light_4.wav", "geiger/light/geiger_light_5.wav", }

local movetypes = {
		[MOVETYPE_NONE] = true,
		[MOVETYPE_FLYGRAVITY] = true,
		[MOVETYPE_NOCLIP] = true,
		[MOVETYPE_OBSERVER] = true
}

if SERVER then

	function PLUGIN:Think( )
		if(self.enableTimer < CurTime()) then
			self.isEnabled = ix.config.Get("radioactiveWaterEnabled",true)
			self.enableTimer = CurTime() + 10
		end
	
		if(self.thinkTimer < CurTime()) then
			for _, player in pairs(player.GetAll()) do
				if(player:WaterLevel() > 0 and not movetypes[player:GetMoveType()]) then
					local TEMP_TargetDamage = DamageInfo()
									
					TEMP_TargetDamage:SetDamage(player:WaterLevel() * 2)
					TEMP_TargetDamage:SetInflictor(player)
					TEMP_TargetDamage:SetDamageType(DMG_RADIATION)
					TEMP_TargetDamage:SetAttacker(player)
	
					player:TakeDamageInfo(TEMP_TargetDamage)
					if player.hasGeiger && player:hasGeiger() then
						player:EmitSound(table.Random(self.geigerLight))
					end
				end
			end
			self.thinkTimer = CurTime()+0.5
		end
	end

end