local showRadius = 2.5
local key = Config.key
local isShowing = false 
local missionActive = false 
local truckModel = Config.truckModel
local trailerModel = Config.trailerModel
local truck = nil
local trailer = nil
local playerPed = PlayerPedId()
local multiplayer = Config.multiplayer
local npcPos = nil

function GetNearestPedData()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local nearestPedData = nil
    local shortestDistance = math.huge

    for _, pedData in ipairs(Config.Peds) do
        local pedCoords = vector3(pedData.coords.x, pedData.coords.y, pedData.coords.z)
        local dist = #(playerCoords - pedCoords)
        if dist < shortestDistance then
            shortestDistance = dist
            nearestPedData = pedData
        end
    end

    return nearestPedData
end
function missionstartingtruckjob(selectedId)
    local job = nil
    for _, deliveryJob in ipairs(Config.deliveryJobs) do
        if deliveryJob.id == selectedId then
            job = deliveryJob
            break
        end
    end
    if not job then
        print("Error: No delivery job found with id " .. tostring(selectedId))
        return
    end
    currentJob = job
    markerPos = job.destination
    SetNewWaypoint(markerPos.x, markerPos.y)
    if Config.progres == true then
        lib.progressCircle({
        duration = 4000,
        position = 'bottom',
        label = locale('instructions'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true
        },
        anim = {
            dict = 'misscarsteal4@actor',
            clip = 'actor_berating_loop'
        },
        }) 
    else
        lib.progressBar({
        duration = 4000,
        label = locale('instructions'),
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true
        },
        anim = {
            dict = 'misscarsteal4@actor',
            clip = 'actor_berating_loop'
        },
        })
    end
    RequestModel(GetHashKey(truckModel))
    while not HasModelLoaded(GetHashKey(truckModel)) do
        Wait(100)
    end
    RequestModel(GetHashKey(trailerModel))
    while not HasModelLoaded(GetHashKey(trailerModel)) do
        Wait(100)
    end
    local pedData = GetNearestPedData()
    npcPos = vector3(pedData.coords.x, pedData.coords.y, pedData.coords.z)
    if not pedData then
        print("No nearby ped data found")
        return
    end
    local spawnCoords = pedData.spawnCoords
    local spawnPos = vector3(spawnCoords.x + 5.0, spawnCoords.y, spawnCoords.z) -- offset by 5 on X
    local heading = spawnCoords.w
    truck = CreateVehicle(GetHashKey(truckModel), spawnPos.x, spawnPos.y, spawnPos.z, heading, true, false)
    trailer = CreateVehicle(GetHashKey(trailerModel), spawnPos.x + 10.0, spawnPos.y, spawnPos.z, heading, true, false)
    AttachVehicleToTrailer(truck, trailer, 1.1)
    TaskWarpPedIntoVehicle(playerPed, truck, -1)
    missionActive = true
    lib.notify({
        description = locale('mission_start'),
        type = 'inform',
        position = Config.notifypos,
    })
end

function missionstopingtruckjob()
    if currentJob and npcPos then
        local dist = #(npcPos - markerPos)
        local multiplier = Config.multiplier
        local totalpay = math.floor(dist * multiplier)
        TriggerServerEvent("moonlight_trucks:ztas1234tjiaeuz1478134", totalpay)
        currentJob = nil
        npcPos = nil
    else
        print("Error: No active job or missing NPC position")
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if missionActive then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local dist = #(coords - markerPos)
            DrawMarker(1, markerPos.x, markerPos.y, markerPos.z - 1.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                2.5, 2.5, 0.5,
                255, 255, 0, 200,
                false, true, 2, false, nil, nil, false)
            if dist < showRadius then
                if not isShowing then
                    lib.showTextUI(locale('stop_job'), {
                        icon = 'truck',
                    })
                    isShowing = true
                end
                if IsControlJustReleased(0, key) then
                    local veh = GetVehiclePedIsIn(playerPed, false)
                    if veh == truck then
                        missionstopingtruckjob()
                        lib.hideTextUI()
                        isShowing = false
                        missionActive = false
                        if truck and DoesEntityExist(truck) then
                            DeleteEntity(truck)
                            truck = nil
                        end
                        if trailer and DoesEntityExist(trailer) then
                            DeleteEntity(trailer)
                            trailer = nil
                        end
                        lib.notify({
                            description = locale('stop_job_notify'),
                            type = 'inform'
                        })
                    else
                        lib.notify({
                            description = locale('stop_job_notify_error'),
                            type = 'error'
                        })
                    end
                end
            else
                if isShowing then
                    lib.hideTextUI()
                    isShowing = false
                end
            end
        else
            if isShowing then
                lib.hideTextUI()
                isShowing = false
            end
            Wait(500)
        end
    end
end)