-- Server Events
RegisterServerEvent("SetTeamOnJoin") -- Set the player to default team when they join
RegisterServerEvent("SetPlayerTeam") -- Change the players team from the client

-- Create the table that holds all players and their respective teams data e.g. {player = {teamdata}}
playerTeams = {}

-- Table filled with all the teams data
local teams = {
    default = {id = 1, name = "default", cmd = "def", colour = 0x00000080},
    blufor = {id = 2, name = "BLUFOR", cmd = "blu", colour = 0x0000FF80},
    opfor = {id = 3, name = "OPFOR", cmd = "opf", colour = 0xFF000080},
    independent = {id = 4, name = "INDEPENDENT", cmd = "ind", colour = 0x00FF0080}
}

-- Variable stored the default team
local defaultTeam = teams.default

-- Function to change the players team
function setPlayerTeam(ped, team)
    -- Check if ped exists
	if ped == nil then return end

    -- Loop through teams table to find team
    for k, v in pairs(teams) do
        if v.cmd == team then
            playerTeams[ped] = v
        end
    end

    broadcastPlayerTeams()

end

-- Send the playerTeams table to all players
function broadcastPlayerTeams()
	TriggerClientEvent("UpdateClientTeams", -1, playerTeams)
end

-- Return the players teams data
function getPlayerTeam(ped)
    if (playerTeams[ped]) then return playerTeams[ped] end
end

function getPlayerTeamID(ped)
    if playerTeams[ped] then return playerTeams[ped].id end
end

AddEventHandler("SetTeamOnJoin", function(team)
    local ped = source -- source == player ID
	setPlayerTeam(ped, "def")
end)

AddEventHandler("SetPlayerTeam", function(team)
	setPlayerTeam(source, team)
end)