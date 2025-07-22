lib.locale()

Citizen.CreateThread(function()
    for _, pedData in ipairs(Config.Peds) do
        local model = GetHashKey(pedData.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(100)
        end
        local ped = CreatePed(4, model, pedData.coords.x, pedData.coords.y, pedData.coords.z, pedData.coords.w, false, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityHeading(ped, pedData.coords.w)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
        exports.ox_target:addLocalEntity(ped, {
            {
                name = "talk_to_ped",
                label = locale('talk_to_ped'),
                icon = "fas fa-truck",
                onSelect = function(data)
                    openpedjobmenu(pedData.blip)
                end
            }
        })
        if pedData.blip then
            local blip = AddBlipForCoord(pedData.blip.x, pedData.blip.y, pedData.blip.z)

            SetBlipSprite(blip, Config.Blip.sprite or 1)
            SetBlipDisplay(blip, Config.Blip.display or 4)
            SetBlipScale(blip, Config.Blip.scale or 0.8)
            SetBlipColour(blip, Config.Blip.color or 0)
            SetBlipAsShortRange(blip, Config.Blip.shortRange ~= false) -- default true

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blip.label or "Truck Job")
            EndTextCommandSetBlipName(blip)
        end
    end
end)
