-- [[ Resource Info ]]

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.0'
author 'Moonlight Scripts' -- https://github.com/Moonlight-Scripts
description 'FiveM Resource for Trucker Job, Feel the road!'


-- [[ Client-Side Files ]]

client_scripts {
    'client/**.lua'
}

-- [[ Server-Side Files ]]

server_scripts {
    'server/*.lua'
}

-- [[ Shared Files & Configs ]]

shared_scripts {
    '@ox_lib/init.lua',
    'configs/*.lua'
}

-- [[ Other Files ]]

escrow_ignore {
  'configs/*.lua'
}

files {
    'locales/*.json'
}

dependencies {
    'ox_target', -- https://github.com/overextended/ox_target
    'ox_lib',    -- https://github.com/overextended/ox_lib
    'ox_inventory'    -- https://github.com/overextended/ox_inventory
}
