QBCore = exports['qb-core']:GetCoreObject()

hasProtection = false
timeLeft = 0

-- SABİT DEĞİŞKENLER
timeToSafe = Config.TimeToSave

RegisterNetEvent("knxr-antitroll:toggle", function(toggle, timeOverride)
    hasProtection = toggle or not hasProtection
    timeLeft = timeOverride or Config.HowLong

    if hasProtection then
        startAntiTroll()
    else
        stopAntiTroll()
        updateTimeToDatabase(0)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded',function(xPlayer, isNew, skin)
    TriggerServerEvent("knxr-antitroll:onjoin", isNew)
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerServerEvent("knxr-antitroll:onjoin", false)
    end
end)
