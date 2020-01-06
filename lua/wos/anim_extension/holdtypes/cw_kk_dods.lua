CustomizableWeaponry_KK.ins2.wOS = CustomizableWeaponry_KK.ins2.wOS or {}

local DATA = {}

DATA.Name = "KK DOD:S MP40"
DATA.HoldType = "cw_kk_dods_mp40"
DATA.BaseHoldType = "ar2"
DATA.Translations = {}

DATA.Translations[ ACT_MP_STAND_IDLE ]					= 678 // 672
DATA.Translations[ ACT_MP_WALK ]						= 681
DATA.Translations[ ACT_MP_RUN ]							= 682
DATA.Translations[ ACT_MP_CROUCH_IDLE ]					= 673
DATA.Translations[ ACT_MP_CROUCHWALK ]					= 680
DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]	= 854
-- DATA.Translations[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
DATA.Translations[ ACT_MP_RELOAD_STAND ]				= 891
DATA.Translations[ ACT_MP_RELOAD_CROUCH ]				= 907
-- DATA.Translations[ ACT_MP_JUMP ]						= 3160
-- DATA.Translations[ ACT_MP_SWIM ]						= IdleActivity + 9
-- DATA.Translations[ ACT_LAND ]							= ACT_LAND

wOS.AnimExtension:RegisterHoldtype( DATA )
