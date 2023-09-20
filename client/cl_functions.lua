local isTimerInstance = false

function setUiShow(bool)
    SendNUIMessage({
        type = "show",
        show = bool
    })
end

function updateUiTime(timeLeft)
    SendNUIMessage({
        type = "update",
        minleft = timeLeft
    })
end

function updateTimeToDatabase(overrideTime)
    TriggerServerEvent("knxr-antitroll:updateTime", overrideTime or timeLeft)
end

function startTimer()
    local interval = timeToSafe

    updateTimeToDatabase()

    CreateThread(function()
        isTimerInstance = true
        while hasProtection do

            if interval == timeToSafe or timeLeft <= 0 then
                interval = 0
                setUiShow(true)
                updateTimeToDatabase()
            end

            interval = interval + 1

            if timeLeft <= 0 then
                stopAntiTroll()
                isTimerInstance = false
                return
            end

            timeLeft = timeLeft - 1

            
            updateUiTime(timeLeft)
            Wait(1000 * 60)
        end
    end)
end

function startAntiTroll()
    if not isTimerInstance then
        startTimer()
    end
    setUiShow(true)

    -- Anti VDM
    if Config.DisableVDM then
        Citizen.CreateThread(function()
            while true do
                SetWeaponDamageModifier(-1553120962, 0.0)
                Citizen.Wait(10)
            end
        end)
    end

    -- Anti Driveby
    if not Config.DriveBy then
        SetPlayerCanDoDriveBy(PlayerId(), false)
    end

    if Config.DisablePunching then
        CreateThread(function()
            while hasProtection do
                Wait(5)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
            end
        end)
    end

    if Config.DisableShooting then
        CreateThread(function()
            while hasProtection do
                Wait(5)
                DisablePlayerFiring(player, true) 
            end
        end)
    end

    if Config.DisablePunchingDamage then
        SetWeaponDamageModifier(-1569615261, 0.0)
    end
end

function stopAntiTroll()
    hasProtection = false
    timeLeft = 0

    -- Anti VDM
    if Config.DisableVDM then
        SetWeaponDamageModifier(-1553120962, 1.0)
    end

    -- Anti Driveby
    if not Config.DriveBy then
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end

    if Config.DisablePunching then
        EnableControlAction(0, 140, true)
        EnableControlAction(0, 141, true)
        EnableControlAction(0, 142, true)
    end

    if Config.DisablePunchingDamage then
        SetWeaponDamageModifier(-1569615261, 1.0)
    end
    setUiShow(false)
end