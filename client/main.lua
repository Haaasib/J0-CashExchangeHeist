local lasers = {
    Laser.new(
        vector3(137.465, -1335.689, 29.661),
        {vector3(135.056, -1338.066, 29.651)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser01"}
    ),  
    Laser.new(
        vector3(137.5, -1335.724, 30.911),
        {vector3(135.108, -1338.116, 30.993)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser02"}
    ),
    Laser.new(
        vector3(133.381, -1331.719, 30.239),
        {vector3(132.993, -1336.093, 30.181)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser03"}
    ),
    Laser.new(
        vector3(133.367, -1331.732, 31.301),
        {vector3(132.99, -1336.096, 30.94)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser04"}
    ),
    Laser.new(
        vector3(130.045, -1334.913, 30.289),
        {vector3(126.5, -1342.825, 30.058)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser05"}
    ),
    Laser.new(
        vector3(132.85, -1336.437, 30.124),
        {vector3(124.507, -1340.9, 30.133)},
        {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "exchangelaser06"}
    )
}

StopLasers = function()
    for _, laser in ipairs(lasers) do
        laser.setActive(false)
    end
end

HitByLaser = function()
    exports["hasib-lib"]:Event('J0-cashExchange:hitbylaser')
end

RegisterNetEvent("J0-cashExchange:hitbylaser")
AddEventHandler("J0-cashExchange:hitbylaser", function()
    local playerPed = PlayerPedId()
    local newHealth = math.max(GetEntityHealth(playerPed) - 50, 0)
    SetEntityHealth(playerPed, newHealth)
end)

StartLasers = function()
    for _, laser in ipairs(lasers) do
        laser.setActive(true)
        laser.setMoving(false)
        laser.onPlayerHit(function(playerBeingHit, hitPos)
            if playerBeingHit then HitByLaser() end
        end)
    end
end

startHeist = function()
    local options = {
        {
            distance = 5.5,
            label = "Plant Thermite",
            icon = 'fas fa-phone',
            onSelect = function()
                if exports["hasib-lib"]:isLeader() then
                    if exports["hasib-lib"]:progressBar("Planting Thermite To Cash Exchange Point", 5000, { car = false, walk = false }, {}, {}) then
                    exports['hasib-lib']:startSkillCheck('bThermite', {
                        numKeys = 5,
                        gridSizeX = 7,
                        gridSizeY = 7,
                        gameTimeoutDuration = 20
                    }, function(success)
                        if success then
                           local response = exports['hasib-lib']:TriggerCallbackAwait('J0-CashExchangeHeist:checkCooldown')
                            if response then
                                exports["hasib-lib"]:thermiteAnim(J0.heistCoords.ThermiteAnim.heading, J0.heistCoords.ThermiteAnim.vec)
                                exports["hasib-lib"]:grpEvent('J0-cashExchange:cl:starterInteraction', {})
                                exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange', 'Go Inside Of Cash Exchange </br> Disable The Lase Security'})
                                exports["hasib-lib"]:Notify('Cash Exchange', 'You Started Cash Exchange Heist', 1)
                                StartLasers()
                            else
                                exports["hasib-lib"]:Notify('Cash Exchange', 'Heist On Cooldown', 3)
                            end
                        else
                            exports["hasib-lib"]:Notify('Cash Exchange', 'You Failed Try Again', 3)
                        end
                    end)
                    end
                else
                    exports["hasib-lib"]:Notify('Cash Exchange', 'You Are Not Group Leader', 3)
                end
            end,
            action = function()
                if exports["hasib-lib"]:isLeader() then
                    if exports["hasib-lib"]:progressBar("Planting Thermite To Cash Exchange Point", 5000, { car = false, walk = false }, {}, {}) then
                    exports['hasib-lib']:startSkillCheck('bThermite', {
                        numKeys = 5,
                        gridSizeX = 7,
                        gridSizeY = 7,
                        gameTimeoutDuration = 20
                    }, function(success)
                        if success then
                            local response = exports['hasib-lib']:TriggerCallbackAwait('J0-CashExchangeHeist:checkCooldown')
                            if response then
                                exports["hasib-lib"]:thermiteAnim(129.72, vec3(137.62, -1334.08, 29.20))
                                exports["hasib-lib"]:grpEvent('J0-cashExchange:cl:starterInteraction', {})
                                exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange Heist', 'Go Inside Of Cash Exchange </br> Disable The Lase Security'})
                                exports["hasib-lib"]:Notify('Cash Exchange', 'You Started Cash Exchange Heist', 1)
                                StartLasers()
                            else
                                exports["hasib-lib"]:Notify('Cash Exchange', 'Heist On Cooldown', 3)
                            end
                        else
                            exports["hasib-lib"]:Notify('Cash Exchange', 'You Failed Try Again', 3)
                        end
                    end)
                    end
                else
                    exports["hasib-lib"]:Notify('Cash Exchange', 'You Are Not Group Leader', 3)
                end
            end,
        }
    }
    exports["hasib-lib"]:addTarget(J0.heistCoords.StartLoc.vec, 5.0, options, 2.5, J0.heistCoords.StartLoc.zname)
end

RegisterNetEvent('J0-cashExchange:cl:starterInteraction')
AddEventHandler('J0-cashExchange:cl:starterInteraction', function()
    local options = 
    {
        {
            distance = 5.5,
            label = "Stop Lasers",
            icon = 'fas fa-phone',
            onSelect = function() 
                TriggerEvent('ultra-voltlab', 60, function(outcome ,reason)
                        if outcome == 0 then
                            print('Hack failed', reason)
                        elseif outcome == 1 then
                            StopLasers() 
                            exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange Heist', 'Go Inside Of Cash Exchange </br> Hack The Doors Of Inside'})
                            exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', {J0.heistCoords.Hack1Lock.zname})
                        elseif outcome == 2 then
                            print('Timed out')
                        elseif outcome == -1 then
                            print('Error occured',reason)
                        end
                    end)
            end,
            action = function() 
                TriggerEvent('ultra-voltlab', 60, function(outcome ,reason)
                    if outcome == 0 then
                        print('Hack failed', reason)
                    elseif outcome == 1 then
                        StopLasers() 
                        exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange Heist', 'Go Inside Of Cash Exchange </br> Hack The Doors Of Inside'})
                        exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', {J0.heistCoords.Hack1Lock.zname})
                    elseif outcome == 2 then
                        print('Timed out')
                    elseif outcome == -1 then
                        print('Error occured',reason)
                    end
                end)
            end,
        }              
    }
    exports["hasib-lib"]:addTarget(J0.heistCoords.Hack1Lock.vec, 5.0, options, 2.5, J0.heistCoords.Hack1Lock.zname)
    for doorId, door in pairs(J0.cashExchangeDoors) do
        AddDoorToSystem(doorId, door.hash, door.coords)
        DoorSystemSetDoorState(doorId, true and 1 or 0)
        local groupName = "CashExchangeDoor_" .. doorId    
        local options = 
        {
            {
                distance = 5.5,
                label = "Open Doors",
                icon = 'fas fa-phone',
                onSelect = function()
                    if exports["hasib-lib"]:progressBar("Typing Keys", 5000, { car = false, walk = false }, {}, {}) then

                    exports['hasib-lib']:startSkillCheck('swords', {
                        gameTimeoutDuration = 60000,
                        requiredCorrectChoices = 10
                    }, function(success)
                        if success then
                            exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange Heist', 'Go Inside Of Cash Exchange </br> Loot The Trollys'})
                            exports["hasib-lib"]:grpEvent('J0-cashExchange:cl:unlockdoor', { doorId })
                            exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', { groupName })
                        else
                            exports["hasib-lib"]:Notify('Cash Exchange', 'You Failed Try Again', 3)
                        end
                    end)
                end
                end,
                action = function()
                    if exports["hasib-lib"]:progressBar("Typing Keys", 5000, { car = false, walk = false }, {}, {}) then

                        exports['hasib-lib']:startSkillCheck('swords', {
                            gameTimeoutDuration = 60000,
                            requiredCorrectChoices = 10
                        }, function(success)
                            if success then
                                exports["hasib-lib"]:grpEvent('J0-status:Show', {'Cash Exchange Heist', 'Go Inside Of Cash Exchange </br> Loot The Trollys'})
                                exports["hasib-lib"]:grpEvent('J0-cashExchange:cl:unlockdoor', { doorId })
                                exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', { groupName })
                            else
                                exports["hasib-lib"]:Notify('Cash Exchange', 'You Failed Try Again', 3)
                            end
                        end)
                    end
                end,
            }
        } 
        exports["hasib-lib"]:addTarget(door.coords, 5.0, options, 2.5, groupName)
    end
    exports['hasib-lib']:CreateTrolly({Trollys = J0.trollysInfo}) 
    for index, trolly in pairs(J0.trollysInfo) do
        local targetName = "Trolly123_" .. index
        local options = {
            {
                distance = 5.5,
                label = "Loot " .. trolly.type,
                icon = 'fas fa-phone',
                onSelect = function()
                    exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', { targetName })
                    exports["hasib-lib"]:LootTrolly(trolly)
                    exports["hasib-lib"]:grpEvent('J0-status:Close', {})
                    if trolly.type == 'cash' then
                        TriggerServerEvent('J0-CashExchangeHeist:sv:reward', 'cash')
                    else
                        TriggerServerEvent('J0-CashExchangeHeist:sv:reward', 'gold')
                    end
                    Citizen.SetTimeout(600000, function()
                        local trollyObject = GetClosestObjectOfType(trolly.coords.x, trolly.coords.y, trolly.coords.z, 1.0, 269934519, false, false, false)
                        if trollyObject ~= 0 then
                            DeleteObject(trollyObject)
                        end
                    end)
                end,
                action = function()
                    exports["hasib-lib"]:grpEvent('hasib-lib:rmvGrpTarget', { targetName })
                    exports["hasib-lib"]:LootTrolly(trolly)
                    exports["hasib-lib"]:grpEvent('J0-status:Close', {})
                    if trolly.type == 'cash' then
                        TriggerServerEvent('J0-CashExchangeHeist:sv:reward', 'cash')
                    else
                        TriggerServerEvent('J0-CashExchangeHeist:sv:reward', 'gold')
                    end
                    Citizen.SetTimeout(600000, function()
                        local trollyObject = GetClosestObjectOfType(trolly.coords.x, trolly.coords.y, trolly.coords.z, 1.0, 269934519, false, false, false)
                        if trollyObject ~= 0 then
                            DeleteObject(trollyObject)
                        end
                    end)
                end,
            }
        }
        exports["hasib-lib"]:addTarget(trolly.coords, 5.0, options, 2.5, targetName)
    end
    exports['hasib-lib']:AlertPol((J0.dispatchInfo))
end)

RegisterNetEvent('J0-cashExchange:cl:unlockdoor')
AddEventHandler('J0-cashExchange:cl:unlockdoor', function(doorId)
    DoorSystemSetDoorState(doorId, 0)
end)

CreateThread(function() 
    startHeist()
end)
