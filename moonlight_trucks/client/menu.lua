function openpedjobmenu(npcPos)
    local options = {}

    for _, job in ipairs(Config.deliveryJobs) do
        
        local dist = #(npcPos - job.destination)
        if dist > 100.0 then
            local multiplier = Config.multiplier
            local totalpay = math.floor(dist * multiplier)
            table.insert(options, {
                title = job.title,
                description = locale('payout'):format(totalpay),
                icon = job.icon or "truck",
                onSelect = function()
                    missionstartingtruckjob(job.id)
                end
            })
        end
    end
    lib.registerContext({
        id = 'truck_job_menu',
        title = locale('menu_title'),
        options = options
    })
    lib.showContext('truck_job_menu')
end
