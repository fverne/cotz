PLUGIN.name = "Hallucinations"
PLUGIN.author = "SpicyLemones"
PLUGIN.description = "Woo crazy."
/*


--include("psyhealth.lua")

include("charcreation/sh_defs.lua")



low50 = {"nightmare/voice/1shot_breathing_01.wav","vj_player/heartbeat.wav",
        "senator/psy_voices_1_r.ogg",
        "npc/bloodsucker/sucker_growl_1.ogg",
        "npc/bloodsucker/swamp_growl_1.ogg"}
low25 = {    "nightmare/voice/1shot_breathing_01.wav",
             "gsc/s.t.a.l.k.e.r/effects/psy_voices.wav",
             "black/death_4.ogg",
             "nightmare/voice/voc_overhere.wav",
             "npc/bloodsucker/sucker_growl_1.ogg",
             "npc/bloodsucker/swamp_growl_1.ogg",}
low10 = {    "black/death_6.ogg",
             "black/death_5.ogg",
             "black/enemy_down_2.ogg",
             "npc/bloodsucker/sucker_growl_1.ogg",
             "npc/bloodsucker/swamp_growl_1.ogg",
             "hgn/stalker/blowout/barman1.mp3"}

hallucinate25 = {"Hey, over here!",
    "Yo, you alright?",
    "You you you you you you you you you you you you.",
    "HELP ME.",
    "HEEEEEEEEEEEEEEEELP.",
    "Are you ok?",
    "What are you doing?",
    "Come here.",
    "Come closer.",
    "Yo, come back!",
    "Don't go there!",
    "FUCK YOU.",
    "Hey, how's it goin?",
    "Sup.",
    "Haha.",
    "жуткие страшные скелеты.",
    "Пошли дрожь по позвоночнику.",
    "Вы будете дрожать и дрожать от.",
    "Когда вы слышите крик этих зомби.",
    "Потому что жуткие, страшные скелеты Крик.",
    "поразительный, пронзительный крик Они вылезут из саркофага.",
    "Ifølge alle kendte Love af luftfart.",
    "der er ingen måde en bi.",
    "Dens vinger er for små til at få.",
    "Bien flyver selvfølgelig alligevel.",
    "因为蜜蜂不在乎",
    "人类所认为的是不可能的。",
    "lol.",
    "fuck.",
    "lmao.",
    "Stop moving for a sec.",
    "Let's trade",
    "Yo, there's mutants."}

hallucinate10 = {"Yo, there's a dead body here.",
    "WHAT THE FUCK ARE YOU DOING DUDE?",
    "Yo, what the fuck!?",
    "Hey, stop moving for a sec.",
    "HIDE!",
    "Mutants to the left!",
    "Mutants to the right!",
    "They're under your skin!",
    "Yo.",
    "Hey dude.",
    "Just die, I can rez you.",
    "I've got some meds here.",
    "Keep running!",
    "Drop your items, it'll regen your psy.",
    "Yo, there's a gun here",
    "Hey, there's a suit here",
    "сверхъестественные стесняются, в чем вообще суета?",
    "Все равно глупы Они будут.",
    "Буду тебя свистом!",
    "Жуткие, страшные скелеты",
    "И просто не оставлю тебя в покое",
    "Жуткие, страшные скелеты",
    "Кричите пугающими, пронзительными криками",
    "Ты просто хочешь пообщаться, но я не думаю, что нам следует",
    "Жуткие, страшные скелеты",
    "Кричите пугающими, пронзительными криками",
    "Uhyggelige, skræmmende skeletter",
    "Send kuldegysninger ned ad ryggen",
    "Du vil ryste og gyse i overraskelse",
    "If you stop moving you can regen your psy.",
    "If you die in an anomaly field you can respawn with full psy.",
    "You're already dead anyways."
    }

spooky25 = {"H̸̀͜e̴͉͝l̶̼̇l̴̰̆ ̷̨̆i̵̘̎s̶̮̈ ̵͈̅è̴͓m̸̨̐p̵̛̖t̷̗̂ŷ̷̫ ̷͔͛a̸̡̓n̷̙͊d̶͕̄ ̶̼͗ȧ̶̻l̸̦͆l̸̺͛ ̸̈͜t̶̐ͅh̸̜͠e̵̹͑ ̶̰̚d̷̙͆e̸͓̚v̷͂͜i̷̫̓l̸̗̊s̸͔̋ ̷͓̒a̷̖̚r̷̩̿e̵̺͐ ̴̩́h̶̭̐ẻ̸͙ŕ̸̼e̴͓̽.̴̢̕",
    "Y̶̺̽o̶̤̓ủ̸̦ ̸̯̍a̴̖͛r̵̛̼ē̴̪ ̸̞͒à̶̗l̴̪͐r̷͙̓e̸̢̓å̸̩d̶̙̒y̵̺͆ ̷̛͙d̷̠͐e̷̺͗ä̶̟ḏ̴͊",
    "Å̶͎r̶͇͗e̶͍͆ ̸̱̈́y̷̪̒o̴͍͌ṳ̶͋ ̸͆͜a̴̭͘ḽ̵͆r̴̳̽i̷̗̅g̸̠̋h̸͓̽t̸̬̑?̷̐͜",
    "Å̶͎r̶͇͗e̶͍͆ ̸̱̈́y̷̪̒o̴͍͌ṳ̶͋ ̸͆͜a̴̭͘ḽ̵͆r̴̳̽i̷̗̅g̸̠̋h̸͓̽t̸̬̑?̷̐͜"}

spooky10 = {"Y̴̰̎̚Ơ̶͔̼̹͍̌̈̓Ǜ̶̢̦ ̴̙͙̈́́̂̅Â̸̠̯̆Ŕ̴̢̌̂͝Ȇ̷̮̃́ ̸̩̠͍̫͂̀͠D̶̮͓́͝E̸̱̫̮̎̌́͘A̷̟͉̼̲̿̑̄D̵̨̯̒̀ ̸̥͓̀Ḑ̸̨͙͝Ę̷̘̩̑̍̆͠A̸̩̐̀͗͜D̸̯̠̿͑͂͜ ̷̠̄̃D̷̹̉̓̚E̷̼̭̳͕̓͐͂Ḁ̸̰͔̥̉̐̕D̴͎̙̅ ̴̧͔́͑́̿D̷̛̖̪̆͊̇E̷̛̦͠͝À̴̻̰͍̝D̸̢̤̫͍̉ ̷̨͉̯̣̅̔̕D̴̨̖̖͔͊̃Ë̷̱͓́̎̚͝Ä̷̧͇́̓͑͂Ḓ̸̛͋",
    "H̴͖̜̰̺͒͘A̸̩͑̈́̂Ḧ̸̬̜̭͚́̌͘Ą̷̣̭̟̑̉͛H̸̬̠͒̇̕̕A̷̻̦͂̆̽͊H̵̖͍̲́͊A̸͍̩̪̯̽̊̾H̵͖̐Ȁ̸̡͔̳̆ͅH̸̪͙̞̰̒͂̉Ą̸̪̮͓͂̒͊H̸̘̫͊͗̔Ā̸̱H̶̱̒A̸͚̽̿Ḣ̵͛͠ͅA̴͍͖͌̌͝͝H̸̯͈̣̉́̏͝H̴̖̳̫͋A̷̻̪͚͛̒́H̸̬̄͌͌̕Â̵͖̥̓͌H̶͖̗̃̈́A̴̳̐͑͝H̴̡̛̙͊͛Á̴͓̟̺̤̒͂̔",
    "Å̶͎r̶͇͗e̶͍͆ ̸̱̈́y̷̪̒o̴͍͌ṳ̶͋ ̸͆͜a̴̭͘ḽ̵͆r̴̳̽i̷̗̅g̸̠̋h̸͓̽t̸̬̑?̷̐͜",
    "You are weak.",
    "Die."}

local player = FindMetaTable("Player")

local icon = Material("entities/vj_mutant_senator.png")


ix.chat.Register("meme", {
	CanSay = function(self, speaker, text)
	    speaker:EmitSound("stalkersound/pda/pda_sos.wav", 55, 100, 0.2, CHAN_AUTO)
		if IsValid(speaker) then
			if speaker:IsAdmin() or speaker:GetCharacter():HasFlags("N") then
				return true
			else
				return false
			end
		else
			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,0,0), "[???] ", Color(138,3,3), icon, ": "..text)
	end,
	prefix = {"/???"}
})

ix.chat.Register("fakeic", {
			--format = "%s says \"%s\"",
			--indicator = "chatTalking",
            OnChatAdd = function(self, speaker, text)
                chat.AddText(Color(255, 255, 150), text)
            end,
})





if (SERVER) or (CLIENT) then
    ticksoundcd = 0

    function PLUGIN:PlayerTick(ply)


        if (ply != nil) then
        playerpsy = ply:GetPsyHealth()
        -- print (self.stalkernames)
        end


        if (playerpsy != nil && playerpsy > 50) then
                    if (CLIENT) then
                        for k,v in pairs(ents.FindByClass("class C_PhysPropClientside")) do
                            v:Remove()
                        end
                    end
        end

        if (playerpsy != nil && playerpsy <= 50 ) then
            ticksoundcd =ticksoundcd + 1

        end


        --change this for how random you want it to be
        rando = math.random(15)

        if (playerpsy != nil &&  playerpsy <= 50 && playerpsy > 25 && ticksoundcd > 1800) then

            if (SERVER) then
		sound.PlayFile(ply,low50[math.random(#low50)],"3d noplay", function (snd, err, errName)
		    if not err and (IsValid(snd)) then
			    snd:SetPos(ply:GetPos() + ply:GetAimVector() * -100 )
			    snd:Set3DFadeDistance(500, 1000)
			    snd:SetVolume(1)
			    snd:EnableLooping(false)
			    snd:SetPlaybackRate(1)
			    snd:Play()

		    end
		end)
               
            end
			 ticksoundcd = 0
			
			

        elseif (playerpsy != nil && playerpsy <= 25 && playerpsy > 10 && ticksoundcd > 1800) then

            --local button = ents.Create( "npc_zombie" )
            --button:SetPos( Vector( 0, 0, 100 ) )
            if (SERVER) then
		sound.PlayFile(ply,low25[math.random(#low25)],"3d noplay", function (snd, err, errName)
		    if not err and (IsValid(snd)) then
			    snd:SetPos(ply:GetPos() + ply:GetAimVector() * -100 )
			    snd:Set3DFadeDistance(500, 1000)
			    snd:SetVolume(1)
			    snd:EnableLooping(false)
			    snd:SetPlaybackRate(1)
			    snd:Play()

		    end
		end)
                --filter = RecipientFilter()
               -- filter:AddPlayer(ply)
                --sound = CreateSound(ply,low25[math.random(#low25)])
                --sound:Play()
				


                if (rando < 1) then
                    ix.chat.Send(ply,"meme", spooky25[math.random(#spooky10)], false, ply)
                elseif (rando < 5) then
                    faketext = ""
                    faketext = faketext.format('%s %s says "%s"', self.stalkernames[math.random(#self.stalkernames)],self.stalkersnames[math.random(#self.stalkersnames)], hallucinate25[math.random(#hallucinate25)])
                    ix.chat.Send(ply,"fakeic", faketext,false,ply)

                end

            end

            ticksoundcd = 0


        elseif (playerpsy != nil && playerpsy <= 10 && ticksoundcd > 1800) then

            if (SERVER) then
				
				
		sound.PlayFile(ply,low10[math.random(#low10)],"3d noplay", function (snd, err, errName)
		    if not err and (IsValid(snd)) then
			    snd:SetPos(ply:GetPos() + ply:GetAimVector() * -100 )
			    snd:Set3DFadeDistance(500, 1000)
			    snd:SetVolume(1)
			    snd:EnableLooping(false)
			    snd:SetPlaybackRate(1)
			    snd:Play()

		    end
		end)

                if (rando < 2) then
                    ix.chat.Send(ply,"meme", spooky10[math.random(#spooky10)], false, ply)
                    spoopytime = 0


                elseif (rando < 10) then
                    faketext = ""
                    faketext = faketext.format('%s %s says "%s"', self.stalkernames[math.random(#self.stalkernames)],self.stalkersnames[math.random(#self.stalkersnames)], hallucinate10[math.random(#hallucinate10)])
                    ix.chat.Send(ply,"fakeic", faketext,false,ply)

                end



            end

            if (rando == 1) then
                    -- make ragdoll here
                    if (CLIENT) then

                            --print(ply:GetAngles())
                            spook = ents.CreateClientProp()
                            spook:SetModel("models/monsters/poltergeist.mdl")
                            spook:SetPos( ply:GetPos() + ply:GetAimVector() * -100   - Vector(0,0,-50))
                            spook:SetAngles( ply:GetAngles())
                            spook:Spawn()

                    end
            end




            ticksoundcd = 0



        end



        --print(ticksoundcd)
        --print(playerpsy)
    end
end



--[[print(ply:GetPsyHealth())



ix.command.Add("Meme", {
	adminOnly = true,
	OnRun = function()
	    print("lol")
	end
})]]--

*/