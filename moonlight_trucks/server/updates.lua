local currentVersion = "1.0.0"
local resourceName = GetCurrentResourceName()
local versionURL = "https://raw.githubusercontent.com/Moonlight-Scripts/update_checker/refs/heads/main/truckjob.txt" -- Change to your hosted version file
function checkForUpdate()
    PerformHttpRequest(versionURL, function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            local remoteVersion = resultData:match("^%s*(.-)%s*$") -- Trim any whitespace
            if remoteVersion ~= currentVersion then
                print("[^8WARNING^8] " .. resourceName .. " has an update available: " .. remoteVersion .. " (current: " .. currentVersion .. ")")
            else
                print("[^2INFO^7] " .. resourceName .. " is up-to-date.")
            end
        else
            print("[^8ERROR^8] Failed to check for updates for " .. resourceName .. ". HTTP error: " .. errorCode)
        end
    end)
end
Citizen.CreateThread(function()
    checkForUpdate()
end)
