Config = {}

Config.truckModel = 'phantom' -- Truck model
Config.trailerModel = 'trailers' -- Trailer model
Config.key = 38 -- E key (https://docs.fivem.net/docs/game-references/controls/)
Config.multiplier = 0.6 -- multiplayer for distance (job payout)
Config.notifypos = 'top-right' -- ('top' or 'top-right' or 'top-left' or 'bottom' or 'bottom-right' or 'bottom-left' or 'center-right' or 'center-left')
Config.progres = true -- (true = circle, false = "normal")

Config.Blip = {
    sprite = 477,              -- Example: truck icon
    color = 81,                -- Orange
    scale = 0.8,
    label = "Truck Job"
}

Config.deliveryJobs = {
    {
        id = 1, -- Job ID
        title = "You Tool", -- Job title on menu
        icon = "wrench", -- Icon for the job (wrench, gas-pump,)
        destination = vector3(2689.89, 3454.57, 55.78) -- Destination coordinates
    },
    {
        id = 2,
        title = "Gas Station",
        icon = "gas-pump",
        destination = vector3(2550.16, 417.01, 108.46)
    },
    {
        id = 3,
        title = "Truck Company",
        icon = "truck",
        destination = vector3(181.47, 2750.27, 43.43)
    },
    {
        id = 4,
        title = "Chicken Bell",
        icon = "bell",
        destination = vector3(5.34, 6267.52, 31.33)
    },
    {
        id = 5,
        title = "Docks",
        icon = "ship",
        destination = vector3(1246.38, -3163.15, 5.64)
    }
    -- You can add more destination here
}

Config.Peds = {
    {
        model = "a_m_m_business_01",
        coords = vector4(2698.49, 3459.74, 55.23, 157.61),
        blip = vector3(2698.49, 3459.74, 55.23),
        spawnCoords = vector4(2688.8, 3445.24, 55.82, 243.3)
    },
    {
        model = "a_m_m_business_01",
        coords = vector4(2553.21, 399.61, 107.56, 357.08),
        blip = vector3(2553.21, 399.61, 107.56),
        spawnCoords = vector4(2565.98, 403.82, 108.46, 179.32)
    },
    {
        model = "a_m_m_business_01",
        coords = vector4(184.9, 2754.36, 44.66, 280.3),
        blip = vector3(184.9, 2754.36, 44.66),
        spawnCoords = vector4(195.59, 2709.09, 42.41, 233.28)
    },
    {
        model = "a_m_m_business_01",
        coords = vector4(-6.09, 6274.51, 30.38, 211.0),
        blip = vector3(-6.09, 6274.51, 30.38),
        spawnCoords = vector4(3.61, 6273.75, 31.24, 117.73)
    },
    {
        model = "a_m_m_business_01",
        coords = vector4(1242.6, -3180.67, 5.03, 272.22),
        blip = vector3(1242.6, -3180.67, 5.03),
        spawnCoords = vector4(1272.91, -3206.14, 5.9, 8.5)
    },
    -- You can add more peds here
}