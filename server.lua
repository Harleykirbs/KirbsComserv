RegisterCommand("comserv", function(source, args)
    local target = tonumber(args[1])
    local taskCount = tonumber(args[2]) or 5

    if not target or not GetPlayerName(target) then
        TriggerClientEvent('chat:addMessage', source, {
            args = {'^1[Error]', 'Invalid player ID'}
        })
        return
    end

    TriggerClientEvent("comserv:start", target, taskCount)
end, true) -- true = only players with permission can run it (add ACE perms if needed)
