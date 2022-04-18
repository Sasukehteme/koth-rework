local ui = false

local count = 0

-- local HUD_ELEMENTS = {
--     HUD = { id = 0, hidden = true },
--     HUD_WANTED_STARS = { id = 1, hidden = true },
--     HUD_WEAPON_ICON = { id = 2, hidden = true },
--     HUD_CASH = { id = 3, hidden = true },
--     HUD_MP_CASH = { id = 4, hidden = true },
--     HUD_MP_MESSAGE = { id = 5, hidden = true },
--     HUD_VEHICLE_NAME = { id = 6, hidden = true },
--     HUD_AREA_NAME = { id = 7, hidden = true },
--     HUD_VEHICLE_CLASS = { id = 8, hidden = true },
--     HUD_STREET_NAME = { id = 9, hidden = true },
--     HUD_HELP_TEXT = { id = 10, hidden = true },
--     HUD_FLOATING_HELP_TEXT_1 = { id = 11, hidden = true },
--     HUD_FLOATING_HELP_TEXT_2 = { id = 12, hidden = true },
--     HUD_CASH_CHANGE = { id = 13, hidden = true },
--     HUD_RETICLE = { id = 14, hidden = true },
--     HUD_SUBTITLE_TEXT = { id = 15, hidden = true },
--     HUD_RADIO_STATIONS = { id = 16, hidden = true },
--     HUD_SAVING_GAME = { id = 17, hidden = true },
--     HUD_GAME_STREAM = { id = 18, hidden = true },
--     HUD_WEAPON_WHEEL = { id = 19, hidden = true },
--     HUD_WEAPON_WHEEL_STATS = { id = 20, hidden = true },
--     MAX_HUD_COMPONENTS = { id = 21, hidden = true },
--     MAX_HUD_WEAPONS = { id = 22, hidden = true },
--     MAX_SCRIPTED_HUD_COMPONENTS = { id = 141, hidden = true }
-- }

-- -- Main thread
Citizen.CreateThread(function()
    -- Loop forever and update HUD every frame
    while true do
        if ui then
            -- If enabled only show radar when in a vehicle (use a zoomed out view)
            -- if HUD_HIDE_RADAR_ON_FOOT then
            --     local player = GetPlayerPed(-1)
            --     DisplayRadar(IsPedInAnyVehicle(player, false))
            --     SetRadarZoomLevelThisFrame(200.0)
            -- end

            -- -- Hide other HUD components
            -- for key, val in pairs(HUD_ELEMENTS) do
            --     if val.hidden then
            --         HideHudComponentThisFrame(val.id)
            --     else
            --         ShowHudComponentThisFrame(val.id)
            --     end
            -- end

            SetCamRot(customCam, math.cos(count)-90.0, 0.0, 0.0, 2)
            count = count + 0.01
        end
        Citizen.Wait(10)
    end
end)

function enableTeamMenu(bool)
    SendNUIMessage({showUI = bool; }) -- Sends a message to the js file. 
    SetNuiFocus(bool, bool)
    ui = bool

    if bool then
        DisplayRadar(false)
        customCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(customCam, -1033.0, -1025.0, 200.0)
        SetCamRot(customCam, -90.0, 0.0, 0.0, 2)
        RenderScriptCams(1,0,2500,0,0)
    end
end

RegisterCommand('openteammenu', function()
    enableTeamMenu(true)
end)

RegisterNUICallback('sendTeamSelected', function(data, cb)
    -- POST data gets parsed as JSON automatically
    SetCamActive(customCam, false)
    RenderScriptCams(0,1,2500,0,0)

    DisplayRadar(true)

    local teamId = data.teamId
    enableTeamMenu(false)
    
    TriggerServerEvent("SetPlayerTeam", teamId)
end)
