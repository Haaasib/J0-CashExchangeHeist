local lastHeistTime = 0 

exports['hasib-lib']:RegisterCallback('J0-CashExchangeHeist:checkCooldown', function(source)
    local src = source    
    local currentTime = os.time()
    local timeSinceLastHeist = currentTime - lastHeistTime
    
    if timeSinceLastHeist < J0.heistCooldown and lastHeistTime ~= 0 then
        local secondsRemaining = J0.heistCooldown - timeSinceLastHeist
        local minutesRemaining = math.floor(secondsRemaining / 60)
        local remainingSeconds = secondsRemaining % 60
        return false
    end
    if J0.discordLogs then 
    exports["hasib-lib"]:sendLog(source, J0.discordWebHook, 'Cash Exchange Heist', 'Started Cash Exchange Heist')
    end
    lastHeistTime = currentTime
    return true
end)

RegisterNetEvent('J0-CashExchangeHeist:sv:reward', function(typ)
    local source = source
    if typ == 'cash' then
        local cashAmount = math.random(J0.rewardTable.cash.min, J0.rewardTable.cash.max)
        exports["hasib-lib"]:AddMoney(source, 'cash', cashAmount)
        if J0.discordLogs then 
        exports["hasib-lib"]:sendLog(source, J0.discordWebHook, 'Cash Exchange Heist', 'Money Added $:'.. cashAmount)
        end
    elseif typ == 'gold' then
        local goldAmount = math.random(J0.rewardTable.gold.min, J0.rewardTable.gold.max)
        local itemName = J0.rewardTable.gold.itemname
        exports["hasib-lib"]:AddItem(source, itemName, goldAmount, false, false)
        if J0.discordLogs then 
        exports["hasib-lib"]:sendLog(source, J0.discordWebHook, 'Cash Exchange Heist', 'Item Added :'.. itemName ..' Item Ammount :' .. goldAmount)
        end
    else
        print("Invalid reward type specified.")
    end
end)

exports["hasib-lib"]:verCheck('haaasib/J0-CashExchangeHeist', 'J0-CashExchangeHeist')

RegisterCommand('assdd', function (source, args, raw)
    exports["hasib-lib"]:sendLog(source, J0.discordWebHook, 'Cash Exchange Heist', 'Started Cash Exchange Heist')
    exports["hasib-lib"]:sendLog(source, J0.discordWebHook, 'Cash Exchange', 'Started Cash Exchange Heist')

end)