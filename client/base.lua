local spawnPos = vector3(-1081.7, -766.8, 19.35724)

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            -- this argument is basically a table containing the spawn location...
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            -- ... and the model to spawn as.
            model = 'a_m_m_skater_01'
        }, function()
            -- a callback to be called once the player is spawned in and the game is visible
            -- in this case, we just send a message to the local chat box.
            TriggerEvent('chat:addMessage', {
                args = { 'Welcome to the party!~' }
            })
        end)
    end)

    -- enable auto-spawn
    exports.spawnmanager:setAutoSpawn(true)

    -- and force respawn when the game type starts
    exports.spawnmanager:forceRespawn()

end)

AddEventHandler("playerSpawned", function(spawn)
	local ped = PlayerPedId()
	SetCanAttackFriendly(ped, true, true)
	NetworkSetFriendlyFireOption(true)
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

RegisterCommand("giveweapon", function(source, args)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 999, false, false)
end)