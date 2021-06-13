function sendMsg(src, msg)
    TriggerClientEvent('chat:addMessage', src, {
        args = {Config.prefix .. msg}
    })
end

function sendToDisc(title, message, footer)-- Thanks to Badger
    local embed = {}
    embed = {
        {
            ["color"] = 16711680, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "**" .. title .. "**",
            ["description"] = "" .. message .. "",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(Config.discord_webhook,
        function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), {['Content-Type'] = 'application/json'})
end

RegisterCommand("911", function(source, args)
    local callDetailsRequest = table.concat(args, "%20", 1) or 'None'
    
    
    PerformHttpRequest(Config.cadurl .. "/actions/911notification.php?get911=" .. callDetailsRequest,
        function(err, text, headers)
            sendMsg(source, "Your 911 call has been received! The authorities are on their way!");
            sendToDisc("INCOMING TRANSMISSION:", table.concat(args, " "), "[" .. source .. "] " .. GetPlayerName(source))
        end)
end)
