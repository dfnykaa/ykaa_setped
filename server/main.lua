local ESX = exports["es_extended"]:getSharedObject()
local webhookURL = "YOUR_WEBHOOKURL"

local function SendPedLog(source, pedName)

    local name = GetPlayerName(source)
    local discord = "Not found"
    local steam = "Not found"

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        if string.find(id, "discord:") then
            local discordId = string.sub(id, 9)
            discord = "<@" .. discordId .. ">"
        elseif string.find(id, "steam:") then
            steam = id
        end
    end

    local embedData = {
        {
            ["color"] = 3447003,
            ["title"] = "🐕 SetPed",
            ["description"] = string.format(
                "**Player:** %s (ID: %s)\n**Discord:** %s\n**Steam:** %s\n**Changed ped to:** `%s`",
                name,
                source,
                discord,
                steam,
                pedName
            ),
            ["footer"] = {
                ["text"] = "YKAA SetPed • " .. os.date("%d.%m.%Y %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers)
        if err == 200 or err == 204 then
        else
        end
    end, 'POST', json.encode({
        username = "YKAA SetPed",
        embeds = embedData
    }), {
        ['Content-Type'] = 'application/json'
    })
end

ESX.RegisterCommand('setped', {'admin', 'superadmin'}, function(xPlayer, args, showError)

    if not args.ped then
        xPlayer.showNotification("Usage: /setped [ped_name] or /setped reset", "error")
        return
    end

    local src = xPlayer.source
    local pedName = args.ped

    TriggerClientEvent('ykaa_setped:client:SetPed', src, pedName)

    SendPedLog(src, pedName)

end, false, {
    help = 'Changes your ped',
    arguments = {
        {
            name = 'ped',
            help = 'Ped name (e.g. a_m_y_skater_01) or "reset"',
            type = 'string'
        }
    }
})