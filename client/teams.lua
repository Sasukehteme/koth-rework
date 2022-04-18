playerTeams = {}

-- Set team when player joins
AddEventHandler('onClientGameTypeStart', function()
	TriggerServerEvent("SetTeamOnJoin")
	Citizen.Wait(500)
    enableTeamMenu(true)
end)

RegisterNetEvent("UpdateClientTeams")

AddEventHandler("UpdateClientTeams", function(tableTeam)
    playerTeams = tableTeam
end)

-- DEBUG print playerTeams
RegisterCommand('clientteam', function(source, args)
    for k, v in pairs(playerTeams) do
    	print(k..": "..v.name)
    end
end, false)
