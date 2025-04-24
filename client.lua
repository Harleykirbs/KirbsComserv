local tasksLeft = 0
local doingTask = false
local comservActive = false

RegisterNetEvent("comserv:start", function(taskAmount)
    comservActive = true
    tasksLeft = taskAmount
    TaskGoStraightToCoord(PlayerPedId(), 1691.4, 2565.3, 45.5, 2.0, -1, 0.0, 0.0)
    SetEntityCoords(PlayerPedId(), 1691.4, 2565.3, 45.5)
    TriggerEvent("chat:addMessage", {
        args = {"^2[Community Service]", "Complete " .. taskAmount .. " cleaning tasks to be released."}
    })
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if comservActive and tasksLeft > 0 and not doingTask then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)

            -- Marker for interaction
            DrawMarker(1, coords.x, coords.y + 2, coords.z - 1, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.0, 255, 255, 0, 100, false, true, 2, nil, nil, false)

            if IsControlJustReleased(0, 38) then -- E key
                doingTask = true
                TaskStartScenarioInPlace(playerPed, "world_human_janitor", 0, true)
                Wait(5000)
                ClearPedTasks(playerPed)
                tasksLeft = tasksLeft - 1
                doingTask = false

                if tasksLeft <= 0 then
                    comservActive = false
                    TriggerEvent("chat:addMessage", { args = {"^2[Community Service]", "You have completed your service. You're free to go!"} })
                else
                    TriggerEvent("chat:addMessage", { args = {"^3[Community Service]", "Task complete! " .. tasksLeft .. " remaining."} })
                end
            end
        end
    end
end)

