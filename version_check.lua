-----------------------------------------------------------------------------
-- Simple 911 Script by ShadyPup- A Simple FiveM Script, Made By ShadyPup --
-----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
-- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
-- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! THERE IS NOTHING TO EDIT --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------
-- Branding!
local label =
    [[ 
  //
  ||         📞🆘 | 911 Script for HAMZ CAD | 📞🆘  
  ||                Created by ShadyPup
  ||]]






Citizen.CreateThread(function()
    local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    if not CurrentVersion then
        print('^1Simple 911 Script by ShadyPup Version Check Failed!^7')
    end
    
    function VersionCheckHTTPRequest()
        PerformHttpRequest('https://raw.githubusercontent.com/TheGamerCoder121/911Script/main/version.json', VersionCheck, 'GET')
    end
    
    function VersionCheck(err, response, headers)
        Citizen.Wait(3000)
        if err == 200 then
            local Data = json.decode(response)
            if CurrentVersion ~= Data.NewestVersion then
                print(label)
                print('  ||    \n  ||    Simple 911 Script by ShadyPup is outdated!')
                print('  ||    Current version: ^2' .. Data.NewestVersion .. '^7')
                print('  ||    Your version: ^1' .. CurrentVersion .. '^7')
                print('  ||    Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
                if Data.Changes ~= '' then
                    print('  ||    \n  ||    ^5Changes: ^7' .. Data.Changes .. "\n^0  \\\\\n")
                end
            else
                print(label)
                print('  ||    ^2Simple 911 Script by ShadyPup is up to date!\n^0  ||\n  \\\\\n')
            end
        else
            print(label)
            print('  ||    ^1There was an error getting the latest version information, if the issue persists contact ShadyPup on Discord.\n^0  ||\n  \\\\\n')
        end
        
        SetTimeout(60000000, VersionCheckHTTPRequest)
    end
    
    VersionCheckHTTPRequest()
end)
