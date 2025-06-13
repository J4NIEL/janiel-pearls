local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('pearls:server:giveDrinks', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        for _, drink in pairs(Config.Drinks) do
            Player.Functions.AddItem(drink, 1)
        end
    end
end)

RegisterServerEvent('pearls:server:craft', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local recipe = Config.CookRecipes[data.recipe]
    if not recipe then return end

    for _, item in pairs(recipe.required) do
        if not Player.Functions.GetItemByName(item.item) or Player.Functions.GetItemByName(item.item).amount < item.amount then
            TriggerClientEvent('QBCore:Notify', src, 'No required ingredients!', 'error')
            return
        end
        
    end

    for _, item in pairs(recipe.required) do
        Player.Functions.RemoveItem(item.item, item.amount)
    end

    Player.Functions.AddItem(recipe.reward, 1)
    TriggerClientEvent('QBCore:Notify', src, 'Food is ready!', 'success')
end)

RegisterServerEvent('pearls:server:cutFish', function(fishType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)


    local fishToMeat = {
        ['trout'] = 1,
        ['salmon'] = 2,
        ['shark'] = 5,
        ['killerwhale'] = 6,
        ['tuna'] = 3,
        ['bass'] = 1,
        ['cod'] = 2,
        ['mackerel'] = 2,
        ['dolphin'] = 5
    }

    local amount = fishToMeat[fishType] or 1

    if Player.Functions.GetItemByName(fishType) then

        Player.Functions.RemoveItem(fishType, 1)  
        Player.Functions.AddItem('fish_meat', amount)  
        TriggerClientEvent('QBCore:Notify', src, fishType .. ' cut!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'No fish!', 'error')
    end
end)

