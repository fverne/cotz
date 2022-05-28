local PLUGIN = PLUGIN
local _tonumber = tonumber
local _math_ceil = math.ceil
local _SoundDuration = SoundDuration
local _Ambients_Cooldown = 10

PLUGIN.name = "Ambient Music"
PLUGIN.description = "Adds background music (client-side)"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"
PLUGIN.songs = {
    {path = "ambient/cotz_01.mp3", duration = 349}, --Apocryphos, Kammarheit, Atrium Carceri - Night so Close to the Tongue
    {path = "ambient/cotz_02.mp3", duration = 318}, --Apocryphos, Kammarheit, Atrium Carceri - Burrows
    {path = "ambient/cotz_03.mp3", duration = 573}, --Apocryphos, Kammarheit, Atrium Carceri - A Lonely Strain
    {path = "ambient/cotz_04.mp3", duration = 431}, --Ugasanie - Aurora
    {path = "ambient/cotz_05.mp3", duration = 389}, --Ugasanie - WIthout the Sun
    {path = "ambient/cotz_06.mp3", duration = 316}, --Abandoned
    {path = "ambient/cotz_07.mp3", duration = 480}, --Dead Melodies - Bryn Celli Ddu
    {path = "ambient/cotz_08.mp3", duration = 499}, --Northumbria - Torngat
    {path = "ambient/cotz_09.mp3", duration = 248}, --Alphaxone & Dronny Darko - Immersion
    {path = "ambient/cotz_10.mp3", duration = 384}, --Wolves and Horses - Aphelion
    {path = "ambient/cotz_11.mp3", duration = 346}, --Keosz - Consigned To Limbo
    {path = "ambient/cotz_12.mp3", duration = 314}, --Apocryphos, Kammarheit, Atrium Carceri - Omission
    {path = "ambient/cotz_13.mp3", duration = 330}, --Council of Nine - Void of Regret
    {path = "ambient/cotz_14.mp3", duration = 682}, --Northumbria - Helluland
    {path = "ambient/cotz_15.mp3", duration = 256}, --Keosz - Nothing Left But Gloom
}

ix.lang.AddTable("english", {
	optEnableAmbient = "Enable ambient",
    optAmbientVolume = "Ambient volume"
})

ix.lang.AddTable("russian", {
	optEnableAmbient = "Включить фоновую музыку",
    optAmbientVolume = "Громкость фоновой музыки"
})

if (CLIENT) then
    m_flAmbientCooldown = m_flAmbientCooldown or 0
    bAmbientPreSaver = bAmbientPreSaver or false

    ix.option.Add("enableAmbient", ix.type.bool, true, {
		category = PLUGIN.name,
        OnChanged = function(oldValue, value)
            if (value) then
                if IsValid(PLUGIN.ambient) then
                    local volume = ix.option.Get("ambientVolume", 1)
                    PLUGIN.ambient:SetVolume(volume)
                end
            else
                if IsValid(PLUGIN.ambient) then
                    PLUGIN.ambient:SetVolume(0)
                end
            end
        end
	})

	ix.option.Add("ambientVolume", ix.type.number, 0.35, {
		category = PLUGIN.name,
        min = 0.1,
        max = 2,
        decimals = 1,
        OnChanged = function(oldValue, value)
            if IsValid(PLUGIN.ambient) and ix.option.Get("enableAmbient", true) then
                PLUGIN.ambient:SetVolume(value)
            end
        end
	})

    do
        if !table.IsEmpty(PLUGIN.songs) then
            for _, data in ipairs(PLUGIN.songs) do
                util.PrecacheSound(data.path)
            end
        end
    end

    function PLUGIN:CreateAmbient()
        local bEnabled = ix.option.Get('enableAmbient', true)

        if (bEnabled and !bAmbientPreSaver) then
            local flVolume = _tonumber(ix.option.Get('ambientVolume', 1))
            local mSongTable = self.songs[math.random(1, #self.songs)]
            local mSongPath = mSongTable.path
            local mSongDuration = mSongTable.duration or _SoundDuration(mSongPath)

            sound.PlayFile('sound/' .. mSongTable.path, 'noblock', function(radio)
                if IsValid(radio) then
                    if IsValid(self.ambient) then self.ambient:Stop() end

                    radio:SetVolume(flVolume)
                    radio:Play()
                    self.ambient = radio

                    m_flAmbientCooldown = os.time() + _tonumber(mSongDuration) + _Ambients_Cooldown
                end
            end)
        end
    end

    net.Receive('ixPlayAmbient', function()
        if !timer.Exists('mAmbientMusicChecker') then
            timer.Create('mAmbientMusicChecker', 5, 0, function()
                if (m_flAmbientCooldown or 0) > os.time() then return end
                PLUGIN:CreateAmbient()
            end)
        end

        if !timer.Exists('mAmbientChecker') then
            timer.Create('mAmbientChecker', 0.5, 0, function()
                if IsValid(ix.gui.characterMenu) and ix.config.Get("music") ~= "" then
                    if IsValid(PLUGIN.ambient) then
                        PLUGIN.ambient:SetVolume(0)
                    end
                else
                    if ix.option.Get('enableAmbient', true) then
                        if IsValid(PLUGIN.ambient) then
                            local volume = ix.option.Get("ambientVolume", 1)
                            PLUGIN.ambient:SetVolume(volume)
                        end
                    end
                end
            end)
        end
    end)
end

if (SERVER) then
    util.AddNetworkString('ixPlayAmbient')
    function PLUGIN:PlayerLoadedCharacter(client, character, currentChar)
        net.Start('ixPlayAmbient')
        net.Send(client)
    end
end