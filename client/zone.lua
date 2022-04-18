local zoneLocation = {x = -1033.0, y = -1025.0, z = 4.0}
local radius = 250.0
local priorityRadius = 100.0

inZone = {{}, {}, {}, {}}

local teams = {
    default = {id = 1, name = "default", cmd = "def", colour = 0x00000080},
    blufor = {id = 2, name = "BLUFOR", cmd = "blu", colour = 0x0000FF80},
    opfor = {id = 3, name = "OPFOR", cmd = "opf", colour = 0xFF000080},
    independent = {id = 4, name = "INDEPENDENT", cmd = "ind", colour = 0x00FF0080}
}

RegisterNetEvent("UpdatePlayersInZone")

AddEventHandler("UpdatePlayersInZone", function(tbl)
    inZone = tbl
    print("Teams Updated")
end)

RegisterCommand('inzone', function(source, args)
    for k, v in pairs(inZone) do
    	print(#v)
    end
end, false)

local blips = {
    {title="Zone", colour=1, id=303, x = zoneLocation.x, y = zoneLocation.y, z = zoneLocation.z}
}

Citizen.CreateThread(function()

    blip = AddBlipForRadius(zoneLocation.x, zoneLocation.y, zoneLocation.z, radius)
    SetBlipColour(blip, 0xE6E6E680)

    local smallBlip = AddBlipForRadius(zoneLocation.x, zoneLocation.y, zoneLocation.z, priorityRadius)
    SetBlipColour(smallBlip, 0xFFD70080)

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end

    Citizen.Wait(1500)
    while true do
        local zoneColour = setZoneColour()
        SetBlipColour(blip, zoneColour)
        Citizen.Wait(100)
    end

end)

function setZoneColour()
    local countTbl = {default = #inZone[1], blufor = #inZone[2], opfor = #inZone[3], independent = #inZone[4]}
    local currentMax = 0

    if #inZone[1] == #inZone[2] and #inZone[1] == #inZone[3] and #inZone[1] == #inZone[4] then
        return 0xE6E6E680
    end
    
    for k, v in pairs(countTbl) do
        if v > currentMax then
            currentMax = k
        end
    end

    return teams[currentMax].colour
end