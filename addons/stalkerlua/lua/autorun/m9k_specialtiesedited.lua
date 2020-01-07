/*------------------------------------------------------

If you're reading this, then that mean's you've extracted this addon, probably with intentions 
of editing it for your own needs, or that you're using a legacy addon.

I have no problem with that, but you must understand that I cannot offer support for legacy addons.
If you've extracted this addon, I cannot offer any help fixing problems that come up. It's impossible
to know what you've changed, and thus impossible to know what to fix.

"But Bob!" you might say. "I only changed one thing!" 

Well, that's a shame. Everybody is going to say this, and I know that some of those people will be
lying to me. The only thing I can do is to refuse support to everyone using legacy addons.

So, by using a legacy addon, you accept the fact that I cannot help fix anything that might be broken.

I know it's tough love, but that's the way it's got to be.

------------------------------------------------------*/

local icol = Color( 255, 255, 255, 255 ) 

if CLIENT then
	language.Add("SatCannon_ammo", "Artillery Cannon")
end


game.AddAmmoType( {
	name = "SatCannon",
	dmgtype = DMG_BULLET
} )


sound.Add({
	name =				"ARTILLERYSHOT",
	channel =			CHAN_USER_BASE+10,
	volume =			1,
	soundlevel =			155,
	sound =				"GDC/Rockets/incomingartillery.mp3"
})

sound.Add({
	name =				"ARTILLERYIMPACT",
	channel =			CHAN_USER_BASE+10,
	volume =			1,
	soundlevel =			155,
	sound =				"GDC/Rockets/artilleryimpact.mp3"
})

--specialties_autorun_mounted = true