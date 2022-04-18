local zoneLocation = vector3(-1033.0, -1025.0,  0)
local radius = 250.0
local priorityRadius = 100.0

inZone = {{}, {}, {}, {}}
lastSent = {1}

function TableComp(a,b) --algorithm is O(n log n), due to table growth.
    i = 1
    while i < 5 do
        if #a ~= #b then return false end

        if #a[i] ~= #b[i] then
            return false
        end
        i = i + 1
    end

    return true
end

function getPlayersInZone()
    inZone = {{}, {}, {}, {}}
    for k, v in pairs(GetPlayers()) do
        local pedCoords = vector3(GetEntityCoords(GetPlayerPed(v)).x, GetEntityCoords(GetPlayerPed(v)).y, 0)
        local pedTeam = getPlayerTeamID(k)

        if #(pedCoords - zoneLocation) < radius then
            table.insert(inZone[tonumber(pedTeam)], v)
        end
    end
    return inZone
end

function broadcastPlayersInZone()
    Citizen.Wait(100)
    local tblToSend = getPlayersInZone()
    if not TableComp(lastSent, tblToSend) then
	    TriggerClientEvent("UpdatePlayersInZone", -1, tblToSend)
        lastSent = tblToSend
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        broadcastPlayersInZone()
        Citizen.Wait(100)
    end
end)

RegisterCommand('printinzone', function()
    getPlayersInZone()
    for k, v in pairs(inZone) do
        print("team")
        print(k)
        for i, n in pairs(v) do
            print(GetPlayerName(n))
        end
    end
end)
