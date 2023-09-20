print([[^1
     _   _  _ _____ ___   _____ ___  ___  _    _    
    /_\ | \| |_   _|_ _| |_   _| _ \/ _ \| |  | |   
   / _ \| .` | | |  | |    | | |   / (_) | |__| |__ 
  /_/ \_\_|\_| |_| |___|   |_| |_|_\\___/|____|____|
          ^8by ZerX (github.com/ZerXGIT)^0
^0---------------------[^2Tests^0]---------------------]])


local QBCore = exports['qb-core']:GetCoreObject()


createTableIfNotExist()





QBCore.Commands.Add('toggletroll', 'Troll Koruma Başlat', { { name = 'id', help = 'Player ID' } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        TriggerClientEvent('knxr-antitroll:toggle', Player) -- TriggerClientEvent'i kullanarak istemci olayını tetikleyin
   
        
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_online'), 'error')
    end
end, 'admin')




RegisterNetEvent("knxr-antitroll:updateTime", function(time)
    local src = source
    local identifier = QBCore.Functions.GetIdentifier(src, 'steam')

    updateOrInsert(identifier, time)
end)

RegisterNetEvent("knxr-antitroll:onjoin", function(isNew)
    local identifier = QBCore.Functions.GetIdentifier(source, 'steam')
    local src = source
    if isNew then
        TriggerClientEvent("knxr-antitroll:toggle", src, true)
        return
    end

    local time = getTimeLeft(identifier)

    if time > 0 then
    
        TriggerClientEvent("knxr-antitroll:toggle", src, true, time)
        return
    end
    
    updateOrInsert(identifier, time)
end)
